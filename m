Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88EFC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5187E2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bSAdmO9K";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bSAdmO9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5187E2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeHMJOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 05:14:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41594 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeHMJOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 05:14:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DE618604BE; Mon, 13 Aug 2018 06:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534142013;
        bh=no6PNoxgHmUzNMTd5bk7eYp/928N5cWSmtMssJh8nJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bSAdmO9K3Kglkl0ZXj04FyIgmOsRbqzwO59CFm3j+D0XmyKpLJXzNn1I9I44OtUZr
         jXxm1DRry4Sw7c+C1CdH8/52XaanlHlYFwCdUF0b6KR3/KOU5LU52RiO/sNmEhu+HP
         HHSvpBZxKIdPbP+CBjeKWAVAx3qw9t0tEbxEA0nM=
Received: from anischal-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: anischal@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A15060B1A;
        Mon, 13 Aug 2018 06:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534142013;
        bh=no6PNoxgHmUzNMTd5bk7eYp/928N5cWSmtMssJh8nJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bSAdmO9K3Kglkl0ZXj04FyIgmOsRbqzwO59CFm3j+D0XmyKpLJXzNn1I9I44OtUZr
         jXxm1DRry4Sw7c+C1CdH8/52XaanlHlYFwCdUF0b6KR3/KOU5LU52RiO/sNmEhu+HP
         HHSvpBZxKIdPbP+CBjeKWAVAx3qw9t0tEbxEA0nM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A15060B1A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anischal@codeaurora.org
From:   Amit Nischal <anischal@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
Subject: [PATCH v3 1/4] clk: qcom: gdsc: Add support to enable/disable the clocks with GDSC
Date:   Mon, 13 Aug 2018 12:03:04 +0530
Message-Id: <1534141987-29601-2-git-send-email-anischal@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534141987-29601-1-git-send-email-anischal@codeaurora.org>
References: <1534141987-29601-1-git-send-email-anischal@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some of the GDSCs, there is a requirement to enable/disable the
few clocks before turning on/off the gdsc power domain. Add support
for the same by specifying a list of clk_hw pointers per gdsc and
enable/disable them along with power domain on/off callbacks.

Signed-off-by: Amit Nischal <anischal@codeaurora.org>
---
 drivers/clk/qcom/gdsc.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/gdsc.h |  5 +++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index a077133..b6adca1 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -12,6 +12,8 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/jiffies.h>
@@ -208,11 +210,41 @@ static inline void gdsc_assert_reset_aon(struct gdsc *sc)
 	regmap_update_bits(sc->regmap, sc->clamp_io_ctrl,
 			   GMEM_RESET_MASK, 0);
 }
+
+static int gdsc_clk_prepare_enable(struct gdsc *sc)
+{
+	int i, ret;
+
+	for (i = 0; i < sc->clk_count; i++) {
+		ret = clk_prepare_enable(sc->clk_hws[i]->clk);
+		if (ret) {
+			for (i--; i >= 0; i--)
+				clk_disable_unprepare(sc->clk_hws[i]->clk);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static void gdsc_clk_disable_unprepare(struct gdsc *sc)
+{
+	int i;
+
+	for (i = 0; i < sc->clk_count; i++)
+		clk_disable_unprepare(sc->clk_hws[i]->clk);
+}
+
 static int gdsc_enable(struct generic_pm_domain *domain)
 {
 	struct gdsc *sc = domain_to_gdsc(domain);
 	int ret;
 
+	if (sc->clk_count) {
+		ret = gdsc_clk_prepare_enable(sc);
+		if (ret)
+			return ret;
+	}
+
 	if (sc->pwrsts == PWRSTS_ON)
 		return gdsc_deassert_reset(sc);
 
@@ -260,6 +292,9 @@ static int gdsc_enable(struct generic_pm_domain *domain)
 		udelay(1);
 	}
 
+	if (sc->clk_count)
+		gdsc_clk_disable_unprepare(sc);
+
 	return 0;
 }
 
@@ -268,6 +303,12 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 	struct gdsc *sc = domain_to_gdsc(domain);
 	int ret;
 
+	if (sc->clk_count) {
+		ret = gdsc_clk_prepare_enable(sc);
+		if (ret)
+			return ret;
+	}
+
 	if (sc->pwrsts == PWRSTS_ON)
 		return gdsc_assert_reset(sc);
 
@@ -299,6 +340,9 @@ static int gdsc_disable(struct generic_pm_domain *domain)
 	if (sc->flags & CLAMP_IO)
 		gdsc_assert_clamp_io(sc);
 
+	if (sc->clk_count)
+		gdsc_clk_disable_unprepare(sc);
+
 	return 0;
 }
 
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index bd1f2c7..59957d7 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/pm_domain.h>
 
+struct clk_hw;
 struct regmap;
 struct reset_controller_dev;
 
@@ -32,6 +33,8 @@
  * @resets: ids of resets associated with this gdsc
  * @reset_count: number of @resets
  * @rcdev: reset controller
+ * @clk_count: number of associated clocks
+ * @clk_hws: clk_hw pointers for associated clocks with gdsc
  */
 struct gdsc {
 	struct generic_pm_domain	pd;
@@ -60,6 +63,8 @@ struct gdsc {
 	struct reset_controller_dev	*rcdev;
 	unsigned int			*resets;
 	unsigned int			reset_count;
+	unsigned int			clk_count;
+	struct clk_hw			*clk_hws[];
 };
 
 struct gdsc_desc {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

