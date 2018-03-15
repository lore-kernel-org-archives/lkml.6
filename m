Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752497AbeCOOZ7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:25:59 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34243 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbeCOOZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:25:55 -0400
X-Google-Smtp-Source: AG47ELt7LGN29nacxCFDbZMpA7TrlCIN+eE9DDU7ygD+b0uPSKaeXdCW0+zHG47G9cOfkri7CtmmQw==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/tegra: plane: Keep 'dependent' blending state of unaffected planes
Date: Thu, 15 Mar 2018 17:24:31 +0300
Message-Id: <ebc6aef3f5cd7b9b9bb25ceff9e86e742390cfca.1521121707.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This way new state takes into account the current state of unaffected
(by the atomic commit) planes.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

v2: Dropped unrelated 'cleanup' changes and fixed
    s/state->dependent[i]/state->dependent[index]/ typo.

 drivers/gpu/drm/tegra/plane.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
index fc37dcf8c458..0784422cc5a2 100644
--- a/drivers/gpu/drm/tegra/plane.c
+++ b/drivers/gpu/drm/tegra/plane.c
@@ -315,9 +315,6 @@ void tegra_plane_check_dependent(struct tegra_plane *tegra,
 	unsigned int zpos[2];
 	unsigned int i;
 
-	for (i = 0; i < 3; i++)
-		state->dependent[i] = false;
-
 	for (i = 0; i < 2; i++)
 		zpos[i] = 0;
 
@@ -331,6 +328,8 @@ void tegra_plane_check_dependent(struct tegra_plane *tegra,
 
 		index = tegra_plane_get_overlap_index(tegra, p);
 
+		state->dependent[index] = false;
+
 		/*
 		 * If any of the other planes is on top of this plane and uses
 		 * a format with an alpha component, mark this plane as being
-- 
2.16.1
