Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AIpwx4+Z12YKP/IYWUBdf6fXNdq4dg/sF9U/DnfDscgpedMbNLbdbSsrpYCLoVy6OxF2m1af2je3
ARC-Seal: i=1; a=rsa-sha256; t=1522337341; cv=none;
        d=google.com; s=arc-20160816;
        b=AeW/AhEDBbd1SraJ6Aq2uc49fs668WPkZyfC5lqZ72u7Inf9zg0PjFyPNUpAeMl8gk
         wjvL0IRE1zLCdYBS9ckBiMSOXY/xAvKbTRrLFiDHdcw9wFSTkR8PTEm1MHPP5ZDrOtbr
         V7Wy8BkK9KCpLiNqQhQajSQCnJ1SkOvgI7Q1l9StAJpjblRtDcapx0v1osl8hpcbqNjU
         49Df8eu4STY5+D26iIwIPFTL2QXNilr2A4rYEcoHLOTvbv5Aiio9Q6+yY6HKxE0qOvir
         3Li4dn4y9S8wFAq5sH3OQ5MHQuR96EpConIQZ0AUtey8CJYUOBIZfKhTIYS42fs6GRfA
         0m5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=jnFJyU6U/r5raNKz0Ux3T0Kwl9p3kn1puS17NJMv3N8=;
        b=YcXru2nwt49Pdq18z0e4Tf+6S3IwM/Ep/kwfHncpdSwoMfQVYfcArkfPU97xjnzGJZ
         GKvawUk1UCH2IP67upWLKGRSiocAgU9nvAeTekYtobCvWCnvX3WF/zA53ASGUOugaTDn
         ev3PrsT+CwooX+kOYFsX3iEThXxpN2+g5cSI6Y25I1IgBWZ7GzHZnebUbXl7CiyGKVkU
         mz85zxhCGQV3ShKTOC/Z2zgsQl9F/N5Z7oLy1iWWynv/ZE86qxVsN9YQFjnRatPnjc0h
         Tos/5deA4Z5x4tiFHyYBhKru3g4ftq90eEGxKDCona1Lg5AEeLU/jU/TBNgT78/dTewr
         5oOg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Hans de Goede <hdegoede@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Michael Thayer <michael.thayer@oracle.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] virt: vbox: Move declarations of vboxguest private functions to private header
Date: Thu, 29 Mar 2018 17:28:54 +0200
Message-Id: <20180329152857.32694-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596286400660557451?=
X-GMAIL-MSGID: =?utf-8?q?1596286400660557451?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Move the declarations of functions from vboxguest_utils.c which are only
meant for vboxguest internal use from include/linux/vbox_utils.h to
drivers/virt/vboxguest/vboxguest_core.h.

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/virt/vboxguest/vboxguest_core.h |  8 ++++++++
 include/linux/vbox_utils.h              | 23 -----------------------
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/virt/vboxguest/vboxguest_core.h b/drivers/virt/vboxguest/vboxguest_core.h
index 6c784bf4fa6d..39ed85cf9244 100644
--- a/drivers/virt/vboxguest/vboxguest_core.h
+++ b/drivers/virt/vboxguest/vboxguest_core.h
@@ -171,4 +171,12 @@ irqreturn_t vbg_core_isr(int irq, void *dev_id);
 
 void vbg_linux_mouse_event(struct vbg_dev *gdev);
 
+/* Private (non exported) functions form vboxguest_utils.c */
+void *vbg_req_alloc(size_t len, enum vmmdev_request_type req_type);
+int vbg_req_perform(struct vbg_dev *gdev, void *req);
+int vbg_hgcm_call32(
+	struct vbg_dev *gdev, u32 client_id, u32 function, u32 timeout_ms,
+	struct vmmdev_hgcm_function_parameter32 *parm32, u32 parm_count,
+	int *vbox_status);
+
 #endif
diff --git a/include/linux/vbox_utils.h b/include/linux/vbox_utils.h
index c71def6b310f..a240ed2a0372 100644
--- a/include/linux/vbox_utils.h
+++ b/include/linux/vbox_utils.h
@@ -24,24 +24,6 @@ __printf(1, 2) void vbg_debug(const char *fmt, ...);
 #define vbg_debug pr_debug
 #endif
 
-/**
- * Allocate memory for generic request and initialize the request header.
- *
- * Return: the allocated memory
- * @len:		Size of memory block required for the request.
- * @req_type:		The generic request type.
- */
-void *vbg_req_alloc(size_t len, enum vmmdev_request_type req_type);
-
-/**
- * Perform a generic request.
- *
- * Return: VBox status code
- * @gdev:		The Guest extension device.
- * @req:		Pointer to the request structure.
- */
-int vbg_req_perform(struct vbg_dev *gdev, void *req);
-
 int vbg_hgcm_connect(struct vbg_dev *gdev,
 		     struct vmmdev_hgcm_service_location *loc,
 		     u32 *client_id, int *vbox_status);
@@ -52,11 +34,6 @@ int vbg_hgcm_call(struct vbg_dev *gdev, u32 client_id, u32 function,
 		  u32 timeout_ms, struct vmmdev_hgcm_function_parameter *parms,
 		  u32 parm_count, int *vbox_status);
 
-int vbg_hgcm_call32(
-	struct vbg_dev *gdev, u32 client_id, u32 function, u32 timeout_ms,
-	struct vmmdev_hgcm_function_parameter32 *parm32, u32 parm_count,
-	int *vbox_status);
-
 /**
  * Convert a VirtualBox status code to a standard Linux kernel return value.
  * Return: 0 or negative errno value.
-- 
2.17.0.rc1
