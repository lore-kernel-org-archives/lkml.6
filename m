Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1163AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8ED20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hckKSOfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfAHCLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 21:11:53 -0500
Received: from ozlabs.org ([203.11.71.1]:56773 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbfAHCLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 21:11:53 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43YbNk5FgNz9sCr;
        Tue,  8 Jan 2019 13:11:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1546913511;
        bh=yuETVS/OCGwxCim1PExs1hPHKHmYt2dmbNfvbpUVFyw=;
        h=Date:From:To:Cc:Subject:From;
        b=hckKSOfUK+dzS1p2XmfK22EqbTIquCi0h9Rbn+JrsFf3bLMsjlKK9PoLMv1bxmLVA
         94lxGlG9I3VeKJjDG4dKlQTkMoxrs7cg5u6cIIFuSMI2/XybyL4B1UPewkeOTVlR3Z
         YHYlrzLuKnjkCO9RFo39PsK0cRGO0v57S0Tf339VUMyq3jWuOcoPES8dbfLw21XWvf
         g4ytw18/383xWlSwES5VpZPQ3Rp2zTVfL8adMQCOGB5LCzASF6suJVF+YoLHAaDTLY
         Y3IHO5a/7xwpY1ESnr1HJVoeuQKCLu795J/hSJfO0zNqKKvOwcFDyKEoJEbMszwUJA
         JuWnx2t7uwrmA==
Date:   Tue, 8 Jan 2019 13:11:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190108131141.730e9c4f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

After merging the akpm-current tree, today's linux-next build (native
perf) failed like this:

bench/numa.c: In function 'bind_to_node':
bench/numa.c:301:21: error: 'NUMA_NO_NODE' undeclared (first use in this function); did you mean 'NUMA_NUM_NODES'?
  if (target_node == NUMA_NO_NODE) {
                     ^~~~~~~~~~~~
                     NUMA_NUM_NODES
bench/numa.c:301:21: note: each undeclared identifier is reported only once for each function it appears in
bench/numa.c: In function 'bind_to_memnode':
bench/numa.c:342:14: error: 'NUMA_NO_NODE' undeclared (first use in this function); did you mean 'NUMA_NUM_NODES'?
  if (node == NUMA_NO_NODE)
              ^~~~~~~~~~~~
              NUMA_NUM_NODES
bench/numa.c: In function 'init_thread_data':
bench/numa.c:1366:19: error: 'NUMA_NO_NODE' undeclared (first use in this function); did you mean 'NUMA_NUM_NODES'?
   td->bind_node = NUMA_NO_NODE;
                   ^~~~~~~~~~~~
                   NUMA_NUM_NODES

Caused by commit

  3856193d8452 ("tools/: replace open encodings for NUMA_NO_NODE")

[BTW, I did not write that patch, just added fixes last time]
[BTW 2, there are lots of cc's that probably no longer apply since this
was split form the previous patch]

I have applied the following fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 8 Jan 2019 13:08:32 +1100
Subject: [PATCH] tools/: fix for replace open encodings for NUMA_NO_NODE

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 tools/perf/bench/numa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index e0ad5f1de226..98ad783efc69 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -34,6 +34,7 @@
 #include <sys/types.h>
 #include <linux/kernel.h>
 #include <linux/time64.h>
+#include <linux/numa.h>
 
 #include <numa.h>
 #include <numaif.h>
-- 
2.20.1

-- 
Cheers,
Stephen Rothwell
