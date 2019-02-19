Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0833C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32DB21773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfBSOVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:21:25 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55200 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfBSOVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:21:25 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gw6Gu-0004nc-IN; Tue, 19 Feb 2019 14:21:20 +0000
From:   Colin King <colin.king@canonical.com>
To:     Yangbo Lu <yangbo.lu@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Richard Cochran <richardcochran@gmail.com>,
        Li Yang <leoyang.li@nxp.com>, netdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ptp_qoriq: don't pass a large struct by value but instead pass it by reference
Date:   Tue, 19 Feb 2019 14:21:20 +0000
Message-Id: <20190219142120.11347-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Passing the struct ptp_clock_info caps by parameter is passing over 130 bytes
of data by value on the stack. Optimize this by passing it by reference instead.
Also shinks the object code size:

Before:
   text	   data	    bss	    dec	    hex	filename
  12596	   2160	     64	  14820	   39e4	drivers/ptp/ptp_qoriq.o

After:
   text	   data	    bss	    dec	    hex	filename
  12567	   2160	     64	  14791	   39c7	drivers/ptp/ptp_qoriq.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_ptp.c | 2 +-
 drivers/ptp/ptp_qoriq.c                          | 6 +++---
 include/linux/fsl/ptp_qoriq.h                    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ptp.c b/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
index dc2f58a7c9e5..8c1497e7d9c5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
@@ -92,7 +92,7 @@ static int enetc_ptp_probe(struct pci_dev *pdev,
 
 	ptp_qoriq->dev = &pdev->dev;
 
-	err = ptp_qoriq_init(ptp_qoriq, base, enetc_ptp_caps);
+	err = ptp_qoriq_init(ptp_qoriq, base, &enetc_ptp_caps);
 	if (err)
 		goto err_no_clock;
 
diff --git a/drivers/ptp/ptp_qoriq.c b/drivers/ptp/ptp_qoriq.c
index 42d3654f77f0..53775362aac6 100644
--- a/drivers/ptp/ptp_qoriq.c
+++ b/drivers/ptp/ptp_qoriq.c
@@ -459,7 +459,7 @@ static int ptp_qoriq_auto_config(struct ptp_qoriq *ptp_qoriq,
 }
 
 int ptp_qoriq_init(struct ptp_qoriq *ptp_qoriq, void __iomem *base,
-		   const struct ptp_clock_info caps)
+		   const struct ptp_clock_info *caps)
 {
 	struct device_node *node = ptp_qoriq->dev->of_node;
 	struct ptp_qoriq_registers *regs;
@@ -468,7 +468,7 @@ int ptp_qoriq_init(struct ptp_qoriq *ptp_qoriq, void __iomem *base,
 	u32 tmr_ctrl;
 
 	ptp_qoriq->base = base;
-	ptp_qoriq->caps = caps;
+	ptp_qoriq->caps = *caps;
 
 	if (of_property_read_u32(node, "fsl,cksel", &ptp_qoriq->cksel))
 		ptp_qoriq->cksel = DEFAULT_CKSEL;
@@ -605,7 +605,7 @@ static int ptp_qoriq_probe(struct platform_device *dev)
 		goto no_ioremap;
 	}
 
-	err = ptp_qoriq_init(ptp_qoriq, base, ptp_qoriq_caps);
+	err = ptp_qoriq_init(ptp_qoriq, base, &ptp_qoriq_caps);
 	if (err)
 		goto no_clock;
 
diff --git a/include/linux/fsl/ptp_qoriq.h b/include/linux/fsl/ptp_qoriq.h
index f127adb71041..992bf9fa1729 100644
--- a/include/linux/fsl/ptp_qoriq.h
+++ b/include/linux/fsl/ptp_qoriq.h
@@ -183,7 +183,7 @@ static inline void qoriq_write_le(unsigned __iomem *addr, u32 val)
 
 irqreturn_t ptp_qoriq_isr(int irq, void *priv);
 int ptp_qoriq_init(struct ptp_qoriq *ptp_qoriq, void __iomem *base,
-		   const struct ptp_clock_info caps);
+		   const struct ptp_clock_info *caps);
 void ptp_qoriq_free(struct ptp_qoriq *ptp_qoriq);
 int ptp_qoriq_adjfine(struct ptp_clock_info *ptp, long scaled_ppm);
 int ptp_qoriq_adjtime(struct ptp_clock_info *ptp, s64 delta);
-- 
2.20.1

