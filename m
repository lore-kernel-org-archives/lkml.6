Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E79C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A33320823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A33320823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeJ3TeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:34:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42471 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeJ3TeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:34:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9UAdpGt1935274
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 30 Oct 2018 03:39:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9UAdpm41935271;
        Tue, 30 Oct 2018 03:39:51 -0700
Date:   Tue, 30 Oct 2018 03:39:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Jiang <tipbot@zytor.com>
Message-ID: <tip-c6ee7a548e2c291398b4f32c1f741c66b9f98e1c@git.kernel.org>
Cc:     dave.hansen@linux.intel.com, dan.j.williams@intel.com,
        peterz@infradead.org, tglx@linutronix.de, luto@kernel.org,
        bp@alien8.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, dave.jiang@intel.com,
        alexander.h.duyck@linux.intel.com
Reply-To: dan.j.williams@intel.com, dave.hansen@linux.intel.com,
          tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
          bp@alien8.de, mingo@kernel.org, dave.jiang@intel.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          alexander.h.duyck@linux.intel.com
In-Reply-To: <154049911459.2685845.9210186007479774286.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154049911459.2685845.9210186007479774286.stgit@dwillia2-desk3.amr.corp.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/numa_emulation: Fix uniform-split numa
 emulation
Git-Commit-ID: c6ee7a548e2c291398b4f32c1f741c66b9f98e1c
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

Commit-ID:  c6ee7a548e2c291398b4f32c1f741c66b9f98e1c
Gitweb:     https://git.kernel.org/tip/c6ee7a548e2c291398b4f32c1f741c66b9f98e1c
Author:     Dave Jiang <dave.jiang@intel.com>
AuthorDate: Thu, 25 Oct 2018 13:26:45 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Oct 2018 11:36:43 +0100

x86/numa_emulation: Fix uniform-split numa emulation

The numa_emulation() routine in the 'uniform' case walks through all the
physical 'memblk' instances and divides them into N emulated nodes with
split_nodes_size_interleave_uniform(). As each physical node is consumed it
is removed from the physical memblk array in the numa_remove_memblk_from()
helper.

Since split_nodes_size_interleave_uniform() handles advancing the array as
the 'memblk' is consumed it is expected that the base of the array is
always specified as the argument.

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

Fixes: 1f6a2c6d9f121 ("x86/numa_emulation: Introduce uniform split capability")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/154049911459.2685845.9210186007479774286.stgit@dwillia2-desk3.amr.corp.intel.com

---
 arch/x86/mm/numa_emulation.c | 12 ++++++++++--
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
