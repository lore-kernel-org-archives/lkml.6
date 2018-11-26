Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E73C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C29320873
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C29320873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeK0Itt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:49:49 -0500
Received: from anholt.net ([50.246.234.109]:38340 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbeK0Its (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:49:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 37EE410A0E84;
        Mon, 26 Nov 2018 13:54:17 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id K8ZkOM8jEMwk; Mon, 26 Nov 2018 13:54:16 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 5619B10A017F;
        Mon, 26 Nov 2018 13:54:16 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id DD5432FE1FE6; Mon, 26 Nov 2018 13:54:15 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>
Subject: [PATCH] drm: shmem helper fixups.
Date:   Mon, 26 Nov 2018 13:54:15 -0800
Message-Id: <20181126215415.19397-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <Message-Id: <20181017130454.44292-5-noralf@tronnes.org>
References: <Message-Id: <20181017130454.44292-5-noralf@tronnes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prime_mmap was removed in a later review change, and the kfree
needs to use obj because shmem is initialized later on.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

With these changes to Noralf's patch, it's:

Tested-by: Eric Anholt <eric@anholt.net>

 drivers/gpu/drm/drm_gem_shmem_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 7471856d34ac..a0f9df8a6721 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -31,7 +31,6 @@ static const struct drm_gem_object_funcs drm_gem_shmem_funcs = {
 	.get_sg_table = drm_gem_shmem_get_sg_table,
 	.vmap = drm_gem_shmem_vmap,
 	.vunmap = drm_gem_shmem_vunmap,
-	.prime_mmap = drm_gem_shmem_prime_mmap,
 	.vm_ops = &drm_gem_shmem_vm_ops,
 };
 
@@ -81,7 +80,7 @@ struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t
 err_release:
 	drm_gem_object_release(obj);
 err_free:
-	kfree(shmem);
+	kfree(obj);
 
 	return ERR_PTR(ret);
 }
-- 
2.20.0.rc1

