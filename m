Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D759C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667E92709D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667E92709D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934442AbeF1H4O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:56:14 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:53866 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933815AbeF1H4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:56:11 -0400
Received: from localhost.localdomain (200116b84699cc0061630d7c5db5b655.dip.versatel-1u1.de [IPv6:2001:16b8:4699:cc00:6163:d7c:5db5:b655])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 02C1128BF06;
        Thu, 28 Jun 2018 07:52:54 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com,
        szabolcs.gyurko@tlt.hu
Cc:     sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        robert.jarzmik@free.fr, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v2 3/4] w1: ds2760: add devicetree matching glue
Date:   Thu, 28 Jun 2018 09:55:39 +0200
Message-Id: <20180628075540.1757-4-daniel@zonque.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628075540.1757-1-daniel@zonque.org>
References: <20180628075540.1757-1-daniel@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an id table for ds2760 so it can be matched by the core.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/w1/slaves/w1_ds2760.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/w1/slaves/w1_ds2760.c b/drivers/w1/slaves/w1_ds2760.c
index 26168abfb8b8..e1726a4e4b1d 100644
--- a/drivers/w1/slaves/w1_ds2760.c
+++ b/drivers/w1/slaves/w1_ds2760.c
@@ -17,6 +17,7 @@
 #include <linux/mutex.h>
 #include <linux/idr.h>
 #include <linux/gfp.h>
+#include <linux/of.h>
 
 #include <linux/w1.h>
 
@@ -157,6 +158,13 @@ static void w1_ds2760_remove_slave(struct w1_slave *sl)
 	platform_device_unregister(pdev);
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id w1_ds2760_of_ids[] = {
+	{ .compatible = "maxim,ds2760" },
+	{}
+};
+#endif
+
 static struct w1_family_ops w1_ds2760_fops = {
 	.add_slave    = w1_ds2760_add_slave,
 	.remove_slave = w1_ds2760_remove_slave,
@@ -166,6 +174,7 @@ static struct w1_family_ops w1_ds2760_fops = {
 static struct w1_family w1_ds2760_family = {
 	.fid = W1_FAMILY_DS2760,
 	.fops = &w1_ds2760_fops,
+	.of_match_table = of_match_ptr(w1_ds2760_of_ids),
 };
 module_w1_family(w1_ds2760_family);
 
-- 
2.17.1

