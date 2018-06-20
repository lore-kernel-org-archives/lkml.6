Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40166C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08DD20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08DD20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753832AbeFTEuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:50:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751422AbeFTEuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:50:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C913579D36;
        Wed, 20 Jun 2018 04:50:19 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-88.pek2.redhat.com [10.72.12.88])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A9A476EF;
        Wed, 20 Jun 2018 04:50:14 +0000 (UTC)
Subject: Re: [PATCH 4/4 V3] Help to dump the old memory encrypted into vmcore
 file
From:   lijiang <lijiang@redhat.com>
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        iommu@lists.linux-foundation.org, kexec@lists.infradead.org
References: <20180616082714.32035-1-lijiang@redhat.com>
 <20180616082714.32035-5-lijiang@redhat.com>
 <20180619031653.GA7101@dhcp-128-65.nay.redhat.com>
 <ca71214f-0a96-32cc-301a-34e31029bfe6@redhat.com>
Message-ID: <fc5aac1f-eb97-1df5-dfda-54ff0c2f514e@redhat.com>
Date:   Wed, 20 Jun 2018 12:50:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <ca71214f-0a96-32cc-301a-34e31029bfe6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 20 Jun 2018 04:50:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 20 Jun 2018 04:50:19 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lijiang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年06月19日 22:46, lijiang 写道:
> 在 2018年06月19日 11:16, Dave Young 写道:
>> On 06/16/18 at 04:27pm, Lianbo Jiang wrote:
>>> In kdump mode, we need to dump the old memory into vmcore file,
>>> if SME is enabled in the first kernel, we must remap the old
>>> memory in encrypted manner, which will be automatically decrypted
>>> when we read from DRAM. It helps to parse the vmcore for some tools.
>>>
>>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>>> ---
>>> Some changes:
>>> 1. add a new file and modify Makefile.
>>> 2. remove some code in sev_active().
>>>
>>>  arch/x86/kernel/Makefile             |  1 +
>>>  arch/x86/kernel/crash_dump_encrypt.c | 53 ++++++++++++++++++++++++++++++++++++
>>>  fs/proc/vmcore.c                     | 20 ++++++++++----
>>>  include/linux/crash_dump.h           | 11 ++++++++
>>>  4 files changed, 79 insertions(+), 6 deletions(-)
>>>  create mode 100644 arch/x86/kernel/crash_dump_encrypt.c
>>>
>>> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
>>> index 02d6f5c..afb5bad 100644
>>> --- a/arch/x86/kernel/Makefile
>>> +++ b/arch/x86/kernel/Makefile
>>> @@ -96,6 +96,7 @@ obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec_$(BITS).o
>>>  obj-$(CONFIG_KEXEC_CORE)	+= relocate_kernel_$(BITS).o crash.o
>>>  obj-$(CONFIG_KEXEC_FILE)	+= kexec-bzimage64.o
>>>  obj-$(CONFIG_CRASH_DUMP)	+= crash_dump_$(BITS).o
>>> +obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= crash_dump_encrypt.o
>>>  obj-y				+= kprobes/
>>>  obj-$(CONFIG_MODULES)		+= module.o
>>>  obj-$(CONFIG_DOUBLEFAULT)	+= doublefault.o
>>> diff --git a/arch/x86/kernel/crash_dump_encrypt.c b/arch/x86/kernel/crash_dump_encrypt.c
>>> new file mode 100644
>>> index 0000000..e44ef33
>>> --- /dev/null
>>> +++ b/arch/x86/kernel/crash_dump_encrypt.c
>>> @@ -0,0 +1,53 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + *	Memory preserving reboot related code.
>>> + *
>>> + *	Created by: Lianbo Jiang (lijiang@redhat.com)
>>> + *	Copyright (C) RedHat Corporation, 2018. All rights reserved
>>> + */
>>> +
>>> +#include <linux/errno.h>
>>> +#include <linux/crash_dump.h>
>>> +#include <linux/uaccess.h>
>>> +#include <linux/io.h>
>>> +
>>> +/**
>>> + * copy_oldmem_page_encrypted - copy one page from "oldmem encrypted"
>>> + * @pfn: page frame number to be copied
>>> + * @buf: target memory address for the copy; this can be in kernel address
>>> + *	space or user address space (see @userbuf)
>>> + * @csize: number of bytes to copy
>>> + * @offset: offset in bytes into the page (based on pfn) to begin the copy
>>> + * @userbuf: if set, @buf is in user address space, use copy_to_user(),
>>> + *	otherwise @buf is in kernel address space, use memcpy().
>>> + *
>>> + * Copy a page from "oldmem encrypted". For this page, there is no pte
>>> + * mapped in the current kernel. We stitch up a pte, similar to
>>> + * kmap_atomic.
>>> + */
>>> +
>>> +ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
>>> +		size_t csize, unsigned long offset, int userbuf)
>>> +{
>>> +	void  *vaddr;
>>> +
>>> +	if (!csize)
>>> +		return 0;
>>> +
>>> +	vaddr = (__force void *)ioremap_encrypted(pfn << PAGE_SHIFT,
>>> +						  PAGE_SIZE);
>>> +	if (!vaddr)
>>> +		return -ENOMEM;
>>> +
>>> +	if (userbuf) {
>>> +		if (copy_to_user((void __user *)buf, vaddr + offset, csize)) {
>>> +			iounmap((void __iomem *)vaddr);
>>> +			return -EFAULT;
>>> +		}
>>> +	} else
>>> +		memcpy(buf, vaddr + offset, csize);
>>> +
>>> +	set_iounmap_nonlazy();
>>> +	iounmap((void __iomem *)vaddr);
>>> +	return csize;
>>> +}
>>> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
>>> index a45f0af..5200266 100644
>>> --- a/fs/proc/vmcore.c
>>> +++ b/fs/proc/vmcore.c
>>> @@ -25,6 +25,8 @@
>>>  #include <linux/uaccess.h>
>>>  #include <asm/io.h>
>>>  #include "internal.h"
>>> +#include <linux/mem_encrypt.h>
>>> +#include <asm/pgtable.h>
>>>  
>>>  /* List representing chunks of contiguous memory areas and their offsets in
>>>   * vmcore file.
>>> @@ -86,7 +88,8 @@ static int pfn_is_ram(unsigned long pfn)
>>>  
>>>  /* Reads a page from the oldmem device from given offset. */
>>>  static ssize_t read_from_oldmem(char *buf, size_t count,
>>> -				u64 *ppos, int userbuf)
>>> +				u64 *ppos, int userbuf,
>>> +				bool encrypted)
>>>  {
>>>  	unsigned long pfn, offset;
>>>  	size_t nr_bytes;
>>> @@ -108,8 +111,11 @@ static ssize_t read_from_oldmem(char *buf, size_t count,
>>>  		if (pfn_is_ram(pfn) == 0)
>>>  			memset(buf, 0, nr_bytes);
>>>  		else {
>>> -			tmp = copy_oldmem_page(pfn, buf, nr_bytes,
>>> -						offset, userbuf);
>>> +			tmp = encrypted ? copy_oldmem_page_encrypted(pfn,
>>> +					    buf, nr_bytes, offset, userbuf)
>>> +					: copy_oldmem_page(pfn, buf, nr_bytes,
>>> +							   offset, userbuf);
>>> +
>>>  			if (tmp < 0)
>>>  				return tmp;
>>>  		}
>>> @@ -143,7 +149,7 @@ void __weak elfcorehdr_free(unsigned long long addr)
>>>   */
>>>  ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
>>>  {
>>> -	return read_from_oldmem(buf, count, ppos, 0);
>>> +	return read_from_oldmem(buf, count, ppos, 0, false);
>>
>> The elf header actually stays in kdump kernel reserved memory so it is
>> not "oldmem", the original function is misleading and doing unnecessary
>> things.  But as for your patch maybe using it as is is good for the time
>> being and add a code comment why the encrypted is "false".
>>
> Thank you, Dave. It is a good idea to add some comments for the code.
> I rechecked the code, the elf header should be still the old memory in the first kernel,
> but why is the old memory unencrypted? Because it copies the elf header from the memory
> encrypted(user space) to the memory unencrypted(kernel space) when SME is activated in the
> first kernel, this operation just leads to decryption.
> 
I just know your means, we allocated the memory unencrypted(kernel space) in reserved
crash memory, from this point of view, it is not "oldmem". Thanks for your comments.

Thanks.
Lianbo

> Thanks.
> Lianbo
>> 	/* elfcorehdr stays in kdump kernel memory and it is not encrypted. */
>> 	return read_from_oldmem(buf, count, ppos, 0, false);
>>
>>
>> I'm thinking to move the function to something like below, still not sure
>> memremap works on every arches or not, still need more test
>>
>> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
>> index cfb6674331fd..40c01cc42b38 100644
>> --- a/fs/proc/vmcore.c
>> +++ b/fs/proc/vmcore.c
>> @@ -136,6 +136,24 @@ static ssize_t read_from_oldmem(char *buf, size_t count,
>>  	return read;
>>  }
>>  
>> +static ssize_t read_from_mem(char *buf, size_t count, u64 *ppos)
>> +{
>> +	resource_size_t offset = (resource_size_t)*ppos;
>> +	char *kbuf;
>> +
>> +	if (!count)
>> +		return 0;
>> +
>> +	kbuf = memremap(offset, count, MEMREMAP_WB);
>> +	if (!kbuf)
>> +		return 0;
>> +
>> +	memcpy(buf, kbuf, count);
>> +	memunmap(kbuf);
>> +
>> +	return count;
>> +}
>> +
>>  /*
>>   * Architectures may override this function to allocate ELF header in 2nd kernel
>>   */
>> @@ -155,7 +173,7 @@ void __weak elfcorehdr_free(unsigned long long addr)
>>   */
>>  ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
>>  {
>> -	return read_from_oldmem(buf, count, ppos, 0);
>> +	return read_from_mem(buf, count, ppos);
>>  }
>>  
>>  /*
>>  
>>
>>>  }
>>>  
>>>  /*
>>> @@ -151,7 +157,7 @@ ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
>>>   */
>>>  ssize_t __weak elfcorehdr_read_notes(char *buf, size_t count, u64 *ppos)
>>>  {
>>> -	return read_from_oldmem(buf, count, ppos, 0);
>>> +	return read_from_oldmem(buf, count, ppos, 0, sme_active());
>>>  }
>>>  
>>>  /*
>>> @@ -161,6 +167,7 @@ int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
>>>  				  unsigned long from, unsigned long pfn,
>>>  				  unsigned long size, pgprot_t prot)
>>>  {
>>> +	prot = pgprot_encrypted(prot);
>>>  	return remap_pfn_range(vma, from, pfn, size, prot);
>>>  }
>>>  
>>> @@ -235,7 +242,8 @@ static ssize_t __read_vmcore(char *buffer, size_t buflen, loff_t *fpos,
>>>  					    m->offset + m->size - *fpos,
>>>  					    buflen);
>>>  			start = m->paddr + *fpos - m->offset;
>>> -			tmp = read_from_oldmem(buffer, tsz, &start, userbuf);
>>> +			tmp = read_from_oldmem(buffer, tsz, &start, userbuf,
>>> +						sme_active());
>>>  			if (tmp < 0)
>>>  				return tmp;
>>>  			buflen -= tsz;
>>> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
>>> index f7ac2aa..f3414ff 100644
>>> --- a/include/linux/crash_dump.h
>>> +++ b/include/linux/crash_dump.h
>>> @@ -25,6 +25,17 @@ extern int remap_oldmem_pfn_range(struct vm_area_struct *vma,
>>>  
>>>  extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
>>>  						unsigned long, int);
>>> +#ifdef CONFIG_AMD_MEM_ENCRYPT
>>> +extern ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
>>> +					   size_t csize, unsigned long offset,
>>> +					   int userbuf);
>>> +#else
>>> +static inline ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
>>> +					size_t csize, unsigned long offset,
>>> +					int userbuf) {
>>
>> Personally I prefer below because it is too long:
>>
>> static inline
>> ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
>> 				   unsigned long offset, int userbuf)
>> {
>> 	return 0;
>> }
>> 			
>>
>>> +	return csize;
>>
>> As above it should be return 0;
>>
Great, Thank you, Dave.

Lianbo
>>> +}
>>> +#endif
>>>  void vmcore_cleanup(void);
>>>  
>>>  /* Architecture code defines this if there are other possible ELF
>>> -- 
>>> 2.9.5
>>>
>>>
>>> _______________________________________________
>>> kexec mailing list
>>> kexec@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/kexec
>>
>> Thanks
>> Dave
>>
