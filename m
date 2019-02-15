Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2773EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBEE5206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550198058;
	bh=FnN2b7tTqbakzSmyWd5wQwV4ibN1ySbrBIAZcvY/YHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ncfQWVWxrqlALa4FcgLhRJy0rbSttLqVp+QrteyS+BIqOOswIq5nL2jK2QGKcXS/C
	 HeIwopS2bwtNmNt8KUaRvdfh7OjQDkQYsDtq7sQ/7m6nb78Ahx72ilD/JOH9LuTRzm
	 c2vTN5N1cqFUG6sRVJUuSpIL6ylbUfCdD/RWlV5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388665AbfBOCeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:34:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:51760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404004AbfBOCLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:11:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E860221934;
        Fri, 15 Feb 2019 02:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196704;
        bh=FnN2b7tTqbakzSmyWd5wQwV4ibN1ySbrBIAZcvY/YHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jHmmsMOPGvDtarx1FqwpJ16EYCkbN65otqj9SJiIVdcw2BvC99ZJCFcaUd+zmL4iH
         OZi42K8sHo1yXg1gzFsEmkIAAr+IoZz3Dr3n3bezsAu6ADkCOodWO85gBaxJ7GKtg+
         PZqtFnJzHUxNydAMnNR4ow20e3DKZZgtmEhq4I74=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Srinivas Ramana <sramana@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-msm@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 14/65] genirq: Make sure the initial affinity is not empty
Date:   Thu, 14 Feb 2019 21:10:30 -0500
Message-Id: <20190215021121.177674-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
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
index 9dbdccab3b6a..5c0ba5ca5930 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -393,6 +393,9 @@ int irq_setup_affinity(struct irq_desc *desc)
 	}
 
 	cpumask_and(&mask, cpu_online_mask, set);
+	if (cpumask_empty(&mask))
+		cpumask_copy(&mask, cpu_online_mask);
+
 	if (node != NUMA_NO_NODE) {
 		const struct cpumask *nodemask = cpumask_of_node(node);
 
-- 
2.19.1

