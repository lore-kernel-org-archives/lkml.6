Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA50DC004D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A639421748
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A639421748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbeI1PBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:01:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:50798 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727389AbeI1PBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:01:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3BBA6ACBF;
        Fri, 28 Sep 2018 08:38:52 +0000 (UTC)
Date:   Fri, 28 Sep 2018 10:38:52 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com, bhe@redhat.com,
        jroedel@suse.de
Subject: Re: [PATCH v7 RESEND 4/4] kdump/vmcore: support encrypted old memory
 with SME enabled
Message-ID: <20180928083852.GA21895@zn.tnic>
References: <20180927071954.29615-1-lijiang@redhat.com>
 <20180927071954.29615-5-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180927071954.29615-5-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 03:19:54PM +0800, Lianbo Jiang wrote:
> In kdump kernel, we need to dump the old memory into vmcore file,if SME
> is enabled in the first kernel, we have to remap the old memory with the
> memory encryption mask, which will be automatically decrypted when we
> read from DRAM.
> 
> For SME kdump, there are two cases that doesn't support:

... and which are simply silly to support.

> 
>  ----------------------------------------------
> | first-kernel | second-kernel | kdump support |
> |      (mem_encrypt=on|off)    |   (yes|no)    |
> |--------------+---------------+---------------|
> |     on       |     on        |     yes       |
> |     off      |     off       |     yes       |
> |     on       |     off       |     no        |
> |     off      |     on        |     no        |
> |______________|_______________|_______________|
> 
> 1. SME is enabled in the first kernel, but SME is disabled in kdump kernel
> In this case, because the old memory is encrypted, we can't decrypt the
> old memory.
> 
> 2. SME is disabled in the first kernel, but SME is enabled in kdump kernel
> On the one hand, the old memory is unencrypted, the old memory can be dumped

s/unencrypted/decrypted/g

But I mentioned that already.

> as usual, we don't need to enable SME in kdump kernel; On the other hand, it
> will increase the complexity of the code, we will have to consider how to
> pass the SME flag from the first kernel to the kdump kernel, it is really
> too expensive to do this.
> 
> This patches are only for SME kdump, the patches don't support SEV kdump.

Please rewrite that commit message in passive voice. I.e., get rid of
that "we".

> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  arch/x86/kernel/Makefile             |  1 +
>  arch/x86/kernel/crash_dump_encrypt.c | 53 ++++++++++++++++++++++++++++
>  fs/proc/vmcore.c                     | 21 +++++++----
>  include/linux/crash_dump.h           | 12 +++++++
>  4 files changed, 81 insertions(+), 6 deletions(-)
>  create mode 100644 arch/x86/kernel/crash_dump_encrypt.c
> 
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 8824d01c0c35..dfbeae0e35ce 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -97,6 +97,7 @@ obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec_$(BITS).o
>  obj-$(CONFIG_KEXEC_CORE)	+= relocate_kernel_$(BITS).o crash.o
>  obj-$(CONFIG_KEXEC_FILE)	+= kexec-bzimage64.o
>  obj-$(CONFIG_CRASH_DUMP)	+= crash_dump_$(BITS).o
> +obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= crash_dump_encrypt.o

No no.

This will build even in the CONFIG_CRASH_DUMP=n case.

Why does this need to be even a separate compilation unit? It is a file
containing a single function?!?!

I would love to know what the logic behind this was...

>  obj-y				+= kprobes/
>  obj-$(CONFIG_MODULES)		+= module.o
>  obj-$(CONFIG_DOUBLEFAULT)	+= doublefault.o
> diff --git a/arch/x86/kernel/crash_dump_encrypt.c b/arch/x86/kernel/crash_dump_encrypt.c
> new file mode 100644
> index 000000000000..e1b1a577f197
> --- /dev/null
> +++ b/arch/x86/kernel/crash_dump_encrypt.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *	Memory preserving reboot related code.
> + *
> + *	Created by: Lianbo Jiang (lijiang@redhat.com)
> + *	Copyright (C) RedHat Corporation, 2018. All rights reserved
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/crash_dump.h>
> +#include <linux/uaccess.h>
> +#include <linux/io.h>
> +
> +/**
> + * copy_oldmem_page_encrypted - copy one page from "oldmem encrypted"
> + * @pfn: page frame number to be copied
> + * @buf: target memory address for the copy; this can be in kernel address
> + *	space or user address space (see @userbuf)
> + * @csize: number of bytes to copy
> + * @offset: offset in bytes into the page (based on pfn) to begin the copy
> + * @userbuf: if set, @buf is in user address space, use copy_to_user(),
> + *	otherwise @buf is in kernel address space, use memcpy().
> + *
> + * Copy a page from "oldmem encrypted". For this page, there is no pte

What is "oldmem encrypted"? Why can't you explain that in plain english?
Note that those comments are not write-only but are meant for other
people to read in the future.

> + * mapped in the current kernel. We stitch up a pte, similar to
> + * kmap_atomic.
> + */
> +
> +ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
> +		size_t csize, unsigned long offset, int userbuf)

Align arguments on the opening brace.

> +{
> +	void  *vaddr;
> +
> +	if (!csize)
> +		return 0;
> +
> +	vaddr = (__force void *)ioremap_encrypted(pfn << PAGE_SHIFT,
> +						  PAGE_SIZE);

Let it stick out.

> +	if (!vaddr)
> +		return -ENOMEM;
> +
> +	if (userbuf) {
> +		if (copy_to_user((void __user *)buf, vaddr + offset, csize)) {
> +			iounmap((void __iomem *)vaddr);
> +			return -EFAULT;
> +		}
> +	} else
> +		memcpy(buf, vaddr + offset, csize);
> +
> +	set_iounmap_nonlazy();
> +	iounmap((void __iomem *)vaddr);
> +	return csize;
> +}
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index cbde728f8ac6..3065c8bada6a 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -25,6 +25,9 @@
>  #include <linux/pagemap.h>
>  #include <linux/uaccess.h>
>  #include <asm/io.h>
> +#include <linux/io.h>
> +#include <linux/mem_encrypt.h>
> +#include <asm/pgtable.h>

Do you not see how the order of the include files is? First linux/ then
asm/, then local headers.

>  #include "internal.h"

And you don't need that if you drop that silly crash_dump_encrypt.c thing.

>  
>  /* List representing chunks of contiguous memory areas and their offsets in
> @@ -98,7 +101,8 @@ static int pfn_is_ram(unsigned long pfn)
>  
>  /* Reads a page from the oldmem device from given offset. */
>  static ssize_t read_from_oldmem(char *buf, size_t count,
> -				u64 *ppos, int userbuf)
> +				u64 *ppos, int userbuf,
> +				bool encrypted)
>  {
>  	unsigned long pfn, offset;
>  	size_t nr_bytes;
> @@ -120,8 +124,11 @@ static ssize_t read_from_oldmem(char *buf, size_t count,
>  		if (pfn_is_ram(pfn) == 0)
>  			memset(buf, 0, nr_bytes);
>  		else {
> -			tmp = copy_oldmem_page(pfn, buf, nr_bytes,
> -						offset, userbuf);
> +			tmp = encrypted ? copy_oldmem_page_encrypted(pfn,
> +					    buf, nr_bytes, offset, userbuf)
> +					: copy_oldmem_page(pfn, buf, nr_bytes,
> +							   offset, userbuf);

Make that a simple if-else so that it can actually be readable.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
