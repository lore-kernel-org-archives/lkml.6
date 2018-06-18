Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8530FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478DC20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478DC20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967775AbeFRI4a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:56:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35760 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967407AbeFRIe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:34:28 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0C77FC8A;
        Mon, 18 Jun 2018 08:34:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Sebastian Sanchez <sebastian.sanchez@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 114/189] IB/hfi1: Fix memory leak in exception path in get_irq_affinity()
Date:   Mon, 18 Jun 2018 10:13:30 +0200
Message-Id: <20180618081213.836102190@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Sanchez <sebastian.sanchez@intel.com>

[ Upstream commit 59482a14918b282ca2a98f38c69da5ebeb1107d2 ]

When IRQ affinity is set and the interrupt type is unknown, a cpu
mask allocated within the function is never freed. Fix this memory
leak by allocating memory within the scope where it is used.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Sebastian Sanchez <sebastian.sanchez@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/hfi1/affinity.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

--- a/drivers/infiniband/hw/hfi1/affinity.c
+++ b/drivers/infiniband/hw/hfi1/affinity.c
@@ -412,7 +412,6 @@ static void hfi1_cleanup_sdma_notifier(s
 static int get_irq_affinity(struct hfi1_devdata *dd,
 			    struct hfi1_msix_entry *msix)
 {
-	int ret;
 	cpumask_var_t diff;
 	struct hfi1_affinity_node *entry;
 	struct cpu_mask_set *set = NULL;
@@ -424,10 +423,6 @@ static int get_irq_affinity(struct hfi1_
 	extra[0] = '\0';
 	cpumask_clear(&msix->mask);
 
-	ret = zalloc_cpumask_var(&diff, GFP_KERNEL);
-	if (!ret)
-		return -ENOMEM;
-
 	entry = node_affinity_lookup(dd->node);
 
 	switch (msix->type) {
@@ -458,6 +453,9 @@ static int get_irq_affinity(struct hfi1_
 	 * finds its CPU here.
 	 */
 	if (cpu == -1 && set) {
+		if (!zalloc_cpumask_var(&diff, GFP_KERNEL))
+			return -ENOMEM;
+
 		if (cpumask_equal(&set->mask, &set->used)) {
 			/*
 			 * We've used up all the CPUs, bump up the generation
@@ -469,6 +467,8 @@ static int get_irq_affinity(struct hfi1_
 		cpumask_andnot(diff, &set->mask, &set->used);
 		cpu = cpumask_first(diff);
 		cpumask_set_cpu(cpu, &set->used);
+
+		free_cpumask_var(diff);
 	}
 
 	cpumask_set_cpu(cpu, &msix->mask);
@@ -482,7 +482,6 @@ static int get_irq_affinity(struct hfi1_
 		hfi1_setup_sdma_notifier(msix);
 	}
 
-	free_cpumask_var(diff);
 	return 0;
 }
 


