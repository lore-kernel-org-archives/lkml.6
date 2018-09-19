Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80D4ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8102152E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8102152E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732970AbeISWww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:52:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731056AbeISWwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:52:51 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7B7692E1B;
        Wed, 19 Sep 2018 17:14:00 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-122-250.rdu2.redhat.com [10.10.122.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEE1599584;
        Wed, 19 Sep 2018 17:13:59 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/nouveau: Add strap_peek to debugfs
Date:   Wed, 19 Sep 2018 13:13:51 -0400
Message-Id: <20180919171353.29648-2-lyude@redhat.com>
In-Reply-To: <20180919171353.29648-1-lyude@redhat.com>
References: <20180919171353.29648-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 19 Sep 2018 17:14:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we already expose the vbios.rom file here, why not also expose the
strap_peek?

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index 9109b69cd052..7379c20584a2 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -46,6 +46,26 @@ nouveau_debugfs_vbios_image(struct seq_file *m, void *data)
 	return 0;
 }
 
+static int
+nouveau_debugfs_strap_peek(struct seq_file *m, void *data)
+{
+	struct drm_info_node *node = m->private;
+	struct nouveau_drm *drm = nouveau_drm(node->minor->dev);
+	int ret;
+
+	ret = pm_runtime_get_sync(drm->dev->dev);
+	if (ret < 0 && ret != -EACCES)
+		return ret;
+
+	seq_printf(m, "0x%08x\n",
+		   nvif_rd32(&drm->client.device.object, 0x101000));
+
+	pm_runtime_mark_last_busy(drm->dev->dev);
+	pm_runtime_put_autosuspend(drm->dev->dev);
+
+	return 0;
+}
+
 static int
 nouveau_debugfs_pstate_get(struct seq_file *m, void *data)
 {
@@ -185,7 +205,8 @@ static const struct file_operations nouveau_pstate_fops = {
 };
 
 static struct drm_info_list nouveau_debugfs_list[] = {
-	{ "vbios.rom", nouveau_debugfs_vbios_image, 0, NULL },
+	{ "vbios.rom",  nouveau_debugfs_vbios_image, 0, NULL },
+	{ "strap_peek", nouveau_debugfs_strap_peek, 0, NULL },
 };
 #define NOUVEAU_DEBUGFS_ENTRIES ARRAY_SIZE(nouveau_debugfs_list)
 
-- 
2.17.1

