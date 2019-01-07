Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7B6C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107BA20859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HglO4sRq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZvU3JAdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfAGKKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:10:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56886 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfAGKKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:10:49 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6B6D660C67; Mon,  7 Jan 2019 10:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546855847;
        bh=JY0fYwYCMlDauuhzXbzpe6pMMXRcC2I8nz/hypWrY1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HglO4sRq4RBqdqzWJCdjH6bJYssKBdwKGjem6DLEHVlMpy/ms2TpHTbwozohHcgiV
         UYdPCgwoi8aTm1Vk/muZH9O5W3guNIrRGLLZqEsEt5mKz7aqukEMb7QE9kmv8j0mTp
         3wpzDXN+foCTZbknRhe0zt8MWBToh1Ge14Tn2dAw=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6D24660C61;
        Mon,  7 Jan 2019 10:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1546855846;
        bh=JY0fYwYCMlDauuhzXbzpe6pMMXRcC2I8nz/hypWrY1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZvU3JAduEGozW4FR4TeZetZ79VBbG4O9FfEMq1cgc2jh+KnLuRRldpXMIzAsSnLm5
         zxeGH5fXyppVmn9IEoBmULfgV38NY/oru9unHhTf3Z/58kxodYU8h5J9JUg0M7xYwt
         UiHxblgVipsSpk0JmaefChRvM/Tv9bCWQSy0tpMo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6D24660C61
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v9 08/10] OPP: Add a dev_pm_opp_of_get_level() helper
Date:   Mon,  7 Jan 2019 15:39:57 +0530
Message-Id: <20190107100959.14528-9-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190107100959.14528-1-rnayak@codeaurora.org>
References: <20190107100959.14528-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have atleast 2 genpd providers, both using a simple
routine to read a performance state (opp-level) value from device
tree, in order to implement the .opp_to_performance_state
callback, add a dev_pm_opp_of_get_level() helper to do
it, so it can be resued across all such genpd providers which
just need to read the value from DT.

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/opp/of.c       | 23 +++++++++++++++++++++++
 include/linux/pm_opp.h |  5 +++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 06f0f632ec47..6fb383fee601 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1029,6 +1029,29 @@ int of_get_required_opp_performance_state(struct device_node *np, int index)
 }
 EXPORT_SYMBOL_GPL(of_get_required_opp_performance_state);
 
+/**
+ * dev_pm_opp_of_get_level() - Reads the opp-level value from Device Tree
+ * @opp: opp for which 'opp-level' should be read and returned
+ *
+ * Returns the opp-level value read from Device Tree, if present, else 0
+ *
+ * Return: Zero or positive opp-level value read from Device tree
+ */
+unsigned int dev_pm_opp_of_get_level(struct dev_pm_opp *opp)
+{
+	struct device_node *np;
+	unsigned int perf_state = 0;
+
+	np = dev_pm_opp_get_of_node(opp);
+	if (of_property_read_u32(np, "opp-level", &perf_state))
+		pr_err("%s: missing 'opp-level' property\n", __func__);
+
+	of_node_put(np);
+
+	return perf_state;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_level);
+
 /**
  * dev_pm_opp_get_of_node() - Gets the DT node corresponding to an opp
  * @opp:	opp for which DT node has to be returned for
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 0a2a88e5a383..bf7d21b23a5e 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -322,6 +322,7 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpuma
 struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
 struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
 int of_get_required_opp_performance_state(struct device_node *np, int index);
+unsigned int dev_pm_opp_of_get_level(struct dev_pm_opp *opp);
 #else
 static inline int dev_pm_opp_of_add_table(struct device *dev)
 {
@@ -364,6 +365,10 @@ static inline int of_get_required_opp_performance_state(struct device_node *np,
 {
 	return -ENOTSUPP;
 }
+static inline int dev_pm_opp_of_get_level(struct dev_pm_opp *opp)
+{
+	return 0;
+}
 #endif
 
 #endif		/* __LINUX_OPP_H__ */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

