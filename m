Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD39C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407D721470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dGewkU0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407D721470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeJDPe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:34:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54500 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeJDPe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:34:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id r63-v6so8203358wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 01:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=idaWRkEFhu8FCWVI7562+doAd1DdMTI5+qXSW+PyLF4=;
        b=dGewkU0gGsOoqX+gJ9cYZgWcA88Nn9U/rwBdKcWT8hxaaWRRm22g/6eBmASCHClev5
         Q9fh3JpCkeF9t25FyK5pmIbqAaBSbIcz/3kwIqON3l3Px3WoRtYhGjgvh5VJOMz6WL65
         grg4xvI817rHlEhgacI5hDGnQ3AU73EWVEIISZKNMILVDPCYZelc7xCBssVwMMxi+u9L
         tXTM5LoDSO0o6B1hEZGYR0edMDPb+LuxVDE0gDzDZOAQ+qZXwvNUjna7iFRbz+4EwB7/
         gKjRX+zvfSLfE732ujxE7hEPX9H2AY9So6yRT2h5KkE7tOFkWwVOKxC0cqp5cHOYxZxJ
         KSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=idaWRkEFhu8FCWVI7562+doAd1DdMTI5+qXSW+PyLF4=;
        b=s0jZnQ/4CbM7eBK5PJ/nU3xx5bSb5N0p2Jfz8fLmv1+S+JiHBl8xFZeMXYmypDo3oi
         Rkjd9zVgdUZBm9f9l4/ONBY/C3Pa4tiOYwjQKB6dWgdwqddi9StN7peGz2mfTVBOgc8z
         kL+0CBVeLMahn2XH6L7Qy8u/cMvIoOcDlWsjlW2OZ0o+tvsyrDTziwNu7nrsuF67lkCF
         Q5qcSYf3TRE1Pp7tLfRLLAmFOc4yJc/MW8q5UM6IcSbtfTJme7MmUJvAL7Shhamq+rMW
         3a6XN3XCMSujkNF8UNjqG9I8WhLp07x16P79lYd4m5pTVLUNKh1yCqCQnY161kvcpq2M
         Zlqg==
X-Gm-Message-State: ABuFfoivUBaQCw2BMnz36Sa+Yomp+zpDx23NkkcyObsEpU0ghUEEkP7t
        qUMZQoWuNbGhSWmfkDsqIR7CMQ==
X-Google-Smtp-Source: ACcGV607+x2/S/c5fmT3kBi9u+bLaDa+2CJ6YNVz7fLtyBfIZJN2yFpqcYLfEw3FaJ/CnOQU1BFqww==
X-Received: by 2002:a1c:88c6:: with SMTP id k189-v6mr3836477wmd.32.1538642566235;
        Thu, 04 Oct 2018 01:42:46 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e34:eeb6:4690:3412:2a4:3cc3:ee11])
        by smtp.gmail.com with ESMTPSA id p11-v6sm3852690wrd.74.2018.10.04.01.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Oct 2018 01:42:45 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/meson: fix max mode_config height/width
Date:   Thu,  4 Oct 2018 10:42:43 +0200
Message-Id: <1538642563-22465-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mode_config max_width/max_height determines the maximum framebuffer
size the pixel reader can handle. But the values were set thinking they
were determining the maximum screen dimensions.

This patch changes the values to the maximum height/width the CANVAS block
can handle rounded to some coherent values.

Fixes: a41e82e6c457 ("drm/meson: Add support for components")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index d344312..2e29968 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -243,8 +243,8 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 		goto free_drm;
 
 	drm_mode_config_init(drm);
-	drm->mode_config.max_width = 3840;
-	drm->mode_config.max_height = 2160;
+	drm->mode_config.max_width = 16384;
+	drm->mode_config.max_height = 8192;
 	drm->mode_config.funcs = &meson_mode_config_funcs;
 
 	/* Hardware Initialization */
-- 
2.7.4

