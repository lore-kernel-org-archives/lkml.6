Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC96EC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0A82152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0A82152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbeI0PdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:33:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55792 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbeI0PdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:33:25 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0E6281117;
        Thu, 27 Sep 2018 09:16:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 4.18 69/88] drm/nouveau/drm/nouveau: Use pm_runtime_get_noresume() in connector_detect()
Date:   Thu, 27 Sep 2018 11:03:50 +0200
Message-Id: <20180927090309.094671495@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
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

commit 6833fb1ec120bf078e1a527c573a09d4de286224 upstream.

It's true we can't resume the device from poll workers in
nouveau_connector_detect(). We can however, prevent the autosuspend
timer from elapsing immediately if it hasn't already without risking any
sort of deadlock with the runtime suspend/resume operations. So do that
instead of entirely avoiding grabbing a power reference.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Karol Herbst <kherbst@redhat.com>
Acked-by: Daniel Vetter <daniel@ffwll.ch>
Cc: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/nouveau_connector.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -570,12 +570,16 @@ nouveau_connector_detect(struct drm_conn
 		nv_connector->edid = NULL;
 	}
 
-	/* Outputs are only polled while runtime active, so acquiring a
-	 * runtime PM ref here is unnecessary (and would deadlock upon
-	 * runtime suspend because it waits for polling to finish).
+	/* Outputs are only polled while runtime active, so resuming the
+	 * device here is unnecessary (and would deadlock upon runtime suspend
+	 * because it waits for polling to finish). We do however, want to
+	 * prevent the autosuspend timer from elapsing during this operation
+	 * if possible.
 	 */
-	if (!drm_kms_helper_is_poll_worker()) {
-		ret = pm_runtime_get_sync(connector->dev->dev);
+	if (drm_kms_helper_is_poll_worker()) {
+		pm_runtime_get_noresume(dev->dev);
+	} else {
+		ret = pm_runtime_get_sync(dev->dev);
 		if (ret < 0 && ret != -EACCES)
 			return conn_status;
 	}
@@ -653,10 +657,8 @@ detect_analog:
 
  out:
 
-	if (!drm_kms_helper_is_poll_worker()) {
-		pm_runtime_mark_last_busy(connector->dev->dev);
-		pm_runtime_put_autosuspend(connector->dev->dev);
-	}
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
 
 	return conn_status;
 }


