Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6078BC2F420
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3229720870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="nT6thWHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfAUO6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:58:51 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:44336 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbfAUO6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:58:50 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id C9E175C0231;
        Mon, 21 Jan 2019 15:58:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1548082728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=JT3s8OPkL95HsDHHmHtzAGT4/3OLRSzmKQWITSuh0pc=;
        b=nT6thWHxzyXiYd4ICXsna52Gw/Z1ai8eaibyupD741JZgPve/a4TpraP60xkuBlXl6Z397
        tqQMrErE5tkrRXEEsQdapCWyitUfiBX7vPJc0t8s0SOyzzS1GzBt2MuJac+zELK0NRHUJH
        u8iQgOy+FL7/67Llwz5ldeGp8Gp3fyY=
From:   Stefan Agner <stefan@agner.ch>
To:     fugang.duan@nxp.com, davem@davemloft.net
Cc:     marcel.ziswiler@toradex.com, max.krummenacher@toradex.com,
        dev@pschenker.ch, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH] net: fec: get regulator optional
Date:   Mon, 21 Jan 2019 15:58:47 +0100
Message-Id: <20190121145847.30223-1-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the device tree binding the phy-supply property is
optional. Use the regulator_get_optional API accordingly. The
code already handles NULL just fine.

This gets rid of the following warning:
  fec 2188000.ethernet: 2188000.ethernet supply phy not found, using dummy regulator

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 6db69ba30dcd..c8315d880c8c 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3479,7 +3479,7 @@ fec_probe(struct platform_device *pdev)
 	if (ret)
 		goto failed_clk_ipg;
 
-	fep->reg_phy = devm_regulator_get(&pdev->dev, "phy");
+	fep->reg_phy = devm_regulator_get_optional(&pdev->dev, "phy");
 	if (!IS_ERR(fep->reg_phy)) {
 		ret = regulator_enable(fep->reg_phy);
 		if (ret) {
-- 
2.20.1

