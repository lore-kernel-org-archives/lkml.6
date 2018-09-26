Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8808C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C610F2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hThJcxqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C610F2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeIZOm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:42:28 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37860 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIZOm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:42:28 -0400
Received: by mail-lf1-f68.google.com with SMTP id a82-v6so7086095lfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 01:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YPhaSuwgZIE6YSc6e7klVWPuc99XZubi/sRtM7ioCts=;
        b=hThJcxqbQu3AdSYpU2fhUYHFcYXj9fYgeyAV6P+cgvcpOwbyAm2JnQW2/p1oYS0RxX
         uDVTwNgmoMEkJ9wTxgg3ezt597jAVYH+6/xJX/9cAt1pRHR3DXcOrAmsg2G3dX9L0JHu
         cTfmFTqhDfgOKgq+eYig1EzqzeGPu+gZsRai4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YPhaSuwgZIE6YSc6e7klVWPuc99XZubi/sRtM7ioCts=;
        b=ZsKECJS8Rxi9FMWP5aCVXU2cSRsaLo+cF/g/mOiRZfQ9RnqrXBydVweJCN+14idwZl
         OvONBlJ4stOQ+o35x+o4DZG1GXGdQAHZOUhDVzBNZEGLnQFBHdelDzuzVvKmw2xk+qqI
         C3Im7gOOPcdCylV+RuLkriBzwXZb+s1lNx+1rHJ9MMukCut2tAUxAGtwNhhZjB8rpyp6
         3hGvoHndzhb02NeC33RTtwXMDhYqswANrOwTBKEyFVLF8wbOiyfrZ51ojtJA2OAlIog0
         dHHehSvyfHKmgj2t+ib4rwMDDh3alrl4y2J8b9pTbWvZGNHSbUdIyU3Bif0OuqhcUbNd
         uLbQ==
X-Gm-Message-State: ABuFfojm37l7vINmpnO4KUcmIw1W2izHNzchozukumTxAWiJj53lXH47
        dnWzHM8zmeavp7v3RP9xO2KtQ5Mfr0wTVwfVfiKfug==
X-Google-Smtp-Source: ACcGV61GzpURWOan1NVkZVIGcTmcmFbk9gsDZuJz9lfAwSUFa737VLEyRjReOXs1JJVLc375hiV8ReY1Lf6cYvOvAgg=
X-Received: by 2002:a19:d189:: with SMTP id i131-v6mr3354027lfg.20.1537950639767;
 Wed, 26 Sep 2018 01:30:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:95d7:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 01:30:39
 -0700 (PDT)
In-Reply-To: <CACRpkdY3YsXsJy0OwGYLuB+x32hbkAHum4w5KQTCGoi-OXt-QA@mail.gmail.com>
References: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
 <CACRpkdY3YsXsJy0OwGYLuB+x32hbkAHum4w5KQTCGoi-OXt-QA@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 26 Sep 2018 16:30:39 +0800
Message-ID: <CAMz4ku+H5Z_W5rE0b3GDz2E0YSZshEerufZ41yeh_E5omD6KLA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] power: supply: core: Introduce one property to
 present the battery internal resistance
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>,
        Craig Tatlor <ctatlor97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 26 September 2018 at 16:00, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Sep 26, 2018 at 4:59 AM Baolin Wang <baolin.wang@linaro.org> wrote:
>
>> Introduce one property to present the battery internal resistance for battery
>> information.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>> Changes from v1:
>>  - New patch in v2.
>
> I'm a bit confused by the physics in this patch.
>
> The internal resistance of a battery is not a constant in its life cycle,
> this varies over the age of the battery, and the reason I thing is
> chemical residuals accumulating on the anode and cathode inside
> the battery and the energy storage medium aging. (Plus/minus my
> ignorance about how batteries actually work.)

Yes, you are right. The internal resistance can be affected by
temperature or battery age or other factors. But our solution just
uses one constant internal resistance to calculate OCV value to look
up the capacity table when system boots on, in this case we do not
need one more accuracy OCV, since we will calculate the battery
capacity in future. So we just introduce one estimation constant
internal resistance.

>
> AFAIK the fact that the internal resistance varies is of high
> importance for people developing algorithms of battery capacity
> and longevity. Such that some (hardware) capacity monitors go
> to great lengths to measure with high precision the current
> internal resistance of the battery for their algorithms.
>
> Sorry for making things more complex, but should it be named
> "factory-internal-resistance-micro-ohms" or
> "typical-internal-resistance-micro-ohms"?

I am fine with this change. If Sebastian also agree with this change,
I will fix.
Thanks for your reviewing and comments.

-- 
Baolin Wang
Best Regards
