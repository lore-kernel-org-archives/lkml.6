Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D07C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A291B2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mp8wT9uj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfBZJXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:23:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52594 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfBZJXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:23:39 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so1634764wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 01:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=lZn3EG9m8sLUE4ePLvkCUsk4a0QKoOz09THpspPRuOY=;
        b=Mp8wT9uj5PzUIYdThdfZNa6ehqkGoVF/pSVCKwO+MFoeTUShfxUpMs2G/xratqfjNB
         oe7C40rOR7o+/vHXupo/7QLzibUR/C+25iJf305x3joIscz6cSjYV7OKb10vKM58fp6Q
         XKDeraMBYN5VMa/d1TutNFR091uzeVKCEXPhcMsBfQn3ODiq23lD+dhByQ9If0Ziai7H
         ex6az5zJsIfaWfMcHQG6CnKXoXwQoFuMV0195611mve5bM16NUnJnQ0XXhaxKScypIvl
         x7VxCtYNI5LCcoSl9Ej9g4Qoav+V05hz8G2zgaZN1Kd3/qtOTJsVcS/zA4TpSohGki+L
         ZWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=lZn3EG9m8sLUE4ePLvkCUsk4a0QKoOz09THpspPRuOY=;
        b=XRt5skpeEs37AEFkrKrkwlZJ131M3FaSHbyRPQ1I3Es2w6Q1yu6qm9bDR5mDDIz0x3
         DMbc1AX5zOzX2v784cEST/PfDUp4udZOjvbi/AObZCuchKuT68C+uNP7rplfZvpzjtBz
         a7eHV2DKgjPNh0cXv2Clsnwv1ec1EdC4zd0udK1G6hTR5Q4qs5DJ3toDBCplGQoVyGUN
         p7+ERgFALLnEG470j7lwmReVKlo2/SFrr/ReXqrgvekm92URNYpc4K36/iVEK73LW5jv
         n7xReROcc5vENPkU8UkOI24nyvhgSXu5ypthBY5otZoPvWkW1D1VpdXLERx3ewV5H3lB
         WWxQ==
X-Gm-Message-State: AHQUAuaRLb1Pa+zuXrY5Wm6R40USH/raIJraPp2tTT/CIopl3c6OrKeJ
        Et087nEqui39BxAN/EZwtQs=
X-Google-Smtp-Source: AHgI3IYawqKmOLOfAIR4QS24wzsvnhik+3/DCmM2WIDvAT0aDCfs9toam0h3ebtihQHc4zIF7+ft2g==
X-Received: by 2002:a1c:2743:: with SMTP id n64mr2063752wmn.143.1551173017855;
        Tue, 26 Feb 2019 01:23:37 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h184sm17082398wmf.0.2019.02.26.01.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 01:23:37 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, rppt@linux.ibm.com
Subject: [PATCH] habanalabs: return error when failing to read/write i2c
Date:   Tue, 26 Feb 2019 11:23:34 +0200
Message-Id: <20190226092334.30646-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can't read/write from i2c if the device is in reset or
disabled. Therefore, return -EBUSY in those cases instead of 0.

This change also fixes a smatch warning about uninitialized variable.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/debugfs.c
index a6d9d809385e..f472b572faea 100644
--- a/drivers/misc/habanalabs/debugfs.c
+++ b/drivers/misc/habanalabs/debugfs.c
@@ -25,7 +25,7 @@ static int hl_debugfs_i2c_read(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
 	int rc;
 
 	if (hl_device_disabled_or_in_reset(hdev))
-		return 0;
+		return -EBUSY;
 
 	memset(&pkt, 0, sizeof(pkt));
 
@@ -50,7 +50,7 @@ static int hl_debugfs_i2c_write(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
 	int rc;
 
 	if (hl_device_disabled_or_in_reset(hdev))
-		return 0;
+		return -EBUSY;
 
 	memset(&pkt, 0, sizeof(pkt));
 
-- 
2.17.1

