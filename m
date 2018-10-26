Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E26ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1625D20651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Jyj6k50f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1625D20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbeJZXXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:23:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41872 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbeJZXXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:23:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id p5-v6so616104plq.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n0i8hVr1HP7XLYiUrhAKpcC+p7UJ+a7PvBsZMlOyWQg=;
        b=Jyj6k50fMheXG0QrecuU6ptwpUp49kRk1iermMfawhZOURbTZPrMz0RSVUQN63lVky
         0g3GYJ5kcVuv9Rth752gPEoF8TPJj8q0cJ/DwFIJ4S5OqZNgTAx9T85/LN4JhUTAuLfq
         U8vg4lBvc3uiUshTqaq5N34JlRMfC9O+GNwxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n0i8hVr1HP7XLYiUrhAKpcC+p7UJ+a7PvBsZMlOyWQg=;
        b=PyAX8FLTCfNw59QGyxiy1H7CKFwtJJl3G1se278oXbg4b7uT0u6yo6FRVFesydLL6n
         vDl0PlseqQjgdDqeqy0no1TM85eNnWXfaiFIILKa6dpjCUZkA0SIUsenvCqD7QUFUx75
         Ow23Az6ZoMKB8bLu2CZ0svSR16tzKpMvtvBb/cQ1S8tcmzgLkCXUBFtfx/VEr20lgleO
         QYQgM08d2gIAH2+l8PdarxJrgQVUvuI4bsfjW13ffXct85qAMdZrfbRoIMIurwy+dlGH
         zXtAWR+BRp5xgpjGKcVJNgxQ+5JJVnFtXmQcOgMlvGLgZ+KSh4IKJMaSCPNBrn9N/sJS
         BD8w==
X-Gm-Message-State: AGRZ1gJBJmCRz1dcRr3dvrps+PJKEAxqGj9bXG72W2H5t5fFuTOeh09C
        Irqlae/LsZzWhCRBXMtSiF+ayw==
X-Google-Smtp-Source: AJdET5dlKpiD4p4HlpJuoB3vwRCoSCL+d2k+aWjgIKETuEcEw3+TUhPBfyKp6hMumO9lOdckqFBJfw==
X-Received: by 2002:a17:902:8342:: with SMTP id z2-v6mr3744544pln.147.1540565171026;
        Fri, 26 Oct 2018 07:46:11 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id z22-v6sm12044467pgv.24.2018.10.26.07.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 07:46:10 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
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
Subject: [PATCH v3 21/25] clk: sunxi-ng: a64: Add min and max rate for PLL_MIPI
Date:   Fri, 26 Oct 2018 20:13:40 +0530
Message-Id: <20181026144344.27778-22-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181026144344.27778-1-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manual noted to use PLL_MIPI rate 500MHz to 1.4GHz,
but lowering the min rate by 300MHz can result proper
working nkms divider with the help of desired dclock
rate from panel driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Tested-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- collect Stephen Ack
- add tested credit
Changes for v2:
- none

 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 019d67bf97c4..5a3a5b821f8b 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -167,6 +167,8 @@ static struct ccu_nkm pll_mipi_clk = {
 	.n		= _SUNXI_CCU_MULT(8, 4),
 	.k		= _SUNXI_CCU_MULT_MIN(4, 2, 2),
 	.m		= _SUNXI_CCU_DIV(0, 4),
+	.min_rate	= 300000000,		/* Actual rate is 500MHz */
+	.max_rate	= 1400000000UL,
 	.common		= {
 		.reg		= 0x040,
 		.hw.init	= CLK_HW_INIT("pll-mipi", "pll-video0",
-- 
2.18.0.321.gffc6fa0e3

