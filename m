Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F5AECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E96208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 15:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E96208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbeGPQMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:12:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727715AbeGPQMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:12:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5EB347C6A9;
        Mon, 16 Jul 2018 15:44:37 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-124-27.rdu2.redhat.com [10.10.124.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 91A222026D65;
        Mon, 16 Jul 2018 15:44:36 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/dp_helper: Add DP aux channel tracing
Date:   Mon, 16 Jul 2018 11:44:32 -0400
Message-Id: <20180716154432.13433-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 16 Jul 2018 15:44:37 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 16 Jul 2018 15:44:37 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is something we've needed for a very long time now, as it makes
debugging issues with faulty MST hubs along with debugging issues
regarding us interfacing with hubs correctly vastly easier to debug.
Currently this can actually be done if you trace the i2c devices for DP
using ftrace but that's significantly less useful for a couple of
reasons:

- Tracing the i2c devices through ftrace means all of the traces are
  going to contain a lot of "garbage" output that we're sending over the
  i2c line. Most of this garbage comes from retrying transactions, DRM's
  helper library adding extra transactions to work around bad hubs, etc.
- Having a user set up ftrace so that they can provide debugging
  information is a lot more difficult then being able to say "just boot
  with drm.debug=0x100"
- We can potentially expand upon this tracing in the future to print
  debugging information in regards to other DP transactions like MST
  sideband transactions

This is inspired by a patch Rob Clark sent to do this a long time back.
Neither of us could find the patch however, so we both assumed it would
probably just be easier to rewrite it anyway.

Cc: Rob Clark <robdclark@gmail.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
Changes since v1:
 - Adjust limit in drm_dp_dump_access() and get rid of unneeded "..."
   suffix (danvet)
 - Remove extraneous whitespace

I will be pushing this in just a moment, sending to list so it gets
updated in patchwork first

 drivers/gpu/drm/drm_dp_helper.c | 32 +++++++++++++++++++++++++++-----
 drivers/gpu/drm/drm_drv.c       | 15 ++++++++-------
 include/drm/drm_print.h         |  6 ++++++
 3 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index a7ba602a43a8..03f8f93c61ac 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -185,6 +185,20 @@ EXPORT_SYMBOL(drm_dp_bw_code_to_link_rate);
 
 #define AUX_RETRY_INTERVAL 500 /* us */
 
+static inline void
+drm_dp_dump_access(const struct drm_dp_aux *aux,
+		   u8 request, uint offset, void *buffer, int ret)
+{
+	const char *arrow = request == DP_AUX_NATIVE_READ ? "->" : "<-";
+
+	if (ret > 0)
+		drm_dbg(DRM_UT_DP, "%s: 0x%05x AUX %s (ret=%3d) %*ph\n",
+			aux->name, offset, arrow, ret, min(ret, 20), buffer);
+	else
+		drm_dbg(DRM_UT_DP, "%s: 0x%05x AUX %s (ret=%3d)\n",
+			aux->name, offset, arrow, ret);
+}
+
 /**
  * DOC: dp helpers
  *
@@ -288,10 +302,14 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 	ret = drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, DP_DPCD_REV, buffer,
 				 1);
 	if (ret != 1)
-		return ret;
+		goto out;
 
-	return drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, offset, buffer,
-				  size);
+	ret = drm_dp_dpcd_access(aux, DP_AUX_NATIVE_READ, offset, buffer,
+				 size);
+
+out:
+	drm_dp_dump_access(aux, DP_AUX_NATIVE_READ, offset, buffer, ret);
+	return ret;
 }
 EXPORT_SYMBOL(drm_dp_dpcd_read);
 
@@ -312,8 +330,12 @@ EXPORT_SYMBOL(drm_dp_dpcd_read);
 ssize_t drm_dp_dpcd_write(struct drm_dp_aux *aux, unsigned int offset,
 			  void *buffer, size_t size)
 {
-	return drm_dp_dpcd_access(aux, DP_AUX_NATIVE_WRITE, offset, buffer,
-				  size);
+	int ret;
+
+	ret = drm_dp_dpcd_access(aux, DP_AUX_NATIVE_WRITE, offset, buffer,
+				 size);
+	drm_dp_dump_access(aux, DP_AUX_NATIVE_WRITE, offset, buffer, ret);
+	return ret;
 }
 EXPORT_SYMBOL(drm_dp_dpcd_write);
 
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 7af748ed1c58..e555eb5de275 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -53,13 +53,14 @@ MODULE_AUTHOR("Gareth Hughes, Leif Delgass, José Fonseca, Jon Smirl");
 MODULE_DESCRIPTION("DRM shared core routines");
 MODULE_LICENSE("GPL and additional rights");
 MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug category.\n"
-"\t\tBit 0 (0x01) will enable CORE messages (drm core code)\n"
-"\t\tBit 1 (0x02) will enable DRIVER messages (drm controller code)\n"
-"\t\tBit 2 (0x04) will enable KMS messages (modesetting code)\n"
-"\t\tBit 3 (0x08) will enable PRIME messages (prime code)\n"
-"\t\tBit 4 (0x10) will enable ATOMIC messages (atomic code)\n"
-"\t\tBit 5 (0x20) will enable VBL messages (vblank code)\n"
-"\t\tBit 7 (0x80) will enable LEASE messages (leasing code)");
+"\t\tBit 0 (0x01)  will enable CORE messages (drm core code)\n"
+"\t\tBit 1 (0x02)  will enable DRIVER messages (drm controller code)\n"
+"\t\tBit 2 (0x04)  will enable KMS messages (modesetting code)\n"
+"\t\tBit 3 (0x08)  will enable PRIME messages (prime code)\n"
+"\t\tBit 4 (0x10)  will enable ATOMIC messages (atomic code)\n"
+"\t\tBit 5 (0x20)  will enable VBL messages (vblank code)\n"
+"\t\tBit 7 (0x80)  will enable LEASE messages (leasing code)\n"
+"\t\tBit 8 (0x100) will enable DP messages (displayport code)");
 module_param_named(debug, drm_debug, int, 0600);
 
 static DEFINE_SPINLOCK(drm_minor_lock);
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index e1a46e9991cc..767c90b654c5 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -195,6 +195,7 @@ static inline struct drm_printer drm_debug_printer(const char *prefix)
 #define DRM_UT_VBL		0x20
 #define DRM_UT_STATE		0x40
 #define DRM_UT_LEASE		0x80
+#define DRM_UT_DP		0x100
 
 __printf(3, 4)
 void drm_dev_printk(const struct device *dev, const char *level,
@@ -307,6 +308,11 @@ void drm_err(const char *format, ...);
 #define DRM_DEBUG_LEASE(fmt, ...)					\
 	drm_dbg(DRM_UT_LEASE, fmt, ##__VA_ARGS__)
 
+#define	DRM_DEV_DEBUG_DP(dev, fmt, ...)					\
+	drm_dev_dbg(dev, DRM_UT_DP, fmt, ## __VA_ARGS__)
+#define DRM_DEBUG_DP(dev, fmt, ...)					\
+	drm_dbg(DRM_UT_DP, fmt, ## __VA_ARGS__)
+
 #define _DRM_DEV_DEFINE_DEBUG_RATELIMITED(dev, category, fmt, ...)	\
 ({									\
 	static DEFINE_RATELIMIT_STATE(_rs,				\
-- 
2.17.1

