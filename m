Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A66C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B78623F16
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 21:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B78623F16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753459AbeGDVvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 17:51:14 -0400
Received: from mga02.intel.com ([134.134.136.20]:37638 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752889AbeGDVvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 17:51:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 14:51:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,309,1526367600"; 
   d="scan'208";a="64478224"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003.jf.intel.com with ESMTP; 04 Jul 2018 14:51:08 -0700
Subject: [PATCH v5 09/11] x86/mm/pat: Prepare {reserve,
 free}_memtype() for "decoy" addresses
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        x86@kernel.org, hch@lst.de, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jack@suse.cz,
        ross.zwisler@linux.intel.com
Date:   Wed, 04 Jul 2018 14:41:11 -0700
Message-ID: <153074047123.27838.4050356397245428561.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153074042316.27838.17319837331947007626.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153074042316.27838.17319837331947007626.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for using set_memory_uc() instead set_memory_np() for
isolating poison from speculation, teach the memtype code to sanitize
physical addresses vs __PHYSICAL_MASK.

The motivation for using set_memory_uc() for this case is to allow
ongoing access to persistent memory pages via the pmem-driver +
memcpy_mcsafe() until the poison is repaired.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: <linux-edac@vger.kernel.org>
Cc: <x86@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/mm/pat.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
index 1555bd7d3449..6788ffa990f8 100644
--- a/arch/x86/mm/pat.c
+++ b/arch/x86/mm/pat.c
@@ -512,6 +512,17 @@ static int free_ram_pages_type(u64 start, u64 end)
 	return 0;
 }
 
+static u64 sanitize_phys(u64 address)
+{
+	/*
+	 * When changing the memtype for pages containing poison allow
+	 * for a "decoy" virtual address (bit 63 clear) passed to
+	 * set_memory_X(). __pa() on a "decoy" address results in a
+	 * physical address with it 63 set.
+	 */
+	return address & __PHYSICAL_MASK;
+}
+
 /*
  * req_type typically has one of the:
  * - _PAGE_CACHE_MODE_WB
@@ -533,6 +544,8 @@ int reserve_memtype(u64 start, u64 end, enum page_cache_mode req_type,
 	int is_range_ram;
 	int err = 0;
 
+	start = sanitize_phys(start);
+	end = sanitize_phys(end);
 	BUG_ON(start >= end); /* end is exclusive */
 
 	if (!pat_enabled()) {
@@ -609,6 +622,9 @@ int free_memtype(u64 start, u64 end)
 	if (!pat_enabled())
 		return 0;
 
+	start = sanitize_phys(start);
+	end = sanitize_phys(end);
+
 	/* Low ISA region is always mapped WB. No need to track */
 	if (x86_platform.is_untracked_pat_range(start, end))
 		return 0;

