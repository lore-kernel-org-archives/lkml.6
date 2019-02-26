Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6174BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2177A21850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551214179;
	bh=VS8jlFSPrAR/4fBl2zpXd+tqA6b2F0cLVXZ7ij6dvmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XexisomIudMNW8qL1VZNtXsRCgS8p8PDqipu/ziVUnWQrC8ojSVnc6bKr7YHNUC9S
	 hvv5cmytKctOlL1e0IqrH3leWO0ljz8Dcs9ztDQmgYo906c3lFFYaz7jQu/oF0cVL7
	 ma+DTD+BTiGreGHt+8BLFe9p1WWoKX10kkLYrZpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbfBZUth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:49:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:37408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727823AbfBZUth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:49:37 -0500
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BC3E21873;
        Tue, 26 Feb 2019 20:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551214176;
        bh=VS8jlFSPrAR/4fBl2zpXd+tqA6b2F0cLVXZ7ij6dvmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UIOeve8JiDVxwY3B7KducRsC6ZVAShyagQlxBnB339u/4l5bsfdU1ToxNQuVAXsqg
         4/ZTDZkngbNLlszhpSeYCZfwNNuLxnKVmSGOlMJg1NuR9IdBHRrgA36QVRKt+qAVqq
         6N5I200ZeRGMzOc0zBxrM4w2g+W8ErAEdoqtrn8w=
From:   Eric Biggers <ebiggers@kernel.org>
To:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vgem: fix use-after-free when drm_gem_handle_create() fails
Date:   Tue, 26 Feb 2019 12:47:26 -0800
Message-Id: <20190226204726.92256-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
In-Reply-To: <CACT4Y+bnxrCTD=s9X6+JdjkV_gS=qZ99WhJsWypP88af3HzMhw@mail.gmail.com>
References: <CACT4Y+bnxrCTD=s9X6+JdjkV_gS=qZ99WhJsWypP88af3HzMhw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

If drm_gem_handle_create() fails in vgem_gem_create(), then the
drm_vgem_gem_object is freed twice: once when the reference is dropped
by drm_gem_object_put_unlocked(), and again by __vgem_gem_destroy().

This was hit by syzkaller using fault injection.

Fix it by skipping the second free.

Reported-by: syzbot+e73f2fb5ed5a5df36d33@syzkaller.appspotmail.com
Fixes: 5ba6c9ff961a ("drm/vgem: Fix mmaping")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/gpu/drm/vgem/vgem_drv.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
index 5930facd6d2d8..70646d9da1596 100644
--- a/drivers/gpu/drm/vgem/vgem_drv.c
+++ b/drivers/gpu/drm/vgem/vgem_drv.c
@@ -189,15 +189,13 @@ static struct drm_gem_object *vgem_gem_create(struct drm_device *dev,
 		return ERR_CAST(obj);
 
 	ret = drm_gem_handle_create(file, &obj->base, handle);
+
 	drm_gem_object_put_unlocked(&obj->base);
+
 	if (ret)
-		goto err;
+		return ERR_PTR(ret);
 
 	return &obj->base;
-
-err:
-	__vgem_gem_destroy(obj);
-	return ERR_PTR(ret);
 }
 
 static int vgem_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

