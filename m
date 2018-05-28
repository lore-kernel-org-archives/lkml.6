Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423374AbeE1LHH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:07:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423342AbeE1LG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:06:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>, Ming Lei <ming.lei@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 067/272] genirq/affinity: Dont return with empty affinity masks on error
Date: Mon, 28 May 2018 12:01:40 +0200
Message-Id: <20180528100246.534540714@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 0211e12dd0a5385ecffd3557bc570dbad7fcf245 ]

When the allocation of node_to_possible_cpumask fails, then
irq_create_affinity_masks() returns with a pointer to the empty affinity
masks array, which will cause malfunction.

Reorder the allocations so the masks array allocation comes last and every
failure path returns NULL.

Fixes: 9a0ef98e186d ("genirq/affinity: Assign vectors to all present CPUs")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/irq/affinity.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -108,7 +108,7 @@ irq_create_affinity_masks(int nvecs, con
 	int affv = nvecs - affd->pre_vectors - affd->post_vectors;
 	int last_affv = affv + affd->pre_vectors;
 	nodemask_t nodemsk = NODE_MASK_NONE;
-	struct cpumask *masks;
+	struct cpumask *masks = NULL;
 	cpumask_var_t nmsk, *node_to_possible_cpumask;
 
 	/*
@@ -121,13 +121,13 @@ irq_create_affinity_masks(int nvecs, con
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
 		return NULL;
 
-	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
-	if (!masks)
-		goto out;
-
 	node_to_possible_cpumask = alloc_node_to_possible_cpumask();
 	if (!node_to_possible_cpumask)
-		goto out;
+		goto outcpumsk;
+
+	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
+	if (!masks)
+		goto outnodemsk;
 
 	/* Fill out vectors at the beginning that don't need affinity */
 	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
@@ -192,8 +192,9 @@ done:
 	/* Fill out vectors at the end that don't need affinity */
 	for (; curvec < nvecs; curvec++)
 		cpumask_copy(masks + curvec, irq_default_affinity);
+outnodemsk:
 	free_node_to_possible_cpumask(node_to_possible_cpumask);
-out:
+outcpumsk:
 	free_cpumask_var(nmsk);
 	return masks;
 }
