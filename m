Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753262AbeDRKkG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 06:40:06 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38953 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753100AbeDRKkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 06:40:05 -0400
X-Google-Smtp-Source: AIpwx49WppBMhPc1Gau8MlybXVWI6PrgYfaQIL3Llf9yJFMNtsl6tnBa7KTOZ0S4X3OeqPRz7lwJbw==
From: Stefan Schake <stschake@gmail.com>
To: thierry.reding@gmail.com
Cc: airlied@linux.ie, jonathanh@nvidia.com,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Schake <stschake@gmail.com>
Subject: [PATCH] drm/tegra: hub: Use state directly
Date: Wed, 18 Apr 2018 03:40:19 -0700
Message-Id: <20180418104019.31344-1-stschake@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using drm_atomic_get_private_obj_state after state has been swapped
will return old state.

Fixes: 0281c4149021 ("drm/tegra: hub: Use private object for global state")
Signed-off-by: Stefan Schake <stschake@gmail.com>
---
 drivers/gpu/drm/tegra/hub.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
index 9a3f23d4780f..bdd2cdd0745c 100644
--- a/drivers/gpu/drm/tegra/hub.c
+++ b/drivers/gpu/drm/tegra/hub.c
@@ -683,12 +683,11 @@ void tegra_display_hub_atomic_commit(struct drm_device *drm,
 {
 	struct tegra_drm *tegra = drm->dev_private;
 	struct tegra_display_hub *hub = tegra->hub;
-	struct tegra_display_hub_state *hub_state;
+	struct tegra_display_hub_state *hub_state =
+		to_tegra_display_hub_state(hub->base.state);
 	struct device *dev = hub->client.dev;
 	int err;
 
-	hub_state = tegra_display_hub_get_state(hub, state);
-
 	if (hub_state->clk) {
 		err = clk_set_rate(hub_state->clk, hub_state->rate);
 		if (err < 0)
-- 
2.14.1
