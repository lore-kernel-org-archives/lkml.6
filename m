Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BA9C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414EA20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 414EA20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbeLCMVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:21:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:35788 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726208AbeLCMVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:21:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4C2AEAFD4;
        Mon,  3 Dec 2018 12:20:15 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Evgeniy Polyakov <zbr@ioremap.net>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] w1: fix wrong dt refcount in attach slave device
Date:   Mon,  3 Dec 2018 13:19:51 +0100
Message-Id: <20181203121951.1230-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With each call to of_find_matching_node() we're decresing the reference
count on the master's dt node. This is not what we actually want. So we
get a refernce to the dt node before calling it.

Fixes: fae68031f7fbc ("w1: core: match sub-nodes of bus masters in devicetree")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/w1/w1.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 890c038c25f8..09514fa6c6b9 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -680,15 +680,17 @@ static int w1_family_notify(unsigned long action, struct w1_slave *sl)
 
 static int __w1_attach_slave_device(struct w1_slave *sl)
 {
+	struct device_node *np;
 	int err;
 
+	np = of_node_get(sl->master->dev.of_node);
+
 	sl->dev.parent = &sl->master->dev;
 	sl->dev.driver = &w1_slave_driver;
 	sl->dev.bus = &w1_bus_type;
 	sl->dev.release = &w1_slave_release;
 	sl->dev.groups = w1_slave_groups;
-	sl->dev.of_node = of_find_matching_node(sl->master->dev.of_node,
-						sl->family->of_match_table);
+	sl->dev.of_node = of_find_matching_node(np, sl->family->of_match_table);
 
 	dev_set_name(&sl->dev, "%02x-%012llx",
 		 (unsigned int) sl->reg_num.family,
-- 
2.19.2

