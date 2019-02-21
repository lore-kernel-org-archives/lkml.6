Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CB3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BF820823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOmahZvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfBUPrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:47:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38959 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfBUPqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:46:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id l5so30046042wrw.6;
        Thu, 21 Feb 2019 07:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zr9ZMCK/RIEsVShfTL9vZ/oRXnYMetMaqCj88B2pMXk=;
        b=qOmahZvNTdBR6w48h6n7PD4d1HPzdsS2E495/2PhFthU2JnaRnP3FEqq0e+hREohos
         AZzmyCxYWh5m5479GW4axtCFXF1ktAJJFNwVx8VNqbtRqZLYSsb1zx8KKQYt0YoP2exG
         dsI9tzS//DZCwiOteFcoOomfq8kU1MNiFTygCa9mpNZf1KZbxNHbjSmOEDgvl/y54qff
         +Sw+SOufvMPD+XJZHof6wCYMV2/tpEUMGt4vHKaNfW0cpSL1CS47PDphs9zNHniPCI8W
         WuLxJ8uKP2c+ZhwfDuD5oX7cBTrsQmzRvq4FQS2d6dq+jPp2yQw5N18DLM/2dc3J9kiz
         MIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zr9ZMCK/RIEsVShfTL9vZ/oRXnYMetMaqCj88B2pMXk=;
        b=s0HqAnjFWsN6b97270ktOiVzspKiWQavbBsJB7OW49akHmi0dMIai/x+eJtQUUTizD
         GMRvn4Cor/nznsr19vYNx87pfBrt1FleBuvOu53876sfC201CsukbbtoloX+c57J68UN
         Lgk8A6NUkucO+1zCxsJF9+uvVxj7gWhK37v4Ud6yYM0J5UCib6JmMZu6EpROladzKFcW
         ul3QKRw+FphBLm+tRoMCBb8oe8NDFaSFPkdDrJfdmkIb/+Q9g8V9qgMMVIhIy+3cSfuZ
         VcPN96oxTD4hBrOUmLHmh/bzXAvYoHU4gKuxiI7P4PN61aC6ZAe9Uz7goNStCf2MmLsr
         x7ig==
X-Gm-Message-State: AHQUAuYYeypWI+NA7WDjkXlxYl4CjPAudu7a/j8uL3FWv+SDGXnmB03z
        gKACLFOfSYGJNyqhPGIo5Wg=
X-Google-Smtp-Source: AHgI3IbEGJ4tqn4YTCwDC05sh3790FkAVP2kf7ZimbIgUtTTsZwCP8IYq4p2d0XzyL1XTevNscqyvw==
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr27002109wru.303.1550763999196;
        Thu, 21 Feb 2019 07:46:39 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id a144sm12653366wmd.30.2019.02.21.07.46.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 07:46:38 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] phy: tegra: xusb: Skip single function lane programming
Date:   Thu, 21 Feb 2019 16:46:31 +0100
Message-Id: <20190221154634.10684-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154634.10684-1-thierry.reding@gmail.com>
References: <20190221154634.10684-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: JC Kuo <jckuo@nvidia.com>

Tegra186 USB2 pads and USB3 pads do not have hardware mux for changing
the pad function. For such "lanes", we can skip the lane mux register
programming.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/phy/tegra/xusb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 5b3b8863363e..e3bc60cfe6a1 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2014-2015, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2014-2016, NVIDIA CORPORATION.  All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -313,6 +313,10 @@ static void tegra_xusb_lane_program(struct tegra_xusb_lane *lane)
 	const struct tegra_xusb_lane_soc *soc = lane->soc;
 	u32 value;
 
+	/* skip single function lanes */
+	if (soc->num_funcs < 2)
+		return;
+
 	/* choose function */
 	value = padctl_readl(padctl, soc->offset);
 	value &= ~(soc->mask << soc->shift);
-- 
2.20.1

