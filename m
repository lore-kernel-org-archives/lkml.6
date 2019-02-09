Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4EEC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1599620823
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfBIRba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:31:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:3310 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfBIRba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:31:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2019 09:31:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,352,1544515200"; 
   d="scan'208";a="132330281"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Feb 2019 09:31:29 -0800
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] mm/gup.c: Remove unused write variable
Date:   Sat,  9 Feb 2019 09:31:09 -0800
Message-Id: <20190209173109.9361-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

write is unused in gup_fast_permitted so remove it.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/x86/include/asm/pgtable_64.h | 3 +--
 mm/gup.c                          | 6 +++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 9c85b54bf03c..0bb566315621 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -259,8 +259,7 @@ extern void init_extra_mapping_uc(unsigned long phys, unsigned long size);
 extern void init_extra_mapping_wb(unsigned long phys, unsigned long size);
 
 #define gup_fast_permitted gup_fast_permitted
-static inline bool gup_fast_permitted(unsigned long start, int nr_pages,
-		int write)
+static inline bool gup_fast_permitted(unsigned long start, int nr_pages)
 {
 	unsigned long len, end;
 
diff --git a/mm/gup.c b/mm/gup.c
index 05acd7e2eb22..b63e88eca31b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1786,7 +1786,7 @@ static void gup_pgd_range(unsigned long addr, unsigned long end,
  * Check if it's allowed to use __get_user_pages_fast() for the range, or
  * we need to fall back to the slow version:
  */
-bool gup_fast_permitted(unsigned long start, int nr_pages, int write)
+bool gup_fast_permitted(unsigned long start, int nr_pages)
 {
 	unsigned long len, end;
 
@@ -1828,7 +1828,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	 * block IPIs that come from THPs splitting.
 	 */
 
-	if (gup_fast_permitted(start, nr_pages, write)) {
+	if (gup_fast_permitted(start, nr_pages)) {
 		local_irq_save(flags);
 		gup_pgd_range(start, end, write, pages, &nr);
 		local_irq_restore(flags);
@@ -1870,7 +1870,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	if (unlikely(!access_ok((void __user *)start, len)))
 		return -EFAULT;
 
-	if (gup_fast_permitted(start, nr_pages, write)) {
+	if (gup_fast_permitted(start, nr_pages)) {
 		local_irq_disable();
 		gup_pgd_range(addr, end, write, pages, &nr);
 		local_irq_enable();
-- 
2.20.1

