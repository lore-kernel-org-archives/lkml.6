Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbeBZKzJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 05:55:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:57964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752328AbeBZKzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 05:55:05 -0500
Date: Mon, 26 Feb 2018 11:54:40 +0100
From: Borislav Petkov <bp@suse.de>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Ingo Molnar <mingo@kernel.org>, tglx@linutronix.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, hpa@zytor.com, kirill.shutemov@linux.intel.com,
        peterz@infradead.org, gorcunov@openvz.org, luto@amacapital.net,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/boot] x86/boot/compressed/64: Prepare trampoline memory
Message-ID: <20180226105440.GB14140@pd.tnic>
References: <20180209142228.21231-4-kirill.shutemov@linux.intel.com>
 <tip-b91993a87aff6dafd60a9c8ce80ebc425161a815@git.kernel.org>
 <20180224214818.GD29374@pd.tnic>
 <20180225105205.xicklkl3n5azdw2j@node.shutemov.name>
 <20180226073552.xabt55ukp24inut5@gmail.com>
 <20180226080256.j7jzuxyokx42uytd@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180226080256.j7jzuxyokx42uytd@node.shutemov.name>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 11:02:56AM +0300, Kirill A. Shutemov wrote:
> Yeah, good idea.
> 
> Borislav, could you check this?

No joy with:

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index dad5da7b4c1a..4c382409b740 100644
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
+	paging_config.trampoline_start = 0x40000;
+#endif
 
 	trampoline = (unsigned long *)paging_config.trampoline_start;
---
-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
