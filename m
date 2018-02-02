Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751797AbeBBMce (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 07:32:34 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.108]:44338 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751546AbeBBMc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 07:32:26 -0500
Date: Fri, 2 Feb 2018 06:32:23 -0600
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] drm/msm/adreno/a5xx_debugfs: fix potential NULL pointer
 dereference
Message-ID: <20180202123223.GA4410@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.152.201.65
X-Source-L: No
X-Exim-ID: 1ehaW1-001tmn-1c
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.152.201.65]:44546
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_minor_ is being dereferenced before it is null checked, hence there
is a potential null pointer dereference. Fix this by moving the pointer
dereference after _minor_ has been null checked.

Fixes: 024ad8df763f ("drm/msm: add a5xx specific debugfs")
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---

I wonder if a better solution for this would be to WARN_ON in case _minor_
happens to be NULL and return -EINVAL, instead of just returning zero.

Something like:

struct drm_device *dev;

if (WARN_ON(!minor)
	return -EINVAL;

dev = minor->dev;

What do you think?

Thanks


 drivers/gpu/drm/msm/adreno/a5xx_debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c b/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c
index 6b27941..059ec7d 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c
@@ -159,13 +159,15 @@ DEFINE_SIMPLE_ATTRIBUTE(reset_fops, NULL, reset_set, "%llx\n");
 
 int a5xx_debugfs_init(struct msm_gpu *gpu, struct drm_minor *minor)
 {
-	struct drm_device *dev = minor->dev;
+	struct drm_device *dev;
 	struct dentry *ent;
 	int ret;
 
 	if (!minor)
 		return 0;
 
+	dev = minor->dev;
+
 	ret = drm_debugfs_create_files(a5xx_debugfs_list,
 			ARRAY_SIZE(a5xx_debugfs_list),
 			minor->debugfs_root, minor);
-- 
2.7.4
