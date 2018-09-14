Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C360ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AC32083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 20:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AC32083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeIOCAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 22:00:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbeIOCAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 22:00:22 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29471308FB98;
        Fri, 14 Sep 2018 20:44:16 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-122-111.rdu2.redhat.com [10.10.122.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B86729959A;
        Fri, 14 Sep 2018 20:44:10 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Sean Paul <seanpaul@chromium.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: Grab runtime PM ref in nv50_mstc_detect()
Date:   Fri, 14 Sep 2018 16:44:03 -0400
Message-Id: <20180914204407.1214-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 14 Sep 2018 20:44:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While we currently grab a runtime PM ref in nouveau's normal connector
detection code, we apparently don't do this for MST. This means if we're
in a scenario where the GPU is suspended and userspace attempts to do a
connector probe on an MSTC connector, the probe will fail entirely due
to the DP aux channel and GPU not being woken up:

[  316.633489] nouveau 0000:01:00.0: i2c: aux 000a: begin idle timeout ffffffff
[  316.635713] nouveau 0000:01:00.0: i2c: aux 000a: begin idle timeout ffffffff
[  316.637785] nouveau 0000:01:00.0: i2c: aux 000a: begin idle timeout ffffffff
...

So, grab a runtime PM ref here.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index c94b7f42d62d..9da0bdfe1e1c 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -938,9 +938,22 @@ static enum drm_connector_status
 nv50_mstc_detect(struct drm_connector *connector, bool force)
 {
 	struct nv50_mstc *mstc = nv50_mstc(connector);
+	enum drm_connector_status conn_status;
+	int ret;
+
 	if (!mstc->port)
 		return connector_status_disconnected;
-	return drm_dp_mst_detect_port(connector, mstc->port->mgr, mstc->port);
+
+	ret = pm_runtime_get_sync(connector->dev->dev);
+	if (ret < 0 && ret != -EACCES)
+		return connector_status_disconnected;
+
+	conn_status = drm_dp_mst_detect_port(connector, mstc->port->mgr,
+					     mstc->port);
+
+	pm_runtime_mark_last_busy(connector->dev->dev);
+	pm_runtime_put_autosuspend(connector->dev->dev);
+	return conn_status;
 }
 
 static void
-- 
2.17.1

