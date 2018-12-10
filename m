Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B18DC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E335C2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iUDo70yl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E335C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbeLJQR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:17:58 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32901 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbeLJQRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:17:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so6988092wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0G2Cm6yl0hA4By0n3opJjvWD4CEYft0z/6JnEL+u5rs=;
        b=iUDo70ylsxbw31KSTQNl5zLd47rgtT8gzDjZUFM2Uytf7J7H3BEaghRCvwtYg0Smek
         91cLB4+6QeyZXk1lRnruo/ODwDJBb2HRJEunozV+R27S0bDcVNJurGw/myGHdHQbF7iM
         g+c6gYO4UxF2sNQUpTrLdQLx1vYxqOd5Rc01M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0G2Cm6yl0hA4By0n3opJjvWD4CEYft0z/6JnEL+u5rs=;
        b=aDlM5p5Tt1pXWVMGO/WTp8xwMlZp03haHEc4aI42gLylONl5JVpEVzJ1eAA2ELcdff
         8uV/VA4hvMQpN4hRRH0KsoGbuCR+d3gCJPfzEUsHEZb1otX/yaOj3T6xhu2Hx/4SdJLZ
         otbBz/8J4COm2vhDqerhQA+1h9NXkHN7Yd62D3I3tuYATaeQQyr932nD2/JLials1xqs
         SuP0gTxryGp+nd5uu+zfB0cG4PxYs7kRu4VPioZnxAdtrd3dlFj7K9Sh6mTHlgafvyY/
         lbCDOdo+WlGUiq02ECmC55c347knoqkk3/xKw0eZzjUcltDNwLxQVPOsnqeivkt4SuZq
         911w==
X-Gm-Message-State: AA+aEWZadXzmz9k8KA/oHbmeWu7j6j9RjgVXpFoJo1LiEwbTQRuY5rBn
        mr6OIp3/pYmUthpWAWfvNROeYA==
X-Google-Smtp-Source: AFSGD/VgVCcVXfXR6IgQH8Ctvc2lTvygISQ8DSmGKfU4RYD/M85sJu1tV6MPzTuEmSwpAC8ZIb3/IQ==
X-Received: by 2002:a1c:990c:: with SMTP id b12mr11709720wme.106.1544458673231;
        Mon, 10 Dec 2018 08:17:53 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com. [213.198.162.59])
        by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:17:52 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 05/17] drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short write 2 param transfer
Date:   Mon, 10 Dec 2018 21:47:17 +0530
Message-Id: <20181210161729.29720-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
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

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 50f535ae57e9..cdd44a1307b3 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -871,6 +871,7 @@ static ssize_t sun6i_dsi_transfer(struct mipi_dsi_host *host,
 	switch (msg->type) {
 	case MIPI_DSI_DCS_SHORT_WRITE:
 	case MIPI_DSI_DCS_SHORT_WRITE_PARAM:
+	case MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM:
 		ret = sun6i_dsi_dcs_write_short(dsi, msg);
 		break;
 
-- 
2.18.0.321.gffc6fa0e3

