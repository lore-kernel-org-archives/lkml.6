Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B242C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 072322082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072322082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeKCDMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:12:03 -0400
Received: from a2nlsmtp01-05.prod.iad2.secureserver.net ([198.71.225.49]:43018
        "EHLO a2nlsmtp01-05.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727776AbeKCDMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:12:02 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id IdmdgSwxvbOGjIdmdgK57U; Fri, 02 Nov 2018 11:02:59 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1gIdmd-0003Xl-JB; Fri, 02 Nov 2018 11:02:59 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-kernel@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v2] genirq/affinity: Spread IRQs to all available NUMA nodes
Date:   Fri,  2 Nov 2018 18:02:48 +0000
Message-Id: <20181102180248.13583-1-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfG6ipy/pc/oczIg+AUAy4IYSbrop7CZoa0o+suZop5DlTyq9QqXyMvrFVnfuOQ8MKkIvXWmSAyEKuBKT2DpiIIE8LtDhJwBL6uZljfrlVRKAwRwhGLtM
 QqomZmm96HbBIGo5K/r89jb7zmcV0s1DHPEcveHEaHiDBUuhcnLdzxVu3S33YuoqlYg6gBf4FUiXiSjl/EQ9SewkRIREK/X38fn2jX0xZ4QjF7q7Y92cZi1h
 e1DRVyc/xjBgZyQhWKCxOmdSerpbN1kvyyoz05j1trwiBwmb5uooKKuKTQrL8M2CrEwswPkGePTXCJQ60fk02/4ZikMtSmrL7g0ubQnivzQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

On systems with large number of NUMA nodes, there may be more NUMA nodes than
the number of MSI/MSI-X interrupts that device requests for. The current code
always picks up the NUMA nodes starting from the node 0, up to the number of
interrupts requested. This may left some later NUMA nodes unused.

For example, if the system has 16 NUMA nodes, and the device reqeusts for 8
interrupts, NUMA node 0 to 7 are assigned for those interrupts, NUMA 8 to 15
are unused.

There are several problems with this approach:
1. Later, when those managed IRQs are allocated, they can not be assigned to
NUMA 8 to 15, this may create an IRQ concentration on NUMA 0 to 7.
2. Some upper layers assume affinity mask has a complete coverage over NUMA nodes.
For example, block layer use the affinity mask to decide how to map CPU queues to
hardware queues, missing NUMA nodes in the masks may result in an uneven mapping
of queues. For the above example of 16 NUMA nodes, CPU queues on NUMA node 0 to 7
are assigned to the hardware queues 0 to 7, respectively. But CPU queues on NUMA
node 8 to 15 are all assigned to the hardware queue 0.

Fix this problem by going over all NUMA nodes and assign them round-robin to
all IRQs.

Change in v2: Removed extra code for calculating "done". (Michael Kelley
<mikelley@microsoft.com>)

Signed-off-by: Long Li <longli@microsoft.com>
---
 kernel/irq/affinity.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index f4f29b9d90ee..e12cdf637c71 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -117,12 +117,11 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
 	 */
 	if (numvecs <= nodes) {
 		for_each_node_mask(n, nodemsk) {
-			cpumask_copy(masks + curvec, node_to_cpumask[n]);
-			if (++done == numvecs)
-				break;
+			cpumask_or(masks + curvec, masks + curvec, node_to_cpumask[n]);
 			if (++curvec == last_affv)
 				curvec = affd->pre_vectors;
 		}
+		done = numvecs;
 		goto out;
 	}
 
-- 
2.14.1

