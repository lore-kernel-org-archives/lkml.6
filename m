Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D6EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF4F20851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEF4F20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbeHWMLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:11:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50092 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732166AbeHWMLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:11:22 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8B51D7F6;
        Thu, 23 Aug 2018 08:42:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ayan Kumar Halder <ayan.halder@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 045/324] drm/arm/malidp: Ensure that the crtcs are shutdown before removing any encoder/connector
Date:   Thu, 23 Aug 2018 09:51:51 +0200
Message-Id: <20180823074958.070155245@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ayan Kumar Halder <ayan.halder@arm.com>

[ Upstream commit 109c4d18e57445afcaf728b8716a69375a3daab2 ]

One needs to ensure that the crtcs are shutdown so that the
drm_crtc_state->connector_mask reflects that no connectors
are currently active. Further, it reduces the reference
count for each connector. This ensures that the connectors
and encoders can be cleanly removed either when _unbind
is called for the corresponding drivers or by
drm_mode_config_cleanup().
We need drm_atomic_helper_shutdown() to be called before
component_unbind_all() otherwise the connectors attached to the
component device will have the wrong reference count value and will not
be cleanly removed.

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/arm/malidp_drv.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -278,7 +278,6 @@ static int malidp_init(struct drm_device
 
 static void malidp_fini(struct drm_device *drm)
 {
-	drm_atomic_helper_shutdown(drm);
 	drm_mode_config_cleanup(drm);
 }
 
@@ -646,6 +645,7 @@ vblank_fail:
 	malidp_de_irq_fini(drm);
 	drm->irq_enabled = false;
 irq_init_fail:
+	drm_atomic_helper_shutdown(drm);
 	component_unbind_all(dev, drm);
 bind_fail:
 	of_node_put(malidp->crtc.port);
@@ -681,6 +681,7 @@ static void malidp_unbind(struct device
 	malidp_se_irq_fini(drm);
 	malidp_de_irq_fini(drm);
 	drm->irq_enabled = false;
+	drm_atomic_helper_shutdown(drm);
 	component_unbind_all(dev, drm);
 	of_node_put(malidp->crtc.port);
 	malidp->crtc.port = NULL;


