Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2595CC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC9821761
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 11:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC9821761
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbeHCNU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 09:20:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:9685 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbeHCNU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 09:20:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2018 04:25:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,438,1526367600"; 
   d="scan'208";a="62107286"
Received: from devel-ww.sh.intel.com ([10.239.48.110])
  by orsmga008.jf.intel.com with ESMTP; 03 Aug 2018 04:25:02 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, akpm@linux-foundation.org,
        penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
        mst@redhat.com
Cc:     wei.w.wang@intel.com
Subject: [PATCH] mm/vmscan: adjust shrinkctl->nr_scanned after invoking scan_objects
Date:   Fri,  3 Aug 2018 18:56:49 +0800
Message-Id: <1533293809-34354-1-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some shrinkers may free more than the requested nr_to_scan of pages
in one invocation of scan_objects, and some may free less than that.

Currently shrinkers can either return the actual number of pages that
have been freed via the return value of scan_objects or track that
actual number in shrinkctl->nr_scanned. But do_shrink_slab works on an
assumption that the actual number is always tracked via
shrinkctl->nr_scanned, which is not true. Having checked the shrinkers
used in the kernel, they basically return the actual number of freed
pages via the return value of scan_objects, and most of them leave
shrinkctl->nr_scanned unchanged after scan_objects is called.

So this patch adjusts shrinkctl->nr_scanned to the actual freed number
after scan_objects is called.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Michael S. Tsirkin <mst@redhat.com>
---
 mm/vmscan.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 03822f8..78a75b9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -447,9 +447,13 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 		if (ret == SHRINK_STOP)
 			break;
 		freed += ret;
+		shrinkctl->nr_scanned = ret;
 
 		count_vm_events(SLABS_SCANNED, shrinkctl->nr_scanned);
-		total_scan -= shrinkctl->nr_scanned;
+		if (total_scan > shrinkctl->nr_scanned)
+			total_scan -= shrinkctl->nr_scanned;
+		else
+			total_scan = 0;
 		scanned += shrinkctl->nr_scanned;
 
 		cond_resched();
-- 
2.7.4

