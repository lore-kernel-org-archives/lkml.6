Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC578C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F7E20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67F7E20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbeJZFMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:12:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:48948 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbeJZFMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:12:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 13:38:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,425,1534834800"; 
   d="scan'208";a="244401258"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004.jf.intel.com with ESMTP; 25 Oct 2018 13:38:33 -0700
Subject: [PATCH v3] x86/numa_emulation: Fix uniform-split numa emulation
From:   Dan Williams <dan.j.williams@intel.com>
To:     mingo@redhat.com
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        stable@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 25 Oct 2018 13:26:45 -0700
Message-ID: <154049911459.2685845.9210186007479774286.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

The numa_emulation() routine in the 'uniform' case walks through all the
physical 'memblk' instances and divides them into N emulated nodes with
split_nodes_size_interleave_uniform(). As each physical node is consumed
it is removed from the physical memblk array in the
numa_remove_memblk_from() helper. Since
split_nodes_size_interleave_uniform() handles advancing the array as the
'memblk' is consumed it is expected that the base of the array is always
specified as the argument.

Otherwise, on multi-socket (> 2) configurations the uniform-split
capability can generate an invalid numa configuration leading to boot
failures with signatures like the following:

    rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
    Sending NMI from CPU 0 to CPUs 2:
    NMI backtrace for cpu 2
    CPU: 2 PID: 1332 Comm: pgdatinit0 Not tainted 4.19.0-rc8-next-20181019-baseline #59
    RIP: 0010:__init_single_page.isra.74+0x81/0x90
    [..]
    Call Trace:
     deferred_init_pages+0xaa/0xe3
     deferred_init_memmap+0x18f/0x318
     kthread+0xf8/0x130
     ? deferred_free_pages.isra.105+0xc9/0xc9
     ? kthread_stop+0x110/0x110
     ret_from_fork+0x35/0x40

Cc: x86@kernel.org
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: <stable@vger.kernel.org>
Fixes: 1f6a2c6d9f121 ("x86/numa_emulation: Introduce uniform split capability")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v2: https://lore.kernel.org/patchwork/patch/988541/

* Update the changelog with details from testing by Alex

 arch/x86/mm/numa_emulation.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index b54d52a2d00a..d71d72cf6c66 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -400,9 +400,17 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
 		n = simple_strtoul(emu_cmdline, &emu_cmdline, 0);
 		ret = -1;
 		for_each_node_mask(i, physnode_mask) {
+			/*
+			 * The reason we pass in blk[0] is due to
+			 * numa_remove_memblk_from() called by
+			 * emu_setup_memblk() will delete entry 0
+			 * and then move everything else up in the pi.blk
+			 * array. Therefore we should always be looking
+			 * at blk[0].
+			 */
 			ret = split_nodes_size_interleave_uniform(&ei, &pi,
-					pi.blk[i].start, pi.blk[i].end, 0,
-					n, &pi.blk[i], nid);
+					pi.blk[0].start, pi.blk[0].end, 0,
+					n, &pi.blk[0], nid);
 			if (ret < 0)
 				break;
 			if (ret < n) {

