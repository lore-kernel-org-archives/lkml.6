Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D460C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EB520855
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FCtO9BlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729835AbfA1PzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:55:17 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46946 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729857AbfA1PzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:55:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so18556165wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 07:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bl3ew2I2xjmi0d8XaQksODeb+uT8jXBsV8IAc/xEUJ0=;
        b=FCtO9BlKB8ovRLPilHdtn2N80dQ7P7bXMmdfadJANXdBLWLP+Jy2YjKfJyqSkJLOkv
         JpCGX4trHlJBKY2lO2Vjdnrkxy1W3ZBrNi+2d3yDO87B3K5DBs5M7gUq2NKkA9nGdj8r
         nhMaBFtYZsrMh0yxfw1MslpNC4gQqUlEwE8Vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bl3ew2I2xjmi0d8XaQksODeb+uT8jXBsV8IAc/xEUJ0=;
        b=jXxs3dlw5GFFGJenwpziUH/SIOViGMCX26v3a7PfVN6eXvaBKuxbZ9VIx5WEypnCSH
         hqMB6uenM5+9zbcJi4AjRt2j0geEWE/ReDP894AvQCujE58cgpcjr7CMp8mUupYturs+
         pPbabdiDwgHqr/3LBlS4TJKvYQ733KAzks5/jiCzv7Y8Hqolf0x/1pYtnE6OVQMI1YHF
         4PTv2sOlU1j+ADRTNVHR+rPTXvutaVDHScS9uP6r9GliEppG5ieS2P4co6Wtpn9NWu0m
         JcolwDTDn/lqLFC7nUDr97lEVCvZx7oCNxoniucFZQDoeLTDhKaxwMO8qLFiuKhCcybV
         wiUw==
X-Gm-Message-State: AJcUukdLHc/E+CosGMlPXWZKmXkmcyvDbhZ37Xg8xQTf3ci0LIlL7fM4
        OMfp3wotn0rIxNfa+QGSa2h3+kbYGkg=
X-Google-Smtp-Source: ALg8bN6fRj+qPBJqGB+Gv+GUNS/govgl7lVav42pAd2oysWDk0Pvw5zzYpVgisJaYl5U6uzsFsFIRg==
X-Received: by 2002:adf:de91:: with SMTP id w17mr23924006wrl.320.1548690913072;
        Mon, 28 Jan 2019 07:55:13 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p6sm145140485wrx.50.2019.01.28.07.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 07:55:12 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] nvmem: imx-ocotp: add i.MX7ULP support
Date:   Mon, 28 Jan 2019 15:54:57 +0000
Message-Id: <20190128155506.25566-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128155506.25566-1-srinivas.kandagatla@linaro.org>
References: <20190128155506.25566-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <anson.huang@nxp.com>

i.MX7ULP is a new SoC of i.MX family which has 8 kbit eFuse OTP,
enable ocotp driver support for this SoC.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index afb429a417fe..90a398252770 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -433,6 +433,11 @@ static const struct ocotp_params imx7d_params = {
 	.set_timing = imx_ocotp_set_imx7_timing,
 };
 
+static const struct ocotp_params imx7ulp_params = {
+	.nregs = 256,
+	.bank_address_words = 0,
+};
+
 static const struct of_device_id imx_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx6q-ocotp",  .data = &imx6q_params },
 	{ .compatible = "fsl,imx6sl-ocotp", .data = &imx6sl_params },
@@ -440,6 +445,7 @@ static const struct of_device_id imx_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx6ul-ocotp", .data = &imx6ul_params },
 	{ .compatible = "fsl,imx7d-ocotp",  .data = &imx7d_params },
 	{ .compatible = "fsl,imx6sll-ocotp", .data = &imx6sll_params },
+	{ .compatible = "fsl,imx7ulp-ocotp", .data = &imx7ulp_params },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
-- 
2.20.1

