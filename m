Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C55DC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A3F21736
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfBJRMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:12:16 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:48207 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfBJRMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:12:15 -0500
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 528A2C0006;
        Sun, 10 Feb 2019 17:12:12 +0000 (UTC)
Date:   Sun, 10 Feb 2019 18:12:12 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tty/nozomi: use pci_iomap instead of ioremap_nocache
Message-ID: <20190210171212.GA22758@behemoth.owl.eu.com.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pci_iomap instead of ioremap_nocache in nozomi_card_init(). This
is a cleaner way to do PCI MMIO (performs additional checks) and
allows to drop the manual call to pci_resource_start.

pci_iomap relies on ioremap for MMIO and thus has uncached behavior.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
 drivers/tty/nozomi.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index fed820e9ab9d..3214e22e79f3 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -1317,7 +1317,6 @@ static void remove_sysfs_files(struct nozomi *dc)
 static int nozomi_card_init(struct pci_dev *pdev,
 				      const struct pci_device_id *ent)
 {
-	resource_size_t start;
 	int ret;
 	struct nozomi *dc = NULL;
 	int ndev_idx;
@@ -1357,17 +1356,10 @@ static int nozomi_card_init(struct pci_dev *pdev,
 		goto err_disable_device;
 	}
 
-	start = pci_resource_start(dc->pdev, 0);
-	if (start == 0) {
-		dev_err(&pdev->dev, "No I/O address for card detected\n");
-		ret = -ENODEV;
-		goto err_rel_regs;
-	}
-
 	/* Find out what card type it is */
 	nozomi_get_card_type(dc);
 
-	dc->base_addr = ioremap_nocache(start, dc->card_type);
+	dc->base_addr = pci_iomap(dc->pdev, 0, dc->card_type);
 	if (!dc->base_addr) {
 		dev_err(&pdev->dev, "Unable to map card MMIO\n");
 		ret = -ENODEV;
-- 
2.20.1
