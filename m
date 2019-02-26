Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66DEC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7893B218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551217539;
	bh=6jQC0/omV0h0X6GsVE3RHxCRG/TavBUIzeU/NZBL0cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zc6SSMICH4EYjyf7Eojdmp4habhOFLYsur+nldqIsh5+kbTfb5QpkS66Jh+8vy5Uq
	 2MK4FLBoikjhAwm/vjyldzG9ugXrxExy2Z5KG5hmrgT/IExiGy0PEgJmuwZGM2YYI+
	 Pe1vAAJU5kiFpUrHKR5EQ/lq5C+2clLnc+unK+BE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfBZVpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 16:45:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728727AbfBZVph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 16:45:37 -0500
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E38D8218A1;
        Tue, 26 Feb 2019 21:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551217536;
        bh=6jQC0/omV0h0X6GsVE3RHxCRG/TavBUIzeU/NZBL0cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PXDuOoEs9+MZXe0NGfpbw4NTbS+EvgM8P6GYizBbZsTjO+3oSVgSSpkFtmkQZAhpQ
         5waGpN/ovBrgCEOzbcKfoJoyL34W/edTI2a0TJdEWQwaKzVyHRUCPwBMLEgwQfs+2r
         tbq50vbYOG8bObkly4K2np+lEOnFVVo3cLLz3GCU=
From:   Eric Biggers <ebiggers@kernel.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-kernel@vger.kernel.org,
        syzbot+e73f2fb5ed5a5df36d33@syzkaller.appspotmail.com,
        Laura Abbott <labbott@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>, stable@vger.kernel.org
Subject: [PATCH v2] drm/vgem: fix use-after-free when drm_gem_handle_create() fails
Date:   Tue, 26 Feb 2019 13:44:51 -0800
Message-Id: <20190226214451.195123-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
In-Reply-To: <20190226213053.GC218103@gmail.com>
References: <20190226213053.GC218103@gmail.com>
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
Fixes: af33a9190d02 ("drm/vgem: Enable dmabuf import interfaces")
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/gpu/drm/vgem/vgem_drv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
index 5930facd6d2d8..11a8f99ba18c5 100644
--- a/drivers/gpu/drm/vgem/vgem_drv.c
+++ b/drivers/gpu/drm/vgem/vgem_drv.c
@@ -191,13 +191,9 @@ static struct drm_gem_object *vgem_gem_create(struct drm_device *dev,
 	ret = drm_gem_handle_create(file, &obj->base, handle);
 	drm_gem_object_put_unlocked(&obj->base);
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

