Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0437CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0BE214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQaC8VHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0BE214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388928AbeKTDKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:10:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:46484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728538AbeKTDKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:10:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7996214C4;
        Mon, 19 Nov 2018 16:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646000;
        bh=tikoaoc0bd4KP3+WObuFTUHWpK+iP9DX9szqj1hwDEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FQaC8VHIRlC9+PC+hwL1YABqsCy3WenafO6yxfE33p8HNF8UbeyrMYxLcAac16Maa
         t9FzOuN6xjF7YmoUSp0F5V+ugSEiQxuepEprrwfMWg4UTCJQTKKRqxsPzxK+ShWXAO
         SkkPgucGii9CqlynsZIGPvAsxXlnw3CqAWZFFyIE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.18 170/171] drm/i915: Fix possible race in intel_dp_add_mst_connector()
Date:   Mon, 19 Nov 2018 17:29:26 +0100
Message-Id: <20181119162641.303258040@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

commit 7c4512300cfa5a4dcc8c1c52ae61e3fa4bd11a39 upstream.

This hasn't caused any issues yet that I'm aware of, but as Ville
Syrjälä pointed out - we need to make sure that
intel_connector->mst_port is set before initializing MST connectors,
since in theory we could potentially check intel_connector->mst_port in
i915_hpd_poll_init_work() after registering the connector but before
having written it's value.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: stable@vger.kernel.org
Link: https://patchwork.freedesktop.org/patch/msgid/20181106213017.14563-2-lyude@redhat.com
(cherry picked from commit 66a5ab1034be801630816d1fa6cfc30db1a2f0b0)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_dp_mst.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/i915/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/intel_dp_mst.c
@@ -464,6 +464,10 @@ static struct drm_connector *intel_dp_ad
 	if (!intel_connector)
 		return NULL;
 
+	intel_connector->get_hw_state = intel_dp_mst_get_hw_state;
+	intel_connector->mst_port = intel_dp;
+	intel_connector->port = port;
+
 	connector = &intel_connector->base;
 	ret = drm_connector_init(dev, connector, &intel_dp_mst_connector_funcs,
 				 DRM_MODE_CONNECTOR_DisplayPort);
@@ -474,10 +478,6 @@ static struct drm_connector *intel_dp_ad
 
 	drm_connector_helper_add(connector, &intel_dp_mst_connector_helper_funcs);
 
-	intel_connector->get_hw_state = intel_dp_mst_get_hw_state;
-	intel_connector->mst_port = intel_dp;
-	intel_connector->port = port;
-
 	for_each_pipe(dev_priv, pipe) {
 		struct drm_encoder *enc =
 			&intel_dp->mst_encoders[pipe]->base.base;


