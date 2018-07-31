Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A567CC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5324520841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5324520841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbeGaRJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 13:09:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732274AbeGaRJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 13:09:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62FB87A7E5;
        Tue, 31 Jul 2018 15:28:32 +0000 (UTC)
Received: from malachite.redhat.com (ovpn-121-83.rdu2.redhat.com [10.10.121.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD8C92142F20;
        Tue, 31 Jul 2018 15:28:30 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Karol Herbst <karolherbst@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/nouveau: Fix potential memory access error in debugfs_pstate_get/set()
Date:   Tue, 31 Jul 2018 11:28:26 -0400
Message-Id: <20180731152827.28573-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 31 Jul 2018 15:28:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 31 Jul 2018 15:28:32 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nouveau_debugfs(drm) will never be NULL, because we're taking the value
of the potentially null device pointer and adding to it so it isn't 0x0.
So, check if drm is NULL instead.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Karol Herbst <karolherbst@gmail.com>
---
Changes since v2:
 - Also fix nouveau_debugfs_pstate_set()

 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index 963a4dba8213..b7440b542cb2 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -50,13 +50,15 @@ static int
 nouveau_debugfs_pstate_get(struct seq_file *m, void *data)
 {
 	struct drm_device *drm = m->private;
-	struct nouveau_debugfs *debugfs = nouveau_debugfs(drm);
-	struct nvif_object *ctrl = &debugfs->ctrl;
+	struct nouveau_debugfs *debugfs;
+	struct nvif_object *ctrl;
 	struct nvif_control_pstate_info_v0 info = {};
 	int ret, i;
 
-	if (!debugfs)
+	if (!drm)
 		return -ENODEV;
+	debugfs = nouveau_debugfs(drm);
+	ctrl = &debugfs->ctrl;
 
 	ret = nvif_mthd(ctrl, NVIF_CONTROL_PSTATE_INFO, &info, sizeof(info));
 	if (ret)
@@ -121,14 +123,16 @@ nouveau_debugfs_pstate_set(struct file *file, const char __user *ubuf,
 {
 	struct seq_file *m = file->private_data;
 	struct drm_device *drm = m->private;
-	struct nouveau_debugfs *debugfs = nouveau_debugfs(drm);
-	struct nvif_object *ctrl = &debugfs->ctrl;
+	struct nouveau_debugfs *debugfs;
+	struct nvif_object *ctrl;
 	struct nvif_control_pstate_user_v0 args = { .pwrsrc = -EINVAL };
 	char buf[32] = {}, *tmp, *cur = buf;
 	long value, ret;
 
-	if (!debugfs)
+	if (!drm)
 		return -ENODEV;
+	debugfs = nouveau_debugfs(drm);
+	ctrl = &debugfs->ctrl;
 
 	if (len >= sizeof(buf))
 		return -EINVAL;
-- 
2.17.1

