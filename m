Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99241C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DF0222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbfBNKHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:07:04 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43880 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfBNKHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:07:03 -0500
Received: by mail-ed1-f67.google.com with SMTP id m35so563211ede.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 02:07:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2jWv3VDlAHB0yEjek/oxjX0f6137lmk0k8eSh2FkZOo=;
        b=Tzn87zv+JYjH6L90yBIdgh+16QmVXx3PpW2o5bTmqhM5JS5iH8KO9P2udfys7VmJ5n
         dRLu1g3///nGVCR1QG6dLeJw1K2O03vT+gJtSmy4pC3pF2i+owWbxP/47Vg3duRKQ1el
         3psD6/Iddvbx4+F2Laq5EN17RZ47xKxE0pvy+Me6viZBwC3nLe6pwNrGiHVS5X5gyK7n
         LM8VM1ARoWqk5zCla04ahcdYZYDi/Nu/3Xii1wq4Kzwt+mSarzikYe7z0hjtlDzkoSBA
         psQytgihkdwmKY50P3QlINWBXtlhjfImgZMFxvWEe6ox8+Kdl/qpW5eTeMwE8LZuPksF
         vlsg==
X-Gm-Message-State: AHQUAuae/RqGQCrpZuk1FZv+PtTvjTKT7bqNsyhCbJ6p5uq4GkeDHza3
        KZ0JNitrLzXLze3jDQt8qxZ62g==
X-Google-Smtp-Source: AHgI3IayFQiWtUL9dGldV0sj3jUjKO7kfqfRKXtNq6Ka3sI0DW7iBt97I7ZkUGBV9mClzZtnzgiXoA==
X-Received: by 2002:aa7:d850:: with SMTP id f16mr2494920eds.100.1550138821782;
        Thu, 14 Feb 2019 02:07:01 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id m32sm477310ede.29.2019.02.14.02.07.00
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 02:07:01 -0800 (PST)
Subject: Re: [PATCH 0/2] extcon: Intel Cherry Trail Whiskey Cove PMIC and
 external charger tweaks
From:   Hans de Goede <hdegoede@redhat.com>
To:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20190210203649.21691-1-jekhor@gmail.com>
 <7d226dcc-9b9c-941c-7915-53ca123fa3a5@redhat.com>
Message-ID: <6c2ee1d5-b06a-4182-e373-12c4113fa514@redhat.com>
Date:   Thu, 14 Feb 2019 11:07:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <7d226dcc-9b9c-941c-7915-53ca123fa3a5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14-02-19 00:00, Hans de Goede wrote:
> Hi,
> 
> On 10-02-19 21:36, Yauhen Kharuzhy wrote:
>> At implementation of charging support for Lenovo Yoga Book (Intel Cherry Trail
>> based with Whiskey Cove PMIC), two pitfalls were found:
>>
>> - for detection of charger type by PMIC, bit 6 in the CHGRCTRL1 register
>>    should be set in 0 (and set to 1 for Host mode). Pick up its definition
>>    and logic from from Intel code drop[1];
>>
>> - "#CHARGE ENABLE" signal of external charger (bq25892) in Yoga Book is
>>    connected to one of PMIC outputs controlled by CHGDISCTRL register.
>>    Enable charging at driver initialization. Pick up this from Lenovo's code
>>    drop[2,3].
>>
>> Please keep in mind that I have no docs for Whiskey Cove PMIC, so this patches
>> are based on some kind of reverse engineering and suppositions, correct me if
>> this semantic is wrong for common case.
>>
>> [1]. https://github.com/01org/ProductionKernelQuilts/uefi/cht-m1stable/patches/0001-power_supply-intel-pmic-ccsm-driver.patch
>> [2]. https://github.com/jekhor/yogabook-linux-android-kernel/blob/b7aa015ab794b516da7b6cb76e5e2d427e3b8b0c/drivers/power/bq2589x_charger.c#L2257
>> [3]. https://github.com/01org/ProductionKernelQuilts/uefi/cht-m1stable/patches/EM-Charger-Disable-battery-charging-in-S3-and-enable.patch
> 
> Thank you for these patches, besides your Lenovo Yoga Book I'm aware of
> only 2 other device models using the CHT Whiskey Cove PMIC, the GPD win
> and GPD pocket devices. These both work fine without the changes your
> patches introduce.
> 
> I need to check if your changes do not cause regressions on these 2
> devices, which are used with Linux by quite a few people. I will try
> to make some time for testing this sometime next week.
> 
> A kind request to the platform-x86 driver maintainers (hi Andy): Please
> do not apply these patches until I've been able to test they don't cause
> issues elsewhere.

Erm, I just realized these are note platform-x86 driver patches at all.

Anyways same request to the extcon maintainers, please do not apply this
until I've had a chance to test this (which I'm doing right now).

Regards,

Hans

