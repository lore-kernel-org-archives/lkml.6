Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuYQqwU8x1qiamJNOFmVisnxxJ5znJPPqPff0tqo9GJYwMKeCG+gsj3SUbvc7B8o/vz0PTI
ARC-Seal: i=1; a=rsa-sha256; t=1521214783; cv=none;
        d=google.com; s=arc-20160816;
        b=xRQJSjfPIkdT3vG7/mKMRRhQYO+25z85/OHiS+FQ7B0Uo/Tarq+vW1QEr+y6AeZAr9
         9GpYWOh5iyZFpvEk8ScVEqBSbn2czxXwjNeTu5c4nORt4u93q94YRKvX92AqdJkpy53c
         2KCyhogyTOOcK6EfxCRvjG2zKkkf8b65C3G+eVL6jqEBzHa8Z8djaHwyIJ57QCAtVDg4
         +/UzIsHwx0G3q6YrZJQwRPMNMmrNQ66jsNvt0/61Sm4yvriwsLkqdv3ymuByDokfUnqX
         qUU4HhUbRfFaHmy+7WLRXUKtUF4POQSs9N3ylf2tdRxLmr0Blec1H/x8hLpDseiaOG1V
         kklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ESScZ4/NPv+7fWDdeCeOPOEoJEeN9BtpOPn0g0tFJmM=;
        b=dCd7hKeXzLpwZYnSeO3JsTOAVEC/ezkQIYBlZX4JrZXTmIp3qyqLiGmtxi5/+KI+hZ
         kavaVUX02q8vdGaEygE8RapMABiI+EYdbriyM6oXhaOhLUZBuiviHPR8qfKuwKMPotG+
         dWb+bzZIDk+GW7FhVbeUYlgv3mlP7Gejwd8ErqCeXsChfhjBVMOk3QuQirQJWFw0Zs8F
         8UtKJoerZ6PJGfWv+wgJ9/dpfoihdAVJfNELpEVyjYmcFWhsZs6/fxHvyyGn5shSjVQY
         PxWdGTPI7CBGNvFNQkStr9nU3ccN5VYMlGFugX4POtllRtV1bY378GCYw880f/gTIhnP
         QsKA==
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
Subject: [PATCH 4.15 018/128] usb: usbmon: Read text within supplied buffer size
Date: Fri, 16 Mar 2018 16:22:39 +0100
Message-Id: <20180316152337.351400305@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108322348681273?=
X-GMAIL-MSGID: =?utf-8?q?1595109312380836585?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -85,6 +85,8 @@ struct mon_reader_text {
 
 	wait_queue_head_t wait;
 	int printf_size;
+	size_t printf_offset;
+	size_t printf_togo;
 	char *printf_buf;
 	struct mutex printf_lock;
 
@@ -376,75 +378,103 @@ err_alloc:
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
