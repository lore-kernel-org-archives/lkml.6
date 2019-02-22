Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D74C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABBA2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 20:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKEv3NoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfBVUF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 15:05:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43408 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfBVUFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 15:05:24 -0500
Received: by mail-pl1-f196.google.com with SMTP id m10so1547010plt.10;
        Fri, 22 Feb 2019 12:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8y87jgMHT7jVdzfBwwQEkDBcKypExDfglZwd0Y0PZzY=;
        b=LKEv3NoS7iZOr3NYj1vxCA872v3cEuKT5EhGglf9GOP4OoFXth+huECr45FxjkuQVK
         zMpdlgSjUQMfx0Vrvlof7znQt0cmEFLoXjq4dYaXQOyfjrvoZtSPgy9Pu0BNPPRopMLY
         r8t+qFHY0kkK3S85Ko7Un4DMXQTcZgxHTo+POZ8XXXsTfKIxpj0996y/2qKbBFr/HdUN
         uEPXNIE0ET4DQu5rf38Ke8DKPfGf5b5X1I6z739+B6v0p0oS5dWGRn0ZHnHw4eaipyD+
         rSGOodGfSD0NmrwWxF5KXekbgDEV3ISWkK20HflIiwqZziHmybpcrmW4EB9a5DjZkMWk
         SQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8y87jgMHT7jVdzfBwwQEkDBcKypExDfglZwd0Y0PZzY=;
        b=LaCnl5zLKRUP8wYQY+xqFYL1H4aep6nKPgv3voaH3htf6MR366yleiKWAU76yBDx6J
         +iaP73t2ajjY1n+01GHsrli3r/fT4iTi7+rR971+pHNfUbn6Pn0c7TAY8urlRor9K8mb
         8+9mNcm0t3ITy7cP7syc844fVEd75pe1OFkFmh4brzUAY7kZpubW8gLvFETk3pvNouGM
         Lo2QAlgUQ678tkYTTpruAUsQyiNrp3wVkqAan88CWi3+iln5yokGTqGeiWKtS3IORDPZ
         11coNF2xIYkjJPBSRrvTR3AsqaKtWqvmSOZFjwODt5qOO6jFJg4+ApwOfkNG1piUWKa5
         VYIg==
X-Gm-Message-State: AHQUAuaszIfKmfC+t/qNeG/It9ND+SGK88yd88KCLll0AFWi6nNI26PR
        ifn0HmhrkIorIB+LIZPPoywbumeC
X-Google-Smtp-Source: AHgI3IZm5V3ynU5SUkhwVI1atygREeTFiWRTg1n1VcS25Hov2NH0iWegGF8O7yp3B3oBNWLlQVHNtw==
X-Received: by 2002:a17:902:a50a:: with SMTP id s10mr5780638plq.223.1550865923491;
        Fri, 22 Feb 2019 12:05:23 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h79sm7471046pfj.186.2019.02.22.12.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 12:05:22 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/13] thermal: qoriq: Remove unnecessary DT node is NULL check
Date:   Fri, 22 Feb 2019 12:04:57 -0800
Message-Id: <20190222200508.26325-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222200508.26325-1-andrew.smirnov@gmail.com>
References: <20190222200508.26325-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is meant to be used with Device Tree and there's no
use-case where device's DT node is going to be NULL. Remove code
protecting against that.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 3b5f5b3fb1bc..7b364933bfb1 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -193,11 +193,6 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	struct qoriq_tmu_data *data;
 	struct device_node *np = pdev->dev.of_node;
 
-	if (!np) {
-		dev_err(&pdev->dev, "Device OF-Node is NULL");
-		return -ENODEV;
-	}
-
 	data = devm_kzalloc(&pdev->dev, sizeof(struct qoriq_tmu_data),
 			    GFP_KERNEL);
 	if (!data)
-- 
2.20.1

