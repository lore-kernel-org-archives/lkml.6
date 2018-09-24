Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE39ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7122F21486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7122F21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388148AbeIXSeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:34:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58116 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbeIXSeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:34:13 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2B20E1018;
        Mon, 24 Sep 2018 12:32:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 090/235] regulator: qcom_spmi: Fix warning Bad of_node_put()
Date:   Mon, 24 Sep 2018 13:51:16 +0200
Message-Id: <20180924113114.123061855@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113103.999624566@linuxfoundation.org>
References: <20180924113103.999624566@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <niklas.cassel@linaro.org>

[ Upstream commit fffe7f52eb5db41eedadba9a8038e982dcfaee0c ]

For of_find_node_by_name(), you typically pass what the previous call
returned. Therefore, of_find_node_by_name() increases the refcount of
the returned node, and decreases the refcount of the node passed as the
first argument.

of_find_node_by_name() is incorrectly used, and produces a warning.
Fix the warning by using the more suitable function
of_get_child_by_name().

Also add a missing of_node_put() for the returned value, since this was
previously being leaked.

OF: ERROR: Bad of_node_put() on /soc/qcom,spmi@400f000/pmic@3/regulators
CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         4.18.0-rc4-00223-gefd7b360b70e #12
Hardware name: Qualcomm Technologies, Inc. DB820c (DT)
Call trace:
 dump_backtrace+0x0/0x1a8
 show_stack+0x14/0x20
 dump_stack+0x90/0xb4
 of_node_release+0x74/0x78
 kobject_put+0x90/0x1f0
 of_node_put+0x14/0x20
 of_find_node_by_name+0x80/0xd8
 qcom_spmi_regulator_probe+0x30c/0x508

Fixes: 0caecaa87202 ("regulator: qcom_spmi: Add support for SAW")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/regulator/qcom_spmi-regulator.c |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1752,7 +1752,8 @@ static int qcom_spmi_regulator_probe(str
 	const char *name;
 	struct device *dev = &pdev->dev;
 	struct device_node *node = pdev->dev.of_node;
-	struct device_node *syscon;
+	struct device_node *syscon, *reg_node;
+	struct property *reg_prop;
 	int ret, lenp;
 	struct list_head *vreg_list;
 
@@ -1780,10 +1781,13 @@ static int qcom_spmi_regulator_probe(str
 
 	for (reg = match->data; reg->name; reg++) {
 
-		if (saw_regmap && \
-		    of_find_property(of_find_node_by_name(node, reg->name), \
-				     "qcom,saw-slave", &lenp)) {
-			continue;
+		if (saw_regmap) {
+			reg_node = of_get_child_by_name(node, reg->name);
+			reg_prop = of_find_property(reg_node, "qcom,saw-slave",
+						    &lenp);
+			of_node_put(reg_node);
+			if (reg_prop)
+				continue;
 		}
 
 		vreg = devm_kzalloc(dev, sizeof(*vreg), GFP_KERNEL);
@@ -1816,13 +1820,17 @@ static int qcom_spmi_regulator_probe(str
 		if (ret)
 			continue;
 
-		if (saw_regmap && \
-		    of_find_property(of_find_node_by_name(node, reg->name), \
-				     "qcom,saw-leader", &lenp)) {
-			spmi_saw_ops = *(vreg->desc.ops);
-			spmi_saw_ops.set_voltage_sel = \
-				spmi_regulator_saw_set_voltage;
-			vreg->desc.ops = &spmi_saw_ops;
+		if (saw_regmap) {
+			reg_node = of_get_child_by_name(node, reg->name);
+			reg_prop = of_find_property(reg_node, "qcom,saw-leader",
+						    &lenp);
+			of_node_put(reg_node);
+			if (reg_prop) {
+				spmi_saw_ops = *(vreg->desc.ops);
+				spmi_saw_ops.set_voltage_sel =
+					spmi_regulator_saw_set_voltage;
+				vreg->desc.ops = &spmi_saw_ops;
+			}
 		}
 
 		config.dev = dev;


