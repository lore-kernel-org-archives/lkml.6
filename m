Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBA9C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 09:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40341206B7
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 09:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40341206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbeLBJG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 04:06:57 -0500
Received: from www.osadl.org ([62.245.132.105]:33520 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbeLBJG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 04:06:57 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wB2942Us005968;
        Sun, 2 Dec 2018 10:04:02 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [RFC PATCH] soc: fsl: guts: handle devm_kstrdup() failure
Date:   Sun,  2 Dec 2018 10:00:58 +0100
Message-Id: <1543741258-17433-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_kstrdup() may return NULL if internal allocation failed.
soc_dev_attr.machine  should be checked (although its only use
in pr_info() would be safe even with a NULL). Therefor
in the unlikely case of allocation failure, fsl_guts_probe() returns
-ENOMEM as this allocating failing is an indication of something
more serious going wrong at system level.

As  machine  is from the device tree which I assume to be RO - if
that assumption is always correct - a better alternative would be
to use devm_kstrdup_const() here. That would then simply copy the
reference to the RO data and not perform any allocation at all.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: a6fc3b698130 ("soc: fsl: add GUTS driver for QorIQ platforms")
---

Problem located by experimental coccinelle script

Patch was compile tested with: multi_v7_defconfig (implies FSL_GUTS=y)

Patch is against 4.20-rc4 (localversion-next is next-20181130)

 drivers/soc/fsl/guts.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 302e0c8..a0c751b 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -156,8 +156,11 @@ static int fsl_guts_probe(struct platform_device *pdev)
 	if (of_property_read_string(root, "model", &machine))
 		of_property_read_string_index(root, "compatible", 0, &machine);
 	of_node_put(root);
-	if (machine)
+	if (machine) {
 		soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);
+		if (!soc_dev_attr.machine)
+			return -ENOMEM;
+	}
 
 	svr = fsl_guts_get_svr();
 	soc_die = fsl_soc_die_match(svr, fsl_soc_die);
-- 
2.1.4

