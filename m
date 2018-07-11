Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7063EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C85520BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RnoYmk9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C85520BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbeGKK0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:26:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34147 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732289AbeGKK0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:26:34 -0400
Received: by mail-wm0-f66.google.com with SMTP id s13-v6so14811797wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 03:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vDEEztRxfmeexwzcpHtjsttOsfjxeUr0XRWIlM/UEIw=;
        b=RnoYmk9K/YnYmA3WadKGpXGiTrZY+KXB7pdqDeYDtGQxayGgESvqr7C93GQkuhLv3s
         XuwmN6spHAWtK+ZBrgV4nRWNYkvctj+RouBReXY0IRW6Ld0dEHXaNbBY7x9Ln8g0p0CI
         to3PD0PxeJFp2dXwZ4Ucw0y5p0iCBJ5KAx8Bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vDEEztRxfmeexwzcpHtjsttOsfjxeUr0XRWIlM/UEIw=;
        b=XYUCGmjH//o9fNA72V1TESnv/rodP7Ap75GAZR4vUtrOLTa2qwlZjcM+qcGU7ZLjAn
         J5mpR3pe/OGBVDbEaWSp2EKm/ETKmeLAEWbjSGUuruSH9lJc1d7eGzJAxNdESNH43g2X
         hNNHgXqnWXUC7hvL7H7tXs4Xkf1STYVlMXd/j0tYuyYqj7DCGrMJN1HTCo/LccXmL0zu
         cvmIrykepHMY7hV8hDvGe2yvoZXXQuqgVWXkneXQAMCJOdMk5EoqJqjhwfXWpaZT7Pp7
         Z682O0fo8kT0fIgrAjh4fjBJx6lXa6Cid4M/m2HxffK0eM2ovBy45XWuIo1ug4lv6rRd
         vH8g==
X-Gm-Message-State: APt69E1RHnpcTXvUy9Coo2deTmdTZ/bFM/CXZC9QizNuVvDhJAAaM0j+
        geXBK7DCQTdsQhkjwgvNPIuoUe9k9rs=
X-Google-Smtp-Source: AAOMgpcNIHV3n52jVkpTYj+ogEpaDvu2at4DHiZkiOfTxYRid/EXW7a5pPoGG9EVGNIiUB0DATEElw==
X-Received: by 2002:a1c:8b81:: with SMTP id n123-v6mr16550833wmd.142.1531304576642;
        Wed, 11 Jul 2018 03:22:56 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 73-v6sm2462032wmu.37.2018.07.11.03.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jul 2018 03:22:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org,
        Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 4/4] nvmem: imx-ocotp: add support for imx6sll
Date:   Wed, 11 Jul 2018 11:20:43 +0100
Message-Id: <20180711102043.24079-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180711102043.24079-1-srinivas.kandagatla@linaro.org>
References: <20180711102043.24079-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

i.MX6SLL is a new SoC of i.MX6 family, enable ocotp
driver support for this SoC.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 60816c856dd6..afb429a417fe 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -409,6 +409,12 @@ static const struct ocotp_params imx6sl_params = {
 	.set_timing = imx_ocotp_set_imx6_timing,
 };
 
+static const struct ocotp_params imx6sll_params = {
+	.nregs = 128,
+	.bank_address_words = 0,
+	.set_timing = imx_ocotp_set_imx6_timing,
+};
+
 static const struct ocotp_params imx6sx_params = {
 	.nregs = 128,
 	.bank_address_words = 0,
@@ -433,6 +439,7 @@ static const struct of_device_id imx_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx6sx-ocotp", .data = &imx6sx_params },
 	{ .compatible = "fsl,imx6ul-ocotp", .data = &imx6ul_params },
 	{ .compatible = "fsl,imx7d-ocotp",  .data = &imx7d_params },
+	{ .compatible = "fsl,imx6sll-ocotp", .data = &imx6sll_params },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
-- 
2.16.2

