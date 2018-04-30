Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoDXTtBXIZa3MkGHmjrb6dNVxY60ZXpD5BqejSGf0gCqPMbulCTP6rtc4ZRfuh+cm3tFftG
ARC-Seal: i=1; a=rsa-sha256; t=1525116381; cv=none;
        d=google.com; s=arc-20160816;
        b=LFqSJ/+gIgauTM0K9IQYRqcJxQOFXjUcBwpGH+chJ6Kxide7g9jEbnH6VKY+PkMhXx
         vMVCI8bp4dmZ1LnIJSfCdii4ziHOVOJ4dTCqnR84wlNHmtWcLyeWvc7+PAGkXhdm/njq
         Ci9URp4VARf/A9GCEuqmRE+SB4ZbSWCyOFbopJVrWgdTio9g4c+zhWN7599w+TAX8vWh
         PAWKCzYfTnv+McgZ18NhDd5Sk5B6m5xCxHzLRCI4yznIR1Bvqnja9XNzRCTjEor2sfff
         pPiYsg7hkkoCYTyNUuC4q+fPOU9RSR+i+Gx7edgAPOj/D3n4FBiJn15vPOFRfqNWDF59
         nihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=6WSx5X5373/Nsk61/YnmZvww5tAjZIr+I+aFf8f7Bn8=;
        b=Iq4hdo0hryP8cC59ycZufvc47GHcAacXwYS8U0Yu/Rplw0g2cXRi0fJtqTal+X8L45
         KbIjVRV6nRtBEkQvUu6Ez9X50vnAH7P+d9hksG59JWhAlL8N3PK7sJERaFteYttd9kFj
         XHTLQZH3sRAtTCTJ+oAkK6oypRg07w4BMPvBLTAjrdw8zvIpbbtsfPsrbEm+lqR8tI5A
         IGEPwouJJJAI1/pVUnfJxt5kZoS6QQPDsQcyik/VcTgZT2mU/BfJ/nPCzryf8LDoxk+5
         3Vt+vDu8ekrTauDSk1y0+vC2KAt7euqax0DnRNJMC5Nbi+HBwzwD/CnNKhMymBh1vgxj
         P8+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED5F22DC8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tiwei Bie <tiwei.bie@intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4.9 18/61] virtio_console: free buffers after reset
Date: Mon, 30 Apr 2018 12:24:21 -0700
Message-Id: <20180430183952.841561761@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200399540203794?=
X-GMAIL-MSGID: =?utf-8?q?1599200435041347330?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1405,7 +1405,6 @@ static int add_port(struct ports_device
 {
 	char debugfs_name[16];
 	struct port *port;
-	struct port_buffer *buf;
 	dev_t devt;
 	unsigned int nr_added_bufs;
 	int err;
@@ -1516,8 +1515,6 @@ static int add_port(struct ports_device
 	return 0;
 
 free_inbufs:
-	while ((buf = virtqueue_detach_unused_buf(port->in_vq)))
-		free_buf(buf, true);
 free_device:
 	device_destroy(pdrvdata.class, port->dev->devt);
 free_cdev:
@@ -1542,34 +1539,14 @@ static void remove_port(struct kref *kre
 
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
@@ -1794,13 +1771,24 @@ static void control_work_handler(struct
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
@@ -1811,8 +1799,10 @@ static void in_intr(struct virtqueue *vq
 	unsigned long flags;
 
 	port = find_port_by_vq(vq->vdev->priv, vq);
-	if (!port)
+	if (!port) {
+		flush_bufs(vq, false);
 		return;
+	}
 
 	spin_lock_irqsave(&port->inbuf_lock, flags);
 	port->inbuf = get_inbuf(port);
@@ -1987,6 +1977,15 @@ static const struct file_operations port
 
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
