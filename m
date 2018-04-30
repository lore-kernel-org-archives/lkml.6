Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq0iZ8UExBVP1hmZtBVBb9GtjxQ7V0CaySAlB5zSY0JVwflGQaPCD0x5ZOflUDDqMydP448
ARC-Seal: i=1; a=rsa-sha256; t=1525116523; cv=none;
        d=google.com; s=arc-20160816;
        b=HJ+H+70nyV0fhC6foxS/UolYLVZ9nKV0MgUb8gCAja1Qu393g7nVhVhB/wx3I/G801
         s0mr/rjsuMSPgQXMzXU0q/Vdbt+ihSrSgV2humSPCJB2Qk/zAMNGtmaB8AW1LpkerSsF
         KmHj6PiEvwfJ+Zx+VCnhIZirsipp1jObQvGCXif0lGoAVVdSL1ISW3vpMphjpOj7dT6Y
         vaJ7+vWJlZu0rqKpnLnFxqZ693aNbVqqtaSmRJt6hHaAE7WDPfgwq5YX+NdZwP5n7n+j
         waTrbxm0Y3YToQUHR0SZar8OD/puJ7LyDNZ9BHmS00RSlkP2BPh29QXulu0f8DczObpg
         8p4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=AGkRPu2gmCnboFdOqw81UjlQnS9B+lBybddImTE/Urc=;
        b=mwzpPqYvLLGCenTKFKGGYtuz7OtPqjPwf9qBZDf4qkDW1cf60CUIG4xs+BUImhoxaJ
         6s9vgY63ay6fwUJV0sgrR7ZOoblqYGyKcgdEDJBMl0cKkZ39RUwwxPWMx3YgoyOigp54
         753Ig+q0zUlIExZDFNf0BmMlh5KHsV4dwsIQvmt2rXRCUwN4PblJzYHhwAUzaC2/cyyf
         3PVQmSkewTUVJbPhabK70IPa3Aof+WAk8ObmYFSwsLlFEcohSPOXlMBjgiN8aa2bOdG8
         TFD1mTe9Myun6vqb++QZrQCEfYMXkRn3cIdcbtvrdasnNLWNhAlUZfFD/vMw0L578VtB
         /slA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0DA22DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4.16 091/113] virt: vbox: Add vbg_req_free() helper function
Date: Mon, 30 Apr 2018 12:25:02 -0700
Message-Id: <20180430184019.053662587@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200584100290117?=
X-GMAIL-MSGID: =?utf-8?q?1599200584100290117?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit f6f9885b0531163f72c7bf898a0ab1ba4c7d5de6 upstream.

This is a preparation patch for fixing issues on x86_64 virtual-machines
with more then 4G of RAM, atm we pass __GFP_DMA32 to kmalloc, but kmalloc
does not honor that, so we need to switch to get_pages, which means we
will not be able to use kfree to free memory allocated with vbg_alloc_req.

While at it also remove a comment on a vbg_alloc_req call which talks
about Windows (inherited from the vbox upstream cross-platform code).

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/virt/vboxguest/vboxguest_core.c  |   66 ++++++++++++++++---------------
 drivers/virt/vboxguest/vboxguest_core.h  |    1 
 drivers/virt/vboxguest/vboxguest_utils.c |   14 +++++-
 3 files changed, 47 insertions(+), 34 deletions(-)

--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -114,7 +114,7 @@ static void vbg_guest_mappings_init(stru
 	}
 
 out:
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 	kfree(pages);
 }
 
@@ -144,7 +144,7 @@ static void vbg_guest_mappings_exit(stru
 
 	rc = vbg_req_perform(gdev, req);
 
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 
 	if (rc < 0) {
 		vbg_err("%s error: %d\n", __func__, rc);
@@ -214,8 +214,8 @@ static int vbg_report_guest_info(struct
 	ret = vbg_status_code_to_errno(rc);
 
 out_free:
-	kfree(req2);
-	kfree(req1);
+	vbg_req_free(req2, sizeof(*req2));
+	vbg_req_free(req1, sizeof(*req1));
 	return ret;
 }
 
@@ -245,7 +245,7 @@ static int vbg_report_driver_status(stru
 	if (rc == VERR_NOT_IMPLEMENTED)	/* Compatibility with older hosts. */
 		rc = VINF_SUCCESS;
 
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 
 	return vbg_status_code_to_errno(rc);
 }
@@ -431,7 +431,7 @@ static int vbg_heartbeat_host_config(str
 	rc = vbg_req_perform(gdev, req);
 	do_div(req->interval_ns, 1000000); /* ns -> ms */
 	gdev->heartbeat_interval_ms = req->interval_ns;
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 
 	return vbg_status_code_to_errno(rc);
 }
@@ -454,12 +454,6 @@ static int vbg_heartbeat_init(struct vbg
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
@@ -481,8 +475,8 @@ static void vbg_heartbeat_exit(struct vb
 {
 	del_timer_sync(&gdev->heartbeat_timer);
 	vbg_heartbeat_host_config(gdev, false);
-	kfree(gdev->guest_heartbeat_req);
-
+	vbg_req_free(gdev->guest_heartbeat_req,
+		     sizeof(*gdev->guest_heartbeat_req));
 }
 
 /**
@@ -543,7 +537,7 @@ static int vbg_reset_host_event_filter(s
 	if (rc < 0)
 		vbg_err("%s error, rc: %d\n", __func__, rc);
 
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 	return vbg_status_code_to_errno(rc);
 }
 
@@ -617,7 +611,7 @@ static int vbg_set_session_event_filter(
 
 out:
 	mutex_unlock(&gdev->session_mutex);
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 
 	return ret;
 }
@@ -642,7 +636,7 @@ static int vbg_reset_host_capabilities(s
 	if (rc < 0)
 		vbg_err("%s error, rc: %d\n", __func__, rc);
 
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 	return vbg_status_code_to_errno(rc);
 }
 
@@ -712,7 +706,7 @@ static int vbg_set_session_capabilities(
 
 out:
 	mutex_unlock(&gdev->session_mutex);
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 
 	return ret;
 }
@@ -749,7 +743,7 @@ static int vbg_query_host_version(struct
 	}
 
 out:
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 	return ret;
 }
 
@@ -847,11 +841,16 @@ int vbg_core_init(struct vbg_dev *gdev,
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
@@ -1415,7 +1419,7 @@ static int vbg_ioctl_write_core_dump(str
 	req->flags = dump->u.in.flags;
 	dump->hdr.rc = vbg_req_perform(gdev, req);
 
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 	return 0;
 }
 
@@ -1513,7 +1517,7 @@ int vbg_core_set_mouse_status(struct vbg
 	if (rc < 0)
 		vbg_err("%s error, rc: %d\n", __func__, rc);
 
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 	return vbg_status_code_to_errno(rc);
 }
 
--- a/drivers/virt/vboxguest/vboxguest_core.h
+++ b/drivers/virt/vboxguest/vboxguest_core.h
@@ -173,6 +173,7 @@ void vbg_linux_mouse_event(struct vbg_de
 
 /* Private (non exported) functions form vboxguest_utils.c */
 void *vbg_req_alloc(size_t len, enum vmmdev_request_type req_type);
+void vbg_req_free(void *req, size_t len);
 int vbg_req_perform(struct vbg_dev *gdev, void *req);
 int vbg_hgcm_call32(
 	struct vbg_dev *gdev, u32 client_id, u32 function, u32 timeout_ms,
--- a/drivers/virt/vboxguest/vboxguest_utils.c
+++ b/drivers/virt/vboxguest/vboxguest_utils.c
@@ -82,6 +82,14 @@ void *vbg_req_alloc(size_t len, enum vmm
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
@@ -137,7 +145,7 @@ int vbg_hgcm_connect(struct vbg_dev *gde
 		rc = hgcm_connect->header.result;
 	}
 
-	kfree(hgcm_connect);
+	vbg_req_free(hgcm_connect, sizeof(*hgcm_connect));
 
 	*vbox_status = rc;
 	return 0;
@@ -166,7 +174,7 @@ int vbg_hgcm_disconnect(struct vbg_dev *
 	if (rc >= 0)
 		rc = hgcm_disconnect->header.result;
 
-	kfree(hgcm_disconnect);
+	vbg_req_free(hgcm_disconnect, sizeof(*hgcm_disconnect));
 
 	*vbox_status = rc;
 	return 0;
@@ -623,7 +631,7 @@ int vbg_hgcm_call(struct vbg_dev *gdev,
 	}
 
 	if (!leak_it)
-		kfree(call);
+		vbg_req_free(call, size);
 
 free_bounce_bufs:
 	if (bounce_bufs) {
