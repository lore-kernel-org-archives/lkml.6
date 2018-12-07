Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA3EC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763F720672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ti8BCZpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763F720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeLGP3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:29:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53973 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbeLGP3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:29:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id y1so4733298wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 07:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ohTwMnZy4lusdqO/qZ5ifBi8bTC/XiQ4YpI1jCqo4E=;
        b=Ti8BCZpI3o379zFrcx0Ni+pB5jemeDk8VYy5fO9mePABbce0R5TGmri39QUTmKPtqv
         pzbeZy8SoPOY6JLz1AVY0tFkiuBrd1eZQeJAzuH/7dzGMKXPhZYJ+wJ5P7wIgTbvJHPC
         ReCKjOn1vyhC1RY5puQaJgs4l3qQlfQn3vucM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ohTwMnZy4lusdqO/qZ5ifBi8bTC/XiQ4YpI1jCqo4E=;
        b=leaOf3yLpXk8i6MICeYvsa+GBR1Ue8gPWV4EymChs5uqaejoKI15aL1okmhhFYxj7E
         nZEeNQrXbxBxfrSAjY2ixBFMW23X7De8JO6ZTPPHTfGDhhwvN3rt70mvifikUUHUwP25
         jgLTJfiXoNhcQ3BS3PExmlmpSWqb6du1Erferzw2175dgEAJQ6G0kN206JXUX/Wcnrs/
         XaoO1A91QP8ahn4HSlmAJ+qmrPCLaYy4GfKPXiIWgU64i/FyHWWNhOUZAX7Rk2vwSAPV
         da2NE5ck2c65Xp4ihe6OnPoZTHx+utH8lrked8jLXccOLmZX4U5oAy54fLSrzCS5wN51
         JL4w==
X-Gm-Message-State: AA+aEWac83NE9+QuQhuOjyhvbdkstJlDz5Rn+mFyszu6E4ZQvNJcRR+C
        yA7eGsU+XPp5H+/V+M4oh/g2LQ==
X-Google-Smtp-Source: AFSGD/VBiLX2VNYpEOEr8hZt9nXSDWVQ08GjLKumhZCB0fHUqfhV6wLItDkuLr6mzgvh8j4/zWla6Q==
X-Received: by 2002:a1c:9855:: with SMTP id a82mr2471256wme.20.1544196577721;
        Fri, 07 Dec 2018 07:29:37 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y145sm2728721wmd.30.2018.12.07.07.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Dec 2018 07:29:36 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org, linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        dianders@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v11 8/8] interconnect: sdm845: Fix build failure after cmd_db API change
Date:   Fri,  7 Dec 2018 17:29:17 +0200
Message-Id: <20181207152917.4862-9-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207152917.4862-1-georgi.djakov@linaro.org>
References: <20181207152917.4862-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently the cmd_db_read_aux_data() function was changed to avoid using
memcpy and return a pointer instead. Update the code to the new API and
fix the build failure.

Fixes: ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()")
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sdm845.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index f594dd6f500f..06dbc99766ee 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -487,7 +487,9 @@ static struct qcom_icc_desc sdm845_rsc_hlos = {
 static int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
 {
 	struct qcom_icc_node *qn;
-	int ret, i;
+	const struct bcm_db *data;
+	size_t data_count;
+	int i;
 
 	bcm->addr = cmd_db_read_addr(bcm->name);
 	if (!bcm->addr) {
@@ -496,22 +498,22 @@ static int qcom_icc_bcm_init(struct qcom_icc_bcm *bcm, struct device *dev)
 		return -EINVAL;
 	}
 
-	if (cmd_db_read_aux_data_len(bcm->name) < sizeof(struct bcm_db)) {
+	data = cmd_db_read_aux_data(bcm->name, &data_count);
+	if (IS_ERR(data)) {
+		dev_err(dev, "%s command db read error (%ld)\n",
+			bcm->name, PTR_ERR(data));
+		return PTR_ERR(data);
+	}
+	if (!data_count) {
 		dev_err(dev, "%s command db missing or partial aux data\n",
 			bcm->name);
 		return -EINVAL;
 	}
 
-	ret = cmd_db_read_aux_data(bcm->name, (u8 *)&bcm->aux_data,
-				   sizeof(struct bcm_db));
-	if (ret < 0) {
-		dev_err(dev, "%s command db read error (%d)\n",
-			bcm->name, ret);
-		return ret;
-	}
-
-	bcm->aux_data.unit = le32_to_cpu(bcm->aux_data.unit);
-	bcm->aux_data.width = le16_to_cpu(bcm->aux_data.width);
+	bcm->aux_data.unit = le32_to_cpu(data->unit);
+	bcm->aux_data.width = le16_to_cpu(data->width);
+	bcm->aux_data.vcd = data->vcd;
+	bcm->aux_data.reserved = data->reserved;
 
 	/*
 	 * Link Qnodes to their respective BCMs
