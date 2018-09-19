Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C5FECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677212150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677212150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732984AbeISWwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:52:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731056AbeISWwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:52:53 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E6E83084219;
        Wed, 19 Sep 2018 17:14:02 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-122-250.rdu2.redhat.com [10.10.122.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 076B899584;
        Wed, 19 Sep 2018 17:14:00 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/nouveau: Add size to vbios.rom file in debugfs
Date:   Wed, 19 Sep 2018 13:13:52 -0400
Message-Id: <20180919171353.29648-3-lyude@redhat.com>
In-Reply-To: <20180919171353.29648-1-lyude@redhat.com>
References: <20180919171353.29648-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 19 Sep 2018 17:14:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this, nvbios /sys/kernel/debug/dri/*/vbios.rom now works!

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index 7379c20584a2..88a52f6b39fe 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -220,8 +220,9 @@ static const struct nouveau_debugfs_files {
 int
 nouveau_drm_debugfs_init(struct drm_minor *minor)
 {
+	struct nouveau_drm *drm = nouveau_drm(minor->dev);
 	struct dentry *dentry;
-	int i;
+	int i, ret;
 
 	for (i = 0; i < ARRAY_SIZE(nouveau_debugfs_files); i++) {
 		dentry = debugfs_create_file(nouveau_debugfs_files[i].name,
@@ -232,9 +233,23 @@ nouveau_drm_debugfs_init(struct drm_minor *minor)
 			return -ENOMEM;
 	}
 
-	return drm_debugfs_create_files(nouveau_debugfs_list,
-					NOUVEAU_DEBUGFS_ENTRIES,
-					minor->debugfs_root, minor);
+	ret = drm_debugfs_create_files(nouveau_debugfs_list,
+				       NOUVEAU_DEBUGFS_ENTRIES,
+				       minor->debugfs_root, minor);
+	if (ret)
+		return ret;
+
+	/* Set the size of the vbios since we know it, and it's confusing to
+	 * userspace if it wants to seek() but the file has a length of 0
+	 */
+	dentry = debugfs_lookup("vbios.rom", minor->debugfs_root);
+	if (!dentry)
+		return 0;
+
+	d_inode(dentry)->i_size = drm->vbios.length;
+	dput(dentry);
+
+	return 0;
 }
 
 int
-- 
2.17.1

