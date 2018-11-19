Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC65C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1E22148E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGr05+tS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1E22148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403839AbeKTDTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:19:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390118AbeKTDTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:19:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8A932147A;
        Mon, 19 Nov 2018 16:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646519;
        bh=qZT3MOwh2L0w6dbmIrUtewbACQeOJvoe9miiYlp/X8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cGr05+tSNNCZ0LVWQrIDnFRiEs0nKzpbq6Ldgjg+sT5hfQRjtg043wwR4xGOBorfO
         JVhkxADXF/O2jaKweCGMAG2b0Q37hYbma+CBSfj0QEuMfXXsSNgNOKf5gJKVWdy/Ox
         7tbH6r7LmqDMSka4U6cebFwmBFInt3R0OxFrBxPY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.9 34/83] clk: s2mps11: Fix matching when built as module and DT node contains compatible
Date:   Mon, 19 Nov 2018 17:29:00 +0100
Message-Id: <20181119162619.288413072@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.046511542@linuxfoundation.org>
References: <20181119162612.046511542@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzk@kernel.org>

commit 8985167ecf57f97061599a155bb9652c84ea4913 upstream.

When driver is built as module and DT node contains clocks compatible
(e.g. "samsung,s2mps11-clk"), the module will not be autoloaded because
module aliases won't match.

The modalias from uevent: of:NclocksT<NULL>Csamsung,s2mps11-clk
The modalias from driver: platform:s2mps11-clk

The devices are instantiated by parent's MFD.  However both Device Tree
bindings and parent define the compatible for clocks devices.  In case
of module matching this DT compatible will be used.

The issue will not happen if this is a built-in (no need for module
matching) or when clocks DT node does not contain compatible (not
correct from bindings perspective but working for driver).

Note when backporting to stable kernels: adjust the list of device ID
entries.

Cc: <stable@vger.kernel.org>
Fixes: 53c31b3437a6 ("mfd: sec-core: Add of_compatible strings for clock MFD cells")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index d44e0eea31ec..0934d3724495 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -245,6 +245,36 @@ static const struct platform_device_id s2mps11_clk_id[] = {
 };
 MODULE_DEVICE_TABLE(platform, s2mps11_clk_id);
 
+#ifdef CONFIG_OF
+/*
+ * Device is instantiated through parent MFD device and device matching is done
+ * through platform_device_id.
+ *
+ * However if device's DT node contains proper clock compatible and driver is
+ * built as a module, then the *module* matching will be done trough DT aliases.
+ * This requires of_device_id table.  In the same time this will not change the
+ * actual *device* matching so do not add .of_match_table.
+ */
+static const struct of_device_id s2mps11_dt_match[] = {
+	{
+		.compatible = "samsung,s2mps11-clk",
+		.data = (void *)S2MPS11X,
+	}, {
+		.compatible = "samsung,s2mps13-clk",
+		.data = (void *)S2MPS13X,
+	}, {
+		.compatible = "samsung,s2mps14-clk",
+		.data = (void *)S2MPS14X,
+	}, {
+		.compatible = "samsung,s5m8767-clk",
+		.data = (void *)S5M8767X,
+	}, {
+		/* Sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, s2mps11_dt_match);
+#endif
+
 static struct platform_driver s2mps11_clk_driver = {
 	.driver = {
 		.name  = "s2mps11-clk",


