Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1343FC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D1A20855
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D1A20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933695AbeGCWGK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:06:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933673AbeGCWGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:06:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0156F81A4EB9;
        Tue,  3 Jul 2018 22:06:07 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA2C4FF5B;
        Tue,  3 Jul 2018 22:06:06 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/nouveau: Fix runtime PM leak in drm_open()
Date:   Tue,  3 Jul 2018 18:05:59 -0400
Message-Id: <20180703220602.16664-2-lyude@redhat.com>
In-Reply-To: <20180703220602.16664-1-lyude@redhat.com>
References: <20180703220602.16664-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 03 Jul 2018 22:06:07 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 03 Jul 2018 22:06:07 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed this as I was skimming through, if we fail to allocate memory
for cli we'll end up returning without dropping the runtime PM ref we
got. Additionally, we'll even return the wrong return code! (ret most
likely will == 0 here, we want -ENOMEM).

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 0452b18d36b9..0f668e275ee1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -919,8 +919,10 @@ nouveau_drm_open(struct drm_device *dev, struct drm_file *fpriv)
 	get_task_comm(tmpname, current);
 	snprintf(name, sizeof(name), "%s[%d]", tmpname, pid_nr(fpriv->pid));
 
-	if (!(cli = kzalloc(sizeof(*cli), GFP_KERNEL)))
-		return ret;
+	if (!(cli = kzalloc(sizeof(*cli), GFP_KERNEL))) {
+		ret = -ENOMEM;
+		goto done;
+	}
 
 	ret = nouveau_cli_init(drm, name, cli);
 	if (ret)
-- 
2.17.1

