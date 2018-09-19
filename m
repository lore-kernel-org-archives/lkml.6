Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302AFECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5CE2151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE5CE2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732296AbeISXvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:51:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:5585 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728096AbeISXvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:51:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 11:12:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,394,1531810800"; 
   d="scan'208";a="74587137"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.93])
  by orsmga008.jf.intel.com with ESMTP; 19 Sep 2018 11:12:14 -0700
Subject: [PATCH v2] x86/numa_emulation: fix parsing of numa_meminfo for
 uniform numa emulation
From:   Dave Jiang <dave.jiang@intel.com>
To:     mingo@redhat.com, dan.j.williams@intel.com
Cc:     tglx@linutronix.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 19 Sep 2018 11:12:14 -0700
Message-ID: <153738070476.51648.10732413805504758768.stgit@djiang5-desk3.ch.intel.com>
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
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---

V2:
- Add comment for the code change (Dan)

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

