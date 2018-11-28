Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA60BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AA720851
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 01:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fDZ7AxD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AA720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeK1Mkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 07:40:45 -0500
Received: from m12-18.163.com ([220.181.12.18]:51797 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbeK1Mko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 07:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=DactAzozDPp6a++Kdi
        RSgOAGTH218BZMwovld9T9Ad4=; b=fDZ7AxD2R5MXlEnplj+grL9U3bEr6f4A7S
        sMMSrQa/HREgXAb0EXM9lUgAQg4pvB3/aBwXLkzin9iU4u7w0ZX++KglkpbgdEP4
        atRH8PrfgYXYKlra3KbfDo2oBhuThSlfMH/ZrS9YiLOKW3CVkoNrmxwd16UVvpX8
        rKfzM5wLU=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp14 (Coremail) with SMTP id EsCowAAXbqUe8v1b3fF0CA--.28752S3;
        Wed, 28 Nov 2018 09:40:49 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] ata: read ->revision before dropping pci_device reference
Date:   Wed, 28 Nov 2018 09:40:43 +0800
Message-Id: <1543369243-64252-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EsCowAAXbqUe8v1b3fF0CA--.28752S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur43try7KF1rCrW7XFy8uFg_yoW8CFW5pF
        ZxCasIvrWrWF1aqwsrAr4UZF1ayayv934FgrW3G34Yva1rXFykXF1rXa4jv34rKrWDCFy7
        Xw4Utr18WF47Z3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jTc_-UUUUU=
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBzwINclaD0cJA3wABsq
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_device->revision is read after dropping pci_device reference via
pci_dev_put, which may result in use-after-free bugs. To fix this, the
patch reads ->revision before dropping reference.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/ata/pata_sis.c      | 4 +++-
 drivers/ata/pata_sl82c105.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_sis.c b/drivers/ata/pata_sis.c
index 626f989..01635bc 100644
--- a/drivers/ata/pata_sis.c
+++ b/drivers/ata/pata_sis.c
@@ -833,6 +833,7 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		u16 trueid;
 		u8 prefctl;
 		u8 idecfg;
+		u8 sbrev;
 
 		/* Try the second unmasking technique */
 		pci_read_config_byte(pdev, 0x4a, &idecfg);
@@ -846,9 +847,10 @@ static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 			if (lpc_bridge == NULL)
 				break;
 			pci_read_config_byte(pdev, 0x49, &prefctl);
+			sbrev = lpc_bridge->revision;
 			pci_dev_put(lpc_bridge);
 
-			if (lpc_bridge->revision == 0x10 && (prefctl & 0x80)) {
+			if (sbrev == 0x10 && (prefctl & 0x80)) {
 				chipset = &sis133_early;
 				break;
 			}
diff --git a/drivers/ata/pata_sl82c105.c b/drivers/ata/pata_sl82c105.c
index 4935f61f..476438e 100644
--- a/drivers/ata/pata_sl82c105.c
+++ b/drivers/ata/pata_sl82c105.c
@@ -264,6 +264,7 @@ static struct ata_port_operations sl82c105_port_ops = {
 static int sl82c105_bridge_revision(struct pci_dev *pdev)
 {
 	struct pci_dev *bridge;
+	u8 rev;
 
 	/*
 	 * The bridge should be part of the same device, but function 0.
@@ -285,8 +286,9 @@ static int sl82c105_bridge_revision(struct pci_dev *pdev)
 	/*
 	 * We need to find function 0's revision, not function 1
 	 */
+	rev = bridge->revision;
 	pci_dev_put(bridge);
-	return bridge->revision;
+	return rev;
 }
 
 static void sl82c105_fixup(struct pci_dev *pdev)
-- 
2.7.4


