Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B27C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAB6206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAB6206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeJBRxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:53:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50080 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbeJBRxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:53:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B5CA01F566;
        Tue,  2 Oct 2018 11:10:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-29.ams2.redhat.com [10.36.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE66F19743;
        Tue,  2 Oct 2018 11:10:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id B16954F284; Tue,  2 Oct 2018 13:10:41 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/2] drm: add drm_connector_attach_edid_property()
Date:   Tue,  2 Oct 2018 13:10:40 +0200
Message-Id: <20181002111041.17053-2-kraxel@redhat.com>
In-Reply-To: <20181002111041.17053-1-kraxel@redhat.com>
References: <20181002111041.17053-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 02 Oct 2018 11:10:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_connector_init doesn't attach the edid property for some connector
types, drm_connector_attach_edid_property() can be used to enable the
edid property in these cases.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 include/drm/drm_connector.h     |  1 +
 drivers/gpu/drm/drm_connector.c | 23 ++++++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 97ea41dc67..4d58966b54 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1083,6 +1083,7 @@ int drm_connector_init(struct drm_device *dev,
 		       struct drm_connector *connector,
 		       const struct drm_connector_funcs *funcs,
 		       int connector_type);
+void drm_connector_attach_edid_property(struct drm_connector *connector);
 int drm_connector_register(struct drm_connector *connector);
 void drm_connector_unregister(struct drm_connector *connector);
 int drm_connector_attach_encoder(struct drm_connector *connector,
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 6011d769d5..486b784e4d 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -256,9 +256,7 @@ int drm_connector_init(struct drm_device *dev,
 
 	if (connector_type != DRM_MODE_CONNECTOR_VIRTUAL &&
 	    connector_type != DRM_MODE_CONNECTOR_WRITEBACK)
-		drm_object_attach_property(&connector->base,
-					      config->edid_property,
-					      0);
+		drm_connector_attach_edid_property(connector);
 
 	drm_object_attach_property(&connector->base,
 				      config->dpms_property, 0);
@@ -291,6 +289,25 @@ int drm_connector_init(struct drm_device *dev,
 EXPORT_SYMBOL(drm_connector_init);
 
 /**
+ * drm_connector_attach_edid_property - attach edid property.
+ * @dev: DRM device
+ * @connector: the connector
+ *
+ * Some connector types like DRM_MODE_CONNECTOR_VIRTUAL do not get a
+ * edid property attached by default.  This function can be used to
+ * explicitly enable the edid property in these cases.
+ */
+void drm_connector_attach_edid_property(struct drm_connector *connector)
+{
+	struct drm_mode_config *config = &connector->dev->mode_config;
+
+	drm_object_attach_property(&connector->base,
+				   config->edid_property,
+				   0);
+}
+EXPORT_SYMBOL(drm_connector_attach_edid_property);
+
+/**
  * drm_connector_attach_encoder - attach a connector to an encoder
  * @connector: connector to attach
  * @encoder: encoder to attach @connector to
-- 
2.9.3

