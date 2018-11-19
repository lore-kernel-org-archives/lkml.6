Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF70C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00B12086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U/v/YMhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00B12086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeKSVC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 16:02:57 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:46412 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeKSVC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 16:02:57 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAJAdFuj067561;
        Mon, 19 Nov 2018 04:39:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542623955;
        bh=uz7oozAot01c9hsILtyWwegpkjRGj8rGu9XJdGwyVTA=;
        h=From:To:CC:Subject:Date;
        b=U/v/YMhWf+rGpbe3IgedCaX69IlvyJfLEwgEHD/GUopyNsvwvWppV2TWRUUnlrnAm
         ZZWvOCh7yBwSu0JZKX+pKkabbqlgA/NqcnyVKhzV3KsL3ZB0Fd/hwYv8OT+f7n9p4t
         UVO+QwtQ5+1ojNWvbCjbdfTD31OoZcmusIF5NfvM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAJAdFD4048538
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 04:39:15 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 19
 Nov 2018 04:39:15 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 19 Nov 2018 04:39:15 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAJAdCDU015876;
        Mon, 19 Nov 2018 04:39:13 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <aaro.koskinen@iki.fi>, <tony@atomide.com>,
        <linux-omap@vger.kernel.org>, <rmk+kernel@armlinux.org.uk>
Subject: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Date:   Mon, 19 Nov 2018 12:40:40 +0200
Message-ID: <20181119104040.12885-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the channel is configured for slave operation the LCH_TYPE needs to be
set to LCh-P. For memcpy channels the LCH_TYPE must be set to LCh-2D.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/omap-dma.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index a4a931ddf6f6..a18cfd497f04 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -185,6 +185,10 @@ enum {
 
 	CLNK_CTRL_ENABLE_LNK	= BIT(15),
 
+	/* OMAP1 only */
+	LCH_CTRL_LCH_2D		= 0,
+	LCH_CTRL_LCH_P		= 2,
+
 	CDP_DST_VALID_INC	= 0 << 0,
 	CDP_DST_VALID_RELOAD	= 1 << 0,
 	CDP_DST_VALID_REUSE	= 2 << 0,
@@ -529,6 +533,7 @@ static void omap_dma_start_sg(struct omap_chan *c, struct omap_desc *d)
 
 static void omap_dma_start_desc(struct omap_chan *c)
 {
+	struct omap_dmadev *od = to_omap_dma_dev(c->vc.chan.device);
 	struct virt_dma_desc *vd = vchan_next_desc(&c->vc);
 	struct omap_desc *d;
 	unsigned cxsa, cxei, cxfi;
@@ -570,6 +575,12 @@ static void omap_dma_start_desc(struct omap_chan *c)
 	omap_dma_chan_write(c, CSDP, d->csdp);
 	omap_dma_chan_write(c, CLNK_CTRL, d->clnk_ctrl);
 
+	if (dma_omap1() && !__dma_omap15xx(od->plat->dma_attr)) {
+		if (is_slave_direction(d->dir))
+			omap_dma_chan_write(c, LCH_CTRL, LCH_CTRL_LCH_P);
+		else
+			omap_dma_chan_write(c, LCH_CTRL, LCH_CTRL_LCH_2D);
+	}
 	omap_dma_start_sg(c, d);
 }
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

