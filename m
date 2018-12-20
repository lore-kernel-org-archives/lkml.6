Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AF9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAFB2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 13:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="E08oEc4m";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kwNCDsah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732901AbeLTNgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 08:36:14 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52732 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbeLTNgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 08:36:13 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1D8F3601D7; Thu, 20 Dec 2018 13:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545312973;
        bh=B0BoM2TW28FpQb4RXeKe07i8DAl6yuNefbtxdPYNu6A=;
        h=From:To:Cc:Subject:Date:From;
        b=E08oEc4mkgShzzLrs2uRsUrRCVXlxiliq7mMTvACoj1VF1HkVmR9VlI/tVle6rrDo
         prgL13T8HB4iWA5Qo/XSfAmm/R1JrH+Kx90grNoLPGklMx+4WOSQw27WVn1q8Ir7O0
         EUiTouWsxMOSYjszaUlZNF8VrK9Bqb6CiUNYjVsE=
Received: from sramana-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sramana@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 34D1F601D7;
        Thu, 20 Dec 2018 13:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545312972;
        bh=B0BoM2TW28FpQb4RXeKe07i8DAl6yuNefbtxdPYNu6A=;
        h=From:To:Cc:Subject:Date:From;
        b=kwNCDsahrYffRWvB49sY6c9Yh+6yTGc+KpdUhf5vIdwP74FLUHoEhn481ta+f/SVz
         Gg1Xv40Untz9jjP2mAE9yKMn2+f6hSs6pXNmGVSgxOObhbrIo4sCTq2gPwrQOwBQH6
         AiynJASZtcNNw5JlOxZvgU6STQ5GOuVjacw5L/iY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34D1F601D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sramana@codeaurora.org
From:   Srinivas Ramana <sramana@codeaurora.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Srinivas Ramana <sramana@codeaurora.org>
Subject: [PATCH] genirq: Make sure the affinity to be set is not empty
Date:   Thu, 20 Dec 2018 19:05:57 +0530
Message-Id: <1545312957-8504-1-git-send-email-sramana@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the default_affinity is managed/initialized by a system and
all the cpus present in irq_default_affinity are hotplugged out
we may end up passing a cpumask of 0 to irq_do_set_affinity().

Fix this by falling back to cpu_online_mask in case the
calculated affinity becomes zero.

Signed-off-by: Srinivas Ramana <sramana@codeaurora.org>
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
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., 
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

