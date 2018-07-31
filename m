Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F36C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA89208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 00:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABA89208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbeGaCRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 22:17:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732191AbeGaCRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 22:17:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 182287DAC7;
        Tue, 31 Jul 2018 00:40:05 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB86D16875;
        Tue, 31 Jul 2018 00:40:04 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Karol Herbst <karolherbst@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/8] drm/nouveau: Fix deadlock with fb_helper using new helpers
Date:   Mon, 30 Jul 2018 20:39:49 -0400
Message-Id: <20180731003954.19962-5-lyude@redhat.com>
In-Reply-To: <20180731003954.19962-1-lyude@redhat.com>
References: <20180731003954.19962-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 31 Jul 2018 00:40:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 31 Jul 2018 00:40:05 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the potential of deadlocking with fb_helper entirely by
preventing it from handling hotplugs during the runtime suspend process
as early as possible in the suspend process. If it turns out this is not
possible, due to some fb_helper action having been queued up before we
got a time to disable hotplugging, we simply return -EBUSY so that the
runtime PM core attempts autosuspending the device again once fb_helper
isn't doing anything.

This fixes one of the issues causing deadlocks on runtime suspend/resume
with nouveau on my P50.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Karol Herbst <karolherbst@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c   | 8 ++++++++
 drivers/gpu/drm/nouveau/nouveau_fbcon.c | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index ee2546db09c9..d47cb5b2af98 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -836,6 +836,14 @@ nouveau_pmops_runtime_suspend(struct device *dev)
 		return -EBUSY;
 	}
 
+	/* There's no way for us to stop fb_helper work in reaction to
+	 * hotplugs later in the RPM process. First off: we don't want to,
+	 * fb_helper should be able to keep the GPU awake. Second off: it is
+	 * capable of grabbing basically any lock in existence.
+	 */
+	if (!drm_fb_helper_suspend_hotplug(drm_dev->fb_helper))
+		return -EBUSY;
+
 	nouveau_switcheroo_optimus_dsm();
 	ret = nouveau_do_suspend(drm_dev, true);
 	pci_save_state(pdev);
diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.c b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
index 85c1f10bc2b6..963ba630fd04 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
@@ -466,6 +466,7 @@ nouveau_fbcon_set_suspend_work(struct work_struct *work)
 	console_unlock();
 
 	if (state == FBINFO_STATE_RUNNING) {
+		drm_fb_helper_resume_hotplug(drm->dev->fb_helper);
 		pm_runtime_mark_last_busy(drm->dev->dev);
 		pm_runtime_put_sync(drm->dev->dev);
 	}
-- 
2.17.1

