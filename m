Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2E9C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E230920700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901566;
	bh=dKUb8vulXQNpdtjNLMg/62jy00nkV0znlLLcL2wfow0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DB4Mg/nuAIRyPjBQRUKJj1hvyin8sjYQH1SZneiVXF3iFhxIc4djdw4w8hhJ/ptKs
	 lxiGaGZtPIbSw4HWUYhE3pBBVuko+Y1wRa91qsWO4DYKAmMbU1VhUUpg75kTiYG912
	 el68AVx48Mv/v5ow12ASY5x2Lfz1dqc8flkjSItA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfBKOW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:22:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:55964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbfBKOW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:22:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBFCA222A1;
        Mon, 11 Feb 2019 14:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894977;
        bh=dKUb8vulXQNpdtjNLMg/62jy00nkV0znlLLcL2wfow0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cT+5CwS3ar2cfRt/m/Pg+9pU58zswtIjuy7VfNKmUQgeHqJUMcF+DvowKh9Otr4dA
         iQ+5nAOY5vsHErckVtADIJodfruYF1LLRVzU6WNOJ++gudtQ6mycCp580hu0sW7qqL
         1WqDmD/3AIrOOc0FQmWPBWPBxWiHv/RvKIfsGdZ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Long Li <longli@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 011/352] genirq/affinity: Spread IRQs to all available NUMA nodes
Date:   Mon, 11 Feb 2019 15:13:58 +0100
Message-Id: <20190211141847.139076298@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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



