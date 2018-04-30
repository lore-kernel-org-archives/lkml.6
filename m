Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoe5nRJcTCrcOsiDYdOXrtdjn9aX+vPOoGYVYuf86WUpa5KuAhnq1UMUsjd0BuuhWa9lNoh
ARC-Seal: i=1; a=rsa-sha256; t=1525116483; cv=none;
        d=google.com; s=arc-20160816;
        b=T52uhLJsq+7JB00CyAF/N4io5nyqx32oTb6eB933TKQc8p9tJjCMpXJeLPu9p3eQWu
         rTjLUPEEoqoNaQqY89ZEzRHBrFSuzV7+DEZeCdkfSfKNmTpmt5NPzr+q/dlnAh2OXn79
         T83m85kPyfOe3dSy6Ptt4kP1qitnsnL6qUmC7ucHJavy1084gbzBr6LccXFl3kFzCudD
         G8JyLSBIBsUiRGIE2qfQ65amqEBDULqFuqUCkYrTP0dQpQmUhKtEZtc3q3ePfvQWghem
         RE6IMSrOOuh8Mnu45x9SPPPrTiBaTr0Z9p66TU+v3M0WBxxqux3l25gpMWqVSBK/jRMx
         mtYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=L1yH//QUXSQn+A6zqai6loiSHK6xKOzhejdP2dqjK4s=;
        b=nGreZoUB1FMvwACsr/DfUyqucOS9fqrP0X0T0Biu0SScIObvWD8rLgjdERbPSHuoV9
         QSQfRpEZ9IqJwPpfCE/5xParO+Cy2A7sIAYAKk8xKeMt8gD4MvTif3bVRVUC/zjWQQ3h
         0YVk7fGKb+ehFuQol3gRI5j2qXKO0OTOErpG99JTvpy2vFVv9AZ+pLqGasFKaT/KGyFQ
         Ugg85q3xQ3BIa7oC43dvjsow6iWTNwxhE/EaMrdDq6sEA+wcTdRG6xIjXm2uJXm9t+1S
         QSjBfAmW8pbmcG56SDMhTDzUIVeT3bB6rz0gsHQZ1V5E3waKu0wBCBsRtzKhWVMFjATO
         cxOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD4A22DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tiwei Bie <tiwei.bie@intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4.16 026/113] virtio_console: free buffers after reset
Date: Mon, 30 Apr 2018 12:23:57 -0700
Message-Id: <20180430184016.178610483@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200399540203794?=
X-GMAIL-MSGID: =?utf-8?q?1599200542230621179?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael S. Tsirkin <mst@redhat.com>

commit a7a69ec0d8e4a58be7db88d33cbfa2912807bb2b upstream.

Console driver is out of spec. The spec says:
	A driver MUST NOT decrement the available idx on a live
	virtqueue (ie. there is no way to “unexpose” buffers).
and it does exactly that by trying to detach unused buffers
without doing a device reset first.

Defer detaching the buffers until device unplug.

Of course this means we might get an interrupt for
a vq without an attached port now. Handle that by
discarding the consumed buffer.

Reported-by: Tiwei Bie <tiwei.bie@intel.com>
Fixes: b3258ff1d6 ("virtio: Decrement avail idx on buffer detach")
Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/virtio_console.c |   49 ++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1402,7 +1402,6 @@ static int add_port(struct ports_device
 {
 	char debugfs_name[16];
 	struct port *port;
-	struct port_buffer *buf;
 	dev_t devt;
 	unsigned int nr_added_bufs;
 	int err;
@@ -1513,8 +1512,6 @@ static int add_port(struct ports_device
 	return 0;
 
 free_inbufs:
-	while ((buf = virtqueue_detach_unused_buf(port->in_vq)))
-		free_buf(buf, true);
 free_device:
 	device_destroy(pdrvdata.class, port->dev->devt);
 free_cdev:
@@ -1539,34 +1536,14 @@ static void remove_port(struct kref *kre
 
 static void remove_port_data(struct port *port)
 {
-	struct port_buffer *buf;
-
 	spin_lock_irq(&port->inbuf_lock);
 	/* Remove unused data this port might have received. */
 	discard_port_data(port);
 	spin_unlock_irq(&port->inbuf_lock);
 
-	/* Remove buffers we queued up for the Host to send us data in. */
-	do {
-		spin_lock_irq(&port->inbuf_lock);
-		buf = virtqueue_detach_unused_buf(port->in_vq);
-		spin_unlock_irq(&port->inbuf_lock);
-		if (buf)
-			free_buf(buf, true);
-	} while (buf);
-
 	spin_lock_irq(&port->outvq_lock);
 	reclaim_consumed_buffers(port);
 	spin_unlock_irq(&port->outvq_lock);
-
-	/* Free pending buffers from the out-queue. */
-	do {
-		spin_lock_irq(&port->outvq_lock);
-		buf = virtqueue_detach_unused_buf(port->out_vq);
-		spin_unlock_irq(&port->outvq_lock);
-		if (buf)
-			free_buf(buf, true);
-	} while (buf);
 }
 
 /*
@@ -1791,13 +1768,24 @@ static void control_work_handler(struct
 	spin_unlock(&portdev->c_ivq_lock);
 }
 
+static void flush_bufs(struct virtqueue *vq, bool can_sleep)
+{
+	struct port_buffer *buf;
+	unsigned int len;
+
+	while ((buf = virtqueue_get_buf(vq, &len)))
+		free_buf(buf, can_sleep);
+}
+
 static void out_intr(struct virtqueue *vq)
 {
 	struct port *port;
 
 	port = find_port_by_vq(vq->vdev->priv, vq);
-	if (!port)
+	if (!port) {
+		flush_bufs(vq, false);
 		return;
+	}
 
 	wake_up_interruptible(&port->waitqueue);
 }
@@ -1808,8 +1796,10 @@ static void in_intr(struct virtqueue *vq
 	unsigned long flags;
 
 	port = find_port_by_vq(vq->vdev->priv, vq);
-	if (!port)
+	if (!port) {
+		flush_bufs(vq, false);
 		return;
+	}
 
 	spin_lock_irqsave(&port->inbuf_lock, flags);
 	port->inbuf = get_inbuf(port);
@@ -1984,6 +1974,15 @@ static const struct file_operations port
 
 static void remove_vqs(struct ports_device *portdev)
 {
+	struct virtqueue *vq;
+
+	virtio_device_for_each_vq(portdev->vdev, vq) {
+		struct port_buffer *buf;
+
+		flush_bufs(vq, true);
+		while ((buf = virtqueue_detach_unused_buf(vq)))
+			free_buf(buf, true);
+	}
 	portdev->vdev->config->del_vqs(portdev->vdev);
 	kfree(portdev->in_vqs);
 	kfree(portdev->out_vqs);
