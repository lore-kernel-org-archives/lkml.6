Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1ECC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FDC20844
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549894944;
	bh=mAJ/IvRiAJggwhNBnNaEg/MW3gSIo/3rigsp4pevsY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xexit9IenJvENoDnWDLwvKY5qRKG5uySneIEb3AM1HRWPjIDzmMy4ka4tHfk7V7n8
	 Ej1s0W6Oo9Iql+9iy/5yDN/J+rIN5MibnJm7v51kWf7wJGppfjlLzwheBOw7E34FZu
	 ubHdl6SUXcFIrLB7oZ4tXbTzwtyjsP5Z4HOR6CGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbfBKOWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:22:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:55220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbfBKOWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:22:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27CDD20844;
        Mon, 11 Feb 2019 14:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894938;
        bh=mAJ/IvRiAJggwhNBnNaEg/MW3gSIo/3rigsp4pevsY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DpQ9guMq45LJ5roBSNaaOcIHkEk7JjmTzuJLSUJszUGBQsWZavlB7MfJ1XyunHdIU
         zv85heFsFhvNsVjJe1bhPWWbzu6+Wmna7YErMljkkxaAXITsfZRazPK8U61QG7qWyr
         t18SreYgxN2vuTWbTOcJggVBmCNWt1wAg8obg6oc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Puhm <puhm@oregano.at>,
        Anatolij Gustschin <agust@denx.de>,
        Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 037/352] fpga: altera-cvp: Fix registration for CvP incapable devices
Date:   Mon, 11 Feb 2019 15:14:24 +0100
Message-Id: <20190211141848.684081319@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 68f60538daa4bc3da5d0764d46f391916fba20fd ]

The probe function needs to verify the CvP enable bit in order to
properly determine if FPGA Manager functionality can be safely
enabled.

Fixes: 34d1dc17ce97 ("fpga manager: Add Altera CvP driver")
Signed-off-by: Andreas Puhm <puhm@oregano.at>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/fpga/altera-cvp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index d9fa7d4bf11f..36d79b039c57 100644
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
2.19.1



