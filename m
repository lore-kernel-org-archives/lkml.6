Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D812AFC6182
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8673E2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oCMrmo84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8673E2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbeINCfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 22:35:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43733 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbeINCfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 22:35:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id v66-v6so3318825pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 14:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=0ZdfWJ91njr8E+MdVulUPoxupHH3eFEWvS2WtXElx5Y=;
        b=oCMrmo84puy1e2w6ruGADwYth8oAn4abaoEQ9pdTHgQYeybjAdu+kgGKUKmr1k0Q3m
         TMYg7aAHzrn6RANeDLVRA+w4zzVNLeq9jwRW5F8wPld4UyOXtI9LbkKTZg/kCRWR82R4
         t4J+vYh4mqiCPyoepeSme54WteT/fV349evo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=0ZdfWJ91njr8E+MdVulUPoxupHH3eFEWvS2WtXElx5Y=;
        b=TH7NICR8kXtILqAKfJDrgxXzr6KPvlVorZZwess6iEune6Pb0AC4Kmt46J/ztYPVTt
         nKrC5TQ9xv0JNvy+W00ArUMph3k/MUFEVJkZTdhfElG9BM0A/TEFf2oUJyE6nf1VG3kk
         +z3Qy8XzgcgUv4TfRgujtUE0z9InRRQRJtZgaWIpMSYpfhsCuMkGqbfX+fAwJprJXVYA
         oAihxZ1mF4cypB3v481LiwHmIyzlxWzUuPKzVpvHutxL2jcLkCf08p2Px+dnCYhVFdEO
         2BtelZwXu8qUW5sT8dMYhhev0B0XmPsz20pOKvljM9TfBnumtUSvHEmaTVjaKW2P4sC0
         CGUw==
X-Gm-Message-State: APzg51AhIGCu+rtV6T8E92fGzs1fCEgUbTn43s9keFVL8VV6hhw3PbWy
        Q73Xaw0vJYH5uhnJ9RF8ygFKFA==
X-Google-Smtp-Source: ANB0VdaaIe5vOyfmhug267l2FI0n0cM3op5ShohVNQXiYJBCuAcLMuPuxBoZ8lYsIu2d6K9ASwEDtg==
X-Received: by 2002:a62:225d:: with SMTP id i90-v6mr9134147pfi.246.1536873838859;
        Thu, 13 Sep 2018 14:23:58 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id f67-v6sm7858276pff.29.2018.09.13.14.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 14:23:57 -0700 (PDT)
Date:   Thu, 13 Sep 2018 14:23:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        Ivan Mikhaylov <ivan@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] net/ibm/emac: Remove VLA usage
Message-ID: <20180913212356.GA37936@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
removes the VLA used for the emac xaht registers size. Since the size
of registers can only ever be 4 or 8, as detected in emac_init_config(),
the max can be hardcoded and a runtime test added for robustness.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Christian Lamparter <chunkeey@gmail.com>
Cc: Ivan Mikhaylov <ivan@de.ibm.com>
Cc: netdev@vger.kernel.org
Co-developed-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/ibm/emac/core.c | 6 +++++-
 drivers/net/ethernet/ibm/emac/core.h | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 372664686309..7410a1de8f1d 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -423,7 +423,7 @@ static void emac_hash_mc(struct emac_instance *dev)
 {
 	const int regs = EMAC_XAHT_REGS(dev);
 	u32 *gaht_base = emac_gaht_base(dev);
-	u32 gaht_temp[regs];
+	u32 gaht_temp[EMAC_XAHT_MAX_REGS];
 	struct netdev_hw_addr *ha;
 	int i;
 
@@ -2964,6 +2964,10 @@ static int emac_init_config(struct emac_instance *dev)
 		dev->xaht_width_shift = EMAC4_XAHT_WIDTH_SHIFT;
 	}
 
+	/* This should never happen */
+	if (WARN_ON(EMAC_XAHT_REGS(dev) > EMAC_XAHT_MAX_REGS))
+		return -ENXIO;
+
 	DBG(dev, "features     : 0x%08x / 0x%08x\n", dev->features, EMAC_FTRS_POSSIBLE);
 	DBG(dev, "tx_fifo_size : %d (%d gige)\n", dev->tx_fifo_size, dev->tx_fifo_size_gige);
 	DBG(dev, "rx_fifo_size : %d (%d gige)\n", dev->rx_fifo_size, dev->rx_fifo_size_gige);
diff --git a/drivers/net/ethernet/ibm/emac/core.h b/drivers/net/ethernet/ibm/emac/core.h
index 369de2cfb15b..84caa4a3fc52 100644
--- a/drivers/net/ethernet/ibm/emac/core.h
+++ b/drivers/net/ethernet/ibm/emac/core.h
@@ -390,6 +390,9 @@ static inline int emac_has_feature(struct emac_instance *dev,
 #define	EMAC4SYNC_XAHT_SLOTS_SHIFT	8
 #define	EMAC4SYNC_XAHT_WIDTH_SHIFT	5
 
+/* The largest span between slots and widths above is 3 */
+#define	EMAC_XAHT_MAX_REGS		(1 << 3)
+
 #define	EMAC_XAHT_SLOTS(dev)         	(1 << (dev)->xaht_slots_shift)
 #define	EMAC_XAHT_WIDTH(dev)         	(1 << (dev)->xaht_width_shift)
 #define	EMAC_XAHT_REGS(dev)          	(1 << ((dev)->xaht_slots_shift - \
-- 
2.17.1


-- 
Kees Cook
Pixel Security
