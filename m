Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE8BC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B785D20672
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TcqF69Ce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B785D20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbeLDSEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:04:48 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43116 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeLDSEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:04:48 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so8597522pfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 10:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qCJFFS6Aem8oBZGbr8g7FAKf5TobHEublKm03jHyLoA=;
        b=TcqF69CeqZkccner/LnGHbd+bVeM/py9aiVIH9Ynvv14pkr/n9x5UfjHfafxU4vKRX
         e3K/l1+lF/alyFp7X06IScPs/1I/0odRHyRBd/xkRwad5BaJY2c70TldC32mLzX0360v
         Lzm1aVaPEVTY8VcKcnbny17u+AKae1r0PNYto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qCJFFS6Aem8oBZGbr8g7FAKf5TobHEublKm03jHyLoA=;
        b=We1mT0I3WGGWary7RN8n6x7rgE4XFPJwlPnoMKSSoGQy7wRzqZKHQSIlVO8Wf9PJ5i
         ePIalnh5nGmkV6R7bphRp0Xj2d1gLfyb8gHDTXiQlUQiMhjg9pvIE8sFE5K9VgVJwFjl
         m6DaHZxJoOiit5b9EK3f+PTNsEyQl2lmnviWN0B0+zNU5Kx+P5yB0aCv0vxyOTFSMWH3
         C5B2unyr/XmJCIJoU1hLh2p9egBKSwbE1u1ICnu84BVVeUKY4A4wo/CjMXwI0zqslWh1
         v4PXtcyMQwLeu/uhfv084cf84NwvWQ4b4EVHcSuV5GqAObWOG9EiUiGZpKxFPrmyp6r6
         ijSA==
X-Gm-Message-State: AA+aEWZlBzE4h9mRnTONQDPeBwcWRYTvP0yMq4q865ry9OpnGb3XoHx4
        jwOZSNFfmTWTEL6IWvQdKsWDSw==
X-Google-Smtp-Source: AFSGD/Uys9k+5ZOk+PNf5vLhfAG9BfmBbeHsPSixY7hSs0srLwaRXBSIbWWkc3v67nGjcQQlG/k6DQ==
X-Received: by 2002:a63:6205:: with SMTP id w5mr17528906pgb.53.1543946686548;
        Tue, 04 Dec 2018 10:04:46 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id u137sm35861805pfc.140.2018.12.04.10.04.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 10:04:45 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <seanpaul@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, jcrouse@codeaurora.org,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        freedreno@lists.freedesktop.org
Subject: [PATCH] drm/msm: Only add available components
Date:   Tue,  4 Dec 2018 10:04:41 -0800
Message-Id: <20181204180441.218160-1-dianders@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to get the display up on my sdm845 board I noticed that
the display wouldn't probe if I had the dsi1 node marked as "disabled"
even though my board doesn't use dsi1.  It looks like the msm code
adds all nodes to its list of components even if they are disabled.  I
believe this doesn't work because all registered components need to
come up before we finish probing.  Let's do like other DRM code and
only add available components.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/msm/msm_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index b1577e960889..0b828822117b 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1190,8 +1190,10 @@ static int add_components_mdp(struct device *mdp_dev,
 		if (!intf)
 			continue;
 
-		drm_of_component_match_add(master_dev, matchptr, compare_of,
-					   intf);
+		if (of_device_is_available(intf))
+			drm_of_component_match_add(master_dev, matchptr,
+						   compare_of, intf);
+
 		of_node_put(intf);
 	}
 
-- 
2.20.0.rc1.387.gf8505762e3-goog

