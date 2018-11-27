Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD91BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B5C208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B5C208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbeK1DrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:47:21 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:5191 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726772AbeK1DrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:47:20 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wARGdV5t008246;
        Tue, 27 Nov 2018 17:48:28 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2nxw9x1d13-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 27 Nov 2018 17:48:27 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 816C1348;
        Tue, 27 Nov 2018 17:47:59 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 404EA532D;
        Tue, 27 Nov 2018 16:48:27 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 27 Nov 2018 17:48:26
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <alexandre.torgue@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <arnd@arndb.de>,
        <mark.rutland@arm.com>, <gabriel.fernandez@st.com>,
        <fabrice.gasnier@st.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/3] mfd: syscon: Add optional clock support
Date:   Tue, 27 Nov 2018 17:48:16 +0100
Message-ID: <1543337297-21873-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1543337297-21873-1-git-send-email-fabrice.gasnier@st.com>
References: <1543337297-21873-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_14:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some system control registers need to be clocked, so the registers can
be accessed. Add an optional clock and attach it to regmap.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/mfd/syscon.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
index b6d05cd..a0ba4ff 100644
--- a/drivers/mfd/syscon.c
+++ b/drivers/mfd/syscon.c
@@ -12,6 +12,7 @@
  * (at your option) any later version.
  */
 
+#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/hwspinlock.h>
 #include <linux/io.h>
@@ -45,6 +46,7 @@ struct syscon {
 
 static struct syscon *of_syscon_register(struct device_node *np)
 {
+	struct clk *clk;
 	struct syscon *syscon;
 	struct regmap *regmap;
 	void __iomem *base;
@@ -119,6 +121,18 @@ static struct syscon *of_syscon_register(struct device_node *np)
 		goto err_regmap;
 	}
 
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		/* clock is optional */
+		if (ret != -ENOENT)
+			goto err_clk;
+	} else {
+		ret = regmap_mmio_attach_clk(regmap, clk);
+		if (ret)
+			goto err_attach;
+	}
+
 	syscon->regmap = regmap;
 	syscon->np = np;
 
@@ -128,6 +142,11 @@ static struct syscon *of_syscon_register(struct device_node *np)
 
 	return syscon;
 
+err_attach:
+	if (!IS_ERR(clk))
+		clk_put(clk);
+err_clk:
+	regmap_exit(regmap);
 err_regmap:
 	iounmap(base);
 err_map:
-- 
1.9.1

