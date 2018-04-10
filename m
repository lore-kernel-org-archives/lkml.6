Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752919AbeDJJFa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 05:05:30 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41998 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752487AbeDJJF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 05:05:28 -0400
X-Google-Smtp-Source: AIpwx48dl0vkYmVqOZ3EJdkri+rD2w4jfJL1Nd0fAlWSKoz+a1olmiWyg7fq9e7WfrohXwxv70t8TA==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH] of: Don't create platform device for OPP tables
Date: Tue, 10 Apr 2018 14:35:22 +0530
Message-Id: <b70afd25fc48ad4d677e4e53951f2138cd34b85e.1523351100.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPP tables are present as separate nodes, whose phandle is used in
the "operating-points-v2" property of devices. Currently the OF core
creates a platform device for the OPP table unconditionally, which is
not used by any kernel code.

Skip creating OPP table platform devices.

Reported-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/of/platform.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index c00d81dfac0b..aaae5d90433d 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -356,6 +356,12 @@ static int of_platform_bus_create(struct device_node *bus,
 		return 0;
 	}
 
+	/* OPP tables have separate nodes, but we don't want devices for them */
+	if (unlikely(of_device_is_compatible(bus, "operating-points-v2"))) {
+		pr_debug("%s() - skipping OPP node %pOF\n", __func__, bus);
+		return 0;
+	}
+
 	if (of_node_check_flag(bus, OF_POPULATED_BUS)) {
 		pr_debug("%s() - skipping %pOF, already populated\n",
 			__func__, bus);
-- 
2.15.0.194.g9af6a3dea062
