Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC0EC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D582086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlkTjj4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfASIkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 03:40:52 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:47029 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfASIkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 03:40:47 -0500
Received: by mail-lf1-f66.google.com with SMTP id y14so12152827lfg.13
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 00:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+qcOXE5cVDqCuNYXeM4OywdRRJJPc4720wZbAYZ2jys=;
        b=FlkTjj4aLH17uPcQh7r8FTzeigzTV30bxYndnY7oZMMYeZvdxHJmuUBao/SSEBTbGZ
         CUzX3NeodqwQ3GWQm3mmmKDER/87gt9ZSwuweyMx6pDOqFcv80/gEvVp2axEtsQQCBVi
         LVFsvQ+nbJuHq+YMDbbVz2z4jfmnYCcczMm09j++N3IoUeN5Aw6nxcq1DA5JatMEqrif
         Hmgyd01MFCWAgo8SfQbCmQerBrqgNaynI2oUnYG8WxKiKRh6BSFckfrgc74xpVmAQiqh
         0JuMJmUcY/z+koy/jtYw06BqhCzpUj6RFOxOAOobYrcRnl43T2RuCeq/dH/zQSQd/cAh
         yyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=+qcOXE5cVDqCuNYXeM4OywdRRJJPc4720wZbAYZ2jys=;
        b=suYfLhplruG38TjMqo5xTl644RJRkH1tGIgf3ViGxTA1JPrH/RQl1bj3etFcEJNplY
         R8V2x/TnyNkGpKunkK6eRT3KpCh945Vra8Egv25j6r/mU/qdeuejCwjeCiAC12OeTmRl
         AKB/1ExZSYPj3aiEy6BmNPoYbuakZV2W6HZ0tM0MfhorEu9/XHsd3TyyWRcuVkXIsFGj
         c2yBeKEwvw6t6YRjow9jKowvZSg1q2Zhk3sYUy48LqJCeCaA8mVUcH6LYuhBw+O++9AD
         l9uaS/29U+9N35FRpA9lOFzgYEwowUiVQhBE8VzcB4iqXANniR6e+UNxasRV7CK7+BYG
         YVZQ==
X-Gm-Message-State: AJcUukdTCDzsDbQWJlTzuEsDD29I2bXTSPCHVH7KJ0KvvD6iPHppc7Ji
        +5zEeRGWlE50DqDD5Dq0cQg=
X-Google-Smtp-Source: ALg8bN5U2/ZzBfn14Cg4ByxiW5KfoQrFh3dfCbJEAlTLkfO4atSVTwQWSyNiw6G16weKYZgEhA6dKQ==
X-Received: by 2002:a19:59c2:: with SMTP id n185mr13757815lfb.118.1547887244647;
        Sat, 19 Jan 2019 00:40:44 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id p23sm1187109lfh.47.2019.01.19.00.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 00:40:44 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Vincent Abriou <vincent.abriou@st.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/6] drmi/rcar-du: prepare for drmP.h removal from drm_modeset_helper.h
Date:   Sat, 19 Jan 2019 09:40:13 +0100
Message-Id: <20190119084014.5355-6-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190119084014.5355-1-sam@ravnborg.org>
References: <20190119084014.5355-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of drmP.h is discouraged and removal of it from
drm_modeset_helper.h caused rcar-du to fail to build.

This patch introduce the necessary fixes to prepare for the
drmP.h removal from drm_modeset_helper.h.

Build tested on arm x86 and arm allmodconfig.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/rcar-du/rcar_lvds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
index 534a128a869d..8010ed702509 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
-- 
2.12.0

