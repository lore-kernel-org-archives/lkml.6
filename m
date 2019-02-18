Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAC1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B5A21773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8eiJykZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfBRTMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:12:18 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37970 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbfBRTMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:12:15 -0500
Received: by mail-pg1-f194.google.com with SMTP id m2so6654430pgl.5;
        Mon, 18 Feb 2019 11:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G1jRqsHlDGlfrRFhbWZQqLMZ680TUhIKscck8kcbiSU=;
        b=Q8eiJykZtSLT+d69UN4B790ZzCfZZovk3nGCaXT8HYH/htuoyAsOulgFAI3C/LXEGe
         pxUyOFxT3NVQe7KjFLVd8tkEVkdc335QacVr27/U2k+RChsqTH89rOWu1z/0obPpQc12
         wQBvWRl/NythEt16frnFBtAbBJaVkXfS1IQnChjQGzXvy1dtO0x+MXePH93j+OnvVhhd
         zppRFrtR7CR18UQp1hblTECwjA+d7gA/MfyOaDkYEH5jR5qbKdrO61zjhlV5NTiDsO5i
         oGkushi9Do3NpVVcjDM3Z5fdOQiJk05eFZE/dUB5sHbUM0bIGVZcdYtwsfpN7qE9z1WT
         8LyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G1jRqsHlDGlfrRFhbWZQqLMZ680TUhIKscck8kcbiSU=;
        b=b+K2wNqJHYXlOLjY77VfkMwU2oWjVWY4wkhqPzg7kHiTuvQgpsDM7iODveHr/i60KG
         Fgnt3fKfEHF+cgP6CpRqy7y3Tf1HzXnDX0yVuy1HVLowvcwfYy/42b4HvYUfjRzJncZf
         4Uoq0nEEU5qxbW/q0XUWUX4rZ4L3VhqU+YRsIc2aBd41NXCzG5JKYztk2uWsH+e+h/9T
         zHundTik7kTwVzUVl9JUXaLa6o6BqBfX1ERfM41oWHRWNvDFOD2bzlfm1ZWs/LYVFhFL
         Ehs01aWFKaz3EOiP7EMveXQRPetYdv/8Z8nMRs1RrjGwsxNYcSJe8TMzEUY04tCXngSI
         k2Qg==
X-Gm-Message-State: AHQUAuajfrFWl0nT2KtNVd/KswMzrByczLtdRso3tFlg0p7IzxTbIjDT
        ggaYo1p7OXIAnPix32w87kXC+nVp
X-Google-Smtp-Source: AHgI3IYTSGWmzAq8cAuWLHOpG/69lmfWDL3fyv5QcEOh0EgEYpILXIYTp+Ypddlq8nhrnk1Kl63VeA==
X-Received: by 2002:a63:8948:: with SMTP id v69mr20527767pgd.140.1550517133699;
        Mon, 18 Feb 2019 11:12:13 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t12sm33189727pgq.68.2019.02.18.11.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:12:12 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] thermal: qoriq: Be more strict when parsing "thermal-sensors"
Date:   Mon, 18 Feb 2019 11:11:40 -0800
Message-Id: <20190218191141.3729-12-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218191141.3729-1-andrew.smirnov@gmail.com>
References: <20190218191141.3729-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
thermal-sensor-cells _must_ be 1, so there is no reason to be more
lenient in the code and treat the absence of argument in
thermal-sensors specifier as a valid DT code. Drop that special case
to simplify sensor ID retreival code.

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
 drivers/thermal/qoriq_thermal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index d4f5e180e1ee..f746c62789b0 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -82,14 +82,14 @@ static int qoriq_tmu_get_sensor_id(void)
 		goto out;
 	}
 
-	if (sensor_specs.args_count >= 1) {
-		id = sensor_specs.args[0];
-		WARN(sensor_specs.args_count > 1,
-				"%pOFn: too many cells in sensor specifier %d\n",
-				sensor_specs.np, sensor_specs.args_count);
-	} else {
-		id = 0;
+	if (sensor_specs.args_count != 1) {
+		pr_err("%pOFn: Invalid number of cells in sensor specifier %d\n",
+		       sensor_specs.np, sensor_specs.args_count);
+		id = -EINVAL;
+		goto out;
 	}
+
+	id = sensor_specs.args[0];
 out:
 	of_node_put(np);
 	of_node_put(sensor_np);
-- 
2.20.1

