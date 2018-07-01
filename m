Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD580C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C1C25670
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C1C25670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753844AbeGARXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:23:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36444 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031485AbeGAQhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:37:48 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 04FAC92B;
        Sun,  1 Jul 2018 16:37:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Travis <mike.travis@hpe.com>,
        Andrew Banman <andrew.banman@hpe.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Russ Anderson <russ.anderson@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>, dan.j.williams@intel.com,
        jgross@suse.com, kirill.shutemov@linux.intel.com, mhocko@suse.com,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.17 003/220] x86/platform/UV: Add adjustable set memory block size function
Date:   Sun,  1 Jul 2018 18:20:27 +0200
Message-Id: <20180701160908.421691551@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: mike.travis@hpe.com <mike.travis@hpe.com>

commit f642fb5864a6e3645edce6f85ffe7b44d5e9b990 upstream.

Add a new function to "adjust" the current fixed UV memory block size
of 2GB so it can be changed to a different physical boundary.  This is
out of necessity so arch dependent code can accommodate specific BIOS
requirements which can align these new PMEM modules at less than the
default boundaries.

A "set order" type of function was used to insure that the memory block
size will be a power of two value without requiring a validity check.
64GB was chosen as the upper limit for memory block size values to
accommodate upcoming 4PB systems which have 6 more bits of physical
address space (46 becoming 52).

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Andrew Banman <andrew.banman@hpe.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russ Anderson <russ.anderson@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dan.j.williams@intel.com
Cc: jgross@suse.com
Cc: kirill.shutemov@linux.intel.com
Cc: mhocko@suse.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/lkml/20180524201711.609546602@stormcage.americas.sgi.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/mm/init_64.c  |   20 ++++++++++++++++----
 include/linux/memory.h |    1 +
 2 files changed, 17 insertions(+), 4 deletions(-)

--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1350,16 +1350,28 @@ int kern_addr_valid(unsigned long addr)
 /* Amount of ram needed to start using large blocks */
 #define MEM_SIZE_FOR_LARGE_BLOCK (64UL << 30)
 
+/* Adjustable memory block size */
+static unsigned long set_memory_block_size;
+int __init set_memory_block_size_order(unsigned int order)
+{
+	unsigned long size = 1UL << order;
+
+	if (size > MEM_SIZE_FOR_LARGE_BLOCK || size < MIN_MEMORY_BLOCK_SIZE)
+		return -EINVAL;
+
+	set_memory_block_size = size;
+	return 0;
+}
+
 static unsigned long probe_memory_block_size(void)
 {
 	unsigned long boot_mem_end = max_pfn << PAGE_SHIFT;
 	unsigned long bz;
 
-	/* If this is UV system, always set 2G block size */
-	if (is_uv_system()) {
-		bz = MAX_BLOCK_SIZE;
+	/* If memory block size has been set, then use it */
+	bz = set_memory_block_size;
+	if (bz)
 		goto done;
-	}
 
 	/* Use regular block if RAM is smaller than MEM_SIZE_FOR_LARGE_BLOCK */
 	if (boot_mem_end < MEM_SIZE_FOR_LARGE_BLOCK) {
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -38,6 +38,7 @@ struct memory_block {
 
 int arch_get_memory_phys_device(unsigned long start_pfn);
 unsigned long memory_block_size_bytes(void);
+int set_memory_block_size_order(unsigned int order);
 
 /* These states are exposed to userspace as text strings in sysfs */
 #define	MEM_ONLINE		(1<<0) /* exposed to userspace */


