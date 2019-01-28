Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E85C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BB02177B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DfLHLmcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfA1RgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:36:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44327 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729415AbfA1PzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:55:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id z5so18585724wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 07:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C0iN6aJENz6qbt1UdAuej131qJDG5aeHCCLqTs0M+VU=;
        b=DfLHLmcWjA3sRWcv5DSf2ZLHJXG2JlyqLLpKmNoompy1g2ioINKlVn0RcyaFDdGu77
         +HdchoyHbse17p4N4KONcQpeKmbkizSmJoNRow25u3KbviqcOEJiX6qwdRtqmpULXjGs
         gm6kuEWfQVJ7b+ECumxyTz9Di/OcUuZudrfwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C0iN6aJENz6qbt1UdAuej131qJDG5aeHCCLqTs0M+VU=;
        b=hg54Xfah6TF/a+zG2i6E1VCE5BzqLbIXrVI++wve2L6973ywP/YEI1vHbygh/IWKjV
         6q6gjDX0MU+1dcKEYIJLNEJschXmv92VYVWPyrUz5jD0r7Ov1T3imRLgAUPNehZYSs3/
         ruHQWuBWr8bpxc33HubVdN12TgxHOQRlXrLMdOECwAOdPto/qNqJb1dtE3dGjjC4993u
         WVe7RkAXkOSchM41lYditeXgITxopX7VyQgA5i6AzMjh31Bsa9QzQXWaDM3dj0cRSsft
         n2QJ0lfdDGHgddUUwz099myKk6Cca/z+Q/NfNIgEEBTGf0vlrLWvZ7yrtNWydhxuKDRO
         aVgg==
X-Gm-Message-State: AJcUukdzCCkPibWo9nQ5hiTwrVESS0KtUPIS2gHIXJnFdr41IcjMZeLR
        dcAHBk22xkuFQumdXwJeBzy+cA==
X-Google-Smtp-Source: ALg8bN7774yYq6Ot7+1n1dJXxSEmY8L2JPF/1fwflaThu8/ADiyAEwzHKOvjSHbS1F41aLGzquqRbA==
X-Received: by 2002:adf:ba8e:: with SMTP id p14mr21825152wrg.230.1548690915143;
        Mon, 28 Jan 2019 07:55:15 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p6sm145140485wrx.50.2019.01.28.07.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Jan 2019 07:55:14 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] nvmem: imx-ocotp: Implement i.MX6ULL/ULZ support
Date:   Mon, 28 Jan 2019 15:54:59 +0000
Message-Id: <20190128155506.25566-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128155506.25566-1-srinivas.kandagatla@linaro.org>
References: <20190128155506.25566-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>

In comparision to the i.MX6UL the lower cost variants i.MX6ULL/ULZ only
supports 8 OTP banks a 8 words.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 90a398252770..08a9b1ef8ae4 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -427,6 +427,12 @@ static const struct ocotp_params imx6ul_params = {
 	.set_timing = imx_ocotp_set_imx6_timing,
 };
 
+static const struct ocotp_params imx6ull_params = {
+	.nregs = 64,
+	.bank_address_words = 0,
+	.set_timing = imx_ocotp_set_imx6_timing,
+};
+
 static const struct ocotp_params imx7d_params = {
 	.nregs = 64,
 	.bank_address_words = 4,
@@ -443,6 +449,7 @@ static const struct of_device_id imx_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx6sl-ocotp", .data = &imx6sl_params },
 	{ .compatible = "fsl,imx6sx-ocotp", .data = &imx6sx_params },
 	{ .compatible = "fsl,imx6ul-ocotp", .data = &imx6ul_params },
+	{ .compatible = "fsl,imx6ull-ocotp", .data = &imx6ull_params },
 	{ .compatible = "fsl,imx7d-ocotp",  .data = &imx7d_params },
 	{ .compatible = "fsl,imx6sll-ocotp", .data = &imx6sll_params },
 	{ .compatible = "fsl,imx7ulp-ocotp", .data = &imx7ulp_params },
-- 
2.20.1

