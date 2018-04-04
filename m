Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbeDDGiG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 02:38:06 -0400
Received: from m12-18.163.com ([220.181.12.18]:45315 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbeDDGiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 02:38:05 -0400
From: Xidong Wang <wangxidong_97@163.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Xidong Wang <wangxidong_97@163.com>
Subject: [PATCH 1/1] drm/i915:Do not use kfree() to free kmem_cache_alloc() return value
Date: Wed,  4 Apr 2018 14:37:31 +0800
Message-Id: <1522823851-28177-1-git-send-email-wangxidong_97@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EsCowAD389mtcsRaEjcKDQ--.42987S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr48KF4xur1rZr48GFy8Zrb_yoW3ZFbE9a
        4kZr47W398Cw1qv3W3CrW3ZFy2y3ZYvFs29w1xt3yftr1Ivan8Xr9xXry8Zr1fGa1jqFn8
        Xw4kZFs3tr13GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUY0fO7UUUUU==
X-Originating-IP: [106.120.213.14]
X-CM-SenderInfo: pzdqw5xlgr0wrbzxqiywtou0bp/1tbizRIe81c7AcqTnQAAsb
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In eb_lookup_vmas(), lut, the return value of kmem_cache_alloc(), is freed
with kfree().I think the expected paired function is kmem_cache_free().

Signed-off-by: Xidong Wang <wangxidong_97@163.com>
---
 drivers/gpu/drm/i915/i915_gem_execbuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
index 8c170db..08fe476 100644
--- a/drivers/gpu/drm/i915/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
@@ -728,7 +728,7 @@ static int eb_lookup_vmas(struct i915_execbuffer *eb)
 
 		err = radix_tree_insert(handles_vma, handle, vma);
 		if (unlikely(err)) {
-			kfree(lut);
+			kmem_cache_free(lut);
 			goto err_obj;
 		}
 
-- 
2.7.4
