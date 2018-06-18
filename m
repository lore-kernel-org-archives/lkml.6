Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBEBC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7031320864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7031320864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966819AbeFRI3b (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:29:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33422 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966796AbeFRI3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:29:24 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D9C86C50;
        Mon, 18 Jun 2018 08:29:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 018/189] clk: honor CLK_MUX_ROUND_CLOSEST in generic clk mux
Date:   Mon, 18 Jun 2018 10:11:54 +0200
Message-Id: <20180618081209.947855952@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 4ad69b80e886a845f56ce0a3d10211208693d92b ]

CLK_MUX_ROUND_CLOSEST is part of the clk_mux documentation but clk_mux
directly calls __clk_mux_determine_rate(), which overrides the flag.
As result, if clk_mux is instantiated with CLK_MUX_ROUND_CLOSEST, the
flag will be ignored and the clock rounded down.

To solve this, this patch expose clk_mux_determine_rate_flags() in the
clk-provider API and uses it in the determine_rate() callback of clk_mux.

Fixes: 15a02c1f6dd7 ("clk: Add __clk_mux_determine_rate_closest")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/clk-mux.c        |   10 +++++++++-
 drivers/clk/clk.c            |    7 ++++---
 include/linux/clk-provider.h |    3 +++
 3 files changed, 16 insertions(+), 4 deletions(-)

--- a/drivers/clk/clk-mux.c
+++ b/drivers/clk/clk-mux.c
@@ -101,10 +101,18 @@ static int clk_mux_set_parent(struct clk
 	return 0;
 }
 
+static int clk_mux_determine_rate(struct clk_hw *hw,
+				  struct clk_rate_request *req)
+{
+	struct clk_mux *mux = to_clk_mux(hw);
+
+	return clk_mux_determine_rate_flags(hw, req, mux->flags);
+}
+
 const struct clk_ops clk_mux_ops = {
 	.get_parent = clk_mux_get_parent,
 	.set_parent = clk_mux_set_parent,
-	.determine_rate = __clk_mux_determine_rate,
+	.determine_rate = clk_mux_determine_rate,
 };
 EXPORT_SYMBOL_GPL(clk_mux_ops);
 
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -351,9 +351,9 @@ static bool mux_is_better_rate(unsigned
 	return now <= rate && now > best;
 }
 
-static int
-clk_mux_determine_rate_flags(struct clk_hw *hw, struct clk_rate_request *req,
-			     unsigned long flags)
+int clk_mux_determine_rate_flags(struct clk_hw *hw,
+				 struct clk_rate_request *req,
+				 unsigned long flags)
 {
 	struct clk_core *core = hw->core, *parent, *best_parent = NULL;
 	int i, num_parents, ret;
@@ -413,6 +413,7 @@ out:
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(clk_mux_determine_rate_flags);
 
 struct clk *__clk_lookup(const char *name)
 {
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -752,6 +752,9 @@ int __clk_mux_determine_rate(struct clk_
 int __clk_determine_rate(struct clk_hw *core, struct clk_rate_request *req);
 int __clk_mux_determine_rate_closest(struct clk_hw *hw,
 				     struct clk_rate_request *req);
+int clk_mux_determine_rate_flags(struct clk_hw *hw,
+				 struct clk_rate_request *req,
+				 unsigned long flags);
 void clk_hw_reparent(struct clk_hw *hw, struct clk_hw *new_parent);
 void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
 			   unsigned long max_rate);


