Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34094C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB17B208DC
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB17B208DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeGDOBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:01:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47590 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbeGDOBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:01:45 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1faiLc-0007mh-7i; Wed, 04 Jul 2018 16:01:32 +0200
Date:   Wed, 4 Jul 2018 16:01:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Yang, Bin" <bin.yang@intel.com>
cc:     "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/mm: fix cpu stuck issue in
 __change_page_attr_set_clr
In-Reply-To: <34a76fad5c43c11ce8ceb491537b453d8053bdb2.camel@intel.com>
Message-ID: <alpine.DEB.2.21.1807041221110.1816@nanos.tec.linutronix.de>
References: <1530180340-18593-1-git-send-email-bin.yang@intel.com>   <alpine.DEB.2.21.1807031442030.1601@nanos.tec.linutronix.de>   <0131cecd5d0456c2a109f4b8bdbfe558389671dd.camel@intel.com>   <alpine.DEB.2.21.1807040849520.1816@nanos.tec.linutronix.de> 
 <3224aae1d09788aba687fd7bd9e088f233016fc8.camel@intel.com>  <alpine.DEB.2.21.1807041119260.1816@nanos.tec.linutronix.de> <34a76fad5c43c11ce8ceb491537b453d8053bdb2.camel@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018, Yang, Bin wrote:
> e820 table:
> =================
> 
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff]
> usable
> [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff]
> reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff]
> reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdffff]
> usable
> [    0.000000] BIOS-e820: [mem 0x00000000bffe0000-0x00000000bfffffff]
> reserved
> [    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff]
> reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff]
> reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000013fffffff]
> usable
> 
> call chain:
> ======================
> 
> ...
> => free_init_pages(what="initrd" or "unused kernel",
> begin=ffff9b26b....000, end=ffff9b26c....000); begin and end addresses
> are random. The begin/end value above is just for reference.
> 
> => set_memory_rw()
> => change_page_attr_set()
> => change_page_attr_set_clr()
> => __change_page_attr_set_clr(); cpa->numpages is 512 on my board if
> what=="unused kernel"
> => __change_page_attr()

> => try_preserve_large_page(); address=ffff9b26bfacf000, pfn=80000,
> level=3; and the check loop count is 262144, exit loop after 861 usecs
> on my board

You are talking about the static_protections() check, right?

> the actual problem
> ===================
> sometimes, free_init_pages returns after hundreds of secounds. The
> major impact is kernel boot time.

That's the symptom you are observing. The problem is in the
try_to_preserve_large_page() logic.

The address range from the example above is:

   0xffff9b26b0000000 - 0xffff9b26c0000000

i.e. 256 MB.

So the first call with address 0xffff9b26b0000000 will try to preserve the
1GB page, but it's obvious that if pgrot changes that this has to split the
1GB page.

The current code is stupid in that regard simply because it does the
static_protection() check loop _before_ checking:

  1) Whether the new and the old pgprot are the same
  
  2) Whether the address range which needs to be changed is aligned to and
     covers the full large mapping

So it does the static_protections() loop before #1 and #2 and checks the
full 1GB page wise, which makes it loop 262144 times.

With your magic 'cache' logic this will still loop exactly 262144 times at
least on the first invocation because there is no valid information in that
'cache'. So I really have no idea how your patch makes any difference
unless it is breaking stuff left and right in very subtle ways.

If there is a second invocation with the same pgprot on that very same
range, then I can see it somehow having that effect by chance, but not by
design.

But this is all voodoo programming and there is a very obvious and simple
solution for this:

  The check for pgprot_val(new_prot) == pgprot_val(old_port) can definitely
  be done _before_ the check loop. The check loop is pointless in that
  case, really. If there is a mismatch anywhere then it existed already and
  instead of yelling loudly the checking would just discover it, enforce
  the split and that would in the worst case preserve the old wrong mapping
  for those pages.

  What we want there is a debug mechanism which catches such cases, but is
  not effective on production kernels and runs once or twice during boot.

  The range check whether the address is aligned to the large page and
  covers the full large page (1G or 2M) is also obvious to do _before_ that
  check, because if the requested range does not fit and has a different
  pgprot_val() then it will decide to split after the check anyway.

  The check loop itself is stupid as well. Instead of looping in 4K steps
  the thing can be rewritten to check for overlapping ranges and then check
  explicitely for those. If there is no overlap in the first place the
  whole loop thing can be avoided, but that's a pure optimization and needs
  more thought than the straight forward and obvious solution to the
  problem at hand.

Untested patch just moving the quick checks to the obvious right place
below.

Thanks,

	tglx

8<-----------------
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -628,47 +628,61 @@ try_preserve_large_page(pte_t *kpte, uns
 	new_prot = static_protections(req_prot, address, pfn);
 
 	/*
-	 * We need to check the full range, whether
-	 * static_protection() requires a different pgprot for one of
-	 * the pages in the range we try to preserve:
+	 * If there are no changes, return. cpa->numpages has been updated
+	 * above.
+	 *
+	 * There is no need to do any of the checks below because the
+	 * existing pgprot of the large mapping has to be correct. If it's
+	 * not then this is a bug in some other code and needs to be fixed
+	 * there and not silently papered over by the static_protections()
+	 * magic and then 'fixed' up in the wrong way.
 	 */
-	addr = address & pmask;
-	pfn = old_pfn;
-	for (i = 0; i < (psize >> PAGE_SHIFT); i++, addr += PAGE_SIZE, pfn++) {
-		pgprot_t chk_prot = static_protections(req_prot, addr, pfn);
-
-		if (pgprot_val(chk_prot) != pgprot_val(new_prot))
-			goto out_unlock;
+	if (pgprot_val(new_prot) == pgprot_val(old_prot)) {
+		do_split = 0;
+		goto out_unlock;
 	}
 
 	/*
-	 * If there are no changes, return. maxpages has been updated
-	 * above:
+	 * If the requested address range is not aligned to the start of
+	 * the large page or does not cover the full range, split it up.
+	 * No matter what the static_protections() check below does, it
+	 * would anyway result in a split after doing all the check work
+	 * for nothing.
 	 */
-	if (pgprot_val(new_prot) == pgprot_val(old_prot)) {
-		do_split = 0;
+	addr = address & pmask;
+	numpages = psize >> PAGE_SHIFT;
+	if (address != addr || cpa->numpages != numpages)
 		goto out_unlock;
-	}
 
 	/*
-	 * We need to change the attributes. Check, whether we can
-	 * change the large page in one go. We request a split, when
-	 * the address is not aligned and the number of pages is
-	 * smaller than the number of pages in the large page. Note
-	 * that we limited the number of possible pages already to
-	 * the number of pages in the large page.
+	 * Check the full range, whether static_protection() requires a
+	 * different pgprot for one of the pages in the existing large
+	 * mapping.
+	 *
+	 * FIXME:
+	 * 1) Make this yell loudly if something tries to set a full
+	 *    large page to something which is not allowed.
+	 * 2) Add a check for catching a case where the existing mapping
+	 *    is wrong already.
+	 * 3) Instead of looping over the whole thing, find the overlapping
+	 *    ranges and check them explicitely instead of looping over a
+	 *    full 1G mapping in 4K steps (256k iterations) for figuring
+	 *    that out.
 	 */
-	if (address == (address & pmask) && cpa->numpages == (psize >> PAGE_SHIFT)) {
-		/*
-		 * The address is aligned and the number of pages
-		 * covers the full page.
-		 */
-		new_pte = pfn_pte(old_pfn, new_prot);
-		__set_pmd_pte(kpte, address, new_pte);
-		cpa->flags |= CPA_FLUSHTLB;
-		do_split = 0;
+	pfn = old_pfn;
+	for (i = 0; i < numpages; i++, addr += PAGE_SIZE, pfn++) {
+		pgprot_t chk_prot = static_protections(req_prot, addr, pfn);
+
+		if (pgprot_val(chk_prot) != pgprot_val(new_prot))
+			goto out_unlock;
 	}
 
+	/* All checks passed. Just change the large mapping entry */
+	new_pte = pfn_pte(old_pfn, new_prot);
+	__set_pmd_pte(kpte, address, new_pte);
+	cpa->flags |= CPA_FLUSHTLB;
+	do_split = 0;
+
 out_unlock:
 	spin_unlock(&pgd_lock);
 




