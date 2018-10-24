Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCEFC46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0F32075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ojkzc46T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0F32075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbeJXLfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:35:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44246 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeJXLfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:35:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id d23-v6so1548211pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 20:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ERbU1tkeMWd/343Ve+mqPg3AxNCH+FYJsIJI9SozjRI=;
        b=Ojkzc46TOm2NrYKiawGAO5DCy2F6pYYehM528gEpuWW/ajE0Zu53ibup/rrMM4i0hZ
         y5KmEeHWJDWT9Qpfd3+A6QiNUysWJD/yH1SNUJerVQROc8r+hWeJZzGHKNP6Sy94Mw8t
         VomcQCFhWnohuKkOSu87FfSm5LAtViSIo3Mhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ERbU1tkeMWd/343Ve+mqPg3AxNCH+FYJsIJI9SozjRI=;
        b=Javfx4wDHMkm2Zm6ZI1n8PIkcLxg9iuiq1xahqEQAiCPkUZn2T8Hl8QE5mtt2A9C1j
         CfKEgtHEjC5DCOllz7T9BVQ/ErQC9BD2UpqMhRp2s4wHDlmJKAUQP45ornqNhO5ShGvB
         gPfR/ipuBIRaSqPWmzxb72pCgGDZnZXC+JeDRhSl37m3/vsEFUPiML3sSNThOnjuEZKG
         Uj1S78qOxJ0vz5ZpYzRQ7ojaknV5DmaTSCRfnW9CLg0RB1kom0bkV/L52ZU/dqJQaZnA
         O1bSlzeitcrnem0m8ZtM0x4wHesRpcAV+qeJoJbu5MLZyByGwX2PSEoiO2FZZg3oM7I2
         4WZg==
X-Gm-Message-State: AGRZ1gIhdk452Dz/wIXeQjdj7nadWbxy4sLWlMhEfGqaUa0p5WzGKqw0
        NrH+42toHjAV0SH+Q6ScsLdpx/T53D4=
X-Google-Smtp-Source: AJdET5cQjMvK590McnwOk28XmkXnrKMHi27EgGiZ0hApeGTCywUNjB0HJSYXWQje0cs+THjPUOgWuw==
X-Received: by 2002:a17:902:82ca:: with SMTP id u10-v6mr589870plz.146.1540344706226;
        Tue, 23 Oct 2018 18:31:46 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5e2b:39df:72ed:4968])
        by smtp.gmail.com with ESMTPSA id p4-v6sm3882341pfg.188.2018.10.23.18.31.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 18:31:45 -0700 (PDT)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-doc@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, heiko@sntech.de,
        aisheng.dong@nxp.com, mchehab+samsung@kernel.org, corbet@lwn.net,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH 4/6] clk: add pre clk changes support
Date:   Tue, 23 Oct 2018 18:31:30 -0700
Message-Id: <20181024013132.115907-5-dbasehore@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181024013132.115907-1-dbasehore@chromium.org>
References: <20181024013132.115907-1-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a new clk_op, pre_rate_req. It allows clks to setup an
intermediate state when clk rates are changed. One use case for this
is when a clk needs to switch to a safe parent when its PLL ancestor
changes rates. This is needed when a PLL cannot guarantee that it will
not exceed the new rate before it locks. The set_rate, set_parent, and
set_rate_and_parent callbacks are used with the pre_rate_req callback.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/clk/clk.c            | 136 +++++++++++++++++++++++++++++++++--
 include/linux/clk-provider.h |  10 +++
 2 files changed, 139 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 1db44b4e46b0..36a2f929ab8d 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -39,6 +39,7 @@ static int enable_refcnt;
 static HLIST_HEAD(clk_root_list);
 static HLIST_HEAD(clk_orphan_list);
 static LIST_HEAD(clk_notifier_list);
+static LIST_HEAD(pre_change_free_list);
 
 /***    private data structures    ***/
 
@@ -1896,6 +1897,74 @@ static struct clk_core *clk_propagate_rate_change(struct clk_core *core,
 	return fail_clk;
 }
 
+static int clk_pre_rate_req(struct list_head *pre_list, struct clk_core *core)
+{
+	struct clk_core *child, *parent = core->parent;
+	struct clk_rate_request next, pre;
+	struct clk_change *change;
+	int ret;
+
+	hlist_for_each_entry(child, &core->children, child_node) {
+		ret = clk_pre_rate_req(pre_list, child);
+		if (ret)
+			return ret;
+	}
+
+	if (core->new_child) {
+		ret = clk_pre_rate_req(pre_list, child);
+		if (ret)
+			return ret;
+	}
+
+	if (!core->ops->pre_rate_req)
+		return 0;
+
+	if (core->change.parent)
+		parent = core->change.parent;
+
+	if (parent) {
+		next.best_parent_hw = parent->hw;
+		next.best_parent_rate = parent->change.rate;
+	}
+
+	next.rate = core->change.rate;
+	clk_core_get_boundaries(core, &next.min_rate, &next.max_rate);
+
+	ret = core->ops->pre_rate_req(core->hw, &next, &pre);
+	if (ret < 0)
+		return ret;
+	else if (!ret)
+		goto out;
+
+	/*
+	 * We allocate a change for each clk with the pre_rate_req op. If we run
+	 * out, that's because we wrapped around to a clk again in the
+	 * pre_rate_req step which is not allowed.
+	 */
+	change = list_first_entry(&pre_change_free_list, struct clk_change,
+				  change_list);
+	if (IS_ERR_OR_NULL(change)) {
+		pr_err("%s: pre_rate_req loop detected on clk %s. All pre_rate_req clk_change structs are used\n",
+				__func__, core->name);
+		return -EDEADLK;
+	}
+
+	change->core = core;
+	change->rate = pre.rate;
+	change->parent = pre.best_parent_hw ? pre.best_parent_hw->core : NULL;
+	list_move(&change->change_list, pre_list);
+
+out:
+	/* If the pre req req pulls in a new parent, add it to the call chain */
+	if (parent != change->parent) {
+		ret = clk_pre_rate_req(pre_list, change->parent);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /*
  * walk down a subtree and set the new rates notifying the rate
  * change on the way
@@ -2065,6 +2134,8 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 	struct clk_core *top, *fail_clk;
 	struct clk_change *change, *tmp;
 	unsigned long rate;
+	LIST_HEAD(pre_changes);
+	LIST_HEAD(post_changes);
 	LIST_HEAD(changes);
 	int ret = 0;
 
@@ -2092,6 +2163,14 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 
 	clk_calc_subtree(core);
 
+	/* We need a separate list for these changes due to error handling. */
+	ret = clk_pre_rate_req(&pre_changes, top);
+	if (ret) {
+		pr_debug("%s: failed pre_rate_req via top clk %s: %d\n",
+				__func__, top->name, ret);
+		goto pre_rate_req;
+	}
+
 	/* Construct the list of changes */
 	clk_prepare_changes(&changes, top);
 
@@ -2100,11 +2179,19 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 	if (fail_clk) {
 		pr_debug("%s: failed to set %s rate\n", __func__,
 				fail_clk->name);
-		clk_propagate_rate_change(top, ABORT_RATE_CHANGE);
 		ret = -EBUSY;
-		goto err;
+		goto prop_rate;
+	}
+
+	ret = clk_change_rates(&pre_changes);
+	if (ret) {
+		pr_debug("%s: rate rate changes failed via top clk %s: %d\n",
+				__func__, top->name, ret);
+		goto pre_rate_req;
 	}
 
+	list_splice_tail(&post_changes, &changes);
+
 	/* change the rates */
 	ret = clk_change_rates(&changes);
 	list_for_each_entry_safe(change, tmp, &changes, change_list) {
@@ -2112,16 +2199,28 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
 		change->parent = NULL;
 		list_del_init(&change->change_list);
 	}
-
 	if (ret) {
 		pr_debug("%s: failed to set %s rate via top clk %s\n", __func__,
 				core->name, top->name);
-		clk_propagate_rate_change(top, ABORT_RATE_CHANGE);
-		goto err;
+		goto change_rates;
 	}
 
+	list_splice(&pre_changes, &pre_change_free_list);
 	core->req_rate = req_rate;
-err:
+
+	return 0;
+
+change_rates:
+	WARN_ON(clk_change_rates(&pre_changes));
+pre_rate_req:
+	list_splice(&pre_changes, &pre_change_free_list);
+prop_rate:
+	clk_propagate_rate_change(top, ABORT_RATE_CHANGE);
+	list_for_each_entry_safe(change, tmp, &changes, change_list) {
+		change->rate = 0;
+		change->parent = NULL;
+		list_del_init(&change->change_list);
+	}
 	clk_pm_runtime_put(core);
 
 	return ret;
@@ -3139,7 +3238,9 @@ static int __clk_core_init(struct clk_core *core)
 
 	/* check that clk_ops are sane.  See Documentation/driver-api/clk.rst */
 	if (core->ops->set_rate &&
-	    !((core->ops->round_rate || core->ops->determine_rate) &&
+	    !((core->ops->round_rate ||
+	       core->ops->determine_rate ||
+	       core->ops->pre_rate_req) &&
 	      core->ops->recalc_rate)) {
 		pr_err("%s: %s must implement .round_rate or .determine_rate in addition to .recalc_rate\n",
 		       __func__, core->name);
@@ -3175,6 +3276,20 @@ static int __clk_core_init(struct clk_core *core)
 				"%s: invalid NULL in %s's .parent_names\n",
 				__func__, core->name);
 
+	/* Allocate a clk_change struct for pre_rate_reqs */
+	if (core->ops->pre_rate_req) {
+		struct clk_change *change = kzalloc(sizeof(*change),
+				GFP_KERNEL);
+		if (!change) {
+			ret = -ENOMEM;
+			kfree(core->parents);
+			goto out;
+		}
+
+		INIT_LIST_HEAD(&change->change_list);
+		list_add(&pre_change_free_list, &change->change_list);
+	}
+
 	core->parent = __clk_init_parent(core);
 
 	/*
@@ -3476,6 +3591,13 @@ static void __clk_release(struct kref *ref)
 	while (--i >= 0)
 		kfree_const(core->parent_names[i]);
 
+	if (core->ops->pre_rate_req) {
+		struct clk_change *change =
+			list_first_entry(&pre_change_free_list,
+					struct clk_change, change_list);
+		list_del(&change->change_list);
+		kfree(change);
+	}
 	kfree(core->parent_names);
 	kfree_const(core->name);
 	kfree(core);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 60c51871b04b..98a65c6c326d 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -138,6 +138,13 @@ struct clk_duty {
  *		actually supported by the clock, and optionally the parent clock
  *		that should be used to provide the clock rate.
  *
+ * @pre_rate_req: Given the next state that the clk will enter via a
+ *		clk_rate_request struct, next, fill in another clk_rate_request
+ *		struct, pre, with any desired intermediate state to change to
+ *		before the state in next is applied. Returns positive to request
+ *		an intermediate state transition, 0 for no transition, and
+ *		-EERROR otherwise.
+ *
  * @set_parent:	Change the input source of this clock; for clocks with multiple
  *		possible parents specify a new parent by passing in the index
  *		as a u8 corresponding to the parent in either the .parent_names
@@ -236,6 +243,9 @@ struct clk_ops {
 					unsigned long *parent_rate);
 	int		(*determine_rate)(struct clk_hw *hw,
 					  struct clk_rate_request *req);
+	int		(*pre_rate_req)(struct clk_hw *hw,
+					const struct clk_rate_request *next,
+					struct clk_rate_request *pre);
 	int		(*set_parent)(struct clk_hw *hw, u8 index);
 	u8		(*get_parent)(struct clk_hw *hw);
 	int		(*set_rate)(struct clk_hw *hw, unsigned long rate,
-- 
2.19.1.568.g152ad8e336-goog

