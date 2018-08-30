Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFD2C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C0F2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dHdAP7Nn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C0F2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeH3TbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:31:08 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40804 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeH3TbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:31:08 -0400
Received: by mail-ua1-f68.google.com with SMTP id 101-v6so5849642uav.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 08:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Kic7LUCNft+fYGiLuKBoLG1eN0boL5204vRN8b9Z43Q=;
        b=dHdAP7NnvDtFkspQxqsWNr8FRn8mMxGHu4UOjPN0BL783L7jRIOSZDEmjmecVqtR1p
         vFQMa68uFhBMcf8Ou1sEJSEKveVkAV0cLXPxsN4ZMmGecIVbHE7N9xTBUQ/oAyKRmBkk
         xwEetAvhZ42Eocjx1ve3go6ZlQXNQ7jzYrWi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Kic7LUCNft+fYGiLuKBoLG1eN0boL5204vRN8b9Z43Q=;
        b=PPMtZFKQwauyi3vEyEOgSVikov2FKRNWXfNxBzrI/lLtdi3u05uMktOS2HBchMt+6/
         ysDW4CylF9KKJvCJH+kbJDpiEjSna7+YnFMb2D9Hyy8Gq0VrUiY/KQCLlj9vBs/FTjmZ
         R9ulTIPOWgnRRuTqPCacIe4YImczfC8h344P1ydKaQQpvbFbYgi02pr0+/5rU5SEsNJK
         YMSitlOLwgx2cMo/537EOHHKMYRtPCsRsm21bL0+/sM5dSErGi/wIWqZ0vjp2FQgynYc
         dc9vGdT0o0Rv+FGOOp/T+CyVcdP0408LVIcccQ6HBl0jNy8Yxitv3SAEYxdItRdZgmuE
         DkDA==
X-Gm-Message-State: APzg51BJpxRFAKctVs2Af4tCsCjiLt8XxntA6ijDjYkbyDJ5IbqzQ7Gn
        3Rzf9ZNEf8WBi2/rWqU1HMQfQuT5oI5ZHA==
X-Google-Smtp-Source: ANB0VdbE5mzpIfZ/+ajmE2Z6Z1oDlThy8KHJtWsaiiFBdKHWW2SFO3eqv7MgtKDym7TqR1Z8eRe8wg==
X-Received: by 2002:a67:f74a:: with SMTP id w10-v6mr550624vso.85.1535642905229;
        Thu, 30 Aug 2018 08:28:25 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id u187-v6sm1974248vke.31.2018.08.30.08.28.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 08:28:24 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id r15-v6so5874227uao.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 08:28:24 -0700 (PDT)
X-Received: by 2002:a9f:2208:: with SMTP id 8-v6mr7484843uad.97.1535642903725;
 Thu, 30 Aug 2018 08:28:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:1f05:0:0:0:0:0 with HTTP; Thu, 30 Aug 2018 08:28:23
 -0700 (PDT)
In-Reply-To: <CACRpkdY6zShFajBv=yhgxk7NRP8WBbM=m16fSiuL6xqsYdP6Dg@mail.gmail.com>
References: <20180702225939.109169-1-dianders@chromium.org>
 <20180702225939.109169-3-dianders@chromium.org> <153059814703.143105.275831530209187562@swboyd.mtv.corp.google.com>
 <CACRpkdY6zShFajBv=yhgxk7NRP8WBbM=m16fSiuL6xqsYdP6Dg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 30 Aug 2018 08:28:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X1qK2ALKiorXe3SCYYijPsVPF57tUR+TdR3is3hLKGsQ@mail.gmail.com>
Message-ID: <CAD=FV=X1qK2ALKiorXe3SCYYijPsVPF57tUR+TdR3is3hLKGsQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] pinctrl: qcom: spmi-gpio: Fix pmic_gpio_config_get()
 to be compliant
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Ivan T. Ivanov" <iivanov@mm-sol.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 9, 2018 at 4:17 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Jul 3, 2018 at 8:09 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
>> > Fixes: eadff3024472 ("pinctrl: Qualcomm SPMI PMIC GPIO pin controller driver")
>> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>
>> We should fix the ssbi-gpio/mpp and spmi-mpp drivers too. All those
>> drivers are designed on the same buggy original driver.
>
> Agreed. Looking forward to the patches :D

Well, it took a little while for me to get to it, but patches are
available at <http://lore.kernel.org/r/20180830152340.242249-1-dianders@chromium.org>.
I personally have no way to test them so I prefixed them with RFT.
Enjoy!

-Doug
