Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BEEC6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE692086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE692086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbeLLCee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:34:34 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44313 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLLCed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:34:33 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBC2XsCR108023
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 18:33:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBC2XpRf108019;
        Tue, 11 Dec 2018 18:33:51 -0800
Date:   Tue, 11 Dec 2018 18:33:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-51c3fbd89d7554caa3290837604309f8d8669d99@git.kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de,
        stable@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        dan.j.williams@intel.com, luto@kernel.org, t2@gert.gr,
        andriy.shevchenko@linux.intel.com, dave.hansen@linux.intel.com,
        hpa@zytor.com
Reply-To: dave.hansen@linux.intel.com, hpa@zytor.com,
          andriy.shevchenko@linux.intel.com, t2@gert.gr, luto@kernel.org,
          dan.j.williams@intel.com, tglx@linutronix.de, mingo@kernel.org,
          stable@vger.kernel.org, bp@alien8.de,
          linux-kernel@vger.kernel.org, peterz@infradead.org
In-Reply-To: <154454337985.789277.12133288391664677775.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154454337985.789277.12133288391664677775.stgit@dwillia2-desk3.amr.corp.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Fix decoy address handling vs 32-bit
 builds
Git-Commit-ID: 51c3fbd89d7554caa3290837604309f8d8669d99
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  51c3fbd89d7554caa3290837604309f8d8669d99
Gitweb:     https://git.kernel.org/tip/51c3fbd89d7554caa3290837604309f8d8669d99
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Tue, 11 Dec 2018 07:49:39 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 11 Dec 2018 18:28:20 -0800

x86/mm: Fix decoy address handling vs 32-bit builds

A decoy address is used by set_mce_nospec() to update the cache attributes
for a page that may contain poison (multi-bit ECC error) while attempting
to minimize the possibility of triggering a speculative access to that
page.

When reserve_memtype() is handling a decoy address it needs to convert it
to its real physical alias. The conversion, AND'ing with __PHYSICAL_MASK,
is broken for a 32-bit physical mask and reserve_memtype() is passed the
last physical page. Gert reports triggering the:

    BUG_ON(start >= end);

...assertion when running a 32-bit non-PAE build on a platform that has
a driver resource at the top of physical memory:

    BIOS-e820: [mem 0x00000000fff00000-0x00000000ffffffff] reserved

Given that the decoy address scheme is only targeted at 64-bit builds and
assumes that the top of physical address space is free for use as a decoy
address range, simply bypass address sanitization in the 32-bit case.

Lastly, there was no need to crash the system when this failure occurred,
and no need to crash future systems if the assumptions of decoy addresses
are ever violated. Change the BUG_ON() to a WARN() with an error return.

Fixes: 510ee090abc3 ("x86/mm/pat: Prepare {reserve, free}_memtype() for...")
Reported-by: Gert Robben <t2@gert.gr>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Gert Robben <t2@gert.gr>
Cc: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: platform-driver-x86@vger.kernel.org
Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/154454337985.789277.12133288391664677775.stgit@dwillia2-desk3.amr.corp.intel.com

---
 arch/x86/mm/pat.c | 13 +++++++++++--
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
