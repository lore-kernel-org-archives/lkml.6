Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbeBYKwS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 05:52:18 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39898 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbeBYKwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 05:52:14 -0500
X-Google-Smtp-Source: AH8x225ogEQ//AjYwrnBel7PMHTHFNIoCnhgbqlVlYy4qS6PbVOxFnByIjBEp3ORUV1UYr0YYxUYxg==
Date: Sun, 25 Feb 2018 13:52:05 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Borislav Petkov <bp@suse.de>
Cc: tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, willy@infradead.org, hpa@zytor.com,
        mingo@kernel.org, kirill.shutemov@linux.intel.com,
        peterz@infradead.org, gorcunov@openvz.org, luto@amacapital.net,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/boot] x86/boot/compressed/64: Prepare trampoline memory
Message-ID: <20180225105205.xicklkl3n5azdw2j@node.shutemov.name>
References: <20180209142228.21231-4-kirill.shutemov@linux.intel.com>
 <tip-b91993a87aff6dafd60a9c8ce80ebc425161a815@git.kernel.org>
 <20180224214818.GD29374@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180224214818.GD29374@pd.tnic>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2018 at 10:48:18PM +0100, Borislav Petkov wrote:
> On Sun, Feb 11, 2018 at 04:19:38AM -0800, tip-bot for Kirill A. Shutemov wrote:
> > Commit-ID:  b91993a87aff6dafd60a9c8ce80ebc425161a815
> > Gitweb:     https://git.kernel.org/tip/b91993a87aff6dafd60a9c8ce80ebc425161a815
> > Author:     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > AuthorDate: Fri, 9 Feb 2018 17:22:27 +0300
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Sun, 11 Feb 2018 12:36:19 +0100
> > 
> > x86/boot/compressed/64: Prepare trampoline memory
> 
> This patch breaks X in my test guest image here. The failing Xorg.0.log file
> has:

Looks like the heuristic to finding right spot for trampoline fails. I
don't understand why.

Could you check if the patch below makes a difference?

If it is, could you check 0x9d000 address instead of 0x99000?

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index dad5da7b4c1a..7274a02406a4 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -32,6 +32,7 @@ struct paging_config paging_prepare(void)
 			(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
 		paging_config.l5_required = 1;
 
+#if 0
 	/*
 	 * Find a suitable spot for the trampoline.
 	 * This code is based on reserve_bios_regions().
@@ -49,6 +50,9 @@ struct paging_config paging_prepare(void)
 	/* Place the trampoline just below the end of low memory, aligned to 4k */
 	paging_config.trampoline_start = bios_start - TRAMPOLINE_32BIT_SIZE;
 	paging_config.trampoline_start = round_down(paging_config.trampoline_start, PAGE_SIZE);
+#else
+	paging_config.trampoline_start = 0x99000;
+#endif
 
 	trampoline = (unsigned long *)paging_config.trampoline_start;
 
-- 
 Kirill A. Shutemov
