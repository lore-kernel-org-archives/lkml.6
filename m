Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564EAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF84206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 15:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWHhyDGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfBXPer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 10:34:47 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45289 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfBXPer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 10:34:47 -0500
Received: by mail-lf1-f65.google.com with SMTP id h10so5008712lfc.12;
        Sun, 24 Feb 2019 07:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MCiOM8z5yHs6ziH/t2CxnPow0VQL7UWCL+qFAhR9opY=;
        b=iWHhyDGmDCUZFWPJoZ+KzoWjKOUTFvuqXrnq30jrhNllLimLWAtc5esDY73OsJ+Lc3
         5BVY6a9/4pndnoUQin5gWRCM9oPY7bnqr7rxidlqc/KK9NQ9yR76XmigFAUxLbTxaNCm
         uzwwZNHywnTbxE2IlClJGhHKZJsjHdNhhjY6ARCfcDIZFWcCiVGEYOtT1f6E57I84p6C
         DzHUR8wDhzcnO6yJZTMs+mRAe1o8xpqt39vgRcaMbjn/wIA5hGt7xVIPeCfPdMs1lAyT
         peHNzKJasG7R6NgPWxybB3omPrl9c1v8HLornXZk0mIKs4nrvDpmNzuOP1JOcks8322k
         1i/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MCiOM8z5yHs6ziH/t2CxnPow0VQL7UWCL+qFAhR9opY=;
        b=uZcB0mAa1q7fosMLenj7o2w8An+cNTw/c5U60aFb7yZa8/G6j+PRyN65g4z4eyt5/G
         /+slcc/1zyLlFgvy/o0Rt8PsnI8E/pM0Hy2ju5FqTcihZePtQqlKKqgJftQPEefwdKaw
         gRIXY35MsuXHTV0ve/rZUy/+ho9sV9WeEwYCJh5RN77yhrTUambi2Rg4Gz9uamffm7rS
         IE6Oq/AZzdMKOLC6blyw97D+Ng3Cuo5LnO6fTCqYFC/v/EcFbIJkTLxzwlq0FKic4Ma3
         vgHopl5AClUOoL9b6YyyvzTmKPXsmf6j8ObeEsRK8JdNbc0KbpISv8YlDyQ9sGYE1rPx
         Gk9g==
X-Gm-Message-State: AHQUAuaKBJ/5Rst7fRppH4+fTcrSL723aA4ewKWn2qDR6QpZaO2JN25O
        pYzeAWbIx9P7XBbxka2WW/0=
X-Google-Smtp-Source: AHgI3IZkaposEfdZSCZUX2HGWAxmZiOYETDipZyCQTlB2gzMfaYpUCpf4IqpIQRE2bc0J7zjz2kiKg==
X-Received: by 2002:a19:7b0e:: with SMTP id w14mr7953982lfc.8.1551022484799;
        Sun, 24 Feb 2019 07:34:44 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id c190sm1145744lfg.84.2019.02.24.07.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 07:34:44 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] drm/tegra: plane: Remove format-modifier checking
Date:   Sun, 24 Feb 2019 18:34:05 +0300
Message-Id: <20190224153405.8447-1-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tiling modifier can't be applied to YV12 video overlay because all tiling
modifiers are filtered out for multi-plane formats. AFAIK, all modifiers
should work with all of formats, hence the checking is incorrect and
simply not needed.

Fixes: e90124cb46bdb ("drm/tegra: plane: Support format modifiers")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/plane.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
index d068e8aa3553..5a8a3387f5ee 100644
--- a/drivers/gpu/drm/tegra/plane.c
+++ b/drivers/gpu/drm/tegra/plane.c
@@ -72,21 +72,6 @@ static void tegra_plane_atomic_destroy_state(struct drm_plane *plane,
 	kfree(state);
 }
 
-static bool tegra_plane_format_mod_supported(struct drm_plane *plane,
-					     uint32_t format,
-					     uint64_t modifier)
-{
-	const struct drm_format_info *info = drm_format_info(format);
-
-	if (modifier == DRM_FORMAT_MOD_LINEAR)
-		return true;
-
-	if (info->num_planes == 1)
-		return true;
-
-	return false;
-}
-
 const struct drm_plane_funcs tegra_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
@@ -94,7 +79,6 @@ const struct drm_plane_funcs tegra_plane_funcs = {
 	.reset = tegra_plane_reset,
 	.atomic_duplicate_state = tegra_plane_atomic_duplicate_state,
 	.atomic_destroy_state = tegra_plane_atomic_destroy_state,
-	.format_mod_supported = tegra_plane_format_mod_supported,
 };
 
 int tegra_plane_state_add(struct tegra_plane *plane,
-- 
2.20.1

