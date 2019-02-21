Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CACC10F07
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F003420880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfBUAne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:43:34 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:49584 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726090AbfBUAne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:43:34 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A6A47E6DB7A5A13EB10B;
        Thu, 21 Feb 2019 08:43:29 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Thu, 21 Feb 2019
 08:43:22 +0800
Subject: Re: linux-next: Tree for Feb 20
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <20190220184341.73bd2084@canb.auug.org.au>
 <1114b964-8ff8-5632-64d4-e94a9160b998@hisilicon.com>
 <20190220095252.GA9089@linux.intel.com>
 <20190220095806.GB9089@linux.intel.com>
 <CAKv+Gu8G5eWeAdCB28xa=16ANFd2he9WPSztgXYwYRkhPfpEyA@mail.gmail.com>
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>
From:   Zhangshaokun <zhangshaokun@hisilicon.com>
Message-ID: <aaac08b0-6366-7b63-d6a7-eea6630ce169@hisilicon.com>
Date:   Thu, 21 Feb 2019 08:43:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8G5eWeAdCB28xa=16ANFd2he9WPSztgXYwYRkhPfpEyA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On 2019/2/20 18:05, Ard Biesheuvel wrote:
> On Wed, 20 Feb 2019 at 10:58, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
>>
>> On Wed, Feb 20, 2019 at 11:52:52AM +0200, Jarkko Sakkinen wrote:
>>> On Wed, Feb 20, 2019 at 05:11:15PM +0800, Zhangshaokun wrote:
>>>> There is a compiler failure on arm64 platform, as follow:
>>>>
>>>>   AS      arch/arm64/kvm/hyp.o
>>>>   CC      kernel/trace/ring_buffer.o
>>>> In file included from security/integrity/ima/ima_fs.c:30:0:
>>>> security/integrity/ima/ima.h:176:7: error: redeclaration of enumerator ‘NONE’
>>>>   hook(NONE)   \
>>>>        ^
>>>> security/integrity/ima/ima.h:188:34: note: in definition of macro ‘__ima_hook_enumify’
>>>>  #define __ima_hook_enumify(ENUM) ENUM,
>>>>                                   ^
>>>> security/integrity/ima/ima.h:191:2: note: in expansion of macro ‘__ima_hooks’
>>>>   __ima_hooks(__ima_hook_enumify)
>>>>   ^
>>>> In file included from ./arch/arm64/include/asm/acpi.h:15:0,
>>>>                  from ./include/acpi/acpi_io.h:7,
>>>>                  from ./include/linux/acpi.h:47,
>>>>                  from ./include/linux/tpm.h:26,
>>>>                  from security/integrity/ima/ima.h:25,
>>>>                  from security/integrity/ima/ima_fs.c:30:
>>>> ./include/linux/efi.h:1716:2: note: previous definition of ‘NONE’ was here
>>>>   NONE,
>>>>   ^
>>>> scripts/Makefile.build:276: recipe for target 'security/integrity/ima/ima_fs.o' failed
>>>> make[3]: *** [security/integrity/ima/ima_fs.o] Error 1
>>>>
>>>> I dug it and it is the commit 901615cb916d ("tpm: move tpm_chip definition to include/linux/tpm.h")
>>>
>>> This results from a new include in tpm.h:
>>>
>>>   #include <linux/acpi.h>
>>>
>>> Must be fixed either in include/linux/efi.h or security/integrity/ima.h as
>>> those files have a name collision. Makes me wonder why neither has taken
>>> care of prefixing the constants properly.
>>
>> Preferably both subsystems should be fixed with proper 'EFI_' and 'IMA_'
>> prefixes. Defining a constant named as NONE in a non-generic subsystem
>> (e.g. not part of the core data structures of Linux) and especially
>> exporting it to include/linux is not too well considered act.
>>
> 
> Fixes for this have already been proposed, and should appear in -next shortly
> 
> The EFI one is here
> https://mail.google.com/mail/u/0/#label/linux-efi/FMfcgxwBVgrQRjglPkWRqRqVclGgVDnB
> 

Because of no privilege, the website is denied for me. Anyway, it's nice to have been fixed.

Thanks,
Shaokun

> Not sure about the IMA one, Mimi should be able to comment ...
> 
> .
> 

