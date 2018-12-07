Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543FFC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1948A208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cpzQws6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1948A208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbeLGHEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 02:04:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36560 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeLGHEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 02:04:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id u3so2780338wrs.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 23:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VYaH+iK80F2dK8xvwFZZ+PfPb10+61RH8PGauKSiAVk=;
        b=cpzQws6b6/Cw1bfa9E8Plxhux9LWhlAagO8y2Wryt1XlpSAz0tQD31RDaSm8dV0f0g
         C0Io9A8BioRjhLetJkeFosMxQz9h3CYK8kKwAhyfS3pey0b+9EdwQ5nHu0/lCZYYBrH4
         mXMXt1tNspBMT/B+rjzlIG9Ghm9QsCCjdFax0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VYaH+iK80F2dK8xvwFZZ+PfPb10+61RH8PGauKSiAVk=;
        b=WlGVqf3rHtT5DmQal+Mk3rK6YysIxUZn/6Qz69fIJni+q9gZiO3+9hRgGx+qhItDhl
         AsMb7oVthXxqJLYa9xdGGex/oOlnQFv8Ngp8aNw42gOzP0vdPigAboTSeD6M+P9PrtFz
         SSwMB1IdhPZ5kw4nSSh6KahAkb/ec8r1m70OdVb2yqffX4FHgJtvixxImg5VGPK6ln3/
         hrDSrCpcXEBmSPDf5AHPIq5Q1wMvH1LmNT6hyYIO2kuXuyUMXdY3to2YmrJw3UW++mfa
         dBo/0tBYwsPGFhBxj1rrDzc7PAc+ekR2/D0Ki1XRg4/H9X5B2M5hwrFuR200PzcucLoT
         1aWg==
X-Gm-Message-State: AA+aEWYpXVwvk+En9A6ehDS8TaxPpCLN2MxeBwTWzwc+KM3BFgkbheVR
        yM2dUeLfz2oMCX1VAvv3qm43DA==
X-Google-Smtp-Source: AFSGD/V7qVEW0Rxapwhz2KPm2aJJhQ1P8jBcQ6RZgOZtKoXRNcDbmufBIuyzBSSqYJltqYQj09+RqA==
X-Received: by 2002:adf:e54a:: with SMTP id z10mr781386wrm.238.1544166281527;
        Thu, 06 Dec 2018 23:04:41 -0800 (PST)
Received: from [192.168.0.40] (80.149.136.77.rev.sfr.net. [77.136.149.80])
        by smtp.googlemail.com with ESMTPSA id y34sm7103070wrd.68.2018.12.06.23.04.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 23:04:40 -0800 (PST)
Subject: Re: [PATCH v2] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
To:     Tao Ren <taoren@fb.com>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Yu Lei <mine260309@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20181003215350.3550926-1-taoren@fb.com>
 <CACRpkdbbUO9_VOtnZL+Xf_0nTTgSruaaPOLnvZ4M+NQfPLzvWQ@mail.gmail.com>
 <BC1ADE3F-F31F-4E1E-A6EE-3BD83C5F2634@fb.com>
 <279e6a06-3f2f-e736-f28e-4d099729a517@linaro.org>
 <7284BEA6-FAE9-4293-94E0-FC29304AA36D@fb.com>
 <48A12A26-5AF0-483C-85D4-428F00038D7A@fb.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <47d85e8e-bf01-11a7-9c02-6d934d911178@linaro.org>
Date:   Fri, 7 Dec 2018 08:04:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <48A12A26-5AF0-483C-85D4-428F00038D7A@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 02:13, Tao Ren wrote:
> On 11/5/18, 11:00 AM, "Tao Ren" <taoren@fb.com> wrote:
> 
>> On 11/5/18, 10:51 AM, "Daniel Lezcano" <daniel.lezcano@linaro.org> wrote:
>>> Oh right, sorry. Should it go to stable also ? Is there a Fixes tag it can apply ?
>>>
>> Personally I don't think it needs to go to stable, because I don't see any functional failures caused by this invalid register access.
> 
> Hi Daniel,
> 
> Not sure if I missed any emails from you, but looks like the patch is not included in your tree? Are we planning to include the patch in 4.21 merge window?

Yes, I have it in the tree. I updated the next branch.

Thanks

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

