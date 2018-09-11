Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8694C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1AC20865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1AC20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeIKM3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:29:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726325AbeIKM3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:29:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DAFC2401DEAF;
        Tue, 11 Sep 2018 07:31:00 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 220472027EA4;
        Tue, 11 Sep 2018 07:30:59 +0000 (UTC)
Date:   Tue, 11 Sep 2018 15:30:57 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, thgarnie@google.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 2/3] x86/mm/KASLR: Calculate the actual size of
 vmemmap region
Message-ID: <20180911073057.GW1740@192.168.1.3>
References: <20180909124946.17988-1-bhe@redhat.com>
 <20180909124946.17988-2-bhe@redhat.com>
 <20180910061151.GA85199@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910061151.GA85199@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 11 Sep 2018 07:31:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 11 Sep 2018 07:31:00 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/18 at 08:11am, Ingo Molnar wrote:
> 
> * Baoquan He <bhe@redhat.com> wrote:
> 
> > @@ -108,6 +109,14 @@ void __init kernel_randomize_memory(void)
> >  	if (memory_tb < kaslr_regions[0].size_tb)
> >  		kaslr_regions[0].size_tb = memory_tb;
> >  
> > +	/*
> > +	 * Calculate how many TB vmemmap region needs, and align to
> > +	 * 1TB boundary.
> > +	 * */
> 
> Yeah, so that's not the standard comment style ...

Sorry for this, Will change. Thanks.

About clean up you suggested, I have made two patches and paste them at
below. Please help check if it's OK. Thanks a lot.

> So I get the part where the 'base' pointer is essentially pointers to various global variables 
> used by the MM to get the virtual base address of the kernel, vmalloc and vmemmap areas from, 
> which base addresses can thus be modified by the very early KASLR code to dynamically shape the 
> virtual memory layout of these kernel memory areas on a per bootup basis.
> 
> (BTW., that would be a great piece of information to add for the uninitiated. It's not like 
> it's obvious!)
> 
> But what does 'size_tb' do? Nothing explains it and your patch doesn't make it clearer either. 
> Also, get_padding() looks like an unnecessary layer of obfuscation:

Yes, I agree. Have made an patch according to your suggestion, paste
it here:

From c74b1e49eaa0e00335adbbb7e2d5df6d60518d4f Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Tue, 11 Sep 2018 14:34:26 +0800
Subject: [PATCH] x86/mm/KASLR: Add code comments to explain fields of struct
 kaslr_memory_region

Signed-off-by: Baoquan He <bhe@redhat.com>
Suggested-by: Ingo Molnar <mingo@kernel.org>

---
 arch/x86/mm/kaslr.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 91053cee7648..402984d8d729 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -41,9 +41,21 @@
 static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
 
 /*
- * Memory regions randomized by KASLR (except modules that use a separate logic
- * earlier during boot). The list is ordered based on virtual addresses. This
- * order is kept after randomization.
+ * Memory regions randomized by KASLR (except modules that use a separate
+ * logic earlier during boot). Currently they are the physical memory
+ * mapping, vmalloc and vmemmap regions, are ordered based on virtual
+ * addresses. The order is kept after randomization.
+ *
+ * @base: points to various global variables used by the MM to get the
+ * virtual base address of the above regions, which base addresses can
+ * thus be modified by the very early KASLR code to dynamically shape
+ * the virtual memory layout of these kernel memory regions on a per
+ * bootup basis.
+ *
+ * @size_tb: size in TB of each memory region. Thereinto, the size of
+ * the physical memory mapping region is variable, calculated according
+ * to the actual size of system RAM in order to save more space for
+ * randomization. The rest are fixed values related to paging mode.
  */
 static __initdata struct kaslr_memory_region {
 	unsigned long *base;

> /* Get size in bytes used by the memory region */
> static inline unsigned long get_padding(struct kaslr_memory_region *region)
> {
>         return (region->size_tb << TB_SHIFT);
> }

Yes, we can open code get_padding() as the following patch.

From e4cababd630af06085cb79a0bae9c00acd5272c0 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Tue, 11 Sep 2018 14:39:38 +0800
Subject: [PATCH] x86/mm/KASLR: Open code unnecessary function get_padding

It's used only twice and we do bit shifts in the parent function
anyway so it's not like it's hiding some uninteresting detail.

Signed-off-by: Baoquan He <bhe@redhat.com>
Suggested-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/kaslr.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 9774b6e39f63..91053cee7648 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -54,12 +54,6 @@ static __initdata struct kaslr_memory_region {
 	{ &vmemmap_base, 0 },
 };
 
-/* Get size in bytes used by the memory region */
-static inline unsigned long get_padding(struct kaslr_memory_region *region)
-{
-	return (region->size_tb << TB_SHIFT);
-}
-
 /*
  * Apply no randomization if KASLR was disabled at boot or if KASAN
  * is enabled. KASAN shadow mappings rely on regions being PGD aligned.
@@ -120,7 +114,7 @@ void __init kernel_randomize_memory(void)
 	/* Calculate entropy available between regions */
 	remain_entropy = vaddr_end - vaddr_start;
 	for (i = 0; i < ARRAY_SIZE(kaslr_regions); i++)
-		remain_entropy -= get_padding(&kaslr_regions[i]);
+		remain_entropy -= kaslr_regions[i].size_tb << TB_SHIFT;
 
 	prandom_seed_state(&rand_state, kaslr_get_random_long("Memory"));
 
@@ -144,7 +138,7 @@ void __init kernel_randomize_memory(void)
 		 * Jump the region and add a minimum padding based on
 		 * randomization alignment.
 		 */
-		vaddr += get_padding(&kaslr_regions[i]);
+		vaddr += kaslr_regions[i].size_tb << TB_SHIFT;
 		if (pgtable_l5_enabled())
 			vaddr = round_up(vaddr + 1, P4D_SIZE);
 		else
-- 
2.13.6

