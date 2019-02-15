Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91B6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3092073D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197655;
	bh=x2VuQDDkSUcZKgVq4YCWhtcQJy3VZd2p4NEogOqb8w4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gmfgRb9hWuojk11sOKq/aKkf+jM26I92ux1QaRhjt2Ce3X5NRNsQRi5Zbt9Rsx6w2
	 AwW6X09UQe3VJlB8o2xw1Oa5rq33mCJCQAk3RHDbac4/TCqXlqy4sR1Rg1Zn19MXSO
	 vaERMmmK6/YK8PTVBLi0LSpbOzyCImi7UGGevOfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbfBOC1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:27:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404732AbfBOCNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:13:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49B7C206BA;
        Fri, 15 Feb 2019 02:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196812;
        bh=x2VuQDDkSUcZKgVq4YCWhtcQJy3VZd2p4NEogOqb8w4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zDYotnEjPsz30q6zCk/f3CFKVxhM/c2h0kqcCwa/TysV7HLOE+eACHgLTu7geYQzD
         bz6lmElxg36HJK+euxeMa1rGifRmWS6zM87+T6YV41dVfjHt+2nW3seTAfeh9DtjSh
         gtyk/1+owy91SLppHpXp6d4GGhFHwIvV6b0HGYKg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinivas Ramana <sramana@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-msm@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 10/40] genirq: Make sure the initial affinity is not empty
Date:   Thu, 14 Feb 2019 21:12:43 -0500
Message-Id: <20190215021313.178476-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021313.178476-1-sashal@kernel.org>
References: <20190215021313.178476-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Ramana <sramana@codeaurora.org>

[ Upstream commit bddda606ec76550dd63592e32a6e87e7d32583f7 ]

If all CPUs in the irq_default_affinity mask are offline when an interrupt
is initialized then irq_setup_affinity() can set an empty affinity mask for
a newly allocated interrupt.

Fix this by falling back to cpu_online_mask in case the resulting affinity
mask is zero.

Signed-off-by: Srinivas Ramana <sramana@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-msm@vger.kernel.org
Link: https://lkml.kernel.org/r/1545312957-8504-1-git-send-email-sramana@codeaurora.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/irq/manage.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 4cd85870f00e..6c877d28838f 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -360,6 +360,9 @@ int irq_setup_affinity(struct irq_desc *desc)
 	}
 
 	cpumask_and(&mask, cpu_online_mask, set);
+	if (cpumask_empty(&mask))
+		cpumask_copy(&mask, cpu_online_mask);
+
 	if (node != NUMA_NO_NODE) {
 		const struct cpumask *nodemask = cpumask_of_node(node);
 
-- 
2.19.1

