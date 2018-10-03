Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E25C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB4720835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ab9fIbS7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB4720835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeJCTQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:16:25 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34866 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbeJCTQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:16:24 -0400
Received: by mail-wm1-f68.google.com with SMTP id o18-v6so5465757wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 05:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r+xJeJiTViUaKyUEJIiLdGISDhU3g624RQT6SjXnmOk=;
        b=Ab9fIbS7Wm0JYNbTzTR+ku9qugi/ZM6tgCkQ5IMniRvPO1XXo+1DnQYK1nXviBtjlN
         8RTBQARY3u6cboxf25VPhHYCtcMtqjTrPtg/gsUognYqX8lHNWt8uOyqkfigvzMHt+Nr
         JcCe0kpBTPu3FLTBGDltIRlnD+gMd6AD58VmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r+xJeJiTViUaKyUEJIiLdGISDhU3g624RQT6SjXnmOk=;
        b=A+Ip7Wnps7+U5IdRBv9xhtgXFrVOjr6MRBjObZ6ShshJqeWH40PXgdQReFtgwO8CJo
         gAuOmSy2JQMHAzMitcBD5IZ9jVLeiPezxyjzG02SJviekLPm6dSmNnnEdSXHx+ubkQx9
         o5lv6yz23PAQUsOEFPUcrcruhotOUmjUIpBl1fHHJGzIwJsFzx2M/umMP+YDBaFAhCqm
         Q+H+XOm8+SKG/v+7jssrshj2c1G3xt5p/mH8nsnx3/ZeHKt/swqSYIwrHYb2+75JtcI1
         kYwVrbDJO79Y+lxc2N1Qdn29PfsXZT3olWcDK9KEg9w51HSAPBgMysHYXIUYAqoCn1+G
         jipw==
X-Gm-Message-State: ABuFfohLy7bf3+i/pZEJVXnnZLWmRuctkGJWHuB4u58iQfbsbLiZVF4Y
        jjStAPWk/h/MIX1DkDd8MxK+uw==
X-Google-Smtp-Source: ACcGV61CIbOoIy0zVCHEcAiH2MROk3PNgsI4FK1d/UviLcZscycS/6MYduI5aD5En6A3jIQm2jcVTQ==
X-Received: by 2002:a1c:4d0b:: with SMTP id o11-v6mr1346968wmh.94.1538569692156;
        Wed, 03 Oct 2018 05:28:12 -0700 (PDT)
Received: from [192.168.0.41] (84.152.136.77.rev.sfr.net. [77.136.152.84])
        by smtp.googlemail.com with ESMTPSA id w192-v6sm1943417wmf.33.2018.10.03.05.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 05:28:11 -0700 (PDT)
Subject: Re: [PATCH] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
To:     Tao Ren <taoren@fb.com>, Linus Walleij <linus.walleij@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Yu Lei <mine260309@gmail.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
References: <20181002041437.2493192-1-taoren@fb.com>
 <CACRpkdY4VaH2Yoob2gWwAk11P1NTDdza262zKGs=gju0NH9skQ@mail.gmail.com>
 <3a294c92-bcc6-b42e-b3af-72bc5f607fd9@fb.com>
 <CACRpkdZXum+bQg1FO+EHhKWpxtPYXfeRhoAKkFXeMQh1Jng3Ww@mail.gmail.com>
 <966C48A9-98F7-4B2B-BCD0-FAF3066C5794@fb.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6e7703e4-461b-77bf-5c9d-cc9e91c5ef3d@linaro.org>
Date:   Wed, 3 Oct 2018 14:28:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <966C48A9-98F7-4B2B-BCD0-FAF3066C5794@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2018 09:46, Tao Ren wrote:
> On 10/2/18, 11:57 PM, "Linus Walleij" <linus.walleij@linaro.org>
> wrote:
> 
>> My thought is go for (2) and do all changes in one patch :)
> 
> No problem, Linus. One more question: looks like my first patch
> 4451d3f59f2a (fix set_next_event handler) is not merged back to
> "timers/core". Should I generate this patch on top of the first patch
> or on top of the current "timers/core"? Which one would be easier for
> you (or Daniel/Thomas)? Sorry I'm pretty new to the community..


Hi Tao,

the branch tip:timers/urgent will be merged in tip:/timers/core, so the
fixes will be propagated to the master branch.

Base your change in top of tip:timers/urgent, the merge will happen soon
and both fixes will end up in tip:timers/core.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

