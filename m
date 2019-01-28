Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D650C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7C6217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696563;
	bh=pKKn77FAk7lTGPblNWGmJvw2sy1EhkiAlcakvIk0S2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OzhPrITfjks7cebBBIJEHQhbC0L4c6XvF1kpYhGmUuOFPQjSlE+jtDQXtGrIlpoHL
	 K1ZinKK2+G5ggYkT5CG9GsYBS2CxzPXs7U4T+yCDcucOstKRhZfqqcH4RzkDaaWr7D
	 aX5pOlYWziLsKQchntVhnunfAPM8H3Pdd9HYLj1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbfA1R3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:29:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:45116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730629AbfA1P7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:59:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C5C821848;
        Mon, 28 Jan 2019 15:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691188;
        bh=pKKn77FAk7lTGPblNWGmJvw2sy1EhkiAlcakvIk0S2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g86zUMSbFAvzfNUZ9NbU3tYCd272ScGQ8tmKTwD5WyOL3i8sFaBa0GI7d1BC/WMob
         9UHSTNRGvoZrNtl35Z8YWziYMKr9juJOP4FpZuCpHWSWcpyF4UIAC1FoyMlPxIfUBI
         cNwrXQX96IrX9aqVfvwdCE4mhjzY3VNVOSntjz+Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 008/258] genirq/affinity: Spread IRQs to all available NUMA nodes
Date:   Mon, 28 Jan 2019 10:55:14 -0500
Message-Id: <20190128155924.51521-8-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

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

