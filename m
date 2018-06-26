Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AE6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDD621757
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ePWo9yuV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EDD621757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934122AbeFZJX5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:23:57 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54834 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933810AbeFZJWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:22:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id i139-v6so1022722wmf.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IdXa8XV5jspUkJyntVmzVAz5Mc3ePJihh8ETQaG1HXM=;
        b=ePWo9yuVO/2z1B/h+W3Er1GYoaNz996t3L70NG7cvpoOr9gUnDnpyHFVrg592zarqL
         tr3NZoT90g+YJpKeVg/VCIyZ5jqw9PaDPZXwFnjepjhZHNpWDlsw/LMhvLOgZFlN9GBb
         0DXSEUm3X2S7LkAFVRvRSSP5aVvddW4J2s8uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IdXa8XV5jspUkJyntVmzVAz5Mc3ePJihh8ETQaG1HXM=;
        b=GNM98rHYS3aLx71WRljA5t8suSfX+qDStX4zZHy2zyUYJL784DY5cPqh1i7Xj5jpf3
         QukJxhNiLfuM60ZRVnMHw6DoDt7np6HMZ+M77f4C4XuGGO3SAZiBPA6Qc8VyzijyCoC+
         UKPQZM/vMsprX+dSoY6WOmubNKXtW+ZmenUGo9R/N7ZQ+4KiBTO4m+FLrYINcqwNqqu+
         jF7j6eKFKQ1PCLTtLly5erns0eGDIOmHx5ozWU35Kp+wLuWJrCkSLoiQfZ0lq3MSGgxz
         2+TVo1jJRnIv9NBSDkO/fjXNtnhpsKCwYbYatm/9Ttcokx3XSYt8c9oKUsVHdiYJT4Lh
         cQNw==
X-Gm-Message-State: APt69E3102IP4BqwwPEUav8p14/Chf2R1EDd7av+evrR1IdF6xXMefzJ
        8CwmeaEuFAzPpb7AcXxCMrkNbg==
X-Google-Smtp-Source: AAOMgpeYiU3fXSavWK911hVvG02EbFYU2vmpmaP6PKiEMfo3YV8woVrv9afcr6aOT1ErnPIaWoD1Rw==
X-Received: by 2002:a1c:c7c3:: with SMTP id x186-v6mr976651wmf.39.1530004953283;
        Tue, 26 Jun 2018 02:22:33 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id x5-v6sm1438456wrr.3.2018.06.26.02.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 02:22:32 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, alsa-devel@alsa-project.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lgirdwood@gmail.com, bgoswami@codeaurora.org, tiwai@suse.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 09/12] ASoC: qdsp6: q6routing: support dt based module loading
Date:   Tue, 26 Jun 2018 10:20:13 +0100
Message-Id: <20180626092016.9296-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses new compatible string to make DT based module loading work.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 593f66b8622f..ab696bf8d1d3 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -993,9 +993,16 @@ static int q6pcm_routing_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id q6pcm_routing_device_id[] = {
+	{ .compatible = "qcom,q6adm-routing" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, q6pcm_routing_device_id);
+
 static struct platform_driver q6pcm_routing_platform_driver = {
 	.driver = {
 		.name = "q6routing",
+		.of_match_table = of_match_ptr(q6pcm_routing_device_id),
 	},
 	.probe = q6pcm_routing_probe,
 	.remove = q6pcm_routing_remove,
-- 
2.16.2

