Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq+pewKMz2JYH6MZnAf17xSMrKOpuPaEoNkZygkeTkif3CirgviyJWuCtleNEzoKel+gmPI
ARC-Seal: i=1; a=rsa-sha256; t=1525116425; cv=none;
        d=google.com; s=arc-20160816;
        b=a6RortzukzsIS+I4LRXqJG9Q68yVOrnfrMfDpiCvdX5bWMe+XBO7WjwXl8qQ1s3ilq
         i/xFQOTqDN1ZhhlKYP+55PDOQkEgB5e5OmeX5RNbIUp+yjr4UGjWgaFIEuqgvc66iIlN
         R+07x7SVWzRfB9Y9K76KakxYJjs6kKNTOtdGGHdJ4tks1EYUKP1vN2vRQ/SUy1ZW4fEr
         m4G9Q7v57rTcRZB9cfQVmq2/eQcOHo9JEgjZk4cCvODOnGBlXxt8GZ/2PsBpk9mZcFWw
         1p49agCG/XMB5h2079jWSkxH2a8ZSyFpEsKR0I5T3ygf3g4mjlSbzAWP/klO0oorUqgl
         iUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=iaS+DFJFY/SQ/QkQP69ctZMcGa4Iv9SfrMS4u/ULKeo=;
        b=ioCL6DeNVT07/casyMN192YgGEHxf6qorHnaBv9A6ab5JE8xdCGaDlMbX8HbEPJWAc
         wgK5FI4ZDZgNdV2bQmrs33xnVtjjzYcf54w9mmQw8imEJuwp0QI8aOSho8qAVaUVnw7u
         5kI454gczAX6LhAXE5Gl30Dmi6FiMciBEiKekSqGQ8Z+xPSAIGCCaU7GPyPvV3AkE8m5
         UtWjFcr/fSU1+dclOBe+P/AIWb4W4zHajJyd+hq5d/OBUgkWpQ7d38tV46yCyZMqwEya
         yQkB6vUAtKZI4YOckMK4YypkUm4esB+nm+u4LSOlbk3Vm51rdG5dfBf2FN0M2lrhia/d
         y4HQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8774722DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tiwei Bie <tiwei.bie@intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4.14 24/91] virtio_console: free buffers after reset
Date: Mon, 30 Apr 2018 12:24:06 -0700
Message-Id: <20180430184005.456857189@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200399540203794?=
X-GMAIL-MSGID: =?utf-8?q?1599200480520385358?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
