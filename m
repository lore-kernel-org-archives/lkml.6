Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126BAC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B140C24401
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 14:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B140C24401
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933896AbeFVOwI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 10:52:08 -0400
Received: from botnar.kaiser.cx ([176.28.20.183]:43130 "EHLO botnar.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933639AbeFVOwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 10:52:05 -0400
Received: from pd956d63d.dip0.t-ipconnect.de ([217.86.214.61] helo=martin-debian-1.paytec.ch)
        by botnar.kaiser.cx with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <martin@kaiser.cx>)
        id 1fWNOa-0003mM-CS; Fri, 22 Jun 2018 16:50:40 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] mtd: rawnand: mxc: remove __init qualifier from mxcnd_probe_dt
Date:   Fri, 22 Jun 2018 16:50:25 +0200
Message-Id: <1529679025-5735-1-git-send-email-martin@kaiser.cx>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mxcnd_probe_dt is called from mxcnd_probe, which is not marked as __init.

Using the sysfs unbind, bind nodes, mxcnd_probe and mxcnd_probe_dt can
potentially be called at any time. After the __init functions are cleaned,
mxcnd_probe_dt is no longer available. Calling it anyway causes a crash.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
I hope that my understanding is correct.

In practice, I could not get the kernel to crash, my compiler would
inline mxcnd_probe_dt into mxcnd_probe and ignore the __init.

If I marked mxcnd_probe_dt as noinline, I could trigger a crash as
follows

[root@host ]# echo bb000000.nand > /sys/bus/platform/drivers/mxc_nand/unbind
[root@host ]# echo bb000000.nand > /sys/bus/platform/drivers/mxc_nand/bind
Internal error: Oops - undefined instruction: 0 [#1] ARM
...

 drivers/mtd/nand/raw/mxc_nand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 26cef21..90cfb5e 100644
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

