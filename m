Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B9AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0801A222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407976AbfBNQcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:32:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:49112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407963AbfBNQb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:31:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9F93AF63;
        Thu, 14 Feb 2019 16:31:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0929E1E0900; Thu, 14 Feb 2019 17:31:56 +0100 (CET)
Date:   Thu, 14 Feb 2019 17:31:56 +0100
From:   Jan Kara <jack@suse.cz>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@ozlabs.org, aneesh.kumar@linux.vnet.ibm.com,
        jack@suse.cz, erhard_f@mailbox.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] powerpc/64s: Fix possible corruption on big endian due
 to pgd/pud_present()
Message-ID: <20190214163156.GB23000@quack2.suse.cz>
References: <20190214062339.7139-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214062339.7139-1-mpe@ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14-02-19 17:23:39, Michael Ellerman wrote:
> In v4.20 we changed our pgd/pud_present() to check for _PAGE_PRESENT
> rather than just checking that the value is non-zero, e.g.:
> 
>   static inline int pgd_present(pgd_t pgd)
>   {
>  -       return !pgd_none(pgd);
>  +       return (pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
>   }
> 
> Unfortunately this is broken on big endian, as the result of the
> bitwise && is truncated to int, which is always zero because
> _PAGE_PRESENT is 0x8000000000000000ul. This means pgd_present() and
> pud_present() are always false at compile time, and the compiler
> elides the subsequent code.
> 
> Remarkably with that bug present we are still able to boot and run
> with few noticeable effects. However under some work loads we are able
> to trigger a warning in the ext4 code:

Wow, good catch. I wouldn't believe there are so few bad effects from
such a major breakage! :)

								Honza

> 
>   WARNING: CPU: 11 PID: 29593 at fs/ext4/inode.c:3927 .ext4_set_page_dirty+0x70/0xb0
>   CPU: 11 PID: 29593 Comm: debugedit Not tainted 4.20.0-rc1 #1
>   ...
>   NIP .ext4_set_page_dirty+0x70/0xb0
>   LR  .set_page_dirty+0xa0/0x150
>   Call Trace:
>    .set_page_dirty+0xa0/0x150
>    .unmap_page_range+0xbf0/0xe10
>    .unmap_vmas+0x84/0x130
>    .unmap_region+0xe8/0x190
>    .__do_munmap+0x2f0/0x510
>    .__vm_munmap+0x80/0x110
>    .__se_sys_munmap+0x14/0x30
>    system_call+0x5c/0x70
> 
> The fix is simple, we need to convert the result of the bitwise && to
> an int before returning it.
> 
> Thanks to Jan Kara and Aneesh for help with debugging.
> 
> Fixes: da7ad366b497 ("powerpc/mm/book3s: Update pmd_present to look at _PAGE_PRESENT bit")
> Cc: stable@vger.kernel.org # v4.20+
> Reported-by: Erhard F. <erhard_f@mailbox.org>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index c9bfe526ca9d..d8c8d7c9df15 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -904,7 +904,7 @@ static inline int pud_none(pud_t pud)
>  
>  static inline int pud_present(pud_t pud)
>  {
> -	return (pud_raw(pud) & cpu_to_be64(_PAGE_PRESENT));
> +	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PRESENT));
>  }
>  
>  extern struct page *pud_page(pud_t pud);
> @@ -951,7 +951,7 @@ static inline int pgd_none(pgd_t pgd)
>  
>  static inline int pgd_present(pgd_t pgd)
>  {
> -	return (pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
> +	return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
>  }
>  
>  static inline pte_t pgd_pte(pgd_t pgd)
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
