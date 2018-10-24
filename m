Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBF5C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02FA2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oq9hBHjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02FA2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbeJXLnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:43:13 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41167 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeJXLnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:43:13 -0400
Received: by mail-pg1-f193.google.com with SMTP id 23-v6so1623860pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 20:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sLIRKsPeonK/zKq59N3XJK3GG96UNWulOAZhs9ex8SY=;
        b=Oq9hBHjfqen+WJ1439fJed/MhzNLjcC79qA5qQHQAIMzaws1C8fAIf3VfOarEvwhWT
         r5J0q+QWxIrpKpO+5x8i/nZxWbf/4AY1bcFhLVCiKwSzy3gcM8vMH0Bp0p7QpIAlXrvQ
         b6nIHrhDtzRLebe1aQipDiaNzS22jPD9vdXOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sLIRKsPeonK/zKq59N3XJK3GG96UNWulOAZhs9ex8SY=;
        b=s4mAa2SsbAOJcPtboSdYa03XxQzlhpBpG4xWjcPitu7s5aNgmsw1h8heng4qs9Q1dV
         ATAcPhJlv5dQ4/8FmkHgi2PJ9PKg/fig7Mi9TuI4Z2JSoHBNwGPQGr+7vndneRhOH2yu
         FPxJke4JeZlquCjrfSHBO/VpZHr2Xhm3XNFXgICE467k7zLvuB8Ks20E5SMShRHCoY/R
         tcweYf/D2GIG5/E76ybtqIEakSrLL2Eo0auxKciBIyQESrW0AN5qFgii2sW5Kt3uJcct
         UIt7cfoWrgjVeOKswSJD8dhbzcMnpCXoZQ0itlrSnjUtuCCZNSvn10SZYb59dZYY/f3a
         YPng==
X-Gm-Message-State: AGRZ1gKE6XAaMB+TPYnr26feCbYTh5WWNFb7nXUQhnzDbAl5UZRN18jw
        9ueS76LRcO/9sxnRAaWpKP7O78mz44o=
X-Google-Smtp-Source: AJdET5dNnQkWHsNuX1YpS5kddgO8he+p0IDdFMXZpwCjVhiBwvyf1ZDsSHKsxalh3KxPcd51MJp1CA==
X-Received: by 2002:a63:fa4e:: with SMTP id g14-v6mr640117pgk.18.1540344702043;
        Tue, 23 Oct 2018 18:31:42 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5e2b:39df:72ed:4968])
        by smtp.gmail.com with ESMTPSA id p4-v6sm3882341pfg.188.2018.10.23.18.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 18:31:41 -0700 (PDT)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-doc@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, heiko@sntech.de,
        aisheng.dong@nxp.com, mchehab+samsung@kernel.org, corbet@lwn.net,
        Stephen Boyd <sboyd@codeaurora.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH 1/6] clk: Remove recursion in clk_core_{prepare,enable}()
Date:   Tue, 23 Oct 2018 18:31:27 -0700
Message-Id: <20181024013132.115907-2-dbasehore@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181024013132.115907-1-dbasehore@chromium.org>
References: <20181024013132.115907-1-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

Enabling and preparing clocks can be written quite naturally with
recursion. We start at some point in the tree and recurse up the
tree to find the oldest parent clk that needs to be enabled or
prepared. Then we enable/prepare and return to the caller, going
back to the clk we started at and enabling/preparing along the
way.

The problem is recursion isn't great for kernel code where we
have a limited stack size. Furthermore, we may be calling this
code inside clk_set_rate() which also has recursion in it, so
we're really not looking good if we encounter a tall clk tree.

Let's create a stack instead by looping over the parent chain and
collecting clks of interest. Then the enable/prepare becomes as
simple as iterating over that list and calling enable.

Cc: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/clk/clk.c | 113 ++++++++++++++++++++++++++--------------------
 1 file changed, 64 insertions(+), 49 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index af011974d4ec..95d818f5edb2 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -71,6 +71,8 @@ struct clk_core {
 	struct hlist_head	children;
 	struct hlist_node	child_node;
 	struct hlist_head	clks;
+	struct list_head	prepare_list;
+	struct list_head	enable_list;
 	unsigned int		notifier_count;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry		*dentry;
@@ -740,49 +742,48 @@ EXPORT_SYMBOL_GPL(clk_unprepare);
 static int clk_core_prepare(struct clk_core *core)
 {
 	int ret = 0;
+	struct clk_core *tmp, *parent;
+	LIST_HEAD(head);
 
 	lockdep_assert_held(&prepare_lock);
 
-	if (!core)
-		return 0;
+	while (core) {
+		list_add(&core->prepare_list, &head);
+		/* Stop once we see a clk that is already prepared */
+		if (core->prepare_count)
+			break;
+		core = core->parent;
+	}
 
-	if (core->prepare_count == 0) {
-		ret = clk_pm_runtime_get(core);
-		if (ret)
-			return ret;
+	list_for_each_entry_safe(core, tmp, &head, prepare_list) {
+		list_del_init(&core->prepare_list);
 
-		ret = clk_core_prepare(core->parent);
-		if (ret)
-			goto runtime_put;
+		if (core->prepare_count == 0) {
+			ret = clk_pm_runtime_get(core);
+			if (ret)
+				goto err;
 
-		trace_clk_prepare(core);
+			trace_clk_prepare(core);
 
-		if (core->ops->prepare)
-			ret = core->ops->prepare(core->hw);
+			if (core->ops->prepare)
+				ret = core->ops->prepare(core->hw);
 
-		trace_clk_prepare_complete(core);
+			trace_clk_prepare_complete(core);
 
-		if (ret)
-			goto unprepare;
+			if (ret) {
+				clk_pm_runtime_put(core);
+				goto err;
+			}
+		}
+		core->prepare_count++;
 	}
 
-	core->prepare_count++;
-
-	/*
-	 * CLK_SET_RATE_GATE is a special case of clock protection
-	 * Instead of a consumer claiming exclusive rate control, it is
-	 * actually the provider which prevents any consumer from making any
-	 * operation which could result in a rate change or rate glitch while
-	 * the clock is prepared.
-	 */
-	if (core->flags & CLK_SET_RATE_GATE)
-		clk_core_rate_protect(core);
-
 	return 0;
-unprepare:
-	clk_core_unprepare(core->parent);
-runtime_put:
-	clk_pm_runtime_put(core);
+err:
+	parent = core->parent;
+	list_for_each_entry_safe_continue(core, tmp, &head, prepare_list)
+		list_del_init(&core->prepare_list);
+	clk_core_unprepare(parent);
 	return ret;
 }
 
@@ -878,37 +879,49 @@ EXPORT_SYMBOL_GPL(clk_disable);
 static int clk_core_enable(struct clk_core *core)
 {
 	int ret = 0;
+	struct clk_core *tmp, *parent;
+	LIST_HEAD(head);
 
 	lockdep_assert_held(&enable_lock);
 
-	if (!core)
-		return 0;
-
-	if (WARN(core->prepare_count == 0,
-	    "Enabling unprepared %s\n", core->name))
-		return -ESHUTDOWN;
+	while (core) {
+		list_add(&core->enable_list, &head);
+		/* Stop once we see a clk that is already enabled */
+		if (core->enable_count)
+			break;
+		core = core->parent;
+	}
 
-	if (core->enable_count == 0) {
-		ret = clk_core_enable(core->parent);
+	list_for_each_entry_safe(core, tmp, &head, enable_list) {
+		list_del_init(&core->enable_list);
 
-		if (ret)
-			return ret;
+		if (WARN_ON(core->prepare_count == 0)) {
+			ret = -ESHUTDOWN;
+			goto err;
+		}
 
-		trace_clk_enable_rcuidle(core);
+		if (core->enable_count == 0) {
+			trace_clk_enable_rcuidle(core);
 
-		if (core->ops->enable)
-			ret = core->ops->enable(core->hw);
+			if (core->ops->enable)
+				ret = core->ops->enable(core->hw);
 
-		trace_clk_enable_complete_rcuidle(core);
+			trace_clk_enable_complete_rcuidle(core);
 
-		if (ret) {
-			clk_core_disable(core->parent);
-			return ret;
+			if (ret)
+				goto err;
 		}
+
+		core->enable_count++;
 	}
 
-	core->enable_count++;
 	return 0;
+err:
+	parent = core->parent;
+	list_for_each_entry_safe_continue(core, tmp, &head, enable_list)
+		list_del_init(&core->enable_list);
+	clk_core_disable(parent);
+	return ret;
 }
 
 static int clk_core_enable_lock(struct clk_core *core)
@@ -3281,6 +3294,8 @@ struct clk *clk_register(struct device *dev, struct clk_hw *hw)
 	core->num_parents = hw->init->num_parents;
 	core->min_rate = 0;
 	core->max_rate = ULONG_MAX;
+	INIT_LIST_HEAD(&core->prepare_list);
+	INIT_LIST_HEAD(&core->enable_list);
 	hw->core = core;
 
 	/* allocate local copy in case parent_names is __initdata */
-- 
2.19.1.568.g152ad8e336-goog

