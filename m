Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AIpwx4+oi7GSyLUvuq/4zW18mVlOCxLeoJjzmdSvgp4qlElBs9FPeTlkfaVrZwXTZGy/aSDtGjGj
ARC-Seal: i=1; a=rsa-sha256; t=1522337342; cv=none;
        d=google.com; s=arc-20160816;
        b=hpfBMlfbHdH7C7AZ6ToD/xCzsOQ/aPv4eRgfGGbx6zBu6QbO/1d1d9jK80RqCt5CeZ
         qp4ivUw4RLgj+l/EtVoiBOwbb+pR/y82tOwb3IrYNLNXgzNaLexeBAZP+yEJPKN2oWBo
         mlV+rBeXn03IoIiPLkZ0IAZGFZhO/GB0Xk8IKU3E1QKe3bU5ruGwdp33S0OtgJ8K4amF
         P1iMPnZFbfdtByLilkxAkW9Qv7suDeXc6fYzPqX9+XFSakty/x7tiqNQp3VEFI+OX91x
         6PzZrysYCOks6Wzs6xGgzOnd+DxuRLqzkab0lyoVMjTWNqxs8Yeb0WUN2QShkk5seHn4
         wwFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=bIvM3X9NJdDLqiJ+4a+yrIPmcSf+yM9f0w5ohPq1V3g=;
        b=PdewXwU4UqEo/0nqHFzAh1sUqr4ytyLDPwvZrZAyP7UtS6dokGPbjkvVHOtg9Eqle3
         3zp/YcrnTvnkKF/vnv/0mT+fpb1zNmce5NFQxnEOGMOgBzmCDS1fUShiV3WQIrVGrSJg
         domMLAjTcQS7X0vkDA1o/o1oJL72z8rvNF2NeO/GkXaIbAIw42ckZy2Kynq6aS9GKieK
         xADpDPxTvOqoK8GYVk52Cr0xmsGoRwU/XCkdkOGslEwrM2yscidzdMtyaOsxhiNr0vUW
         f7TmmAl03vmy2BoDkgHjnD34MBLROT2UQYNt2YziUIbF8ggqc/QnO9wZXxvIXevKwK8Y
         NHfg==
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
Subject: [PATCH v2 2/4] virt: vbox: Add vbg_req_free() helper function
Date: Thu, 29 Mar 2018 17:28:55 +0200
Message-Id: <20180329152857.32694-2-hdegoede@redhat.com>
In-Reply-To: <20180329152857.32694-1-hdegoede@redhat.com>
References: <20180329152857.32694-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596270815677103806?=
X-GMAIL-MSGID: =?utf-8?q?1596286401625363577?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a preparation patch for fixing issues on x86_64 virtual-machines
with more then 4G of RAM, atm we pass __GFP_DMA32 to kmalloc, but kmalloc
does not honor that, so we need to switch to get_pages, which means we
will not be able to use kfree to free memory allocated with vbg_alloc_req.

While at it also remove a comment on a vbg_alloc_req call which talks
about Windows (inherited from the vbox upstream cross-platform code).

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Put the vbg_req_free() prototype decl. in the private vboxguest_core.h
 instead of in linux/vbox_utils.h as it is private
---
 drivers/virt/vboxguest/vboxguest_core.c  | 66 +++++++++++++-----------
 drivers/virt/vboxguest/vboxguest_core.h  |  1 +
 drivers/virt/vboxguest/vboxguest_utils.c | 14 +++--
 3 files changed, 47 insertions(+), 34 deletions(-)

diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
index 190dbf8cfcb5..7411a535fda2 100644
--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -114,7 +114,7 @@ static void vbg_guest_mappings_init(struct vbg_dev *gdev)
 	}
 
 out:
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 	kfree(pages);
 }
 
@@ -144,7 +144,7 @@ static void vbg_guest_mappings_exit(struct vbg_dev *gdev)
 
 	rc = vbg_req_perform(gdev, req);
 
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 
 	if (rc < 0) {
 		vbg_err("%s error: %d\n", __func__, rc);
@@ -214,8 +214,8 @@ static int vbg_report_guest_info(struct vbg_dev *gdev)
 	ret = vbg_status_code_to_errno(rc);
 
 out_free:
-	kfree(req2);
-	kfree(req1);
+	vbg_req_free(req2, sizeof(*req2));
+	vbg_req_free(req1, sizeof(*req1));
 	return ret;
 }
 
@@ -245,7 +245,7 @@ static int vbg_report_driver_status(struct vbg_dev *gdev, bool active)
 	if (rc == VERR_NOT_IMPLEMENTED)	/* Compatibility with older hosts. */
 		rc = VINF_SUCCESS;
 
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 
 	return vbg_status_code_to_errno(rc);
 }
@@ -431,7 +431,7 @@ static int vbg_heartbeat_host_config(struct vbg_dev *gdev, bool enabled)
 	rc = vbg_req_perform(gdev, req);
 	do_div(req->interval_ns, 1000000); /* ns -> ms */
 	gdev->heartbeat_interval_ms = req->interval_ns;
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 
 	return vbg_status_code_to_errno(rc);
 }
@@ -454,12 +454,6 @@ static int vbg_heartbeat_init(struct vbg_dev *gdev)
 	if (ret < 0)
 		return ret;
 
-	/*
-	 * Preallocate the request to use it from the timer callback because:
-	 *    1) on Windows vbg_req_alloc must be called at IRQL <= APC_LEVEL
-	 *       and the timer callback runs at DISPATCH_LEVEL;
-	 *    2) avoid repeated allocations.
-	 */
 	gdev->guest_heartbeat_req = vbg_req_alloc(
 					sizeof(*gdev->guest_heartbeat_req),
 					VMMDEVREQ_GUEST_HEARTBEAT);
@@ -481,8 +475,8 @@ static void vbg_heartbeat_exit(struct vbg_dev *gdev)
 {
 	del_timer_sync(&gdev->heartbeat_timer);
 	vbg_heartbeat_host_config(gdev, false);
-	kfree(gdev->guest_heartbeat_req);
-
+	vbg_req_free(gdev->guest_heartbeat_req,
+		     sizeof(*gdev->guest_heartbeat_req));
 }
 
 /**
@@ -543,7 +537,7 @@ static int vbg_reset_host_event_filter(struct vbg_dev *gdev,
 	if (rc < 0)
 		vbg_err("%s error, rc: %d\n", __func__, rc);
 
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 	return vbg_status_code_to_errno(rc);
 }
 
@@ -617,7 +611,7 @@ static int vbg_set_session_event_filter(struct vbg_dev *gdev,
 
 out:
 	mutex_unlock(&gdev->session_mutex);
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 
 	return ret;
 }
@@ -642,7 +636,7 @@ static int vbg_reset_host_capabilities(struct vbg_dev *gdev)
 	if (rc < 0)
 		vbg_err("%s error, rc: %d\n", __func__, rc);
 
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 	return vbg_status_code_to_errno(rc);
 }
 
@@ -712,7 +706,7 @@ static int vbg_set_session_capabilities(struct vbg_dev *gdev,
 
 out:
 	mutex_unlock(&gdev->session_mutex);
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 
 	return ret;
 }
@@ -749,7 +743,7 @@ static int vbg_query_host_version(struct vbg_dev *gdev)
 	}
 
 out:
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 	return ret;
 }
 
@@ -847,11 +841,16 @@ int vbg_core_init(struct vbg_dev *gdev, u32 fixed_events)
 	return 0;
 
 err_free_reqs:
-	kfree(gdev->mouse_status_req);
-	kfree(gdev->ack_events_req);
-	kfree(gdev->cancel_req);
-	kfree(gdev->mem_balloon.change_req);
-	kfree(gdev->mem_balloon.get_req);
+	vbg_req_free(gdev->mouse_status_req,
+		     sizeof(*gdev->mouse_status_req));
+	vbg_req_free(gdev->ack_events_req,
+		     sizeof(*gdev->ack_events_req));
+	vbg_req_free(gdev->cancel_req,
+		     sizeof(*gdev->cancel_req));
+	vbg_req_free(gdev->mem_balloon.change_req,
+		     sizeof(*gdev->mem_balloon.change_req));
+	vbg_req_free(gdev->mem_balloon.get_req,
+		     sizeof(*gdev->mem_balloon.get_req));
 	return ret;
 }
 
@@ -872,11 +871,16 @@ void vbg_core_exit(struct vbg_dev *gdev)
 	vbg_reset_host_capabilities(gdev);
 	vbg_core_set_mouse_status(gdev, 0);
 
-	kfree(gdev->mouse_status_req);
-	kfree(gdev->ack_events_req);
-	kfree(gdev->cancel_req);
-	kfree(gdev->mem_balloon.change_req);
-	kfree(gdev->mem_balloon.get_req);
+	vbg_req_free(gdev->mouse_status_req,
+		     sizeof(*gdev->mouse_status_req));
+	vbg_req_free(gdev->ack_events_req,
+		     sizeof(*gdev->ack_events_req));
+	vbg_req_free(gdev->cancel_req,
+		     sizeof(*gdev->cancel_req));
+	vbg_req_free(gdev->mem_balloon.change_req,
+		     sizeof(*gdev->mem_balloon.change_req));
+	vbg_req_free(gdev->mem_balloon.get_req,
+		     sizeof(*gdev->mem_balloon.get_req));
 }
 
 /**
@@ -1415,7 +1419,7 @@ static int vbg_ioctl_write_core_dump(struct vbg_dev *gdev,
 	req->flags = dump->u.in.flags;
 	dump->hdr.rc = vbg_req_perform(gdev, req);
 
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 	return 0;
 }
 
@@ -1513,7 +1517,7 @@ int vbg_core_set_mouse_status(struct vbg_dev *gdev, u32 features)
 	if (rc < 0)
 		vbg_err("%s error, rc: %d\n", __func__, rc);
 
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 	return vbg_status_code_to_errno(rc);
 }
 
diff --git a/drivers/virt/vboxguest/vboxguest_core.h b/drivers/virt/vboxguest/vboxguest_core.h
index 39ed85cf9244..7ad9ec45bfa9 100644
--- a/drivers/virt/vboxguest/vboxguest_core.h
+++ b/drivers/virt/vboxguest/vboxguest_core.h
@@ -173,6 +173,7 @@ void vbg_linux_mouse_event(struct vbg_dev *gdev);
 
 /* Private (non exported) functions form vboxguest_utils.c */
 void *vbg_req_alloc(size_t len, enum vmmdev_request_type req_type);
+void vbg_req_free(void *req, size_t len);
 int vbg_req_perform(struct vbg_dev *gdev, void *req);
 int vbg_hgcm_call32(
 	struct vbg_dev *gdev, u32 client_id, u32 function, u32 timeout_ms,
diff --git a/drivers/virt/vboxguest/vboxguest_utils.c b/drivers/virt/vboxguest/vboxguest_utils.c
index 0f0dab8023cf..bad915463359 100644
--- a/drivers/virt/vboxguest/vboxguest_utils.c
+++ b/drivers/virt/vboxguest/vboxguest_utils.c
@@ -82,6 +82,14 @@ void *vbg_req_alloc(size_t len, enum vmmdev_request_type req_type)
 	return req;
 }
 
+void vbg_req_free(void *req, size_t len)
+{
+	if (!req)
+		return;
+
+	kfree(req);
+}
+
 /* Note this function returns a VBox status code, not a negative errno!! */
 int vbg_req_perform(struct vbg_dev *gdev, void *req)
 {
@@ -137,7 +145,7 @@ int vbg_hgcm_connect(struct vbg_dev *gdev,
 		rc = hgcm_connect->header.result;
 	}
 
-	kfree(hgcm_connect);
+	vbg_req_free(hgcm_connect, sizeof(*hgcm_connect));
 
 	*vbox_status = rc;
 	return 0;
@@ -166,7 +174,7 @@ int vbg_hgcm_disconnect(struct vbg_dev *gdev, u32 client_id, int *vbox_status)
 	if (rc >= 0)
 		rc = hgcm_disconnect->header.result;
 
-	kfree(hgcm_disconnect);
+	vbg_req_free(hgcm_disconnect, sizeof(*hgcm_disconnect));
 
 	*vbox_status = rc;
 	return 0;
@@ -623,7 +631,7 @@ int vbg_hgcm_call(struct vbg_dev *gdev, u32 client_id, u32 function,
 	}
 
 	if (!leak_it)
-		kfree(call);
+		vbg_req_free(call, size);
 
 free_bounce_bufs:
 	if (bounce_bufs) {
-- 
2.17.0.rc1
