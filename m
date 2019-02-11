Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A454EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73EF420838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895970;
	bh=zOVSQ8PZ89S8cs0q2VNE6PyEw+f40T5yc4wbtIhbmuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QKRZIDm7YvjFw95b8GmKhlM2d9Kezg3JGVkCxnFtz4Mjuwnt1+rnY0LgY7/XISvBW
	 X/Nme2eQXbSMsEKMvdV/MTFLFKZnlhYYZt+674KvXhVSiWET3wB96cZqiXE0lRTeme
	 MeyHCCVsX4Q/pcOKlPhoPi3wJMz789EAH3BX/Oec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731439AbfBKOj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:39:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:49710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728002AbfBKOj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:39:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5D1120700;
        Mon, 11 Feb 2019 14:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895965;
        bh=zOVSQ8PZ89S8cs0q2VNE6PyEw+f40T5yc4wbtIhbmuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MeCG1DhiekYMSUE5p/oLyOFDYaZqhJQJyNfdgkZ6SvBhlHcH6OJixoa+sRmjoyjoV
         pgT++Iwalo7jyqzJBDE+NL4FwmLSxcCl5B4AHKd0z/k8hGBlxhsfzsTU90YdB+Vixl
         oKphD0Nz2bJpeJrGT/bE0q5MgjMvRhAWefJTwisw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Long Li <longli@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 009/313] genirq/affinity: Spread IRQs to all available NUMA nodes
Date:   Mon, 11 Feb 2019 15:14:49 +0100
Message-Id: <20190211141853.580982643@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b82592199032bf7c778f861b936287e37ebc9f62 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.19.1



