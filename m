Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0611C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632F32152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632F32152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbeI0Phj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:37:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56304 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbeI0Phj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:37:39 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E10C6111C;
        Thu, 27 Sep 2018 09:20:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 4.14 43/64] drm/nouveau/drm/nouveau: Fix bogus drm_kms_helper_poll_enable() placement
Date:   Thu, 27 Sep 2018 11:04:00 +0200
Message-Id: <20180927090256.075490040@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090249.801943776@linuxfoundation.org>
References: <20180927090249.801943776@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

commit d77ef138ff572409ab93d492e5e6c826ee6fb21d upstream.

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
Acked-by: Karol Herbst <kherbst@redhat.com>
Acked-by: Daniel Vetter <daniel@ffwll.ch>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/nouveau_display.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -356,8 +356,6 @@ nouveau_display_hpd_work(struct work_str
 	pm_runtime_get_sync(drm->dev->dev);
 
 	drm_helper_hpd_irq_event(drm->dev);
-	/* enable polling for external displays */
-	drm_kms_helper_poll_enable(drm->dev);
 
 	pm_runtime_mark_last_busy(drm->dev->dev);
 	pm_runtime_put_sync(drm->dev->dev);
@@ -412,6 +410,11 @@ nouveau_display_init(struct drm_device *
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


