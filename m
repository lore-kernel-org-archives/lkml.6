Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B412AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86037222A1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391828AbfBMXAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:00:48 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33678 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfBMXAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:00:47 -0500
Received: by mail-ed1-f66.google.com with SMTP id a2so3465101edi.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 15:00:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F0TpCTxv+/m3TwzY+OUc/JTp4f+jIrWjrGOkYJDiRXw=;
        b=A1L21KJCXIW+udJxrbsVoa3lreJLye957pSEozvx1Ff03wuwSjKPhicnKxthbQj0Mh
         BWMQVWcdCUXIa2ld8LRRyGdRcwBXzjSWu7R5W7Qxj92lykREno9nWaWsg0yLo8sql4L0
         hKprhcJiRWJ+yQxKfX7TIAmeHIE8k4PozKh3+UcoPpaEX83Fw4MDokraLMJYihersW/h
         Ajsfb2RGYZPTyq6wGEtDaZ6uwxCFADIYg0QatG8qNwiDm6nfoiIF5gKA4ct1o6SiNwt4
         TCRceCU19u3JQHL/bbtjzbPCkPy9iGQWx2cpRG7dqb+ppdJUQ+w4RO0VwY4NQnTvBD33
         8YlA==
X-Gm-Message-State: AHQUAuYiGuPk7rgQf+LQXVZYYBoXHmd6vA4b28k+gmwsHanW1pvS42oP
        SOlcdSqiwEY++F2V4sHgnCgR2Q==
X-Google-Smtp-Source: AHgI3IYr7UgQrlv4ozX7+bW7DIS+JIFz+KKpIGqDmFJo9ppEq0yq3A/80GsgV1w+bFmAIdS3XLZJ3w==
X-Received: by 2002:a50:a8c3:: with SMTP id k61mr381881edc.296.1550098845847;
        Wed, 13 Feb 2019 15:00:45 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id b11sm136905eje.27.2019.02.13.15.00.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 15:00:45 -0800 (PST)
Subject: Re: [PATCH 0/2] extcon: Intel Cherry Trail Whiskey Cove PMIC and
 external charger tweaks
To:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20190210203649.21691-1-jekhor@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7d226dcc-9b9c-941c-7915-53ca123fa3a5@redhat.com>
Date:   Thu, 14 Feb 2019 00:00:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190210203649.21691-1-jekhor@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10-02-19 21:36, Yauhen Kharuzhy wrote:
> At implementation of charging support for Lenovo Yoga Book (Intel Cherry Trail
> based with Whiskey Cove PMIC), two pitfalls were found:
> 
> - for detection of charger type by PMIC, bit 6 in the CHGRCTRL1 register
>    should be set in 0 (and set to 1 for Host mode). Pick up its definition
>    and logic from from Intel code drop[1];
> 
> - "#CHARGE ENABLE" signal of external charger (bq25892) in Yoga Book is
>    connected to one of PMIC outputs controlled by CHGDISCTRL register.
>    Enable charging at driver initialization. Pick up this from Lenovo's code
>    drop[2,3].
> 
> Please keep in mind that I have no docs for Whiskey Cove PMIC, so this patches
> are based on some kind of reverse engineering and suppositions, correct me if
> this semantic is wrong for common case.
> 
> [1]. https://github.com/01org/ProductionKernelQuilts/uefi/cht-m1stable/patches/0001-power_supply-intel-pmic-ccsm-driver.patch
> [2]. https://github.com/jekhor/yogabook-linux-android-kernel/blob/b7aa015ab794b516da7b6cb76e5e2d427e3b8b0c/drivers/power/bq2589x_charger.c#L2257
> [3]. https://github.com/01org/ProductionKernelQuilts/uefi/cht-m1stable/patches/EM-Charger-Disable-battery-charging-in-S3-and-enable.patch

Thank you for these patches, besides your Lenovo Yoga Book I'm aware of
only 2 other device models using the CHT Whiskey Cove PMIC, the GPD win
and GPD pocket devices. These both work fine without the changes your
patches introduce.

I need to check if your changes do not cause regressions on these 2
devices, which are used with Linux by quite a few people. I will try
to make some time for testing this sometime next week.

A kind request to the platform-x86 driver maintainers (hi Andy): Please
do not apply these patches until I've been able to test they don't cause
issues elsewhere.

Regards,

Hans
