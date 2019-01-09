Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF8BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F094206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L9Dn6Z/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbfAIJLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:11:38 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44782 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730200AbfAIJLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:11:34 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x099BSxm126956;
        Wed, 9 Jan 2019 03:11:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547025088;
        bh=8ot+0O6B2BbAUmeHp7l9V33Ie/x+1Yqbqw8R1x1htvo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=L9Dn6Z/h4NN64Kaq/w8xTP+iqFBydxHFIw7rh0PQLcDdIeTYyOBMrtk1eQPtN6NpP
         8l1ea3y0/0NAvKeQISMcl84RuWoZ9zzsIrvxualM+WT5YSiQmjo8qaRctk58vlHlkH
         vdfXC0iWFhdRyC4JpOAMXwsT3PyDsiOvvn+pTEOM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x099BS53111657
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 03:11:28 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 9
 Jan 2019 03:11:28 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 9 Jan 2019 03:11:28 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x099BFBR017497;
        Wed, 9 Jan 2019 03:11:25 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Jiri Slaby <jslaby@suse.com>, Vignesh R <vigneshr@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-serial@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] serial: 8250_omap: Use clk_get_rate() to obtain fclk frequency
Date:   Wed, 9 Jan 2019 14:42:06 +0530
Message-ID: <20190109091206.25759-4-vigneshr@ti.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109091206.25759-1-vigneshr@ti.com>
References: <20190109091206.25759-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

8250_omap driver uses clock-frequency DT property to obtain functional
clk frequency. This is not ideal as users need to calculate functional
clk frequency offline and populate it in DT.
Therefore add support to obtain functional clock frequency using clk
APIs when clock-frequency DT property is not defined.

Suggested-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/tty/serial/8250/8250_omap.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index a74126569785..0a8316632d75 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -12,6 +12,7 @@
 #define SUPPORT_SYSRQ
 #endif
 
+#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -1203,7 +1204,18 @@ static int omap8250_probe(struct platform_device *pdev)
 	}
 	up.port.line = ret;
 
-	of_property_read_u32(np, "clock-frequency", &up.port.uartclk);
+	if (of_property_read_u32(np, "clock-frequency", &up.port.uartclk)) {
+		struct clk *clk;
+
+		clk = devm_clk_get(&pdev->dev, NULL);
+		if (IS_ERR(clk)) {
+			if (PTR_ERR(clk) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+		} else {
+			up.port.uartclk = clk_get_rate(clk);
+		}
+	}
+
 	priv->wakeirq = irq_of_parse_and_map(np, 1);
 
 	id = of_match_device(of_match_ptr(omap8250_dt_ids), &pdev->dev);
-- 
2.20.1

