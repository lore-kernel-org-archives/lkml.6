Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C373C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC3F22419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC3F22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732622AbeKODHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:07:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:31553 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725759AbeKODHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:07:23 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1270A315487B;
        Wed, 14 Nov 2018 17:03:23 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-204-52.brq.redhat.com [10.40.204.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EBB9160BF6;
        Wed, 14 Nov 2018 17:03:20 +0000 (UTC)
From:   Laurent Vivier <lvivier@redhat.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Satheesh Rajendran <satheera@in.ibm.com>,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] powerpc/numa: fix hot-added CPU on memory-less node
Date:   Wed, 14 Nov 2018 18:03:19 +0100
Message-Id: <20181114170319.24828-1-lvivier@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 14 Nov 2018 17:03:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to hotplug a CPU on an empty NUMA node (without
memory or CPU) crashes the kernel when the CPU is onlined.

During the onlining process, the kernel calls start_secondary()
that ends by calling
set_numa_mem(local_memory_node(numa_cpu_lookup_table[cpu]))
that relies on NODE_DATA(nid)->node_zonelists and in our case
NODE_DATA(nid) is NULL.

To fix that, add the same checking as we already have in
find_and_online_cpu_nid(): if NODE_DATA() is NULL, use
the first online node.

Bug: https://github.com/linuxppc/linux/issues/184
Fixes: ea05ba7c559c8e5a5946c3a94a2a266e9a6680a6
       (powerpc/numa: Ensure nodes initialized for hotplug)
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 arch/powerpc/mm/numa.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 3a048e98a132..1b2d25a3c984 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -483,6 +483,15 @@ static int numa_setup_cpu(unsigned long lcpu)
 	if (nid < 0 || !node_possible(nid))
 		nid = first_online_node;
 
+	if (NODE_DATA(nid) == NULL) {
+		/*
+		 * Default to using the nearest node that has memory installed.
+		 * Otherwise, it would be necessary to patch the kernel MM code
+		 * to deal with more memoryless-node error conditions.
+		 */
+		nid = first_online_node;
+	}
+
 	map_cpu_to_node(lcpu, nid);
 	of_node_put(cpu);
 out:
-- 
2.17.2

