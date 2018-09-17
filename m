Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1173ECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD2B2150B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD2B2150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbeIQUEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:04:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55196 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeIQUEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:04:41 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g1ue6-0008SD-Ir; Mon, 17 Sep 2018 16:37:02 +0200
Message-Id: <20180917143545.731701535@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 17 Sep 2018 16:29:07 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Bin Yang <bin.yang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Gross <mark.gross@intel.com>,
        kernel test robot <rong.a.chen@intel.com>
Subject: [patch V3 01/11] x86/mm/init32: Mark text and rodata RO in one go
References: <20180917142906.384767038@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-mm-init32--Mark-text-and-rodata-RO-in-one-go.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/mm/init_32.c |   23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

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


