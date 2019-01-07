Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CE4C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C53A2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbfAGPGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:06:36 -0500
Received: from asrmicro.com ([210.13.118.86]:10894 "EHLO spam.asrmicro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729090AbfAGPGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:06:34 -0500
Received: from mail2012.asrmicro.com (mail2012.asrmicro.com [10.1.24.123])
        by spam.asrmicro.com with ESMTP id x07F4Z8D003374;
        Mon, 7 Jan 2019 23:04:35 +0800 (GMT-8)
        (envelope-from yizeng@asrmicro.com)
Received: from localhost (10.1.166.151) by mail2012.asrmicro.com (10.1.24.123)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 7 Jan 2019 23:05:00
 +0800
From:   Yi Zeng <yizeng@asrmicro.com>
To:     <rui.zhang@intel.com>, <edubezval@gmail.com>,
        <daniel.lezcano@linaro.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Yi Zeng <yizeng@asrmicro.com>
Subject: [PATCH] thermal: of-thermal: support to select governor in dts for thermal zone
Date:   Mon, 7 Jan 2019 23:04:39 +0800
Message-ID: <1546873479-20415-1-git-send-email-yizeng@asrmicro.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.166.151]
X-ClientProxiedBy: mail2012.asrmicro.com (10.1.24.123) To
 mail2012.asrmicro.com (10.1.24.123)
X-DNSRBL: 
X-MAIL: spam.asrmicro.com x07F4Z8D003374
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the governor property parsing that defined in thermal zone node
in dts. If define the governor property for one thermal zone, for
example, governor = "step_wise", then parse and register the thermal
zone will find and set the right governor, except the only choice
of default governor.

Signed-off-by: Yi Zeng <yizeng@asrmicro.com>
---
 drivers/thermal/of-thermal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 4bfdb4a..f9368f4 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -1024,6 +1024,7 @@ int __init of_parse_thermal_zones(void)
 		struct thermal_zone_params *tzp;
 		int i, mask = 0;
 		u32 prop;
+		const char *name;
 
 		tz = thermal_of_build_thermal_zone(child);
 		if (IS_ERR(tz)) {
@@ -1049,6 +1050,10 @@ int __init of_parse_thermal_zones(void)
 		if (!of_property_read_u32(child, "sustainable-power", &prop))
 			tzp->sustainable_power = prop;
 
+		if (!of_property_read_string(child, "governor", &name))
+			strncpy(tzp->governor_name, name,
+				THERMAL_NAME_LENGTH);
+
 		for (i = 0; i < tz->ntrips; i++)
 			mask |= 1 << i;
 
-- 
1.9.1

