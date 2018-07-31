Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2A6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C79208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 01:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C79208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbeGaCnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:43:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728705AbeGaCnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:43:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3CFB77C6A9;
        Tue, 31 Jul 2018 01:05:26 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CE8F112D199;
        Tue, 31 Jul 2018 01:05:24 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Karol Herbst <karolherbst@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/nouveau: Fix potential memory access error in nouveau_debugfs_pstate_get()
Date:   Mon, 30 Jul 2018 21:05:23 -0400
Message-Id: <20180731010523.22388-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 31 Jul 2018 01:05:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 31 Jul 2018 01:05:26 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
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
Forgot to hit :w before committing, whoops!

 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index 963a4dba8213..8e758c4cb4fd 100644
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
-- 
2.17.1

