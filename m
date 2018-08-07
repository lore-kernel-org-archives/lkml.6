Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF119C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DC021569
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DC021569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeHGWzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:55:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726875AbeHGWzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:55:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CED674023336;
        Tue,  7 Aug 2018 20:39:27 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16D5B1C664;
        Tue,  7 Aug 2018 20:39:27 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Lukas Wunner <lukas@wunner.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/13] drm/nouveau: Fix bogus drm_kms_helper_poll_enable() placement
Date:   Tue,  7 Aug 2018 16:38:58 -0400
Message-Id: <20180807203914.2192-2-lyude@redhat.com>
In-Reply-To: <20180807203914.2192-1-lyude@redhat.com>
References: <20180807203914.2192-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 07 Aug 2018 20:39:27 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 07 Aug 2018 20:39:27 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out this part is my fault for not noticing when reviewing
9a2eba337cace ("drm/nouveau: Fix drm poll_helper handling"). Currently
we call drm_kms_helper_poll_enable() from nouveau_display_hpd_work().
This makes basically no sense however, because that means we're calling
drm_kms_helper_poll_enable() every time we schedule the hotplug
detection work. This is also against the advice mentioned in
drm_kms_helper_poll_enable()'s documentation:

 Note that calls to enable and disable polling must be strictly ordered,
 which is automatically the case when they're only call from
 suspend/resume callbacks.

Of course, hotplugs can't really be ordered. They could even happen
immediately after we called drm_kms_helper_poll_disable() in
nouveau_display_fini(), which can lead to all sorts of issues.

Additionally; enabling polling /after/ we call
drm_helper_hpd_irq_event() could also mean that we'd miss a hotplug
event anyway, since drm_helper_hpd_irq_event() wouldn't bother trying to
probe connectors so long as polling is disabled.

So; simply move this back into nouveau_display_init() again. The race
condition that both of these patches attempted to work around has
already been fixed properly in

  d61a5c106351 ("drm/nouveau: Fix deadlock on runtime suspend")

Fixes: 9a2eba337cace ("drm/nouveau: Fix drm poll_helper handling")
Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/nouveau/nouveau_display.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index ec7861457b84..1d36ab5d4796 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -355,8 +355,6 @@ nouveau_display_hpd_work(struct work_struct *work)
 	pm_runtime_get_sync(drm->dev->dev);
 
 	drm_helper_hpd_irq_event(drm->dev);
-	/* enable polling for external displays */
-	drm_kms_helper_poll_enable(drm->dev);
 
 	pm_runtime_mark_last_busy(drm->dev->dev);
 	pm_runtime_put_sync(drm->dev->dev);
@@ -411,6 +409,11 @@ nouveau_display_init(struct drm_device *dev)
 	if (ret)
 		return ret;
 
+	/* enable connector detection and polling for connectors without HPD
+	 * support
+	 */
+	drm_kms_helper_poll_enable(dev);
+
 	/* enable hotplug interrupts */
 	drm_connector_list_iter_begin(dev, &conn_iter);
 	nouveau_for_each_non_mst_connector_iter(connector, &conn_iter) {
-- 
2.17.1

