Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC23C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3321620671
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GtyBDLNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3321620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeJXLu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:50:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40190 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeJXLu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:50:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id g21-v6so1699538pfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 20:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HrPsp6pBOcXi6Ct6scDVU4tHzdJBdJzFt1oM5B21HXE=;
        b=GtyBDLNFzvLZzxjymVDzrpNr3fBuSlvxU/MQh7IQhJzy8+XXkC2fUbkg73+fsda2Qs
         sJHS5iAJHP7OgQ7iY63HO5QyauIS6Uw0gKPodFy0O45+V+uaeOXi/yN0PclPRMAdn3RQ
         I8gNwsb32Q34+sY7d1l592cLNsgw5GnApncD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HrPsp6pBOcXi6Ct6scDVU4tHzdJBdJzFt1oM5B21HXE=;
        b=OGA+Xq6YRQ4EbmkwUtUkmTAsamxLni4ZcpXRO00GoPxkhVIaGt61ikeUaVnHMJw9Cs
         UhTgMl7nl4O8SG40z8GnSicvknw/f7PlAV8OIHPjQNVTAcLah4JMUFw3CG9xVwf4ZdhV
         caWiQTwzT3YClaCtc0BJKtKdEgVwiBx9lhQCUZY0i30IJMWzlqHbhMaoamnoTMsVJP91
         L+mc4+JvjxCtnd5bH/wUE8CeBWGALLhODQo9k6RAC6QV/Jc2md5WFYKWh8rJZWd/Dj0l
         zHN6ZJ8sGhCzabHEmJTyOpkbP+x+SYPowNVpZnXelWMmp0FMKfvRtQKHwHAG8SaIo65g
         R9jg==
X-Gm-Message-State: AGRZ1gIneu9uU9Usw8KEw+bwiT4y+A6h1LXmZIXb/rphm+q4Jd7ovGWl
        H9SRs1Isnbij4ix+VqO3u06pKe/qyPM=
X-Google-Smtp-Source: AJdET5dfPdi7JYSGLyS7tEr6GCsinJHrF3Xs1kJM1Avu8z0ujvwHOk7N3fDsKHasPEFZbhUMwf+KJA==
X-Received: by 2002:a63:5b1f:: with SMTP id p31mr641606pgb.56.1540344703450;
        Tue, 23 Oct 2018 18:31:43 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5e2b:39df:72ed:4968])
        by smtp.gmail.com with ESMTPSA id p4-v6sm3882341pfg.188.2018.10.23.18.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 18:31:42 -0700 (PDT)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-doc@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, heiko@sntech.de,
        aisheng.dong@nxp.com, mchehab+samsung@kernel.org, corbet@lwn.net,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH 2/6] clk: fix clk_calc_subtree compute duplications
Date:   Tue, 23 Oct 2018 18:31:28 -0700
Message-Id: <20181024013132.115907-3-dbasehore@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181024013132.115907-1-dbasehore@chromium.org>
References: <20181024013132.115907-1-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_calc_subtree was called at every step up the clk tree in
clk_calc_new_rates. Since it recursively calls itself for its
children, this means it would be called once on each clk for each
step above the top clk is.

This fixes this by breaking the subtree calculation into two parts.
The first part recalcs the rate for each child of the parent clk in
clk_calc_new_rates. This part is not recursive itself. The second part
recursively calls a new clk_calc_subtree on the clk_core that was
passed into clk_set_rate.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/clk/clk.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 95d818f5edb2..61de8ad3e4cf 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1717,11 +1717,19 @@ static int __clk_speculate_rates(struct clk_core *core,
 	return ret;
 }
 
-static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
-			     struct clk_core *new_parent, u8 p_index)
+static void clk_calc_subtree(struct clk_core *core)
 {
 	struct clk_core *child;
 
+	hlist_for_each_entry(child, &core->children, child_node) {
+		child->new_rate = clk_recalc(child, core->new_rate);
+		clk_calc_subtree(child);
+	}
+}
+
+static void clk_set_change(struct clk_core *core, unsigned long new_rate,
+			   struct clk_core *new_parent, u8 p_index)
+{
 	core->new_rate = new_rate;
 	core->new_parent = new_parent;
 	core->new_parent_index = p_index;
@@ -1729,11 +1737,6 @@ static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
 	core->new_child = NULL;
 	if (new_parent && new_parent != core->parent)
 		new_parent->new_child = core;
-
-	hlist_for_each_entry(child, &core->children, child_node) {
-		child->new_rate = clk_recalc(child, new_rate);
-		clk_calc_subtree(child, child->new_rate, NULL, 0);
-	}
 }
 
 /*
@@ -1744,7 +1747,7 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 					   unsigned long rate)
 {
 	struct clk_core *top = core;
-	struct clk_core *old_parent, *parent;
+	struct clk_core *old_parent, *parent, *child;
 	unsigned long best_parent_rate = 0;
 	unsigned long new_rate;
 	unsigned long min_rate;
@@ -1791,6 +1794,8 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 		/* pass-through clock with adjustable parent */
 		top = clk_calc_new_rates(parent, rate);
 		new_rate = parent->new_rate;
+		hlist_for_each_entry(child, &parent->children, child_node)
+			child->new_rate = clk_recalc(child, new_rate);
 		goto out;
 	}
 
@@ -1813,11 +1818,14 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
 	}
 
 	if ((core->flags & CLK_SET_RATE_PARENT) && parent &&
-	    best_parent_rate != parent->rate)
+	    best_parent_rate != parent->rate) {
 		top = clk_calc_new_rates(parent, best_parent_rate);
+		hlist_for_each_entry(child, &parent->children, child_node)
+			child->new_rate = clk_recalc(child, parent->new_rate);
+	}
 
 out:
-	clk_calc_subtree(core, new_rate, parent, p_index);
+	clk_set_change(core, new_rate, parent, p_index);
 
 	return top;
 }
@@ -2018,6 +2026,8 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 	if (ret)
 		return ret;
 
+	clk_calc_subtree(core);
+
 	/* notify that we are about to change rates */
 	fail_clk = clk_propagate_rate_change(top, PRE_RATE_CHANGE);
 	if (fail_clk) {
-- 
2.19.1.568.g152ad8e336-goog

