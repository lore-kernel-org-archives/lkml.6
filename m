Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDC5C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E229121873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X7rlwMEp";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RrPw3yiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbeLRRIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:08:18 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48942 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbeLRRIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:08:18 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6696E605A5; Tue, 18 Dec 2018 17:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545152897;
        bh=aYJkrPOgJuHwT8PEc3wRoJtoLpp5dPqY7ziQqra9rAM=;
        h=From:To:Cc:Subject:Date:From;
        b=X7rlwMEpkGrrrE+U5PAhlj6nImLXrwYgawYhsDEweYXwqHl8/ZMzampmnyP9xOPxs
         fYatT79g1Kr0LfcLDaRrj43+AWZNAWiElkrODurcba1rTT7v0cypOOtIrbX2P5yD4O
         hVd4WPVHhznmmpzWDpRcTDzTZyAplUoU48V+Ai48=
Received: from jhugo-perf-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D7A2C605A5;
        Tue, 18 Dec 2018 17:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545152896;
        bh=aYJkrPOgJuHwT8PEc3wRoJtoLpp5dPqY7ziQqra9rAM=;
        h=From:To:Cc:Subject:Date:From;
        b=RrPw3yiR0XE2bZ+U0c96wnL1pv5bc58o4ImlNusPSUS03pHCk3GWBVubtF/bYuy9p
         3pvcLB3e51tWX5V5IpKv4+l4SJ0oG0lJYdwndeqw+fKHs/Qx2+Cz1ZznPDjd2WDdyr
         h3Jv5Tjgvc2//zCH4NPnF0hlc+/ewCebcroyOMEc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D7A2C605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
From:   Jeffrey Hugo <jhugo@codeaurora.org>
To:     mturquette@baylibre.com, sboyd@kernel.org, andy.gross@linaro.org,
        david.brown@linaro.org
Cc:     bjorn.andersson@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH] clk: qcom: List rates in debugfs for rcg
Date:   Tue, 18 Dec 2018 10:08:04 -0700
Message-Id: <1545152884-768-1-git-send-email-jhugo@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCGs typically have multiple frequencies they can support based on client
requests.  It can be very helpful to have a list of what are the supported
frequencies when attempting to bringup or debug a new device.  Add a clock
specific "list_rates" debugfs file which dumps the supported rates of a
selected rcg in a convenient format.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
---
 drivers/clk/qcom/clk-rcg2.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 6e3bd19..e4b1d35 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -13,6 +13,8 @@
 #include <linux/regmap.h>
 #include <linux/math64.h>
 #include <linux/slab.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
 
 #include <asm/div64.h>
 
@@ -347,6 +349,36 @@ static int clk_rcg2_set_floor_rate_and_parent(struct clk_hw *hw,
 	return __clk_rcg2_set_rate(hw, rate, FLOOR);
 }
 
+static int rcg2_list_rates_show(struct seq_file *m, void *unused)
+{
+	struct clk_rcg2 *rcg = m->private;
+	const struct freq_tbl *f;
+
+	if (rcg->freq_tbl)
+		for (f = rcg->freq_tbl; f->freq; f++)
+			seq_printf(m, "%lu\n", f->freq);
+
+	return 0;
+}
+
+static int rcg2_list_rates_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, rcg2_list_rates_show, inode->i_private);
+}
+
+static const struct file_operations rcg2_list_rates_fops = {
+	.open		= rcg2_list_rates_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+static void clk_rcg2_debug_init(struct clk_hw *hw, struct dentry *dentry)
+{
+	debugfs_create_file("list_rates", 0444, dentry, to_clk_rcg2(hw),
+			    &rcg2_list_rates_fops);
+}
+
 const struct clk_ops clk_rcg2_ops = {
 	.is_enabled = clk_rcg2_is_enabled,
 	.get_parent = clk_rcg2_get_parent,
@@ -355,6 +387,7 @@ static int clk_rcg2_set_floor_rate_and_parent(struct clk_hw *hw,
 	.determine_rate = clk_rcg2_determine_rate,
 	.set_rate = clk_rcg2_set_rate,
 	.set_rate_and_parent = clk_rcg2_set_rate_and_parent,
+	.debug_init = clk_rcg2_debug_init,
 };
 EXPORT_SYMBOL_GPL(clk_rcg2_ops);
 
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

