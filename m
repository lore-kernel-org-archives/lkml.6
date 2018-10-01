Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A619C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB1220666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB1220666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeJBDCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:02:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:59744 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbeJBDCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:02:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E7A9DAEE9;
        Mon,  1 Oct 2018 20:22:43 +0000 (UTC)
Date:   Mon, 1 Oct 2018 22:22:44 +0200
From:   Borislav Petkov <bp@suse.de>
To:     lijiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com, bhe@redhat.com,
        jroedel@suse.de
Subject: Re: [PATCH v9 4/4] kdump/vmcore: support encrypted old memory with
 SME enabled
Message-ID: <20181001202244.GB8350@zn.tnic>
References: <20180930031033.22110-1-lijiang@redhat.com>
 <20180930031033.22110-5-lijiang@redhat.com>
 <be7b47f9-6be6-e0d1-2c2a-9125bc74b818@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be7b47f9-6be6-e0d1-2c2a-9125bc74b818@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 04:37:41PM +0800, lijiang wrote:
> In kdump kernel, the old memory needs to be dumped into vmcore file.
> If SME is enabled in the first kernel, the old memory has to be
> remapped with the memory encryption mask, which will be automatically
> decrypted when read from DRAM.
> 
> For SME kdump, there are two cases that doesn't support:

Get rid of those two cases in the commit message.

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
> In this case, because the old memory is encrypted, it can't be decrypted.
> The root cause is that the encryption key is not visible to any software
> runnint on the CPU cores(AMD cpu with SME), and is randomly generated on
> eache system reset. That is to say, kdump kernel won't have a chance to
> get the encryption key. So the encrypted memory can not be decrypted
> unless SME is active.
> 
> 2. SME is disabled in the first kernel, but SME is enabled in kdump kernel
> On the one hand, the old memory is decrypted, the old memory can be dumped
> as usual, so SME doesn't need to be enabled in kdump kernel; On the other
> hand, it will increase the complexity of the code, because that will have
> to consider how to pass the SME flag from the first kernel to the kdump
> kernel, it is really too expensive to do this.
> 
> This patches are only for SME kdump, the patches don't support SEV kdump.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

You cannot keep Reviewed-by: tags on patches which you change in a
non-trivial manner.

> ---
> Changes since v7:
> 1. Delete a file arch/x86/kernel/crash_dump_encrypt.c, and move the
> copy_oldmem_page_encrypted() to arch/x86/kernel/crash_dump_64.c, also
> rewrite some functions.(Suggested by Borislav)
> 2. Modify all code style issue.(Suggested by Borislav)
> 3. Remove a reduntant header file.(Suggested by Borislav)
> 4. Improve patch log.(Suggested by Borislav)
> 5. Modify compile error "fs/proc/vmcore.c:115: undefined reference
>    to `copy_oldmem_page_encrypted'"
> 6. Modify compile error "arch/x86//kernel/crash_dump_64.c:93:9:
>    error: redefinition of 'copy_oldmem_page_encrypted'"
> 
>  arch/x86/kernel/crash_dump_64.c | 65 ++++++++++++++++++++++++++++-----
>  fs/proc/vmcore.c                | 24 +++++++++---
>  include/linux/crash_dump.h      | 13 +++++++
>  3 files changed, 87 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
> index 4f2e0778feac..6adbde592c44 100644
> --- a/arch/x86/kernel/crash_dump_64.c
> +++ b/arch/x86/kernel/crash_dump_64.c
> @@ -12,7 +12,7 @@
>  #include <linux/io.h>
>  
>  /**
> - * copy_oldmem_page - copy one page from "oldmem"
> + * __copy_oldmem_page - copy one page from "old memory encrypted or decrypted"

Dammit, what's it with those "old memory encrypted or decrypted" in quotation
marks?! What is wrong with simply saying:

Copy one page of the old kernel's memory. If @encrypted is set, the old
memory will be remapped with the encryption mask.

How hard is that?!

>   * @pfn: page frame number to be copied
>   * @buf: target memory address for the copy; this can be in kernel address
>   *	space or user address space (see @userbuf)
> @@ -20,31 +20,78 @@
>   * @offset: offset in bytes into the page (based on pfn) to begin the copy
>   * @userbuf: if set, @buf is in user address space, use copy_to_user(),
>   *	otherwise @buf is in kernel address space, use memcpy().
> + * @encrypted: if true, the old memory is encrypted.
> + *             if false, the old memory is decrypted.
>   *
> - * Copy a page from "oldmem". For this page, there is no pte mapped
> - * in the current kernel. We stitch up a pte, similar to kmap_atomic.
> + * Copy a page from "old memory encrypted or decrypted". For this page, there
> + * is no pte mapped in the current kernel. We stitch up a pte, similar to
> + * kmap_atomic.
>   */

This function is static now - why does it need to keep the comments
above it? And you've duplicated almost the same comment *three* times
now. Why?

Have the whole comment *once* and only one line sentences over the other
functions explaining the difference only.

> -ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
> -		size_t csize, unsigned long offset, int userbuf)
> +static ssize_t __copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
> +				  unsigned long offset, int userbuf,
> +				  bool encrypted)
>  {
>  	void  *vaddr;

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
