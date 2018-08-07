Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E07C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC9021569
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC9021569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeHGWzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:55:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726359AbeHGWzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:55:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE1EB4023337;
        Tue,  7 Aug 2018 20:39:29 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 842321C664;
        Tue,  7 Aug 2018 20:39:29 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Lukas Wunner <lukas@wunner.de>,
        Karol Herbst <karolherbst@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/13] drm/nouveau: Remove useless poll_enable() call in drm_load()
Date:   Tue,  7 Aug 2018 16:39:02 -0400
Message-Id: <20180807203914.2192-6-lyude@redhat.com>
In-Reply-To: <20180807203914.2192-1-lyude@redhat.com>
References: <20180807203914.2192-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 07 Aug 2018 20:39:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 07 Aug 2018 20:39:29 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Again, this doesn't do anything. drm_kms_helper_poll_enable() will have
already been called in nouveau_display_init()

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Karol Herbst <karolherbst@gmail.com>
[omitting stable Cc, this probably doesn't fix any real bugs]
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 5fdc1fbe2ee5..04f704b77a3c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -592,10 +592,8 @@ nouveau_drm_load(struct drm_device *dev, unsigned long flags)
 		pm_runtime_allow(dev->dev);
 		pm_runtime_mark_last_busy(dev->dev);
 		pm_runtime_put(dev->dev);
-	} else {
-		/* enable polling for external displays */
-		drm_kms_helper_poll_enable(dev);
 	}
+
 	return 0;
 
 fail_dispinit:
-- 
2.17.1

