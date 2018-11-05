Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3F4ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3E320869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3E320869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbeKEUlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:41:23 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53281 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbeKEUlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:41:22 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA5BLu2v309704
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 5 Nov 2018 03:21:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA5BLtgD309701;
        Mon, 5 Nov 2018 03:21:55 -0800
Date:   Mon, 5 Nov 2018 03:21:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Long Li <tipbot@zytor.com>
Message-ID: <tip-b82592199032bf7c778f861b936287e37ebc9f62@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        mingo@kernel.org, longli@microsoft.com, ming.lei@redhat.com,
        tglx@linutronix.de, hpa@zytor.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, ming.lei@redhat.com,
          longli@microsoft.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, mikelley@microsoft.com
In-Reply-To: <20181102180248.13583-1-longli@linuxonhyperv.com>
References: <20181102180248.13583-1-longli@linuxonhyperv.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/affinity: Spread IRQs to all available NUMA
 nodes
Git-Commit-ID: b82592199032bf7c778f861b936287e37ebc9f62
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

Commit-ID:  b82592199032bf7c778f861b936287e37ebc9f62
Gitweb:     https://git.kernel.org/tip/b82592199032bf7c778f861b936287e37ebc9f62
Author:     Long Li <longli@microsoft.com>
AuthorDate: Fri, 2 Nov 2018 18:02:48 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 5 Nov 2018 12:16:26 +0100

genirq/affinity: Spread IRQs to all available NUMA nodes

If the number of NUMA nodes exceeds the number of MSI/MSI-X interrupts
which are allocated for a device, the interrupt affinity spreading code
fails to spread them across all nodes.

The reason is, that the spreading code starts from node 0 and continues up
to the number of interrupts requested for allocation. This leaves the nodes
past the last interrupt unused.

This results in interrupt concentration on the first nodes which violates
the assumption of the block layer that all nodes are covered evenly. As a
consequence the NUMA nodes above the number of interrupts are all assigned
to hardware queue 0 and therefore NUMA node 0, which results in bad
performance and has CPU hotplug implications, because queue 0 gets shut
down when the last CPU of node 0 is offlined.

Go over all NUMA nodes and assign them round-robin to all requested
interrupts to solve this.

[ tglx: Massaged changelog ]

Signed-off-by: Long Li <longli@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Cc: Michael Kelley <mikelley@microsoft.com>
Link: https://lkml.kernel.org/r/20181102180248.13583-1-longli@linuxonhyperv.com

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
 
