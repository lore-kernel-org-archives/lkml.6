Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44A0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93292208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+cyKahC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93292208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934187AbeFZJX7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:23:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36794 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933785AbeFZJWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:22:33 -0400
Received: by mail-wm0-f67.google.com with SMTP id u18-v6so1006649wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dDHlQQyDgNgCnbd9tlc16D/4bHw7LUCY4jFdFkZ6Znk=;
        b=F+cyKahCRSnwMLc7HfBOO2kByLZWw6cGsDsVvXJ/5IKhTl99gon0VxdjX+sggnQZbB
         J7vAj/hERlj2l2iB0HYph5BmrMLwJsy6ssMZFJH9vZBhYkuLDYgvrd5EaP2AWeiR9jEE
         F6UAS/IpTtzcv2Uso5hktnirhbllP7emVTXow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dDHlQQyDgNgCnbd9tlc16D/4bHw7LUCY4jFdFkZ6Znk=;
        b=T6MP7bNdm7rb9Rfd4S04LRvQi+Xy7aAKl7PXjDtKbeuLlRZdv0xPYHXI1XVNnO0EhL
         hp/7Aulvh/KE90cbeNG5GMqe9j+nFnu5wpknTzYu7n0HJirFrmy+QR2OXd9Yy/ClESQi
         7cVC0ow9CZU3+lI2Ir0pD1m4mqZ5158a07HB/vct6qTTEqK4/41aVyCUW4kejFgwPpD1
         SFI5mjiYU/7xQYUVvrM13nq3dw8Yx2bmYlxKc4v2Hp4t3oX8ir2OXRorGz4lnV/TTI9m
         ptdx+IKuCjGm7SeCZoxLuVzt7ZPwuJLyYSLPDcTMzEBX1fgdzxr03SUc2Y3mHzdJ67xe
         f//A==
X-Gm-Message-State: APt69E2O0LnYghdVt+tRwcpi4H7TSAB/2CHNpOTPUr6t1Ud2UevNv4jM
        AgGABRBolnfgyyAybg5HhStxLW9GAJs=
X-Google-Smtp-Source: AAOMgperth8EHM+m2QNNn3h9PzFVmHeUyUbIw0GCW22N+ieWLZdjh+mx6c8dF8WgR9yiopRatfHIDg==
X-Received: by 2002:a1c:9e95:: with SMTP id h143-v6mr952105wme.68.1530004952197;
        Tue, 26 Jun 2018 02:22:32 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id x5-v6sm1438456wrr.3.2018.06.26.02.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 02:22:31 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, alsa-devel@alsa-project.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lgirdwood@gmail.com, bgoswami@codeaurora.org, tiwai@suse.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 08/12] ASoC: qdsp6: q6asm-dai: support dt based module loading
Date:   Tue, 26 Jun 2018 10:20:12 +0100
Message-Id: <20180626092016.9296-9-srinivas.kandagatla@linaro.org>
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
 sound/soc/qcom/qdsp6/q6asm-dai.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 349c6a883c63..1196dc7483d2 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -611,9 +611,16 @@ static int q6asm_dai_dev_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id q6asm_dai_device_id[] = {
+	{ .compatible = "qcom,q6asm-dais" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, q6asm_dai_device_id);
+
 static struct platform_driver q6asm_dai_platform_driver = {
 	.driver = {
 		.name = "q6asm-dai",
+		.of_match_table = of_match_ptr(q6asm_dai_device_id),
 	},
 	.probe = q6asm_dai_probe,
 	.remove = q6asm_dai_dev_remove,
-- 
2.16.2

