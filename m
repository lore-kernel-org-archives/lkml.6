Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52476C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B61921531
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Z0oF4OD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B61921531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeI0SHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:07:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34246 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbeI0SHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:07:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id d19-v6so1801758pgv.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 04:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zrFpat5SwIdegq1NOT/FqyMYxxQkp+FdL7Qi1lHha3A=;
        b=Z0oF4OD/xPjfnwHbof7mvGPMGhxlEan1hfyrqRq7JENuXZC9h4LjOoTiqlRxUWdUxN
         p8SDzPUJ2sJMbEpKcW97Zhls0ty7T/ToGdsGIJQ7iB/wjFe21Pe+e2f6flCx5MDX5Shv
         RvSzdDCL2YTArUSciF0JSiu7AGPza5ThoV4UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zrFpat5SwIdegq1NOT/FqyMYxxQkp+FdL7Qi1lHha3A=;
        b=N7RI16rzsuX/vQbdRvLFPteXN7m1zvOzBeWrs9ebL+++wsQCutRVqHkn3pfHxAEXlQ
         mZVbgKatO6OorJTTvHbr4xWQDGnH2dHxmTAFI5twvPOhQ/0okYAOuZ7axCDZN48Pl73b
         qw872BaXrfm5ItqNxLiACkI9Ns2QMgCs2KkyrzzAvPyFUxiujKSdRUiixIzQKthv81+F
         JIewmE6RIKi5HSTZOKSPhLc82KRdw0kyuUI1bnyBcn2vua7takXAszGNJrVOVWykfHy/
         gkxhqyjYSwECye8lADSkshV4j7+fvIK23kN5ZMoqd8T/kngAy21cN/10S04IYTE94je5
         F3gQ==
X-Gm-Message-State: ABuFfoh0KWIIsN2shZ4tRFOVNimUXGzwYm9bomZmHzjpzrglrwL0EUVK
        or46/k3oK1ApXvf3Oc9aaNPoVKVMZVg=
X-Google-Smtp-Source: ACcGV626P/nIK+nl+dkDoqQjr+hcyM7N1R7kYzYQ5ARGgoyJI2iLlyCEw7XW8Yt5xZz+B6o7DvvjKQ==
X-Received: by 2002:a65:5304:: with SMTP id m4-v6mr10083218pgq.250.1538048990484;
        Thu, 27 Sep 2018 04:49:50 -0700 (PDT)
Received: from localhost.localdomain ([183.82.230.83])
        by smtp.gmail.com with ESMTPSA id v36-v6sm3744872pgn.85.2018.09.27.04.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 04:49:49 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 05/12] drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short write 2 param transfer
Date:   Thu, 27 Sep 2018 17:18:43 +0530
Message-Id: <20180927114850.24565-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20180927114850.24565-1-jagan@amarulasolutions.com>
References: <20180927114850.24565-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Short transfer write support for DCS and Generic transfer types
share similar way to process command sequence in DSI block so
add generic write 2 param transfer type macro so-that the panels
which are requesting similar transfer type may process properly.

Also added error check for unsupporting transfer types this make
debugging easy for new transfer types.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 156b371243c6..1c7e42015645 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -869,6 +869,7 @@ static ssize_t sun6i_dsi_transfer(struct mipi_dsi_host *host,
 		     SUN6I_DSI_CMD_CTL_TX_FLAG);
 
 	switch (msg->type) {
+	case MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM:
 	case MIPI_DSI_DCS_SHORT_WRITE:
 	case MIPI_DSI_DCS_SHORT_WRITE_PARAM:
 		ret = sun6i_dsi_dcs_write_short(dsi, msg);
@@ -885,6 +886,8 @@ static ssize_t sun6i_dsi_transfer(struct mipi_dsi_host *host,
 		}
 
 	default:
+		dev_err(dsi->dev, "unsupported message type 0x%02x\n",
+			msg->type);
 		ret = -EINVAL;
 	}
 
-- 
2.18.0.321.gffc6fa0e3

