Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32576C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 06:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2423206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 06:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2423206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeI2MwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 08:52:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbeI2MwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 08:52:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C993788E56;
        Sat, 29 Sep 2018 06:25:11 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-53.pek2.redhat.com [10.72.12.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3550608E5;
        Sat, 29 Sep 2018 06:24:57 +0000 (UTC)
Subject: Re: [PATCH v7 RESEND 4/4] kdump/vmcore: support encrypted old memory
 with SME enabled
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com, bhe@redhat.com,
        jroedel@suse.de
References: <20180927071954.29615-1-lijiang@redhat.com>
 <20180927071954.29615-5-lijiang@redhat.com> <20180928083852.GA21895@zn.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <1c27b9a9-ae93-011a-b003-a50ecc22ccc5@redhat.com>
Date:   Sat, 29 Sep 2018 14:24:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928083852.GA21895@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sat, 29 Sep 2018 06:25:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年09月28日 16:38, Borislav Petkov 写道:
> On Thu, Sep 27, 2018 at 03:19:54PM +0800, Lianbo Jiang wrote:
>> In kdump kernel, we need to dump the old memory into vmcore file,if SME
>> is enabled in the first kernel, we have to remap the old memory with the
>> memory encryption mask, which will be automatically decrypted when we
>> read from DRAM.
>>
>> For SME kdump, there are two cases that doesn't support:
> 
> ... and which are simply silly to support.
> 

But the root cause is that the encryption key is not visible to any software
running on the CPU cores(AMD cpu with SME), and is randomly generated on each
system reset. That is to say, kdump kernel won't have a chance to get the
encryption key. So the encrypted memory can not be decrypted unless SME is
active. 

Thanks.
>>
>>  ----------------------------------------------
>> | first-kernel | second-kernel | kdump support |
>> |      (mem_encrypt=on|off)    |   (yes|no)    |
>> |--------------+---------------+---------------|
>> |     on       |     on        |     yes       |
>> |     off      |     off       |     yes       |
>> |     on       |     off       |     no        |
>> |     off      |     on        |     no        |
>> |______________|_______________|_______________|
>>
>> 1. SME is enabled in the first kernel, but SME is disabled in kdump kernel
>> In this case, because the old memory is encrypted, we can't decrypt the
>> old memory.
>>
>> 2. SME is disabled in the first kernel, but SME is enabled in kdump kernel
>> On the one hand, the old memory is unencrypted, the old memory can be dumped
> 
> s/unencrypted/decrypted/g
> 
> But I mentioned that already.
> 

Thanks for your valuable advice to improve these patches.
The patch log and all code style issue will be improved.

>> as usual, we don't need to enable SME in kdump kernel; On the other hand, it
>> will increase the complexity of the code, we will have to consider how to
>> pass the SME flag from the first kernel to the kdump kernel, it is really
>> too expensive to do this.
>>
>> This patches are only for SME kdump, the patches don't support SEV kdump.
> 
> Please rewrite that commit message in passive voice. I.e., get rid of
> that "we".
> 
>>
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>  arch/x86/kernel/Makefile             |  1 +
>>  arch/x86/kernel/crash_dump_encrypt.c | 53 ++++++++++++++++++++++++++++
>>  fs/proc/vmcore.c                     | 21 +++++++----
>>  include/linux/crash_dump.h           | 12 +++++++
>>  4 files changed, 81 insertions(+), 6 deletions(-)
>>  create mode 100644 arch/x86/kernel/crash_dump_encrypt.c
>>
>> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
>> index 8824d01c0c35..dfbeae0e35ce 100644
>> --- a/arch/x86/kernel/Makefile
>> +++ b/arch/x86/kernel/Makefile
>> @@ -97,6 +97,7 @@ obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec_$(BITS).o
>>  obj-$(CONFIG_KEXEC_CORE)	+= relocate_kernel_$(BITS).o crash.o
>>  obj-$(CONFIG_KEXEC_FILE)	+= kexec-bzimage64.o
>>  obj-$(CONFIG_CRASH_DUMP)	+= crash_dump_$(BITS).o
>> +obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= crash_dump_encrypt.o
> 
> No no.
> 
> This will build even in the CONFIG_CRASH_DUMP=n case.
> 
> Why does this need to be even a separate compilation unit? It is a file
> containing a single function?!?!
> 
> I would love to know what the logic behind this was...
> 
Good question. It's my pleasure.

At first, i added an input parameter for read_from_oldmem() because of encryption(SME). But
for avoiding to also add the same parameter for copy_oldmem_page(), so i added a new function
copy_oldmem_page_encrypted(). Maybe you had noticed that these functions were very similar. 

Sometimes, it is hard to make a choice about this. The reasons are as follows:

A. If i add the same input parameter for copy_oldmem_page(), which will cause more code changes,
   because the interface changes will affect other architectures, such as ARM/MIPS/POWERPC/S390.

B. If not A, i have to add a new function copy_oldmem_page_encrypted(), and also put it into a
   same file(arch/x86/kernel/crash_dump_64.c).
 
   Should i merge the similar functions into one function?
   ( copy_oldmem_page() and copy_oldmem_page_encrypted() )

   a. If the answer is no, i will have two choices:
      1). put these functions into a same file(arch/x86/kernel/crash_dump_64.c). But someone
          thought that these functions were too similar, these functions should be merged or
          rebuilt. This is contradictory to the case a.
      2). add a new file for copy_oldmem_page_encrypted(), then which will avoid the case '1)'.
          That is just current solution.

   b. If the answer is yes, i have to add an input parameter for copy_oldmem_page(), this is back
      to the case A.

Could you give me any advice about this? Any advice will be appreciated.

Thanks.
Lianbo

>>  obj-y				+= kprobes/
>>  obj-$(CONFIG_MODULES)		+= module.o
>>  obj-$(CONFIG_DOUBLEFAULT)	+= doublefault.o
>> diff --git a/arch/x86/kernel/crash_dump_encrypt.c b/arch/x86/kernel/crash_dump_encrypt.c
>> new file mode 100644
>> index 000000000000..e1b1a577f197
>> --- /dev/null
>> +++ b/arch/x86/kernel/crash_dump_encrypt.c
>> @@ -0,0 +1,53 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + *	Memory preserving reboot related code.
>> + *
>> + *	Created by: Lianbo Jiang (lijiang@redhat.com)
>> + *	Copyright (C) RedHat Corporation, 2018. All rights reserved
>> + */
>> +
>> +#include <linux/errno.h>
>> +#include <linux/crash_dump.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/io.h>
>> +
>> +/**
>> + * copy_oldmem_page_encrypted - copy one page from "oldmem encrypted"
>> + * @pfn: page frame number to be copied
>> + * @buf: target memory address for the copy; this can be in kernel address
>> + *	space or user address space (see @userbuf)
>> + * @csize: number of bytes to copy
>> + * @offset: offset in bytes into the page (based on pfn) to begin the copy
>> + * @userbuf: if set, @buf is in user address space, use copy_to_user(),
>> + *	otherwise @buf is in kernel address space, use memcpy().
>> + *
>> + * Copy a page from "oldmem encrypted". For this page, there is no pte
> 
> What is "oldmem encrypted"? Why can't you explain that in plain english?

So sorry, here "oldmem encrypted" means the "old memory is encrypted".

> Note that those comments are not write-only but are meant for other
> people to read in the future.
> 
>> + * mapped in the current kernel. We stitch up a pte, similar to
>> + * kmap_atomic.
>> + */
>> +
>> +ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
>> +		size_t csize, unsigned long offset, int userbuf)
> 
> Align arguments on the opening brace.
> 
>> +{
>> +	void  *vaddr;
>> +
>> +	if (!csize)
>> +		return 0;
>> +
>> +	vaddr = (__force void *)ioremap_encrypted(pfn << PAGE_SHIFT,
>> +						  PAGE_SIZE);
> 
> Let it stick out.
> 
>> +	if (!vaddr)
>> +		return -ENOMEM;
>> +
>> +	if (userbuf) {
>> +		if (copy_to_user((void __user *)buf, vaddr + offset, csize)) {
>> +			iounmap((void __iomem *)vaddr);
>> +			return -EFAULT;
>> +		}
>> +	} else
>> +		memcpy(buf, vaddr + offset, csize);
>> +
>> +	set_iounmap_nonlazy();
>> +	iounmap((void __iomem *)vaddr);
>> +	return csize;
>> +}
>> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
>> index cbde728f8ac6..3065c8bada6a 100644
>> --- a/fs/proc/vmcore.c
>> +++ b/fs/proc/vmcore.c
>> @@ -25,6 +25,9 @@
>>  #include <linux/pagemap.h>
>>  #include <linux/uaccess.h>
>>  #include <asm/io.h>
>> +#include <linux/io.h>
>> +#include <linux/mem_encrypt.h>
>> +#include <asm/pgtable.h>
> 
> Do you not see how the order of the include files is? First linux/ then
> asm/, then local headers.
> 
>>  #include "internal.h"
> 
> And you don't need that if you drop that silly crash_dump_encrypt.c thing.
> 
>>  
>>  /* List representing chunks of contiguous memory areas and their offsets in
>> @@ -98,7 +101,8 @@ static int pfn_is_ram(unsigned long pfn)
>>  
>>  /* Reads a page from the oldmem device from given offset. */
>>  static ssize_t read_from_oldmem(char *buf, size_t count,
>> -				u64 *ppos, int userbuf)
>> +				u64 *ppos, int userbuf,
>> +				bool encrypted)
>>  {
>>  	unsigned long pfn, offset;
>>  	size_t nr_bytes;
>> @@ -120,8 +124,11 @@ static ssize_t read_from_oldmem(char *buf, size_t count,
>>  		if (pfn_is_ram(pfn) == 0)
>>  			memset(buf, 0, nr_bytes);
>>  		else {
>> -			tmp = copy_oldmem_page(pfn, buf, nr_bytes,
>> -						offset, userbuf);
>> +			tmp = encrypted ? copy_oldmem_page_encrypted(pfn,
>> +					    buf, nr_bytes, offset, userbuf)
>> +					: copy_oldmem_page(pfn, buf, nr_bytes,
>> +							   offset, userbuf);
> 
> Make that a simple if-else so that it can actually be readable.
> 
