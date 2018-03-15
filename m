Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeCOBBx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 21:01:53 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42969 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751547AbeCOBBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 21:01:47 -0400
X-Google-Smtp-Source: AG47ELu75Eu49soURrZ4xNpi9fxPFVu5kza1N7N3lzzE2psXFTs6sqtObyID1olugdwYlg51lWBPVw==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] drm/tegra: plane: Correct legacy blending
Date: Thu, 15 Mar 2018 04:00:24 +0300
Message-Id: <00cf4565238be471c90e5823e53e0ed504869bfe.1521075485.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <8d9c7220b1d2cf126bd2030e5d232ec06f761440.1521075485.git.digetx@gmail.com>
References: <8d9c7220b1d2cf126bd2030e5d232ec06f761440.1521075485.git.digetx@gmail.com>
In-Reply-To: <8d9c7220b1d2cf126bd2030e5d232ec06f761440.1521075485.git.digetx@gmail.com>
References: <8d9c7220b1d2cf126bd2030e5d232ec06f761440.1521075485.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep old 'dependent' state of unaffected planes, this way new state takes
into account current state of unaffected planes.

Fixes: ebae8d07435a ("drm/tegra: dc: Implement legacy blending")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/plane.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
index fc37dcf8c458..3c0cb6a04c66 100644
--- a/drivers/gpu/drm/tegra/plane.c
+++ b/drivers/gpu/drm/tegra/plane.c
@@ -287,13 +287,11 @@ unsigned int tegra_plane_format_adjust(unsigned int opaque)
 	return opaque;
 }
 
-unsigned int tegra_plane_get_overlap_index(struct tegra_plane *plane,
-					   struct tegra_plane *other)
+static unsigned int tegra_plane_get_overlap_index(struct tegra_plane *plane,
+						  struct tegra_plane *other)
 {
 	unsigned int index = 0, i;
 
-	WARN_ON(plane == other);
-
 	for (i = 0; i < 3; i++) {
 		if (i == plane->index)
 			continue;
@@ -310,18 +308,15 @@ unsigned int tegra_plane_get_overlap_index(struct tegra_plane *plane,
 void tegra_plane_check_dependent(struct tegra_plane *tegra,
 				 struct tegra_plane_state *state)
 {
-	struct drm_plane_state *old, *new;
+	struct drm_plane_state *new;
 	struct drm_plane *plane;
 	unsigned int zpos[2];
 	unsigned int i;
 
-	for (i = 0; i < 3; i++)
-		state->dependent[i] = false;
-
 	for (i = 0; i < 2; i++)
 		zpos[i] = 0;
 
-	for_each_oldnew_plane_in_state(state->base.state, plane, old, new, i) {
+	for_each_new_plane_in_state(state->base.state, plane, new, i) {
 		struct tegra_plane *p = to_tegra_plane(plane);
 		unsigned index;
 
@@ -331,6 +326,8 @@ void tegra_plane_check_dependent(struct tegra_plane *tegra,
 
 		index = tegra_plane_get_overlap_index(tegra, p);
 
+		state->dependent[i] = false;
+
 		/*
 		 * If any of the other planes is on top of this plane and uses
 		 * a format with an alpha component, mark this plane as being
-- 
2.16.1
