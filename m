Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1E8C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0579D21473
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvZuHqEL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0579D21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbeKZV4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:56:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729436AbeKZV4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:56:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A9342147D;
        Mon, 26 Nov 2018 11:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230165;
        bh=RelLPr/eJs61Od1xJF6KjtcxJca6bKdlb/qQvL9zL4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TvZuHqELbczIAN4VCFcdTbOO+N0uYT75Tf/wAWm2QrXeu1/vvKhtcyUdwJxdKL6tG
         oZOnPHw6vvXPILjMf9LkON5O3B1TeP80Ri7zrRRIeisR1N8AaZjvA2s606mocUN4oJ
         cprMkZsPpIwwPnp5k3bJYTCE/hV7gIZVhsJHESXM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 031/118] clk: ti: fix OF child-node lookup
Date:   Mon, 26 Nov 2018 11:50:25 +0100
Message-Id: <20181126105101.070113081@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 00a461cc32ec27fa7bd9c874a7b36b0c6c542c12 ]

Fix child-node lookup which by using the wrong OF helper was searching
the whole tree depth-first, something which could end up matching an
unrelated node.

Also fix the related node-reference leaks.

Fixes: 5b385a45e001 ("clk: ti: add support for clkctrl aliases")
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ti/clk.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 7d22e1af2247..27e0979b3158 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -129,7 +129,7 @@ int ti_clk_setup_ll_ops(struct ti_clk_ll_ops *ops)
 void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
 {
 	struct ti_dt_clk *c;
-	struct device_node *node;
+	struct device_node *node, *parent;
 	struct clk *clk;
 	struct of_phandle_args clkspec;
 	char buf[64];
@@ -164,8 +164,12 @@ void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
 			continue;
 
 		node = of_find_node_by_name(NULL, buf);
-		if (num_args)
-			node = of_find_node_by_name(node, "clk");
+		if (num_args) {
+			parent = node;
+			node = of_get_child_by_name(parent, "clk");
+			of_node_put(parent);
+		}
+
 		clkspec.np = node;
 		clkspec.args_count = num_args;
 		for (i = 0; i < num_args; i++) {
@@ -173,11 +177,12 @@ void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
 			if (ret) {
 				pr_warn("Bad tag in %s at %d: %s\n",
 					c->node_name, i, tags[i]);
+				of_node_put(node);
 				return;
 			}
 		}
 		clk = of_clk_get_from_provider(&clkspec);
-
+		of_node_put(node);
 		if (!IS_ERR(clk)) {
 			c->lk.clk = clk;
 			clkdev_add(&c->lk);
-- 
2.17.1



