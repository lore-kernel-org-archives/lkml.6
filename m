Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751565AbeBOFUZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 00:20:25 -0500
Received: from gateway20.websitewelcome.com ([192.185.62.46]:49989 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750743AbeBOFUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 00:20:23 -0500
Date: Wed, 14 Feb 2018 23:20:00 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] drm/amdgpu_gem: fix error handling path in
 amdgpu_gem_va_update_vm
Message-ID: <20180215052000.GA25691@embeddedgus>
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
X-Source-IP: 189.175.4.238
X-Source-L: No
X-Exim-ID: 1emBxh-002rU9-9N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.4.238]:45954
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if amdgpu_vm_bo_update() fails, the returned error
is being ignored.

Fix this by properly checking _r_ after calling amdgpu_vm_bo_update.
Also, remove redundant code just before label _error_.

Addresses-Coverity-ID: 1464280 ("Unused value")
Fixes: 0abc6878fc2d ("drm/amdgpu: update VM PDs after the PTs")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index e48b4ec..db85fc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -523,12 +523,13 @@ static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 		goto error;
 
 	if (operation == AMDGPU_VA_OP_MAP ||
-	    operation == AMDGPU_VA_OP_REPLACE)
+	    operation == AMDGPU_VA_OP_REPLACE) {
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
+		if (r)
+			goto error;
+	}
 
 	r = amdgpu_vm_update_directories(adev, vm);
-	if (r)
-		goto error;
 
 error:
 	if (r && r != -ERESTARTSYS)
-- 
2.7.4
