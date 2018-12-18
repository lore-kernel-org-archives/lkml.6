Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F13C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B2C218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g401sXmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeLRV3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:29:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37374 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbeLRV3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:29:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so16988898wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8yYswTIddbl98Ij+qY0GbRy4Tl1Yh+JSAqMNtmY8jFQ=;
        b=g401sXmLhb+xsift8JwQPHt9yvnZ6iheN96seKdQflFPqI/ZKBiptVEpPyJcez7Fb6
         geE1Jm15A8hVVVZRX9/S4wnZVXyvqat0L4Ov1e+mYLxlFLaN70Oo0Wk7I87LpdJb77tV
         hGW34U6YGwTZVyXgrEuWCllQJUqbC98tfhuzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8yYswTIddbl98Ij+qY0GbRy4Tl1Yh+JSAqMNtmY8jFQ=;
        b=jKSXcqNWy3X0vZHrHxf6fSAIHmqFp/SJwNoyB6UV/Q8zViWSBHRUrlOItVKgjem4Ul
         x+mli3UVysrbOczwjb5TkISOavOPQGYDJijJEmhVlQCuYlRNdwHkaPxWXCRArcO6vRzj
         LJffwhbwtCbs8g7OBVexf6Zet+JxT1XzCOHfgaEco68dSd0KsJKm6/WVS1ny6A3iG6WQ
         kIGSCf1mKo0X23t1ymFS8Cp0WRcmbu8TTwSvIcWjMIsqnL7XqcuCX73CnTx93i4e+Ifs
         aIBzuSjzapY7D64HtvMyLEDDx5zQCnpEAFVaR0MnmyX5f52j0Vr8epFWuZTt/NRZsfb7
         tbYA==
X-Gm-Message-State: AA+aEWareAPpb9GCJkMWupoXMqTJwTs1XK8kq3oO0ItmCiPQReWgEzWq
        QHjcWugkbhh0ME6WXhEVEpqN0BfWW5Y=
X-Google-Smtp-Source: AFSGD/WjNXuQx6IXGPoeOmLh4lJyzOrBN7JTJRk/uuSVFY2viOSnBfrRaTDM8KwtIAVLnP8sKfabBQ==
X-Received: by 2002:a05:6000:1287:: with SMTP id f7mr16992587wrx.302.1545168574098;
        Tue, 18 Dec 2018 13:29:34 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:29:33 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 16/25] clocksource/drivers/integrator-ap: Add missing of_node_put()
Date:   Tue, 18 Dec 2018 22:28:34 +0100
Message-Id: <20181218212844.30445-16-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218212844.30445-1-daniel.lezcano@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
 <20181218212844.30445-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

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
---
 drivers/clocksource/timer-integrator-ap.c | 25 +++++++++++++++--------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksource/timer-integrator-ap.c
index 76e526f58620..19fb7de4b928 100644
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
2.17.1

