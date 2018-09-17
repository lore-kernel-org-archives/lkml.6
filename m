Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7073DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E8C214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E8C214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeIQXMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:12:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42926 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbeIQXMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:12:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F14B388318;
        Mon, 17 Sep 2018 17:43:51 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-121-187.rdu2.redhat.com [10.10.121.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD62217BBF;
        Mon, 17 Sep 2018 17:43:47 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/probe_helper: Don't bother probing when connectors are forced off
Date:   Mon, 17 Sep 2018 13:43:44 -0400
Message-Id: <20180917174344.22011-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 17 Sep 2018 17:43:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Userspace asked them to be forced off, so why would we care about what a
probe tells us?

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_probe_helper.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index a1bb157bfdfa..56d2b5dd1f58 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -269,7 +269,9 @@ drm_helper_probe_detect_ctx(struct drm_connector *connector, bool force)
 retry:
 	ret = drm_modeset_lock(&connector->dev->mode_config.connection_mutex, &ctx);
 	if (!ret) {
-		if (funcs->detect_ctx)
+		if (connector->force == DRM_FORCE_OFF)
+			ret = connector_status_disconnected;
+		else if (funcs->detect_ctx)
 			ret = funcs->detect_ctx(connector, &ctx, force);
 		else if (connector->funcs->detect)
 			ret = connector->funcs->detect(connector, force);
@@ -317,6 +319,9 @@ drm_helper_probe_detect(struct drm_connector *connector,
 	if (ret)
 		return ret;
 
+	if (connector->force == DRM_FORCE_OFF)
+		return connector_status_disconnected;
+
 	if (funcs->detect_ctx)
 		return funcs->detect_ctx(connector, ctx, force);
 	else if (connector->funcs->detect)
-- 
2.17.1

