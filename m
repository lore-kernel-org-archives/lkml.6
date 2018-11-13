Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF20DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2BC20896
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="d5aqCfmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2BC20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeKNFai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:30:38 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54876 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNFai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:30:38 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wADJUgQW051228;
        Tue, 13 Nov 2018 13:30:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542137442;
        bh=Eaibw42TEZJ4RgYZwRWqg4J0BgO+zEcG3Q2MRl7w58s=;
        h=From:To:CC:Subject:Date;
        b=d5aqCfmQX1uiXf4rcmDzU2V9BoOByJ4HbU0YYdTjNc8QXEe8q2xO8W3OLseTyuiNE
         euGNKjluFEn6BgDWSMUYl2PVt6E/yXHzz7w0Ww60iha5cThgyyyutYyS+tMGHwwHlh
         VXY0LNWCCgTQ2tMxCi4KbnvYydKH+vnOE7CvgzPI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wADJUgVc021908
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Nov 2018 13:30:42 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 13
 Nov 2018 13:30:41 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 13 Nov 2018 13:30:41 -0600
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wADJUfAe021871;
        Tue, 13 Nov 2018 13:30:41 -0600
Received: from localhost (uda0274052.dhcp.ti.com [128.247.59.203])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id wADJUfx18701;
        Tue, 13 Nov 2018 13:30:41 -0600 (CST)
From:   Dave Gerlach <d-gerlach@ti.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Keerthy J <j-keerthy@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v4] cpufreq: ti-cpufreq: Only register platform_device when supported
Date:   Tue, 13 Nov 2018 13:30:40 -0600
Message-ID: <20181113193040.15181-1-d-gerlach@ti.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the ti-cpufreq driver blindly registers a 'ti-cpufreq' to force
the driver to probe on any platforms where the driver is built in.
However, this should only happen on platforms that actually can make use
of the driver. There is already functionality in place to match the
SoC compatible so let's factor this out into a separate call and
make sure we find a match before creating the ti-cpufreq platform device.

Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
v3->v4: Use platform_device_register_data rather than
	platform_device_register_resndata as we are only passing data.

	v3: https://patchwork.kernel.org/patch/10681161/

 drivers/cpufreq/ti-cpufreq.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 3f0e2a14895a..22b53bf26817 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -201,19 +201,28 @@ static const struct of_device_id ti_cpufreq_of_match[] = {
 	{},
 };
 
+static const struct of_device_id *ti_cpufreq_match_node(void)
+{
+	struct device_node *np;
+	const struct of_device_id *match;
+
+	np = of_find_node_by_path("/");
+	match = of_match_node(ti_cpufreq_of_match, np);
+	of_node_put(np);
+
+	return match;
+}
+
 static int ti_cpufreq_probe(struct platform_device *pdev)
 {
 	u32 version[VERSION_COUNT];
-	struct device_node *np;
 	const struct of_device_id *match;
 	struct opp_table *ti_opp_table;
 	struct ti_cpufreq_data *opp_data;
 	const char * const reg_names[] = {"vdd", "vbb"};
 	int ret;
 
-	np = of_find_node_by_path("/");
-	match = of_match_node(ti_cpufreq_of_match, np);
-	of_node_put(np);
+	match = dev_get_platdata(&pdev->dev);
 	if (!match)
 		return -ENODEV;
 
@@ -290,7 +299,14 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 
 static int ti_cpufreq_init(void)
 {
-	platform_device_register_simple("ti-cpufreq", -1, NULL, 0);
+	const struct of_device_id *match;
+
+	/* Check to ensure we are on a compatible platform */
+	match = ti_cpufreq_match_node();
+	if (match)
+		platform_device_register_data(NULL, "ti-cpufreq", -1, match,
+					      sizeof(*match));
+
 	return 0;
 }
 module_init(ti_cpufreq_init);
-- 
2.19.0

