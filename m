Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E95C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8FF20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8FF20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeIJO2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:28:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:29368 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbeIJO2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:28:13 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 02:35:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,355,1531810800"; 
   d="scan'208";a="79269878"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Sep 2018 02:34:51 -0700
Date:   Mon, 10 Sep 2018 17:39:38 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@elte.hu>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86, mm: Reserver some memory for bootmem allocator for
 NO_BOOTMEM
Message-ID: <20180910093938.ka732apzy3d3a5ip@shbuild888>
References: <20180830124915.GH2656@dhcp22.suse.cz>
 <20180830125909.uq3e76akcmep6j2u@shbuild888>
 <alpine.DEB.2.21.1808301504300.1210@nanos.tec.linutronix.de>
 <20180830131920.w2jqjvlkpfb4ejb2@shbuild888>
 <alpine.DEB.2.21.1808301523510.1210@nanos.tec.linutronix.de>
 <20180831061519.3zbxsjs4rd6mmsuo@shbuild888>
 <alpine.DEB.2.21.1808311328260.2208@nanos.tec.linutronix.de>
 <20180831133659.pkmscqpudjnkujbg@shbuild888>
 <20180907081716.bxw3hmcl6w7gqvax@shbuild888>
 <alpine.DEB.2.21.1809071250240.1402@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809071250240.1402@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 12:52:17PM +0200, Thomas Gleixner wrote:
> On Fri, 7 Sep 2018, Feng Tang wrote:
> > On Fri, Aug 31, 2018 at 09:36:59PM +0800, Feng Tang wrote:
> > > Any sugestion? I can only have patch like this:
> > 
> > Could you review this patch, as at this time window there is no usable memory
> > block or other memory allocators that I know, so I follow the exisitng static
> > fixmap page table code and add one more.
> 
> You really want to add a proper sanity check for this. The static stuff has
> to cover the fixmap. Just making it work for this particular case is sloppy
> at best as the next larger change of the fixmap will just bring the problem
> back.
Yes, agree.

Since the issue happens very early before any serial console, I can only think
of a build time check.

Thanks,
Feng

---
 arch/x86/kernel/head_64.S |  6 +++++-
 arch/x86/mm/pgtable.c     | 13 +++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 15ebc2fc166e..3a1d33b43c29 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -448,11 +448,15 @@ NEXT_PAGE(level2_fixmap_pgt)
 	.fill	506,8,0
 	.quad	level1_fixmap_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
 	/* 8MB reserved for vsyscalls + a 2MB hole = 4 + 1 entries */
-	.fill	5,8,0
+	.quad	level1_fixmap_pgt1 - __START_KERNEL_map + _PAGE_TABLE_NOENC
+	.fill	4,8,0
 
 NEXT_PAGE(level1_fixmap_pgt)
 	.fill	512,8,0
 
+NEXT_PAGE(level1_fixmap_pgt1)
+	.fill	512,8,0
+
 #undef PMDS
 
 	.data
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index e848a4811785..fc172551048a 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -637,6 +637,19 @@ void __native_set_fixmap(enum fixed_addresses idx, pte_t pte)
 {
 	unsigned long address = __fix_to_virt(idx);
 
+#ifdef CONFIG_X86_64
+	/*
+	 * In arch/x86/kernel/head_64.S, the static page table
+	 * has been setup for 4M space [-12M, -8M]
+	 *	0xFFFFFFFFFF400000 ~ 0xFFFFFFFFFF7FFFFF
+	 * Add a sanity check whether fixed_address crosses
+	 * the boundary.
+	 */
+	#define FIXMAP_STATIC_PGTABLE_START	0xFFFFFFFFFF400000
+	BUILD_BUG_ON(__fix_to_virt(__end_of_permanent_fixed_addresses)
+			< FIXMAP_STATIC_PGTABLE_START);
+#endif
+
 	if (idx >= __end_of_fixed_addresses) {
 		BUG();
 		return;
-- 
2.14.1

> 
> Thanks,
> 
> 	tglx
