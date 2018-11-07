Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0198FC46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC012086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="esSeKFV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC012086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbeKHDX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:23:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:53216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728131AbeKHDX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:23:27 -0500
Received: from localhost.localdomain (rrcs-67-79-197-43.sw.biz.rr.com [67.79.197.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93ED520896;
        Wed,  7 Nov 2018 17:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541613120;
        bh=PIIv7+iNiZqHWjN2mucAtpn8NZHG20kRZUawXYtAuNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=esSeKFV1BH1uP2+WexUC5kql/5wWECnfOvh1xsr8S5QwgcjtLNZm9Y6c0gALDh97p
         Oq/1rvsK6iddbVyuo9kebsm2KU6+GfA6o2mJLi7ySiEeplBKSEtRZvjOB7iyP2INMl
         OuNcoP/QR6JpHD3/lF5Zauo2LZ8x2zvaO30eAsgM=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Andreas Puhm <puhm@oregano.at>,
        Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 3/4] fpga: altera-cvp: Fix registration for CvP incapable devices
Date:   Wed,  7 Nov 2018 11:51:47 -0600
Message-Id: <1541613108-29660-4-git-send-email-atull@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541613108-29660-1-git-send-email-atull@kernel.org>
References: <1541613108-29660-1-git-send-email-atull@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Puhm <puhm@oregano.at>

The probe function needs to verify the CvP enable bit in order to
properly determine if FPGA Manager functionality can be safely
enabled.

Fixes: 34d1dc17ce97 ("fpga manager: Add Altera CvP driver")
Signed-off-by: Andreas Puhm <puhm@oregano.at>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/altera-cvp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 144fa2a..7395085 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -403,6 +403,7 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 	struct altera_cvp_conf *conf;
 	struct fpga_manager *mgr;
 	u16 cmd, val;
+	u32 regval;
 	int ret;
 
 	/*
@@ -416,6 +417,14 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 		return -ENODEV;
 	}
 
+	pci_read_config_dword(pdev, VSE_CVP_STATUS, &regval);
+	if (!(regval & VSE_CVP_STATUS_CVP_EN)) {
+		dev_err(&pdev->dev,
+			"CVP is disabled for this device: CVP_STATUS Reg 0x%x\n",
+			regval);
+		return -ENODEV;
+	}
+
 	conf = devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
 	if (!conf)
 		return -ENOMEM;
-- 
2.7.4

