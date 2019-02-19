Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F673C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C6F21736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfBSPBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:01:36 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56237 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfBSPBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:01:36 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gw6tl-0008Fe-UA; Tue, 19 Feb 2019 15:01:30 +0000
From:   Colin King <colin.king@canonical.com>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/i915/selftests: fix memory leak of 'spin'
Date:   Tue, 19 Feb 2019 15:01:29 +0000
Message-Id: <20190219150129.12728-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a memory leak of 'spin' on an error return path. Fix this by
kfree'ing spin before the return.

Fixes: c06ee6ff2cbc ("drm/i915/selftests: Context SSEU reconfiguration tests")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/i915/selftests/i915_gem_context.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_gem_context.c b/drivers/gpu/drm/i915/selftests/i915_gem_context.c
index d00d0bb07784..cf988797bb17 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_context.c
@@ -725,8 +725,10 @@ __sseu_prepare(struct drm_i915_private *i915,
 		}
 
 		ret = igt_spinner_init(spin, i915);
-		if (ret)
+		if (ret) {
+			kfree(spin);
 			return ret;
+		}
 
 		rq = igt_spinner_create_request(spin, ctx, engine, MI_NOOP);
 		if (IS_ERR(rq)) {
-- 
2.20.1

