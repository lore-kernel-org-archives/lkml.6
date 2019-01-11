Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D79C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F092184C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217148;
	bh=J6h3NzEa0zLtB4i/OR0d861cfC1SWi0lkoCDObyGm28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JSJT4wvzFywgNYvyQV1+jeazXmKCRbfKIfVDsZU+orkv0dpUKmhvgSb+/cim6TdHk
	 rznrCdeLaT3v6Qb0tq//8xGV65QNnwXJrrtCbVdUEuxyg3gxMHpHiFVmTUyhXBrr3L
	 BLu8E3DxVQXLlx7A0n3zK2b7SX9bRZc/UTSkN6HE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389434AbfAKOc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:32:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389405AbfAKOcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:32:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D757B2063F;
        Fri, 11 Jan 2019 14:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217144;
        bh=J6h3NzEa0zLtB4i/OR0d861cfC1SWi0lkoCDObyGm28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zSMoLKAsa48mkjiLnsYfURAK73+FJbtSKrwMn2d/MYUoMKB+xkftYQNcsOlcod7lg
         NT1nmtLJMI/OMbZm33vOV3HH9b/K8jkSCDkJYJDkHhdsGLqscqsh8cDxFcTyBJ6Byx
         8tmHAKbfLRxZvP8yKcyVK4xxUt3svLVfuM2Q3dbc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH 4.14 057/105] genirq/affinity: Dont return with empty affinity masks on error
Date:   Fri, 11 Jan 2019 15:14:28 +0100
Message-Id: <20190111131107.804095722@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 0211e12dd0a5385ecffd3557bc570dbad7fcf245 upstream.

When the allocation of node_to_possible_cpumask fails, then
irq_create_affinity_masks() returns with a pointer to the empty affinity
masks array, which will cause malfunction.

Reorder the allocations so the masks array allocation comes last and every
failure path returns NULL.

Fixes: 9a0ef98e186d ("genirq/affinity: Assign vectors to all present CPUs")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Mihai Carabas <mihai.carabas@oracle.com>
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


