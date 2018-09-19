Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9048C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A2F2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A2F2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732891AbeISW6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:58:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:57176 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731841AbeISW6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:58:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 10:19:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,394,1531810800"; 
   d="scan'208";a="91959318"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.93])
  by orsmga001.jf.intel.com with ESMTP; 19 Sep 2018 10:19:31 -0700
Subject: [PATCH] x86/numa_emulation: fix parsing of numa_meminfo for uniform
 numa emulation
From:   Dave Jiang <dave.jiang@intel.com>
To:     mingo@redhat.com, dan.j.williams@intel.com
Cc:     tglx@linutronix.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 19 Sep 2018 10:19:31 -0700
Message-ID: <153737757130.23982.8187099986085191337.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During fakenuma processing in numa_emulation(), pi gets passed in and
processed as new fake numa nodes are being split out. Once the original
memory region is proccessed, it gets removed from the pi by
numa_remove_memblk_from() in emu_setup_memblk(). So entry 0 gets deleted
and the rest of the entries get moved up. Therefore we should always pass
in entry 0 for the next entry to process.

Fixes: 1f6a2c6d9f121 ("x86/numa_emulation: Introduce uniform split
capability")

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 arch/x86/mm/numa_emulation.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index b54d52a2d00a..a3ca8bf5afcb 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -401,8 +401,8 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
 		ret = -1;
 		for_each_node_mask(i, physnode_mask) {
 			ret = split_nodes_size_interleave_uniform(&ei, &pi,
-					pi.blk[i].start, pi.blk[i].end, 0,
-					n, &pi.blk[i], nid);
+					pi.blk[0].start, pi.blk[0].end, 0,
+					n, &pi.blk[0], nid);
 			if (ret < 0)
 				break;
 			if (ret < n) {

