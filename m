Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320E1C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C55259F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 20:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C55259F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966192AbeF0UuG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 16:50:06 -0400
Received: from botnar.kaiser.cx ([176.28.20.183]:49786 "EHLO botnar.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965457AbeF0UuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 16:50:05 -0400
Received: from dslb-084-059-250-221.084.059.pools.vodafone-ip.de ([84.59.250.221] helo=martin-debian-1.paytec.ch)
        by botnar.kaiser.cx with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <martin@kaiser.cx>)
        id 1fYHMs-0006dH-W3; Wed, 27 Jun 2018 22:48:47 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v3] mtd: rawnand: mxc: remove __init qualifier from mxcnd_probe_dt
Date:   Wed, 27 Jun 2018 22:47:44 +0200
Message-Id: <1530132464-8210-1-git-send-email-martin@kaiser.cx>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1529679025-5735-1-git-send-email-martin@kaiser.cx>
References: <1529679025-5735-1-git-send-email-martin@kaiser.cx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the sysfs unbind, bind nodes, mxcnd_probe and mxcnd_probe_dt can
potentially be called at any time. After the __init functions are cleaned,
mxcnd_probe_dt is no longer available. Calling it anyway causes a crash.

mxcnd_probe used to be marked as __init, this was removed years ago.
Remove the __init qualifier from from mxcnd_probe_dt as well.

Fixes: 06f255106923 ("mtd: remove use of __devinit")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
changes in v3
   - show the first 12 characters of the SHA-1 ID in the Fixes: tag

changes in v2
   - rephrased the commit message
   - added a Fixes: tag

 drivers/mtd/nand/raw/mxc_nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 26cef218bb43..90cfb5e730aa 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -1686,7 +1686,7 @@ static const struct of_device_id mxcnd_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mxcnd_dt_ids);
 
-static int __init mxcnd_probe_dt(struct mxc_nand_host *host)
+static int mxcnd_probe_dt(struct mxc_nand_host *host)
 {
 	struct device_node *np = host->dev->of_node;
 	const struct of_device_id *of_id =
@@ -1700,7 +1700,7 @@ static int __init mxcnd_probe_dt(struct mxc_nand_host *host)
 	return 0;
 }
 #else
-static int __init mxcnd_probe_dt(struct mxc_nand_host *host)
+static int mxcnd_probe_dt(struct mxc_nand_host *host)
 {
 	return 1;
 }
-- 
2.1.4

