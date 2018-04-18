Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AB8JxZpzoqx3Vf+Se8hnFX6+9455+g5CjW6GPr2sqEWS7GDOoXLYEbIf6y0yPfdwYHSTMOYb23+x
ARC-Seal: i=1; a=rsa-sha256; t=1524057894; cv=none;
        d=google.com; s=arc-20160816;
        b=KFrpOxrKhH9D1wDGA++RiKzd/vb5ZV+R/kj+N3n+gGof5mlXkRznSeVvus7zQoPDpw
         NNaVOP+rkeVBz2b7kwDHFn/GvTd+298IVHF5tM3UEAq/RufAMIBUgHxO8Vht/oBNO6C/
         4yrGZ0MvRdoonzo8GJXtMbD/cN53Du6SGPP0ZqTGx4a2OZVWYWPrNymHJmqgVM2j6Mmf
         ftElJuuShrseQJu29bLW4drCxdsFYhnEnIfZRx0Rl3syJywoPHQsaYrO/u2ddsNGMmLr
         /wxyABLwJ8fsCCyOoQtOdV/AnIQvpQI0iLJJ6PvIGZHQggIliV+Cbv2Stimg2M+7+3fm
         Nxgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=T4M3DpTLp3tJTtLZbMDkaPpjJQC9mVR2ib0RwvrgTJ4=;
        b=JyfdcWREjkQ8XYmt2+BfUZEAJ0sjj0qWsbUnWj8l9GOIjcoIirsYr2bKChf0FDojCM
         3/EV9H4BtHNOqLeuJwzaDUn/EwHHqFzagIN+A4x/WT8U0baK3g3FO687YGdcrq79t8mz
         wEoP3KvbQsapo9eKk9YElZonKu93Ooy75mLVucBiisR5k5fIVWVQdiZpoFIGIDxfEG8y
         pfAARl53BpA1M9iXXOCQ8tcwqCK/BpkFZcjasFQx2uUbmZiW2raFhuDVjRtWD5vCpskX
         MAduKIS5rtZH8Fd7ffCKW6ZIC/YEnf4yCWBH2yXfvuq46w7jZu+vtI7Zp7VCxdk1Rq9B
         z/Ow==
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
	Larry Finger <Larry.Finger@lwfinger.net>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH resend 1/4] virt: vbox: Move declarations of vboxguest private functions to private header
Date: Wed, 18 Apr 2018 15:24:47 +0200
Message-Id: <20180418132450.11663-2-hdegoede@redhat.com>
In-Reply-To: <20180418132450.11663-1-hdegoede@redhat.com>
References: <20180418132450.11663-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598090530309243872?=
X-GMAIL-MSGID: =?utf-8?q?1598090530309243872?=
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
2.17.0
