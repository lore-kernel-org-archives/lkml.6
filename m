Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B39C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4738620870
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4738620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933166AbeGJICL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:02:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52670 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751233AbeGJICC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:02:02 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 35E572093F; Tue, 10 Jul 2018 10:02:01 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6BB00208FC;
        Tue, 10 Jul 2018 10:01:50 +0200 (CEST)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Marco Franchi <marco.franchi@nxp.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Smitha T Murthy <smitha.t@samsung.com>,
        Tom Saeger <tom.saeger@oracle.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Benoit Parrot <bparrot@ti.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pawel Osciak <posciak@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Randy Li <ayaka@soulik.info>,
        Hans Verkuil <hans.verkuil@cisco.com>
Subject: [PATCH v5 01/22] v4l2-ctrls: add v4l2_ctrl_request_hdl_find/put/ctrl_find functions
Date:   Tue, 10 Jul 2018 10:00:53 +0200
Message-Id: <20180710080114.31469-2-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil@xs4all.nl>

If a driver needs to find/inspect the controls set in a request then
it can use these functions.

E.g. to check if a required control is set in a request use this in the
req_validate() implementation:

	int res = -EINVAL;

	hdl = v4l2_ctrl_request_hdl_find(req, parent_hdl);
	if (hdl) {
		if (v4l2_ctrl_request_hdl_ctrl_find(hdl, ctrl_id))
			res = 0;
		v4l2_ctrl_request_hdl_put(hdl);
	}
	return res;

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 drivers/media/v4l2-core/v4l2-ctrls.c | 25 ++++++++++++++++
 include/media/v4l2-ctrls.h           | 44 +++++++++++++++++++++++++++-
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index 86a6ae54ccaa..198b7e924d21 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -2976,6 +2976,31 @@ static const struct media_request_object_ops req_ops = {
 	.release = v4l2_ctrl_request_release,
 };
 
+struct v4l2_ctrl_handler *v4l2_ctrl_request_hdl_find(struct media_request *req,
+					struct v4l2_ctrl_handler *parent)
+{
+	struct media_request_object *obj;
+	
+	if (WARN_ON(req->state != MEDIA_REQUEST_STATE_VALIDATING &&
+		    req->state != MEDIA_REQUEST_STATE_QUEUED))
+		return NULL;
+
+	obj = media_request_object_find(req, &req_ops, parent);
+	if (obj)
+		return container_of(obj, struct v4l2_ctrl_handler, req_obj);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(v4l2_ctrl_request_hdl_find);
+
+struct v4l2_ctrl *
+v4l2_ctrl_request_hdl_ctrl_find(struct v4l2_ctrl_handler *hdl, u32 id)
+{
+	struct v4l2_ctrl_ref *ref = find_ref_lock(hdl, id);
+
+	return (ref && ref->req == ref) ? ref : NULL;
+}
+EXPORT_SYMBOL_GPL(v4l2_ctrl_request_hdl_ctrl_find);
+
 static int v4l2_ctrl_request_bind(struct media_request *req,
 			   struct v4l2_ctrl_handler *hdl,
 			   struct v4l2_ctrl_handler *from)
diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
index de70cc3a1b80..34ee3167d7dd 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -1111,7 +1111,49 @@ void v4l2_ctrl_request_setup(struct media_request *req,
  * request object.
  */
 void v4l2_ctrl_request_complete(struct media_request *req,
-				struct v4l2_ctrl_handler *hdl);
+				struct v4l2_ctrl_handler *parent);
+
+/**
+ * v4l2_ctrl_request_hdl_find - Find the control handler in the request
+ *
+ * @req: The request
+ * @parent: The parent control handler ('priv' in media_request_object_find())
+ *
+ * This function finds the control handler in the request. It may return
+ * NULL if not found. When done, you must call v4l2_ctrl_request_put_hdl()
+ * with the returned handler pointer.
+ *
+ * If the request is not in state VALIDATING or QUEUED, then this function
+ * will always return NULL.
+ */
+struct v4l2_ctrl_handler *v4l2_ctrl_request_hdl_find(struct media_request *req,
+					struct v4l2_ctrl_handler *parent);
+
+/**
+ * v4l2_ctrl_request_hdl_put - Put the control handler
+ *
+ * @hdl: Put this control handler
+ *
+ * This function released the control handler previously obtained from'
+ * v4l2_ctrl_request_hdl_find().
+ */
+static inline void v4l2_ctrl_request_hdl_put(struct v4l2_ctrl_handler *hdl)
+{
+	if (hdl)
+		media_request_object_put(&hdl->req_obj);
+}
+
+/**
+ * v4l2_ctrl_request_ctrl_find() - Find a control with the given ID.
+ *
+ * @hdl: The control handler from the request.
+ * @id: The ID of the control to find.
+ *
+ * This function returns a pointer to the control if this control is
+ * part of the request or NULL otherwise.
+ */
+struct v4l2_ctrl *
+v4l2_ctrl_request_hdl_ctrl_find(struct v4l2_ctrl_handler *hdl, u32 id);
 
 /* Helpers for ioctl_ops */
 
-- 
2.17.1

