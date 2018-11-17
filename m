Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D75C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3B32089D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 01:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3B32089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbeKQMFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:05:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbeKQMFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:05:22 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 361B258E35;
        Sat, 17 Nov 2018 01:50:33 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DF98614C6;
        Sat, 17 Nov 2018 01:50:32 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/dp: Add ->pre/post_transfer() hooks for drm_dp_aux
Date:   Fri, 16 Nov 2018 20:50:22 -0500
Message-Id: <20181117015024.5771-2-lyude@redhat.com>
In-Reply-To: <20181117015024.5771-1-lyude@redhat.com>
References: <20181117015024.5771-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sat, 17 Nov 2018 01:50:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many DRM drivers unfortunately need to be able to access the DP AUX
channel during their suspend/resume callbacks. This leads to an annoying
catch-22: drivers which try to ensure that the DP AUX channel is
initialized and ready may need to runtime-resume the device housing the
channel, which would lead to a deadlock between runtime power management
and drm_dp_aux->hw_mutex.

So: add a simple set of optional hooks that drivers can implement in
order to perform such setup before hw_mutex is locked, then clean up
afterwards. We additionally add the drm_dp_aux_get() and
drm_dp_aux_put() functions so that users of the AUX channel that need to
prepare the AUX channel ahead of time to avoid other kinds of locking
version can do so. We'll need this if we ever want to have a universal
dp_mst_status debugfs node, since dumping the MST topology without
having the AUX channel prepared beforehand would lead to lock inversion.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_helper.c |  5 ++
 include/drm/drm_dp_helper.h     | 91 +++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 6d483487f2b4..fb1912a2f246 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -224,6 +224,10 @@ static int drm_dp_dpcd_access(struct drm_dp_aux *aux, u8 request,
 	msg.buffer = buffer;
 	msg.size = size;
 
+	ret = drm_dp_aux_get(aux);
+	if (ret)
+		return ret;
+
 	mutex_lock(&aux->hw_mutex);
 
 	/*
@@ -265,6 +269,7 @@ static int drm_dp_dpcd_access(struct drm_dp_aux *aux, u8 request,
 
 unlock:
 	mutex_unlock(&aux->hw_mutex);
+	drm_dp_aux_put(aux);
 	return ret;
 }
 
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 3314e91f6eb3..b0208bc666d1 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -1243,6 +1243,46 @@ struct drm_dp_aux {
 	struct mutex hw_mutex;
 	struct work_struct crc_work;
 	u8 crc_count;
+	/**
+	 * @pre_transfer:
+	 *
+	 * An optional callback for drivers that if implemented, will be
+	 * called before locking @hw_mutex and beginning a DP AUX transaction.
+	 *
+	 * Drivers can use this to perform any initialization that might be
+	 * required before the DP AUX channel is ready to be used, such as
+	 * waking up the device housing the AUX channel.
+	 *
+	 * This callback may be called more then once for a single
+	 * transaction.
+	 *
+	 * See also:
+	 * drm_dp_aux_get()
+	 * drm_dp_aux_put()
+	 *
+	 * Returns:
+	 *
+	 * 0 on success, negative error code on failure.
+	 */
+	int (*pre_transfer)(struct drm_dp_aux *aux);
+	/**
+	 * @post_transfer:
+	 *
+	 * An optional callback for drivers that if implemented, will be
+	 * called after having performed a DP AUX transaction.
+	 *
+	 * Drivers can use this to undo any initialization that was performed
+	 * by @pre_transfer, such as putting the device housing the DP AUX
+	 * channel back to sleep.
+	 *
+	 * This callback may be called more then once for a single
+	 * transaction.
+	 *
+	 * See also:
+	 * drm_dp_aux_get()
+	 * drm_dp_aux_put()
+	 */
+	void (*post_transfer)(struct drm_dp_aux *aux);
 	ssize_t (*transfer)(struct drm_dp_aux *aux,
 			    struct drm_dp_aux_msg *msg);
 	/**
@@ -1259,6 +1299,57 @@ struct drm_dp_aux {
 	struct drm_dp_aux_cec cec;
 };
 
+/**
+ * drm_dp_aux_get() - Prepare a DP AUX channel for a transaction
+ * @aux: DisplayPort AUX channel to initialize
+ *
+ * If implemented by the driver, this function will invoke the
+ * &drm_dp_aux.pre_transfer callback for the given @aux device. This function
+ * can be used to setup the DP AUX channel before going under lock, in order
+ * to avoid lock inversion between the DP AUX channel setup and
+ * &drm_dp_aux.hw_mutex. This function is implicitly called by
+ * drm_dp_dpcd_read(), drm_dp_dpcd_readb(), drm_dp_dpcd_write(), and
+ * drm_dp_dpcd_writeb().
+ *
+ * Each call to drm_dp_aux_get() must have a matching drm_dp_aux_put() call to
+ * cleanup any resources that were required for the DP AUX transaction.
+ *
+ * See also:
+ * drm_dp_aux_put()
+ *
+ * Returns:
+ * 0 on success, negative error code on failure
+ */
+static inline int drm_dp_aux_get(struct drm_dp_aux *aux)
+{
+	if (aux->pre_transfer)
+		return aux->pre_transfer(aux);
+	else
+		return 0;
+}
+
+/**
+ * drm_dp_aux_put() - Cleanup after performing a transaction on a DP AUX
+ * channel
+ * @aux: DisplayPort AUX channel to cleanup
+ *
+ * If implemented by the driver, this function will invoke the
+ * &drm_dp_aux.post_transfer callback for the given @aux device. This function
+ * is implicitly called by drm_dp_dpcd_read(), drm_dp_dpcd_readb(),
+ * drm_dp_dpcd_write(), and drm_dp_dpcd_writeb().
+ *
+ * Each call to drm_dp_aux_get() must have a matching drm_dp_aux_put() call to
+ * cleanup any resources that were required for the DP AUX transaction.
+ *
+ * See also:
+ * drm_dp_aux_get()
+ */
+static inline void drm_dp_aux_put(struct drm_dp_aux *aux)
+{
+	if (aux->post_transfer)
+		aux->post_transfer(aux);
+}
+
 ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 			 void *buffer, size_t size);
 ssize_t drm_dp_dpcd_write(struct drm_dp_aux *aux, unsigned int offset,
-- 
2.19.1

