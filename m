Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id NYXCEGZCGVulfAAAmS7hNA
	; Thu, 07 Jun 2018 14:38:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 31A67608BA; Thu,  7 Jun 2018 14:38:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id ED287601C3;
	Thu,  7 Jun 2018 14:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED287601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934233AbeFGOi0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:38:26 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40476 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933882AbeFGOiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:38:23 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbQ-0005a0-Ec; Thu, 07 Jun 2018 15:09:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbC-0003D9-9f; Thu, 07 Jun 2018 15:09:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Pete Zaitcev" <zaitcev@redhat.com>,
        "Fredrik Noring" <noring@nocrew.org>,
        "Pete Zaitcev" <zaitcev@kotori.zaitcev.us>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.829960450@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 339/410] usb: usbmon: Read text within supplied
 buffer size
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Pete Zaitcev <zaitcev@kotori.zaitcev.us>

commit a5f596830e27e15f7a0ecd6be55e433d776986d8 upstream.

This change fixes buffer overflows and silent data corruption with the
usbmon device driver text file read operations.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
Signed-off-by: Pete Zaitcev <zaitcev@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/mon/mon_text.c | 126 +++++++++++++++++++++++--------------
 1 file changed, 78 insertions(+), 48 deletions(-)

--- a/drivers/usb/mon/mon_text.c
+++ b/drivers/usb/mon/mon_text.c
@@ -82,6 +82,8 @@ struct mon_reader_text {
 
 	wait_queue_head_t wait;
 	int printf_size;
+	size_t printf_offset;
+	size_t printf_togo;
 	char *printf_buf;
 	struct mutex printf_lock;
 
@@ -373,75 +375,103 @@ err_alloc:
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
