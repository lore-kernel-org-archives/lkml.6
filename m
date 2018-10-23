Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ECCC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B71A207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oRPQpqnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B71A207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbeJXAPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:15:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37472 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbeJXAP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:15:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id bh10-v6so837561plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3eeg4cPMpf6ZO8A2CN8XTlIX+ceIdjQJrEvIG6Ts4Fw=;
        b=oRPQpqnBjUdrfV6xGscSNy217s+6s+q1t3/C6B54OBKvGWmOVMTvue/7ZRTw14c7lA
         64yV15lGLRrnHk1qEsa8MBe/bX2aQRgjOMAhRQ6YAUQlsTG8d0Rh3upAk60TUz0zsFUy
         JmMHDzKKepsvrMuq4ggQOPcxHKNPgSuhdrbF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3eeg4cPMpf6ZO8A2CN8XTlIX+ceIdjQJrEvIG6Ts4Fw=;
        b=SJaGeF3cEjOk8HRfDwfudQAP/2dG5GQDX1ROIaUmt0KGVcb/BI4FuedgRuwrEbMR18
         P+HW4qTLPnAaozzXH/8hg1vTmrkuaa5bwlPyTyBT8F0rZnndEmbES8mx0tCZay9/zDqx
         yHgLKYo7i1IWLizzbqhgksMETNAhRLZXXy5CEvzkpLu3sR7XCfGUv/NViHF1OhLciafm
         MmRQkC9ec+eKzCYKl+tEvn5BafYTX2/bPZ/l7ggwEJHgwVDW3PoO1PBoRG9lAxVsmA9t
         RHCHjeqZQHoSr3ht7VWWs1uNyOQUVRSD58b2h4Nwcs0u2jtUyKvO7GQn1dm+8/9v5WLI
         J3UQ==
X-Gm-Message-State: AGRZ1gIn5F0jA4/Tcb5Cf0Jg2Es/dAZjdZArBP249ipwMoU+Zn/qRPFV
        HlBP2iaNSIc/tDAft5smC53hTA==
X-Google-Smtp-Source: AJdET5ftv9r5/C4cgca0UT1ygc5rqgGsXmjPT9QBWKUbhGijsZbwSf027FciwTHWChSaUtVbZfzyOQ==
X-Received: by 2002:a17:902:66e5:: with SMTP id e92-v6mr3353277plk.92.1540309892881;
        Tue, 23 Oct 2018 08:51:32 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id o75-v6sm7442829pfg.0.2018.10.23.08.51.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 08:51:32 -0700 (PDT)
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
Subject: [PATCH v2 06/15] drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short write 2 param transfer
Date:   Tue, 23 Oct 2018 21:20:26 +0530
Message-Id: <20181023155035.9101-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181023155035.9101-1-jagan@amarulasolutions.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
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
Changes for v2:
- drop dev_err
- add macro in alphabetical

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 8e9c76febca2..fc8560607147 100644
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

