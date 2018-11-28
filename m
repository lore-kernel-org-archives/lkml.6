Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA89C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E0D20645
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="f273KR74"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E0D20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeK1LzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:55:17 -0500
Received: from m12-12.163.com ([220.181.12.12]:49098 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbeK1LzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 06:55:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=kr1v9j9sNHqtJwDizz
        BzO5O23+o4sg+9l5iPrfz+Os0=; b=f273KR74kLelBDWxGPLDima+y4HCcho1DF
        u1tmvGG008g4jU5tLzEL4Ze79NFDkxaSlquheoNtzFJDksokc5xzq3hqBR7rgOdB
        QVA8wbWjhsq8LZOujSbiAmgiwCkDZgVbqLN78TZqJRzJh9acI0st7bO4UDG/60ia
        FakJp8j7I=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp8 (Coremail) with SMTP id DMCowADnDuB95_1bijY1CQ--.34027S3;
        Wed, 28 Nov 2018 08:55:30 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] sis5513: fix potential use after free
Date:   Wed, 28 Nov 2018 08:55:26 +0800
Message-Id: <1543366526-46767-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DMCowADnDuB95_1bijY1CQ--.34027S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWUXF1DGw1kCF4xur4fGrg_yoWDZwb_CF
        yvy397Ga1rZryUuw47Gr4SvrZIg3Wqgr48WFs7tr9I934Yv3Z5Wrykurn5JrW7u34xJrW3
        Kw42vr4UAryjyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0ubyJUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBzwINclaD0cJA3gAAsq
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function sis_find_family drops lpc_bridge reference via pci_dev_put,
however, after that, field lpc_bridge->revision is read. This may result
in a use after free bug. The patch moves the put operation after the
condition check.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/ide/sis5513.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ide/sis5513.c b/drivers/ide/sis5513.c
index 024bc7b..69f9889 100644
--- a/drivers/ide/sis5513.c
+++ b/drivers/ide/sis5513.c
@@ -434,7 +434,6 @@ static int sis_find_family(struct pci_dev *dev)
 
 				lpc_bridge = pci_get_slot(dev->bus, 0x10); /* Bus 0, Dev 2, Fn 0 */
 				pci_read_config_byte(dev, 0x49, &prefctl);
-				pci_dev_put(lpc_bridge);
 
 				if (lpc_bridge->revision == 0x10 && (prefctl & 0x80)) {
 					printk(KERN_INFO DRV_NAME " %s: SiS 961B MuTIOL IDE UDMA133 controller\n",
@@ -445,6 +444,8 @@ static int sis_find_family(struct pci_dev *dev)
 						pci_name(dev));
 					chipset_family = ATA_100;
 				}
+
+				pci_dev_put(lpc_bridge);
 			}
 	}
 
-- 
2.7.4


