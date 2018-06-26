Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9ADC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F865250C7
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N9jz4cKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F865250C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934089AbeFZJXm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:23:42 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46200 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933824AbeFZJWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:22:35 -0400
Received: by mail-wr0-f194.google.com with SMTP id l14-v6so11398432wrq.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hA6RVdDkQgf8mnMUWOdmGysxSbhxeav6nDTk9MlVzdg=;
        b=N9jz4cKoEhfc9vCHXO3jP2r/AjjwUv8nQ1iHHeK1++mK4BELZeAb4qwL16OsCc4tuM
         QBdyPsIZWznYlfH9BnqYzIDuq1kQYFVEEtqhfyr5EfSCHn/lHv936uDpNlB+UBrimDqQ
         hVoTPj/tQKKbY3oDkLy85JxCyRhkoeXM5/Do8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hA6RVdDkQgf8mnMUWOdmGysxSbhxeav6nDTk9MlVzdg=;
        b=ndppKkIuf+JS1mb3j26nocntK7QYzXG6oCFTE9Rkig/LVs1PAgDl6y5Vd3vOQ0dtQO
         JKrfoOX97pUvZ8rrYym5rEQSXipabxzcVMYNGsXVMq6Xe1GkLnOoUIPy+pRxV+23mAnt
         Kmnymay4IplcQ6Z6bo8SOrnGGm9CuOGwbwCUjz87zDUg5UlAf8jHqvdJQ35disIYoXu7
         6BxnlsaHpFLPFmNduvn1vhWSEo/JJi2JvtsR9SqDMAWOroHfXnlZez1YsVtObprLy4rB
         ptzhIEQ9nU5hKvyswHitOHRYXbDkJxCKQobq9ZAtKYUBdtlphdn7s+iNsOWpBgzeLNtL
         h23w==
X-Gm-Message-State: APt69E3DX0oiDwYKszsIUR4dmQdrvbS2aTd/It2qck1IC5Q6jCfalaPn
        7ayQ6E+ddaXVseookja72l1rJw==
X-Google-Smtp-Source: AAOMgpeSVXohdOsWl5cMqj4Hh0icUR1KdlajywIpvjdKsfNb37XYkW66KmCVJ2agNfP8szJuPdNMXQ==
X-Received: by 2002:adf:c546:: with SMTP id s6-v6mr798473wrf.46.1530004954415;
        Tue, 26 Jun 2018 02:22:34 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id x5-v6sm1438456wrr.3.2018.06.26.02.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 02:22:33 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, alsa-devel@alsa-project.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lgirdwood@gmail.com, bgoswami@codeaurora.org, tiwai@suse.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 10/12] ASoC: qcom: apq8096: remove redundant owner assignment
Date:   Tue, 26 Jun 2018 10:20:14 +0100
Message-Id: <20180626092016.9296-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

module owner is already set in platform_driver_register(), so remove this
redundant assignment.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 sound/soc/qcom/apq8096.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index 561cd429e6f2..6e79fec7e789 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -245,7 +245,6 @@ static struct platform_driver msm_snd_apq8096_driver = {
 	.remove = apq8096_platform_remove,
 	.driver = {
 		.name = "msm-snd-apq8096",
-		.owner = THIS_MODULE,
 		.of_match_table = msm_snd_apq8096_dt_match,
 	},
 };
-- 
2.16.2

