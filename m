Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA39C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8BF2469C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 04:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8BF2469C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933345AbeGDEpA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 00:45:00 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:41012 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932684AbeGDEoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 00:44:22 -0400
Received: from localhost.localdomain (pD95EF712.dip0.t-ipconnect.de [217.94.247.18])
        by mail.bugwerft.de (Postfix) with ESMTPSA id E753D28D401;
        Wed,  4 Jul 2018 04:40:58 +0000 (UTC)
From:   Daniel Mack <daniel@zonque.org>
To:     zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com,
        szabolcs.gyurko@tlt.hu
Cc:     sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        robert.jarzmik@free.fr, Daniel Mack <daniel@zonque.org>
Subject: [PATCH v3 2/4] w1: core: match sub-nodes of bus masters in devicetree
Date:   Wed,  4 Jul 2018 06:44:09 +0200
Message-Id: <20180704044411.2693-3-daniel@zonque.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704044411.2693-1-daniel@zonque.org>
References: <20180704044411.2693-1-daniel@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once a new slave device is detected, match it against all sub-nodes of the
master bus controller. If a match is found, set the slave device's of_node
pointer.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/w1/w1.c    | 3 +++
 include/linux/w1.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index caef0e0fd817..890c038c25f8 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -26,6 +26,7 @@
 #include <linux/kthread.h>
 #include <linux/freezer.h>
 #include <linux/hwmon.h>
+#include <linux/of.h>
 
 #include <linux/atomic.h>
 
@@ -686,6 +687,8 @@ static int __w1_attach_slave_device(struct w1_slave *sl)
 	sl->dev.bus = &w1_bus_type;
 	sl->dev.release = &w1_slave_release;
 	sl->dev.groups = w1_slave_groups;
+	sl->dev.of_node = of_find_matching_node(sl->master->dev.of_node,
+						sl->family->of_match_table);
 
 	dev_set_name(&sl->dev, "%02x-%012llx",
 		 (unsigned int) sl->reg_num.family,
diff --git a/include/linux/w1.h b/include/linux/w1.h
index 694101f744c7..3111585c371f 100644
--- a/include/linux/w1.h
+++ b/include/linux/w1.h
@@ -274,6 +274,8 @@ struct w1_family {
 
 	struct w1_family_ops	*fops;
 
+	const struct of_device_id *of_match_table;
+
 	atomic_t		refcnt;
 };
 
-- 
2.17.1

