Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227o+RV8G1PzxcAy6vftV9tktplCulX9JHMjrMAY3FLe2BZmzIbr81LymTCqWyV6JnUwG/Ni
ARC-Seal: i=1; a=rsa-sha256; t=1518709015; cv=none;
        d=google.com; s=arc-20160816;
        b=q5rPjVK4bKuHqIXuusQxFAXQz7DMFG8KknVl66QJpc+vlAwtbYR+yA77igRKvtonk4
         l/uJdgBjMdSA+wCw0r5sd3PX1LPjDOchYuTsMbTCQhMLS+1/mPj72vZkzV5bn//NX+LP
         pp71GXx2GF6V47tFcCgY+fyAUZippZH6pShiZUiLazYV0zlMiCGmKoypHq6yHZIhjud7
         rctHEyMQ+XmgqrwfOZ2wSbKZiIWdi4avMhoWtgyWASZHBp2nrfPuFq+8SBOQv8aSNNPs
         ZhPXLc+1BBLbVqWEY2X64FDdRKFGNzs5be8ETLGhF5z7QCtTOrzKhh1ZIhNuB16IFBkG
         /OWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=X1KPTiCZ7VWYf+uKqYKqU55p04ElKoIOUeX1XOIsSCo=;
        b=AX+Y4qWJxrMdGHnBIL/KGV3gNVxakbsBBaEsOmDNQiW4AUnWaPxvACklFL+ZeOOABZ
         2wuO6y7rBvW5OyBe8s7aDcYdH4/2sVEcgCPze6hYR1t9eMJ2lUGCK9EPoYXJ/H+wf6xN
         tC7GJEmroa22JiEyHJAExpGC2U0K7SShC5MyTVsDir49cAi4jeAqeT2vscC2xdgChkl6
         G0APGTxUe2XzKFgpki2hYMYDN4SJbyJG4dNZ9S33QHMEOL9EuCEwAznGemCsORJydSY9
         JxUViDMbSS4soS1Ex4ECMyukLEO4ln48nllZPcgn9ra3CThKY+cKbavZygOe6RTLaTSf
         7WcA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 4.14 127/195] media: v4l2-compat-ioctl32.c: fix ctrl_is_pointer
Date: Thu, 15 Feb 2018 16:16:58 +0100
Message-Id: <20180215151712.092447371@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481012130822446?=
X-GMAIL-MSGID: =?utf-8?q?1592481825065130358?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hans.verkuil@cisco.com>

commit b8c601e8af2d08f733d74defa8465303391bb930 upstream.

ctrl_is_pointer just hardcoded two known string controls, but that
caused problems when using e.g. custom controls that use a pointer
for the payload.

Reimplement this function: it now finds the v4l2_ctrl (if the driver
uses the control framework) or it calls vidioc_query_ext_ctrl (if the
driver implements that directly).

In both cases it can now check if the control is a pointer control
or not.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c |   59 +++++++++++++++++---------
 1 file changed, 39 insertions(+), 20 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
+++ b/drivers/media/v4l2-core/v4l2-compat-ioctl32.c
@@ -18,6 +18,8 @@
 #include <linux/videodev2.h>
 #include <linux/v4l2-subdev.h>
 #include <media/v4l2-dev.h>
+#include <media/v4l2-fh.h>
+#include <media/v4l2-ctrls.h>
 #include <media/v4l2-ioctl.h>
 
 static long native_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
@@ -601,24 +603,39 @@ struct v4l2_ext_control32 {
 	};
 } __attribute__ ((packed));
 
-/* The following function really belong in v4l2-common, but that causes
-   a circular dependency between modules. We need to think about this, but
-   for now this will do. */
-
-/* Return non-zero if this control is a pointer type. Currently only
-   type STRING is a pointer type. */
-static inline int ctrl_is_pointer(u32 id)
-{
-	switch (id) {
-	case V4L2_CID_RDS_TX_PS_NAME:
-	case V4L2_CID_RDS_TX_RADIO_TEXT:
-		return 1;
-	default:
-		return 0;
+/* Return true if this control is a pointer type. */
+static inline bool ctrl_is_pointer(struct file *file, u32 id)
+{
+	struct video_device *vdev = video_devdata(file);
+	struct v4l2_fh *fh = NULL;
+	struct v4l2_ctrl_handler *hdl = NULL;
+	struct v4l2_query_ext_ctrl qec = { id };
+	const struct v4l2_ioctl_ops *ops = vdev->ioctl_ops;
+
+	if (test_bit(V4L2_FL_USES_V4L2_FH, &vdev->flags))
+		fh = file->private_data;
+
+	if (fh && fh->ctrl_handler)
+		hdl = fh->ctrl_handler;
+	else if (vdev->ctrl_handler)
+		hdl = vdev->ctrl_handler;
+
+	if (hdl) {
+		struct v4l2_ctrl *ctrl = v4l2_ctrl_find(hdl, id);
+
+		return ctrl && ctrl->is_ptr;
 	}
+
+	if (!ops->vidioc_query_ext_ctrl)
+		return false;
+
+	return !ops->vidioc_query_ext_ctrl(file, fh, &qec) &&
+		(qec.flags & V4L2_CTRL_FLAG_HAS_PAYLOAD);
 }
 
-static int get_v4l2_ext_controls32(struct v4l2_ext_controls *kp, struct v4l2_ext_controls32 __user *up)
+static int get_v4l2_ext_controls32(struct file *file,
+				   struct v4l2_ext_controls *kp,
+				   struct v4l2_ext_controls32 __user *up)
 {
 	struct v4l2_ext_control32 __user *ucontrols;
 	struct v4l2_ext_control __user *kcontrols;
@@ -651,7 +668,7 @@ static int get_v4l2_ext_controls32(struc
 			return -EFAULT;
 		if (get_user(id, &kcontrols->id))
 			return -EFAULT;
-		if (ctrl_is_pointer(id)) {
+		if (ctrl_is_pointer(file, id)) {
 			void __user *s;
 
 			if (get_user(p, &ucontrols->string))
@@ -666,7 +683,9 @@ static int get_v4l2_ext_controls32(struc
 	return 0;
 }
 
-static int put_v4l2_ext_controls32(struct v4l2_ext_controls *kp, struct v4l2_ext_controls32 __user *up)
+static int put_v4l2_ext_controls32(struct file *file,
+				   struct v4l2_ext_controls *kp,
+				   struct v4l2_ext_controls32 __user *up)
 {
 	struct v4l2_ext_control32 __user *ucontrols;
 	struct v4l2_ext_control __user *kcontrols =
@@ -698,7 +717,7 @@ static int put_v4l2_ext_controls32(struc
 		/* Do not modify the pointer when copying a pointer control.
 		   The contents of the pointer was changed, not the pointer
 		   itself. */
-		if (ctrl_is_pointer(id))
+		if (ctrl_is_pointer(file, id))
 			size -= sizeof(ucontrols->value64);
 		if (copy_in_user(ucontrols, kcontrols, size))
 			return -EFAULT;
@@ -912,7 +931,7 @@ static long do_video_ioctl(struct file *
 	case VIDIOC_G_EXT_CTRLS:
 	case VIDIOC_S_EXT_CTRLS:
 	case VIDIOC_TRY_EXT_CTRLS:
-		err = get_v4l2_ext_controls32(&karg.v2ecs, up);
+		err = get_v4l2_ext_controls32(file, &karg.v2ecs, up);
 		compatible_arg = 0;
 		break;
 	case VIDIOC_DQEVENT:
@@ -939,7 +958,7 @@ static long do_video_ioctl(struct file *
 	case VIDIOC_G_EXT_CTRLS:
 	case VIDIOC_S_EXT_CTRLS:
 	case VIDIOC_TRY_EXT_CTRLS:
-		if (put_v4l2_ext_controls32(&karg.v2ecs, up))
+		if (put_v4l2_ext_controls32(file, &karg.v2ecs, up))
 			err = -EFAULT;
 		break;
 	case VIDIOC_S_EDID:
