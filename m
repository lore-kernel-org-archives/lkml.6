Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37889C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08EF23DDE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RBqtAPe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08EF23DDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752700AbeGCLJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:09:23 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52228 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbeGCLJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:09:22 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w63B9B3g091203;
        Tue, 3 Jul 2018 06:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530616151;
        bh=p6v5syPvQOGDgdPzR0P24uEG2T1NFNawHrLy63EbFyw=;
        h=From:To:CC:Subject:Date;
        b=RBqtAPe9vUaPP24bX9p4AxGKguLK5W9vKXxrQgqWZ+FBwzYbXVvFo4OZIDfJvrT2J
         ePXlK8buV0bvQTxhmHMz7DXgiFJ2uxA+DkDzOFTwdWJyiDDUkB4Lki+L9qjx+QseDO
         fxhzt5J1n4wbCEP8XRT5T7jWvq8hf7gdBrCEMup8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w63B9BTV015088;
        Tue, 3 Jul 2018 06:09:11 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 3 Jul
 2018 06:09:11 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 3 Jul 2018 06:09:11 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w63B98I6031175;
        Tue, 3 Jul 2018 06:09:09 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-can@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC:     <wg@grandegger.com>, <mkl@pengutronix.de>, <davem@davemloft.net>,
        <faiz_abbas@ti.com>
Subject: [PATCH v2] can: m_can: Fix runtime resume call
Date:   Tue, 3 Jul 2018 16:41:02 +0530
Message-ID: <20180703111102.26502-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_sync() returns a 1 if the state of the device is already
'active'. This is not a failure case and should return a success.

Therefore fix error handling for pm_runtime_get_sync() call such that
it returns success when the value is 1.

Also cleanup the TODO for using runtime PM for sleep mode as that is
implemented.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---

Changes in v2:

rebased to latest mainline

 drivers/net/can/m_can/m_can.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index b397a33f3d32..ac4c6dc2f8c8 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -634,10 +634,12 @@ static int m_can_clk_start(struct m_can_priv *priv)
 	int err;
 
 	err = pm_runtime_get_sync(priv->device);
-	if (err)
+	if (err < 0) {
 		pm_runtime_put_noidle(priv->device);
+		return err;
+	}
 
-	return err;
+	return 0;
 }
 
 static void m_can_clk_stop(struct m_can_priv *priv)
@@ -1687,8 +1689,6 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	return ret;
 }
 
-/* TODO: runtime PM with power down or sleep mode  */
-
 static __maybe_unused int m_can_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
-- 
2.17.0

