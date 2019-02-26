Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C01C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B21921873
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 22:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551218972;
	bh=nAWKJVnGFlVIF8CgK1I4DdB1l4VNvxVN31ahu5HL3UA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BwtMVxCsp9SpMFT5SI/FBseoQR5ll5IKXNOUpwbWjsi6n3epMoEUCiERjUYpKyNsz
	 aNBVDsiLSlhzZtmmZufq6PaHcA/3pyxDi7pewnbgFbJZlezb3+mP+843LWz03Q8Mxe
	 1Bk2OCNAyBpk2JZLayYgzkO+TKooKAB3Akv7qwGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbfBZWJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 17:09:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:44714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbfBZWJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 17:09:30 -0500
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 254D72146F;
        Tue, 26 Feb 2019 22:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551218969;
        bh=nAWKJVnGFlVIF8CgK1I4DdB1l4VNvxVN31ahu5HL3UA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=05h2ohzKBEH0wwOHfZ44YT4D6kdeU9zel4+3F1iNAS4IFmmEvO9IrtRZ5UJ1/IeyL
         r/PO5PTMP92OX0FXUa9Va/OQ1viQUcCp1YEsIoHep8fACc8wzPzTG4qg+YHXf95HYn
         Oz+Rx2Cpyx1fozuVkL2gczCb5y4aCl7bIXtFeoaw=
From:   Eric Biggers <ebiggers@kernel.org>
To:     dri-devel@lists.freedesktop.org
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-kernel@vger.kernel.org,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>, stable@vger.kernel.org
Subject: [PATCH] drm/vkms: fix use-after-free when drm_gem_handle_create() fails
Date:   Tue, 26 Feb 2019 14:08:58 -0800
Message-Id: <20190226220858.214438-1-ebiggers@kernel.org>
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

If drm_gem_handle_create() fails in vkms_gem_create(), then the
vkms_gem_object is freed twice: once when the reference is dropped by
drm_gem_object_put_unlocked(), and again by the extra calls to
drm_gem_object_release() and kfree().

Fix it by skipping the second release and free.

This bug was originally found in the vgem driver by syzkaller using
fault injection, but I noticed it's also present in the vkms driver.

Fixes: 559e50fd34d1 ("drm/vkms: Add dumb operations")
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/gpu/drm/vkms/vkms_gem.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_gem.c b/drivers/gpu/drm/vkms/vkms_gem.c
index 138b0bb325cf9..69048e73377dc 100644
--- a/drivers/gpu/drm/vkms/vkms_gem.c
+++ b/drivers/gpu/drm/vkms/vkms_gem.c
@@ -111,11 +111,8 @@ struct drm_gem_object *vkms_gem_create(struct drm_device *dev,
 
 	ret = drm_gem_handle_create(file, &obj->gem, handle);
 	drm_gem_object_put_unlocked(&obj->gem);
-	if (ret) {
-		drm_gem_object_release(&obj->gem);
-		kfree(obj);
+	if (ret)
 		return ERR_PTR(ret);
-	}
 
 	return &obj->gem;
 }
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

