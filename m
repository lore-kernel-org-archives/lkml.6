Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743D7C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4560C20645
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546976016;
	bh=UrAh5yny5LNoG+2p+xDmBbh6djkyPab6brOwxHuB5tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dUIoZ+DwmZRElSjygGjQpTzt5URUX/X9qnsVDx5zwq7DhygfSJWvAARJgPcliKpPX
	 O1QMNzTBnKXlgfFw9pYMeEuEGfIXGKysSyNLgT86SMoQlc9hXulzhmQN7n0vIGFfT8
	 yU6rLfRlR56qcv8IDbC3teICI1O965tbrJkccHHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbfAHTdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:33:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731719AbfAHTda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:33:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F62D20827;
        Tue,  8 Jan 2019 19:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546976010;
        bh=UrAh5yny5LNoG+2p+xDmBbh6djkyPab6brOwxHuB5tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g0Is47xIOuJG6HvHW870TkF9mKHcANc9W/swFRZ0mv8S4xfMrEftKyYRSy586++JB
         1KpLHZBDhFgK/als+iolFQvRrKGQ9Mj8YM4jtdb8oogwV720YA9NyYeyKGEbghiQO0
         gi8tGm5m/vFqkhWea+pai2U6dieH7G0dr6/5/ii4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 43/53] clocksource/drivers/integrator-ap: Add missing of_node_put()
Date:   Tue,  8 Jan 2019 14:32:11 -0500
Message-Id: <20190108193222.123316-43-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108193222.123316-1-sashal@kernel.org>
References: <20190108193222.123316-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

[ Upstream commit 5eb73c831171115d3b4347e1e7124a5a35d8086c ]

The function of_find_node_by_path() acquires a reference to the node
returned by it and that reference needs to be dropped by its caller.

integrator_ap_timer_init_of() doesn't do that.  The pri_node and the
sec_node are used as an identifier to compare against the current
node, so we can directly drop the refcount after getting the node from
the path as it is not used as pointer.

By dropping the refcount right after getting it, a single variable is
needed instead of two.

Fix this by use a single variable and drop the refcount right after
of_find_node_by_path().

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/timer-integrator-ap.c | 25 +++++++++++++++--------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksource/timer-integrator-ap.c
index 62d24690ba02..9701107806a7 100644
--- a/drivers/clocksource/timer-integrator-ap.c
+++ b/drivers/clocksource/timer-integrator-ap.c
@@ -181,8 +181,7 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
 	int irq;
 	struct clk *clk;
 	unsigned long rate;
-	struct device_node *pri_node;
-	struct device_node *sec_node;
+	struct device_node *alias_node;
 
 	base = of_io_request_and_map(node, 0, "integrator-timer");
 	if (IS_ERR(base))
@@ -204,7 +203,18 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
 		return err;
 	}
 
-	pri_node = of_find_node_by_path(path);
+	alias_node = of_find_node_by_path(path);
+
+	/*
+	 * The pointer is used as an identifier not as a pointer, we
+	 * can drop the refcount on the of__node immediately after
+	 * getting it.
+	 */
+	of_node_put(alias_node);
+
+	if (node == alias_node)
+		/* The primary timer lacks IRQ, use as clocksource */
+		return integrator_clocksource_init(rate, base);
 
 	err = of_property_read_string(of_aliases,
 				"arm,timer-secondary", &path);
@@ -213,14 +223,11 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
 		return err;
 	}
 
+	alias_node = of_find_node_by_path(path);
 
-	sec_node = of_find_node_by_path(path);
-
-	if (node == pri_node)
-		/* The primary timer lacks IRQ, use as clocksource */
-		return integrator_clocksource_init(rate, base);
+	of_node_put(alias_node);
 
-	if (node == sec_node) {
+	if (node == alias_node) {
 		/* The secondary timer will drive the clock event */
 		irq = irq_of_parse_and_map(node, 0);
 		return integrator_clockevent_init(rate, base, irq);
-- 
2.19.1

