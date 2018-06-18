Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBAAC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C8220864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C8220864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934824AbeFRIUB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:20:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54976 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964843AbeFRIT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:19:57 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F2A1FBAD;
        Mon, 18 Jun 2018 08:19:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Wang <xswang@marvell.com>,
        Ofer Heifetz <oferh@marvell.com>, Tejun Heo <tj@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 108/279] libahci: Allow drivers to override stop_engine
Date:   Mon, 18 Jun 2018 10:11:33 +0200
Message-Id: <20180618080613.289457922@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Evan Wang <xswang@marvell.com>

[ Upstream commit fa89f53bd7288d6aa7a982841119e7123faf5a53 ]

Marvell armada37xx, armada7k and armada8k share the same
AHCI sata controller IP, and currently there is an issue
(Errata Ref#226)that the SATA can not be detected via SATA
Port-MultiPlayer(PMP). After debugging, the reason is
found that the value of Port-x FIS-based Switching Control
(PxFBS@0x40) became wrong.
According to design, the bits[11:8, 0] of register PxFBS
are cleared when Port Command and Status (0x18) bit[0]
changes its value from 1 to 0, i.e. falling edge of Port
Command and Status bit[0] sends PULSE that resets PxFBS
bits[11:8; 0].
So it needs save the port PxFBS register before PxCMD
ST write and restore the port PxFBS register afterwards
in ahci_stop_engine().

This commit allows drivers to override ahci_stop_engine
behavior for use by the Marvell AHCI driver(and potentially
other drivers in the future).

Signed-off-by: Evan Wang <xswang@marvell.com>
Cc: Ofer Heifetz <oferh@marvell.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/ahci.c          |    6 +++---
 drivers/ata/ahci.h          |    7 +++++++
 drivers/ata/ahci_qoriq.c    |    2 +-
 drivers/ata/ahci_xgene.c    |    4 ++--
 drivers/ata/libahci.c       |   20 ++++++++++++--------
 drivers/ata/sata_highbank.c |    2 +-
 6 files changed, 26 insertions(+), 15 deletions(-)

--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -699,7 +699,7 @@ static int ahci_vt8251_hardreset(struct
 
 	DPRINTK("ENTER\n");
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 
 	rc = sata_link_hardreset(link, sata_ehc_deb_timing(&link->eh_context),
 				 deadline, &online, NULL);
@@ -725,7 +725,7 @@ static int ahci_p5wdh_hardreset(struct a
 	bool online;
 	int rc;
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 
 	/* clear D2H reception area to properly wait for D2H FIS */
 	ata_tf_init(link->device, &tf);
@@ -789,7 +789,7 @@ static int ahci_avn_hardreset(struct ata
 
 	DPRINTK("ENTER\n");
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 
 	for (i = 0; i < 2; i++) {
 		u16 val;
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -365,6 +365,13 @@ struct ahci_host_priv {
 	 * be overridden anytime before the host is activated.
 	 */
 	void			(*start_engine)(struct ata_port *ap);
+	/*
+	 * Optional ahci_stop_engine override, if not set this gets set to the
+	 * default ahci_stop_engine during ahci_save_initial_config, this can
+	 * be overridden anytime before the host is activated.
+	 */
+	int			(*stop_engine)(struct ata_port *ap);
+
 	irqreturn_t 		(*irq_handler)(int irq, void *dev_instance);
 
 	/* only required for per-port MSI(-X) support */
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -96,7 +96,7 @@ static int ahci_qoriq_hardreset(struct a
 
 	DPRINTK("ENTER\n");
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 
 	/*
 	 * There is a errata on ls1021a Rev1.0 and Rev2.0 which is:
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -165,7 +165,7 @@ static int xgene_ahci_restart_engine(str
 				    PORT_CMD_ISSUE, 0x0, 1, 100))
 		  return -EBUSY;
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 	ahci_start_fis_rx(ap);
 
 	/*
@@ -421,7 +421,7 @@ static int xgene_ahci_hardreset(struct a
 	portrxfis_saved = readl(port_mmio + PORT_FIS_ADDR);
 	portrxfishi_saved = readl(port_mmio + PORT_FIS_ADDR_HI);
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 
 	rc = xgene_ahci_do_hardreset(link, deadline, &online);
 
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -560,6 +560,9 @@ void ahci_save_initial_config(struct dev
 	if (!hpriv->start_engine)
 		hpriv->start_engine = ahci_start_engine;
 
+	if (!hpriv->stop_engine)
+		hpriv->stop_engine = ahci_stop_engine;
+
 	if (!hpriv->irq_handler)
 		hpriv->irq_handler = ahci_single_level_irq_intr;
 }
@@ -897,9 +900,10 @@ static void ahci_start_port(struct ata_p
 static int ahci_deinit_port(struct ata_port *ap, const char **emsg)
 {
 	int rc;
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 
 	/* disable DMA */
-	rc = ahci_stop_engine(ap);
+	rc = hpriv->stop_engine(ap);
 	if (rc) {
 		*emsg = "failed to stop engine";
 		return rc;
@@ -1310,7 +1314,7 @@ int ahci_kick_engine(struct ata_port *ap
 	int busy, rc;
 
 	/* stop engine */
-	rc = ahci_stop_engine(ap);
+	rc = hpriv->stop_engine(ap);
 	if (rc)
 		goto out_restart;
 
@@ -1549,7 +1553,7 @@ int ahci_do_hardreset(struct ata_link *l
 
 	DPRINTK("ENTER\n");
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 
 	/* clear D2H reception area to properly wait for D2H FIS */
 	ata_tf_init(link->device, &tf);
@@ -2075,14 +2079,14 @@ void ahci_error_handler(struct ata_port
 
 	if (!(ap->pflags & ATA_PFLAG_FROZEN)) {
 		/* restart engine */
-		ahci_stop_engine(ap);
+		hpriv->stop_engine(ap);
 		hpriv->start_engine(ap);
 	}
 
 	sata_pmp_error_handler(ap);
 
 	if (!ata_dev_enabled(ap->link.device))
-		ahci_stop_engine(ap);
+		hpriv->stop_engine(ap);
 }
 EXPORT_SYMBOL_GPL(ahci_error_handler);
 
@@ -2129,7 +2133,7 @@ static void ahci_set_aggressive_devslp(s
 		return;
 
 	/* set DITO, MDAT, DETO and enable DevSlp, need to stop engine first */
-	rc = ahci_stop_engine(ap);
+	rc = hpriv->stop_engine(ap);
 	if (rc)
 		return;
 
@@ -2189,7 +2193,7 @@ static void ahci_enable_fbs(struct ata_p
 		return;
 	}
 
-	rc = ahci_stop_engine(ap);
+	rc = hpriv->stop_engine(ap);
 	if (rc)
 		return;
 
@@ -2222,7 +2226,7 @@ static void ahci_disable_fbs(struct ata_
 		return;
 	}
 
-	rc = ahci_stop_engine(ap);
+	rc = hpriv->stop_engine(ap);
 	if (rc)
 		return;
 
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -410,7 +410,7 @@ static int ahci_highbank_hardreset(struc
 	int rc;
 	int retry = 100;
 
-	ahci_stop_engine(ap);
+	hpriv->stop_engine(ap);
 
 	/* clear D2H reception area to properly wait for D2H FIS */
 	ata_tf_init(link->device, &tf);


