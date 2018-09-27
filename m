Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DF2C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66AA7216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66AA7216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbeI1BGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:06:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60617 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbeI1BGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:06:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RIjqCZ129250
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 11:45:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RIjqsp129247;
        Thu, 27 Sep 2018 11:45:52 -0700
Date:   Thu, 27 Sep 2018 11:45:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-2a25dc7c79c92c6cba45c6218c49395173be80bf@git.kernel.org>
Cc:     bin.yang@intel.com, peterz@infradead.org, mark.gross@intel.com,
        dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, rong.a.chen@intel.com, mingo@kernel.org,
        hpa@zytor.com
Reply-To: rong.a.chen@intel.com, mingo@kernel.org, hpa@zytor.com,
          bin.yang@intel.com, peterz@infradead.org, mark.gross@intel.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          dave.hansen@intel.com
In-Reply-To: <20180917143545.731701535@linutronix.de>
References: <20180917143545.731701535@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/init32: Mark text and rodata RO in one go
Git-Commit-ID: 2a25dc7c79c92c6cba45c6218c49395173be80bf
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

Commit-ID:  2a25dc7c79c92c6cba45c6218c49395173be80bf
Gitweb:     https://git.kernel.org/tip/2a25dc7c79c92c6cba45c6218c49395173be80bf
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 17 Sep 2018 16:29:07 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 27 Sep 2018 20:39:37 +0200

x86/mm/init32: Mark text and rodata RO in one go

The sequence of marking text and rodata read-only in 32bit init is:

  set_ro(text);
  kernel_set_to_readonly = 1;
  set_ro(rodata);

When kernel_set_to_readonly is 1 it enables the protection mechanism in CPA
for the read only regions. With the upcoming checks for existing mappings
this consequently triggers the warning about an existing mapping being
incorrect vs. static protections because rodata has not been converted yet.

There is no technical reason to split the two, so just combine the RO
protection to convert text and rodata in one go.

Convert the printks to pr_info while at it.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Bin Yang <bin.yang@intel.com>
Cc: Mark Gross <mark.gross@intel.com>
Link: https://lkml.kernel.org/r/20180917143545.731701535@linutronix.de

---
 arch/x86/mm/init_32.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 979e0a02cbe1..142c7d9f89cc 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -923,34 +923,19 @@ static void mark_nxdata_nx(void)
 void mark_rodata_ro(void)
 {
 	unsigned long start = PFN_ALIGN(_text);
-	unsigned long size = PFN_ALIGN(_etext) - start;
+	unsigned long size = (unsigned long)__end_rodata - start;
 
 	set_pages_ro(virt_to_page(start), size >> PAGE_SHIFT);
-	printk(KERN_INFO "Write protecting the kernel text: %luk\n",
+	pr_info("Write protecting kernel text and read-only data: %luk\n",
 		size >> 10);
 
 	kernel_set_to_readonly = 1;
 
 #ifdef CONFIG_CPA_DEBUG
-	printk(KERN_INFO "Testing CPA: Reverting %lx-%lx\n",
-		start, start+size);
-	set_pages_rw(virt_to_page(start), size>>PAGE_SHIFT);
-
-	printk(KERN_INFO "Testing CPA: write protecting again\n");
-	set_pages_ro(virt_to_page(start), size>>PAGE_SHIFT);
-#endif
-
-	start += size;
-	size = (unsigned long)__end_rodata - start;
-	set_pages_ro(virt_to_page(start), size >> PAGE_SHIFT);
-	printk(KERN_INFO "Write protecting the kernel read-only data: %luk\n",
-		size >> 10);
-
-#ifdef CONFIG_CPA_DEBUG
-	printk(KERN_INFO "Testing CPA: undo %lx-%lx\n", start, start + size);
+	pr_info("Testing CPA: Reverting %lx-%lx\n", start, start + size);
 	set_pages_rw(virt_to_page(start), size >> PAGE_SHIFT);
 
-	printk(KERN_INFO "Testing CPA: write protecting again\n");
+	pr_info("Testing CPA: write protecting again\n");
 	set_pages_ro(virt_to_page(start), size >> PAGE_SHIFT);
 #endif
 	mark_nxdata_nx();
