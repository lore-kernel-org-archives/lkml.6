Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78ACC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8806D206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fSI2jfZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392108AbfAPKgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:36:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38739 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392111AbfAPKgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:36:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so6319621wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 02:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NsK0iqTrTmHE1gYUMSazLmzu2N46hv/xsJSaDrfAhtQ=;
        b=fSI2jfZkye1lTqYpa4tD7/vmAKbUkBlsRcznhPzW7810s9GuPMQKkvVVQco37EIBzJ
         gHPpc634E79AGt9ScTs4i9IA/mL297KKrixYkIbaheFqjb/xU0ST5RAM7ifMcJcdUF/S
         FtAWdR0iJirC5jEVkFOf2r4a2UvNi15OONMww8XPIEKmzyo+iqzjrc6kKCBx82IOj+mm
         0Xzbz+9kMsTS8W/n7optcnwIEma0i1TqRA2xM6lDg0IHCTWWA/NbNhOu1AxJ0TrGD/r+
         Hk6+hgSE3sCUmgUgdAReQEP2g+nBog3p7pDR/tGNM0a/MNV9pnXIemozvx6TxGxN0hea
         ebBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NsK0iqTrTmHE1gYUMSazLmzu2N46hv/xsJSaDrfAhtQ=;
        b=ZzBYway84ODkUWD+UdB3Wl2T45Oc80ANMdEvY0VaDxWLUFv3FpIeB66XLqeVpVXxLF
         xeg/dWvZnhD2esEgRdk9IBYB5IJ6u9GcqH6uuVMRY4gVrpkYjJDTUFLlrAnVzTCK/8Vh
         fS4zdeSUU8YTKWFZJIrgPUj/hjZZyXqVMzVSkdVOjGTChkHJXZeK21ffjcP4wzVPCyyY
         pvmYzHjwAbRwB4Cd7nY7epP9p2bWaNK7q561reItcputgMmopzdkMa9RCXeZFelPq+2v
         +nwq9GUCUNrnFe/OdV4HzZ2js5AT1ODk1W5dxxIdZVd9ix832KX1TQnStOEu8GmKC42k
         5Ggg==
X-Gm-Message-State: AJcUukcN7SirI1KvGABqGvvhcdot90goebS6HoqoZ+QOL0DyAx9PrPrw
        11F5cqwkokqeMxo6BV3yAm2cvw==
X-Google-Smtp-Source: ALg8bN4f1ho6Zvypun6/17vluUZ+LgKMT9PKuHHUnuewspsGprVm69PeKc4mAY8Jt7fCmsF1LiOXTg==
X-Received: by 2002:a5d:4586:: with SMTP id p6mr6733708wrq.69.1547634997868;
        Wed, 16 Jan 2019 02:36:37 -0800 (PST)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id k19sm116232430wre.5.2019.01.16.02.36.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 02:36:37 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, Carlo Caione <carlo@caione.org>
Subject: [PATCH] dt-bindings: reset: meson-axg: fix SPDX license id
Date:   Wed, 16 Jan 2019 11:36:32 +0100
Message-Id: <20190116103632.17754-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported, the SPDX license id is not placed correctly and the variant
of the BSD License used should be specified.

Fixes: c16292578ffa ("dt-bindings: reset: Add bindings for the Meson-AXG SoC Reset Controller")
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 Sorry for the delay Thomas.

 Regards
 Jerome

 include/dt-bindings/reset/amlogic,meson-axg-reset.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/dt-bindings/reset/amlogic,meson-axg-reset.h b/include/dt-bindings/reset/amlogic,meson-axg-reset.h
index ad6f55dabd6d..0f2e0fe45ca4 100644
--- a/include/dt-bindings/reset/amlogic,meson-axg-reset.h
+++ b/include/dt-bindings/reset/amlogic,meson-axg-reset.h
@@ -1,12 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
 /*
- *
  * Copyright (c) 2016 BayLibre, SAS.
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  *
  * Copyright (c) 2017 Amlogic, inc.
  * Author: Yixun Lan <yixun.lan@amlogic.com>
  *
- * SPDX-License-Identifier: (GPL-2.0+ OR BSD)
  */
 
 #ifndef _DT_BINDINGS_AMLOGIC_MESON_AXG_RESET_H
-- 
2.20.1

