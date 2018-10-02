Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77927C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FE220684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47FE220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeJBNAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 09:00:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbeJBNAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 09:00:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 122B181DE9;
        Tue,  2 Oct 2018 06:19:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-29.ams2.redhat.com [10.36.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF7D060C60;
        Tue,  2 Oct 2018 06:19:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 7C1B416E2B; Tue,  2 Oct 2018 08:19:05 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] drm: add drm_connector_attach_edid_property()
Date:   Tue,  2 Oct 2018 08:19:04 +0200
Message-Id: <20181002061905.10496-2-kraxel@redhat.com>
In-Reply-To: <20181002061905.10496-1-kraxel@redhat.com>
References: <20181002061905.10496-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 02 Oct 2018 06:19:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_connector_init doesn't attach the edid property for some connector
types, drm_connector_attach_edid_property() can be used to enable the
edid property in these cases.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_connector.h     |  1 +
 drivers/gpu/drm/drm_connector.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

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
index 6011d769d5..6c6ef4f9b9 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -291,6 +291,26 @@ int drm_connector_init(struct drm_device *dev,
 EXPORT_SYMBOL(drm_connector_init);
 
 /**
+ * drm_connector_attach_edid_property - attach edid property.
+ * @dev: DRM device
+ * @connector: the connector
+ *
+ * Some connector types like DRM_MODE_CONNECTOR_VIRTUAL do not get a
+ * edid property attached by default.  This function can be used to
+ * explicitly enable the edid property in these cases.
+ *
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

