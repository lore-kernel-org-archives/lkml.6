Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266EDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D830121557
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 19:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xdBLudeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D830121557
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbeHWWwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 18:52:07 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45650 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeHWWwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 18:52:05 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7NJKcu0065506;
        Thu, 23 Aug 2018 14:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535052038;
        bh=G855R1hIFQQxOte1LcXkyZCHvaLlOLhLvNcT4DSa2CA=;
        h=From:To:CC:Subject:Date;
        b=xdBLudeIUGtvW2IlzFvhHXUoAvS1OJoIOAG+/EkQaVkcQDMoQjBsG+kyPiV7vtJPW
         FKqT0gPXX1xpwPSgJw9JR7ZknYmImrzoJTw86mTZwV7S3TsrBBC0H5/KeuT3xA9QpY
         A75+MS9dfR4/2ykdGyhaQhFCQ9AVtvlkvsVUswAs=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7NJKcsA011311;
        Thu, 23 Aug 2018 14:20:38 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 23
 Aug 2018 14:20:37 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 23 Aug 2018 14:20:37 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7NJKbvB008289;
        Thu, 23 Aug 2018 14:20:37 -0500
Received: from localhost (uda0274052.dhcp.ti.com [128.247.59.203])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w7NJKbx04183;
        Thu, 23 Aug 2018 14:20:37 -0500 (CDT)
From:   Dave Gerlach <d-gerlach@ti.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>, Keerthy J <j-keerthy@ti.com>
Subject: [PATCH v2] cpufreq: ti-cpufreq: Only register platform_device when supported
Date:   Thu, 23 Aug 2018 14:20:35 -0500
Message-ID: <20180823192035.22940-1-d-gerlach@ti.com>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
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
v1->v2:
* Return 'match' directly in ti_cpufreq_match_node.
* Add Johan's Reviewed-by.

 drivers/cpufreq/ti-cpufreq.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 3f0e2a14895a..6b025953ddee 100644
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
+	match = ti_cpufreq_match_node();
 	if (!match)
 		return -ENODEV;
 
@@ -290,7 +299,10 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 
 static int ti_cpufreq_init(void)
 {
-	platform_device_register_simple("ti-cpufreq", -1, NULL, 0);
+	/* Check to ensure we are on a compatible platform */
+	if (ti_cpufreq_match_node())
+		platform_device_register_simple("ti-cpufreq", -1, NULL, 0);
+
 	return 0;
 }
 module_init(ti_cpufreq_init);
-- 
2.16.1

