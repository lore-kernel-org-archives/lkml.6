Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939037AbeE1NBm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:01:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164146AbeE1Kxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:53:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 271/496] drm/tegra: Shutdown on driver unbind
Date: Mon, 28 May 2018 12:00:56 +0200
Message-Id: <20180528100331.274719153@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thierry Reding <treding@nvidia.com>

[ Upstream commit 192b4af6cd28cdad9b42fd79c21a90a2aeb0bec7 ]

Since commit 846c7dfc1193 ("drm/atomic: Try to preserve the crtc enabled
state in drm_atomic_remove_fb, v2."), removing the last framebuffer will
no longer disable the corresponding pipeline, which causes the KMS core
to complain about leaked connectors on driver unbind.

Fix this by calling drm_atomic_helper_shutdown() on driver unbind, which
will cause all display pipelines to be shut down and therefore drop the
extra references on the connectors.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/tegra/drm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -250,6 +250,7 @@ static void tegra_drm_unload(struct drm_
 
 	drm_kms_helper_poll_fini(drm);
 	tegra_drm_fb_exit(drm);
+	drm_atomic_helper_shutdown(drm);
 	drm_mode_config_cleanup(drm);
 
 	err = host1x_device_exit(device);
