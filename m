Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC663C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF762084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF762084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbeLKQCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:02:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:46758 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730716AbeLKQCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 11:02:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 08:02:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,342,1539673200"; 
   d="scan'208";a="108707979"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga008.fm.intel.com with ESMTP; 11 Dec 2018 08:02:14 -0800
Subject: [PATCH] x86/mm: Fix decoy address handling vs 32-bit builds
From:   Dan Williams <dan.j.williams@intel.com>
To:     x86@kernel.org
Cc:     Gert Robben <t2@gert.gr>, Gert Robben <t2@gert.gr>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 11 Dec 2018 07:49:39 -0800
Message-ID: <154454337985.789277.12133288391664677775.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A decoy address is used by set_mce_nospec() to update the cache
attributes for a page that may contain poison (multi-bit ECC error)
while attempting to minimize the possibility of triggering a speculative
access to that page.

When reserve_memtype() is handling a decoy address it needs to convert
it to its real physical alias. The conversion, AND'ing with
__PHYSICAL_MASK, is broken for a 32-bit physical mask and
reserve_memtype() is passed the last physical page. Gert reports
triggering the:

    BUG_ON(start >= end);

...assertion when running a 32-bit non-PAE build on a platform that has
a driver resource at the top of physical memory:

    BIOS-e820: [mem 0x00000000fff00000-0x00000000ffffffff] reserved

Given that the decoy address scheme is only targeted at 64-bit builds
and assumes that the top of physical address space is free for use as a
decoy address range, simply bypass address sanitization in the 32-bit
case.

Lastly, there was no need to crash the system when this failure
occurred, and no need to crash future systems if the assumptions of
decoy addresses are ever violated. Change the BUG_ON() to a WARN() with
an error return.

Reported-by: Gert Robben <t2@gert.gr>
Tested-by: Gert Robben <t2@gert.gr>
Cc: <stable@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Fixes: 510ee090abc3 ("x86/mm/pat: Prepare {reserve, free}_memtype() for...")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/mm/pat.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat.c b/arch/x86/mm/pat.c
index 08013524fba1..4fe956a63b25 100644
--- a/arch/x86/mm/pat.c
+++ b/arch/x86/mm/pat.c
@@ -519,8 +519,13 @@ static u64 sanitize_phys(u64 address)
 	 * for a "decoy" virtual address (bit 63 clear) passed to
 	 * set_memory_X(). __pa() on a "decoy" address results in a
 	 * physical address with bit 63 set.
+	 *
+	 * Decoy addresses are not present for 32-bit builds, see
+	 * set_mce_nospec().
 	 */
-	return address & __PHYSICAL_MASK;
+	if (IS_ENABLED(CONFIG_X86_64))
+		return address & __PHYSICAL_MASK;
+	return address;
 }
 
 /*
@@ -546,7 +551,11 @@ int reserve_memtype(u64 start, u64 end, enum page_cache_mode req_type,
 
 	start = sanitize_phys(start);
 	end = sanitize_phys(end);
-	BUG_ON(start >= end); /* end is exclusive */
+	if (start >= end) {
+		WARN(1, "%s failed: [mem %#010Lx-%#010Lx], req %s\n", __func__,
+				start, end - 1, cattr_name(req_type));
+		return -EINVAL;
+	}
 
 	if (!pat_enabled()) {
 		/* This is identical to page table setting without PAT */

