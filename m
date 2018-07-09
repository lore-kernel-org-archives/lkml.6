Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F149C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11AB20873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="VdBBQaNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11AB20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932858AbeGIMyY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:54:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42394 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932735AbeGIMyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Message-Id:Date:Subject:Cc:To:From
        :Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gpnE1etiqWxiECtuP3ySGtzLzQjfhU91ycIvxhBMMuk=; b=VdBBQaNYbCGRSi2C10HduagsS
        LszY3X7VE2dayZEKZ3QkhqUaQNZrX1BN91RKIL59jreFE7sScIK977JlofXTI5twXtvbya2U7R+vW
        539NC7Zqkp4bfscOO2h0BF4KScOeF4ioW7tD37MeH+RPyeYVpVRFmvKEfgDCra6uYNrv4=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcVgI-0003lI-A2; Mon, 09 Jul 2018 12:54:18 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcVgH-0008S0-N5; Mon, 09 Jul 2018 13:54:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        pascal paillet <p.paillet@st.com>, benjamin.gaignard@linaro.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: core: Don't link consumers on the same device
Date:   Mon,  9 Jul 2018 13:54:02 +0100
Message-Id: <20180709125402.32427-1-broonie@kernel.org>
X-Mailer: git-send-email 2.18.0.rc2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases a device may end up supplying itself, for example when a
DCDC is used to improve the efficiency of LDOs or when a LDO is provided
to clean up sensitive supplies.  In these cases the driver core will
warn loudly about attempts to add links so suppress them here.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---

Compile tested only.

 drivers/regulator/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index b5db0257bc40..1302e66e80ac 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1741,7 +1741,8 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 			rdev->use_count = 0;
 	}
 
-	device_link_add(dev, &rdev->dev, DL_FLAG_STATELESS);
+	if (dev != &rdev->dev)
+		device_link_add(dev, &rdev->dev, DL_FLAG_STATELESS);
 
 	return regulator;
 }
@@ -1840,7 +1841,7 @@ static void _regulator_put(struct regulator *regulator)
 			if (r->dev == regulator->dev)
 				count++;
 
-		if (count == 1)
+		if (count == 1 && regulator->dev != &rdev->dev)
 			device_link_remove(regulator->dev, &rdev->dev);
 
 		/* remove any sysfs entries */
-- 
2.18.0.rc2

