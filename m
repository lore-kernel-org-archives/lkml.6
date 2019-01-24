Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9365C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986B721905
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358657;
	bh=DJbOQLrCOIMAQHm+lpt1pi4EM4CUal5p/YCWhFdUwCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WIUq7h5kf9sdrZYIzFip8ABEgNVg0Vr7orLg5i3Fz01Q2AoMg/ug+PnfhnRpq0yss
	 x1POz3MSkWbLQ3/HvFy92KhQzBn3W/zCmmMfZ6AOocTQsYcMgSmgDwZruK8hPBlfRr
	 qVskhXNR0EjKoN01kKoucZh5eDRUi/0buxuou8YU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbfAXThf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:37:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730790AbfAXThb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:37:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 658ED218FC;
        Thu, 24 Jan 2019 19:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358649;
        bh=DJbOQLrCOIMAQHm+lpt1pi4EM4CUal5p/YCWhFdUwCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QaLc+1ST10VWDshNX/E8HxjBk9lc9wR603UFzuPkb7ezqo/XTVhUAN6ocAdOpjm6w
         QeEh1kMNbFwFhXjdZo+ngAsIk6RMhvOGKy4TgDv9P2OiX8nZDO1fkptqbq8AMeAdtH
         /ct4xveOU77eSf9UOeykF22If8l2VpyE+GC1tjbc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 083/106] clocksource/drivers/integrator-ap: Add missing of_node_put()
Date:   Thu, 24 Jan 2019 20:20:40 +0100
Message-Id: <20190124190211.430824893@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



