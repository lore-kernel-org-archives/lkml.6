Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F075C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E510625661
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E510625661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030862AbeGARWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:22:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36622 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031527AbeGAQiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:38:03 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6D62992B;
        Sun,  1 Jul 2018 16:38:02 +0000 (UTC)
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
Subject: [PATCH 4.17 005/220] x86/platform/UV: Add kernel parameter to set memory block size
Date:   Sun,  1 Jul 2018 18:20:29 +0200
Message-Id: <20180701160908.520467416@linuxfoundation.org>
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

commit d7609f4210cb716c11abfe2bfb5997191095d00b upstream.

Add a kernel parameter that allows setting UV memory block size.  This
is to provide an adjustment for new forms of PMEM and other DIMM memory
that might require alignment restrictions other than scanning the global
address table for the required minimum alignment.  The value set will be
further adjusted by both the GAM range table scan as well as restrictions
imposed by set_memory_block_size_order().

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
Link: https://lkml.kernel.org/lkml/20180524201711.854849120@stormcage.americas.sgi.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/apic/x2apic_uv_x.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -396,6 +396,17 @@ EXPORT_SYMBOL(uv_hub_info_version);
 /* Default UV memory block size is 2GB */
 static unsigned long mem_block_size = (2UL << 30);
 
+/* Kernel parameter to specify UV mem block size */
+static int parse_mem_block_size(char *ptr)
+{
+	unsigned long size = memparse(ptr, NULL);
+
+	/* Size will be rounded down by set_block_size() below */
+	mem_block_size = size;
+	return 0;
+}
+early_param("uv_memblksize", parse_mem_block_size);
+
 static __init int adj_blksize(u32 lgre)
 {
 	unsigned long base = (unsigned long)lgre << UV_GAM_RANGE_SHFT;


