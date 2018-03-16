Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtv9u8JMz8cDL7Kwmv/dokAt2PaZTUNYeKVSWoWKly8pQckJOV1mnsKoWXImHXxZ/880XU+
ARC-Seal: i=1; a=rsa-sha256; t=1521214440; cv=none;
        d=google.com; s=arc-20160816;
        b=haENBPddu4yz4NGXeu19Y9Z4+tAEJ+0UPtvp6vUQ3JT5xOipQWZiYYT58Gb7yEckwo
         iolmumDDYr5qjt8iwUlDsfatBBq3CWD2C1RosZlOCwR/hXAyYN2k3LufeFDohxvzx2bU
         FPpnqMCMKN7ZDo/QbVjUkMqafKoelviB+b2Z/YsmoATY0HUC//rBuaFOXWPgjn6QZ0Mn
         R4GSTnUiy0J/6L7vAZ5YLrMC9JO/2KLyR5pjiPsxbNe08X9N1m/4sYGQf9VWuI/BFK5k
         GDOrKVQ3CatJ56LU9W2GIQ4T4akvOdqSnzVUAovQfTyHS9WU0cofoe0qbjBpilln7zgB
         4bRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3Uc0Q57mPGSnODFc7RIbg7dDCWdmmdlILzvlXj6sJec=;
        b=Xz3YBaS50dMlI6z5qErGPqsGpo5Lt/JG/2PlPNOIaDQz6iTKLfRg5Aqd0c9E0v1cmw
         V8Sy+/5lOqX0NhCmpVh3ry0rSo7RPu04JagXwZQz7lW0Gd3FWhXmsP3669N7RZBc2StX
         DY2qFjfUBnv0QQ3OJ7xKWbcnSSge+UQSf9EKxyqHcrKL+hSusTrwWt0ImvaK+3WSSbz6
         gie+K/YJzWP8VQZwihuOfi4qWOK9RbslMvJshGnoq1rOfhzQz7JVNwNYWhl6caSEtxq0
         0a03b49MHTIkrcRNVp/KIPhtWZGPD9PXbtBTk1le+QXrWZiUyEc7DQwTGMGNfe/hAtRK
         ZCAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Fredrik Noring <noring@nocrew.org>,
	Pete Zaitcev <zaitcev@redhat.com>
Subject: [PATCH 4.9 81/86] usb: usbmon: Read text within supplied buffer size
Date: Fri, 16 Mar 2018 16:23:44 +0100
Message-Id: <20180316152322.800823379@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108322348681273?=
X-GMAIL-MSGID: =?utf-8?q?1595108952711764277?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pete Zaitcev <zaitcev@kotori.zaitcev.us>

commit a5f596830e27e15f7a0ecd6be55e433d776986d8 upstream.

This change fixes buffer overflows and silent data corruption with the
usbmon device driver text file read operations.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/mon/mon_text.c |  124 +++++++++++++++++++++++++++------------------
 1 file changed, 77 insertions(+), 47 deletions(-)

--- a/drivers/usb/mon/mon_text.c
+++ b/drivers/usb/mon/mon_text.c
@@ -83,6 +83,8 @@ struct mon_reader_text {
 
 	wait_queue_head_t wait;
 	int printf_size;
+	size_t printf_offset;
+	size_t printf_togo;
 	char *printf_buf;
 	struct mutex printf_lock;
 
@@ -374,75 +376,103 @@ err_alloc:
 	return rc;
 }
 
-/*
- * For simplicity, we read one record in one system call and throw out
- * what does not fit. This means that the following does not work:
- *   dd if=/dbg/usbmon/0t bs=10
- * Also, we do not allow seeks and do not bother advancing the offset.
- */
+static ssize_t mon_text_copy_to_user(struct mon_reader_text *rp,
+    char __user * const buf, const size_t nbytes)
+{
+	const size_t togo = min(nbytes, rp->printf_togo);
+
+	if (copy_to_user(buf, &rp->printf_buf[rp->printf_offset], togo))
+		return -EFAULT;
+	rp->printf_togo -= togo;
+	rp->printf_offset += togo;
+	return togo;
+}
+
+/* ppos is not advanced since the llseek operation is not permitted. */
 static ssize_t mon_text_read_t(struct file *file, char __user *buf,
-				size_t nbytes, loff_t *ppos)
+    size_t nbytes, loff_t *ppos)
 {
 	struct mon_reader_text *rp = file->private_data;
 	struct mon_event_text *ep;
 	struct mon_text_ptr ptr;
+	ssize_t ret;
 
-	ep = mon_text_read_wait(rp, file);
-	if (IS_ERR(ep))
-		return PTR_ERR(ep);
 	mutex_lock(&rp->printf_lock);
-	ptr.cnt = 0;
-	ptr.pbuf = rp->printf_buf;
-	ptr.limit = rp->printf_size;
-
-	mon_text_read_head_t(rp, &ptr, ep);
-	mon_text_read_statset(rp, &ptr, ep);
-	ptr.cnt += snprintf(ptr.pbuf + ptr.cnt, ptr.limit - ptr.cnt,
-	    " %d", ep->length);
-	mon_text_read_data(rp, &ptr, ep);
 
-	if (copy_to_user(buf, rp->printf_buf, ptr.cnt))
-		ptr.cnt = -EFAULT;
+	if (rp->printf_togo == 0) {
+
+		ep = mon_text_read_wait(rp, file);
+		if (IS_ERR(ep)) {
+			mutex_unlock(&rp->printf_lock);
+			return PTR_ERR(ep);
+		}
+		ptr.cnt = 0;
+		ptr.pbuf = rp->printf_buf;
+		ptr.limit = rp->printf_size;
+
+		mon_text_read_head_t(rp, &ptr, ep);
+		mon_text_read_statset(rp, &ptr, ep);
+		ptr.cnt += snprintf(ptr.pbuf + ptr.cnt, ptr.limit - ptr.cnt,
+		    " %d", ep->length);
+		mon_text_read_data(rp, &ptr, ep);
+
+		rp->printf_togo = ptr.cnt;
+		rp->printf_offset = 0;
+
+		kmem_cache_free(rp->e_slab, ep);
+	}
+
+	ret = mon_text_copy_to_user(rp, buf, nbytes);
 	mutex_unlock(&rp->printf_lock);
-	kmem_cache_free(rp->e_slab, ep);
-	return ptr.cnt;
+	return ret;
 }
 
+/* ppos is not advanced since the llseek operation is not permitted. */
 static ssize_t mon_text_read_u(struct file *file, char __user *buf,
-				size_t nbytes, loff_t *ppos)
+    size_t nbytes, loff_t *ppos)
 {
 	struct mon_reader_text *rp = file->private_data;
 	struct mon_event_text *ep;
 	struct mon_text_ptr ptr;
+	ssize_t ret;
 
-	ep = mon_text_read_wait(rp, file);
-	if (IS_ERR(ep))
-		return PTR_ERR(ep);
 	mutex_lock(&rp->printf_lock);
-	ptr.cnt = 0;
-	ptr.pbuf = rp->printf_buf;
-	ptr.limit = rp->printf_size;
 
-	mon_text_read_head_u(rp, &ptr, ep);
-	if (ep->type == 'E') {
-		mon_text_read_statset(rp, &ptr, ep);
-	} else if (ep->xfertype == USB_ENDPOINT_XFER_ISOC) {
-		mon_text_read_isostat(rp, &ptr, ep);
-		mon_text_read_isodesc(rp, &ptr, ep);
-	} else if (ep->xfertype == USB_ENDPOINT_XFER_INT) {
-		mon_text_read_intstat(rp, &ptr, ep);
-	} else {
-		mon_text_read_statset(rp, &ptr, ep);
+	if (rp->printf_togo == 0) {
+
+		ep = mon_text_read_wait(rp, file);
+		if (IS_ERR(ep)) {
+			mutex_unlock(&rp->printf_lock);
+			return PTR_ERR(ep);
+		}
+		ptr.cnt = 0;
+		ptr.pbuf = rp->printf_buf;
+		ptr.limit = rp->printf_size;
+
+		mon_text_read_head_u(rp, &ptr, ep);
+		if (ep->type == 'E') {
+			mon_text_read_statset(rp, &ptr, ep);
+		} else if (ep->xfertype == USB_ENDPOINT_XFER_ISOC) {
+			mon_text_read_isostat(rp, &ptr, ep);
+			mon_text_read_isodesc(rp, &ptr, ep);
+		} else if (ep->xfertype == USB_ENDPOINT_XFER_INT) {
+			mon_text_read_intstat(rp, &ptr, ep);
+		} else {
+			mon_text_read_statset(rp, &ptr, ep);
+		}
+		ptr.cnt += snprintf(ptr.pbuf + ptr.cnt, ptr.limit - ptr.cnt,
+		    " %d", ep->length);
+		mon_text_read_data(rp, &ptr, ep);
+
+		rp->printf_togo = ptr.cnt;
+		rp->printf_offset = 0;
+
+		kmem_cache_free(rp->e_slab, ep);
 	}
-	ptr.cnt += snprintf(ptr.pbuf + ptr.cnt, ptr.limit - ptr.cnt,
-	    " %d", ep->length);
-	mon_text_read_data(rp, &ptr, ep);
 
-	if (copy_to_user(buf, rp->printf_buf, ptr.cnt))
-		ptr.cnt = -EFAULT;
+	ret = mon_text_copy_to_user(rp, buf, nbytes);
 	mutex_unlock(&rp->printf_lock);
-	kmem_cache_free(rp->e_slab, ep);
-	return ptr.cnt;
+	return ret;
 }
 
 static struct mon_event_text *mon_text_read_wait(struct mon_reader_text *rp,
