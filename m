Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BA4C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8B920880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D8B920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeILUOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:14:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47109 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeILUOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:14:22 -0400
Received: from [114.245.38.229] (helo=[192.168.1.10])
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <aaron.ma@canonical.com>)
        id 1g06lf-0005Py-9p; Wed, 12 Sep 2018 15:09:24 +0000
Subject: Re: [PATCH] x86/efi: earlyprintk - Add 64bit efi fb address support
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1536423828-5693-1-git-send-email-aaron.ma@canonical.com>
 <CAKv+Gu_dfQUXDdvk99fe6-qW3wj8e=8wR2aqCtJj1GfkXirzRg@mail.gmail.com>
From:   Aaron Ma <aaron.ma@canonical.com>
Openpgp: preference=signencrypt
Message-ID: <7b08c376-2c34-d462-9d6f-2a104ca48878@canonical.com>
Date:   Wed, 12 Sep 2018 23:09:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu_dfQUXDdvk99fe6-qW3wj8e=8wR2aqCtJj1GfkXirzRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 11:00 PM, Ard Biesheuvel wrote:
> On 8 September 2018 at 18:23, Aaron Ma <aaron.ma@canonical.com> wrote:
>> EFI GOP uses 64-bit frame buffer address in some BIOS.
>> Add 64bit address support in efi earlyprintk.
>>
>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>> ---
>>  arch/x86/platform/efi/early_printk.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/x86/platform/efi/early_printk.c b/arch/x86/platform/efi/early_printk.c
>> index 5fdacb322ceb..c0ae25f59acd 100644
>> --- a/arch/x86/platform/efi/early_printk.c
>> +++ b/arch/x86/platform/efi/early_printk.c
>> @@ -32,6 +32,8 @@ static __init int early_efi_map_fb(void)
>>                 return 0;
>>
>>         base = boot_params.screen_info.lfb_base;
>> +       if (boot_params.screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
>> +               base |= (u64)boot_params.screen_info.ext_lfb_base << 32;
>>         size = boot_params.screen_info.lfb_size;
>>         efi_fb = ioremap(base, size);
>>
>> @@ -49,6 +51,8 @@ static __ref void *early_efi_map(unsigned long start, unsigned long len)
>>         unsigned long base;
>>
>>         base = boot_params.screen_info.lfb_base;
>> +       if (boot_params.screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
>> +               base |= (u64)boot_params.screen_info.ext_lfb_base << 32;
>>
>>         if (efi_fb)
>>                 return (efi_fb + start);
> Please fix this in a way that works on 32-bit x86/PAE as well (i.e.,
> use a suitable type for base)
> 

Right, I will send a v2 patch.

Thanks,
Aaron
