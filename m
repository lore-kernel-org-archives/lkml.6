Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9DAC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0CE20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="svt9Km2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0CE20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeJPMBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbeJPMA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:00:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 434E52098A;
        Tue, 16 Oct 2018 04:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663157;
        bh=uyk7z/IYDeOjj+DS15h/n/c3SD7/ZRcT22HhaDorY6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=svt9Km2xPeSaAD4pBkdva5qZSeO2/4INaGCF5NHBB9c3AUlv5pW7KKcbgx6Tx/T7h
         iZQrR7PmEIKFuiwTjyg9bISgAsrU5Rlg942sRKjOi74bkZgDujrT3OpkCRTUcJRWI6
         yBpsXi7CS15Ejq/7H+OPcSjPkzPAuGRbIqOt5AhI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 014/100] drm/i2c: tda9950: fix timeout counter check
Date:   Tue, 16 Oct 2018 00:10:55 -0400
Message-Id: <20181016041221.135528-14-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit d98627d1360d55e3b28f702caca8b6342c4a4e45 ]

Currently the check to see if the timeout has reached zero is incorrect
and the check is instead checking if the timeout is non-zero and not
zero, hence it will break out of the loop on the first iteration and
the msleep is never executed.  Fix this by breaking from the loop when
timeout is zero.

Detected by CoverityScan, CID#1469404 ("Logically Dead Code")

Fixes: f0316f93897c ("drm/i2c: tda9950: add CEC driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i2c/tda9950.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i2c/tda9950.c b/drivers/gpu/drm/i2c/tda9950.c
index 3f7396caad48..f2186409f0cf 100644
--- a/drivers/gpu/drm/i2c/tda9950.c
+++ b/drivers/gpu/drm/i2c/tda9950.c
@@ -307,7 +307,7 @@ static void tda9950_release(struct tda9950_priv *priv)
 	/* Wait up to .5s for it to signal non-busy */
 	do {
 		csr = tda9950_read(client, REG_CSR);
-		if (!(csr & CSR_BUSY) || --timeout)
+		if (!(csr & CSR_BUSY) || !--timeout)
 			break;
 		msleep(10);
 	} while (1);
-- 
2.17.1

