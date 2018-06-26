Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B5BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DF426778
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ca/XOO6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DF426778
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934010AbeFZJWl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:22:41 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38365 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933780AbeFZJWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:22:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id 69-v6so993975wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zli9OPXToTCwTxHVHeLl0HZXVWIpoxlzZHDFGirmZxw=;
        b=ca/XOO6G31Et+xOwCvbmdclHba/ISE/w+hGyUIzppQVZBNoVWlm5OtGBuXjR949Hsh
         S0ye8ty+SqRo35BEE+HSasdBO4gM2+kYERF/qh4/UjxgrFCIp/WLtmD5HRjFkC/DBzJ9
         8m6FNGSPgxsVR3upCmq/9kly72y+tj0fw0Fjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zli9OPXToTCwTxHVHeLl0HZXVWIpoxlzZHDFGirmZxw=;
        b=klTn8JrpohEOc2ZIWq8M5Kacx3FGHNyUCh5xCYqP23NYBnTqCepBM/XTT4rPr5mB8K
         QmPCA8Em7n6hruOTmjGLTs86svfO0hVXegfhLDAIdn8NM+Vxt6UauIsSecOswORPkhtO
         Ld6BNVXzUvtP+bwcS4ls+2DwMZ8Wsol1fFXSB+cXmWOYASCEjwvx/mSNXMDUzO7aSeG7
         E+EMo/LwQGt1u6NffIabVmadMN4cqBz+nSO+64OZ0ayj4WlGMLW2n2/2EG4mDnV0HJEy
         1bA+2ByUxftW8QSa0hF0Qd+XkoHHiUKhmwpBwXt1+1CCp/XSYhlGjy+bmWDzFid51rbn
         EUTg==
X-Gm-Message-State: APt69E1yJe0d07zh0kzFSCXFIqhKm+m451M8I1+ikDO5kuukKqlgLKak
        rRLJZ9bifJDPb8fnsMtjKPDtfg==
X-Google-Smtp-Source: AAOMgpej43uQyJwhyDiQGoYLFHI173ZJ5BAYof79OOxzUo9dKNFFHJK55JHQ5h7Zv2uGVXbYiCsn7A==
X-Received: by 2002:a1c:6b56:: with SMTP id g83-v6mr936231wmc.143.1530004948848;
        Tue, 26 Jun 2018 02:22:28 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id x5-v6sm1438456wrr.3.2018.06.26.02.22.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 02:22:28 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, alsa-devel@alsa-project.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lgirdwood@gmail.com, bgoswami@codeaurora.org, tiwai@suse.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 05/12] ASoC: qdsp6: q6asm: use of_platform_populate/depopulate()
Date:   Tue, 26 Jun 2018 10:20:09 +0100
Message-Id: <20180626092016.9296-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the child nodes have there own compatible strings,
Use of_platform_populate/depopulate() instead of less common
of_platform_device_create()/destroy().

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 530852385cad..c4fd28f168d5 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -177,7 +177,6 @@ struct q6asm {
 	struct platform_device *pcmdev;
 	spinlock_t slock;
 	struct audio_client *session[MAX_SESSIONS + 1];
-	struct platform_device *pdev_dais;
 };
 
 struct audio_client {
@@ -1344,7 +1343,6 @@ EXPORT_SYMBOL_GPL(q6asm_cmd_nowait);
 static int q6asm_probe(struct apr_device *adev)
 {
 	struct device *dev = &adev->dev;
-	struct device_node *dais_np;
 	struct q6asm *q6asm;
 
 	q6asm = devm_kzalloc(dev, sizeof(*q6asm), GFP_KERNEL);
@@ -1359,22 +1357,12 @@ static int q6asm_probe(struct apr_device *adev)
 	spin_lock_init(&q6asm->slock);
 	dev_set_drvdata(dev, q6asm);
 
-	dais_np = of_get_child_by_name(dev->of_node, "dais");
-	if (dais_np) {
-		q6asm->pdev_dais = of_platform_device_create(dais_np,
-							   "q6asm-dai", dev);
-		of_node_put(dais_np);
-	}
-
-	return 0;
+	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
 
 static int q6asm_remove(struct apr_device *adev)
 {
-	struct q6asm *q6asm = dev_get_drvdata(&adev->dev);
-
-	if (q6asm->pdev_dais)
-		of_platform_device_destroy(&q6asm->pdev_dais->dev, NULL);
+	of_platform_depopulate(&adev->dev);
 
 	return 0;
 }
-- 
2.16.2

