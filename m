Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D5BC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E9F20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E9F20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbeLNJSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:18:16 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:54166 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727698AbeLNJSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:18:15 -0500
X-UUID: e4c31ede5efa483cbe5fa465c901535a-20181214
X-UUID: e4c31ede5efa483cbe5fa465c901535a-20181214
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <nick.fan@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1641462383; Fri, 14 Dec 2018 17:18:06 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Dec 2018 17:18:05 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 17:18:05 +0800
From:   Nick Fan <Nick.Fan@mediatek.com>
To:     Viresh Kumar <vireshk@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <tfiga@chromium.org>,
        <Chiawen.Lee@mediatek.com>, <erin.lo@mediatek.com>,
        Nick Fan <Nick.Fan@mediatek.com>
Subject: [RFC PATCH] [RESEND] opp: Add API for getting voltage from supplies
Date:   Fri, 14 Dec 2018 17:17:42 +0800
Message-ID: <1544779062-8276-1-git-send-email-Nick.Fan@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Resending because the previous attempt did not reach the mailing lists.]

This new API is needed for a downstream GPU driver, but posting it as an RFC to make sure that we implement it in a potentially upstreamable way or in case someone needs it for an upstream user later.

Add API to get voltage for multiple supplies from opp table

Signed-off-by: Nick Fan <Nick.Fan@mediatek.com>
---
 drivers/opp/core.c     | 28 ++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2c2df4e..ee73546 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -113,6 +113,34 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage);
 
 /**
+ * dev_pm_opp_get_voltage_supply() - Gets the voltage corresponding to an opp
+ * with index
+ * @opp:        opp for which voltage has to be returned for
+ * @index:      index to specify the returned supplies
+ *
+ * Return: voltage in micro volt corresponding to the opp with index, else
+ * return 0
+ *
+ * This is useful for devices with multiple power supplies.
+ */
+unsigned long dev_pm_opp_get_voltage_supply(struct dev_pm_opp *opp,
+					    unsigned int index)
+{
+	if (IS_ERR_OR_NULL(opp)) {
+		pr_err("%s: Invalid parameters\n", __func__);
+		return 0;
+	}
+
+	if (index >= opp->opp_table->regulator_count) {
+		pr_err("%s: Invalid supply index: %u\n", __func__, index);
+		return 0;
+	}
+
+	return opp->supplies[index].u_volt;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_voltage_supply);
+
+/**
  * dev_pm_opp_get_freq() - Gets the frequency corresponding to an available opp
  * @opp:	opp for which frequency has to be returned for
  *
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 5d399eee..2f1c2a8 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -84,6 +84,9 @@ struct dev_pm_set_opp_data {
 
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 
+unsigned long dev_pm_opp_get_voltage_supply(struct dev_pm_opp *opp,
+					    unsigned int index);
+
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
 
 bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp);
-- 
1.9.1

