Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZob4OtKp8CedsAhOga5xb1sz2+4P3poFkcv6uiYqT9sd+p9n3gJ+M2+R/bFUSUEVhfFHrHQ
ARC-Seal: i=1; a=rsa-sha256; t=1525116347; cv=none;
        d=google.com; s=arc-20160816;
        b=vdHIC9vvqkou7IjYxl2KiMfB9dAvuiL0hMr7N/cHRIxo2bTIwWJTugKcyDLhnxlrNw
         wGGkl5MOHAbYqT24FOBIbVZbZNDGkz1FpuE2kdtf8kXheryEj5F5T4B5C0OhLDMErSQQ
         O9Ct97DwzNo5lW0a4DAOReXJOaDPvEKO9kaMp1gPJLIjvj6qsGr+UFmdVll5VacF2jkL
         WmS+2Seseotz5mKkLkwsPoIXk49Jhb+8BWMjteXu54PlP257b2Wn9oGDAF7KUp5t5SCU
         aM0xlZsRKKj+Tsjp8tW1kr6p7cUdpZlZYJLOmZMe9a3cwOrgGXz98lZ0GzW6E9wgSARE
         LpvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=qwOTnFWl64GJf4zIQ0rrAusj3t/YUikv6cvGkfta8Oo=;
        b=YjSf5vuCsKj0O2GPjfmmYo+VGNP9vvteov8Kn2dwxmAS+sDWA5drylD5IaIwm1Uw5e
         CEh7QeE3htrjQ6jXMYHjpZkBDZgxhuHjTW7W4jmdPqlzOG3ytFm31E7KDuj0fI9cMCAX
         pqxHrhtRFxhKVXI2mQB3Q+H+BIOQMNmvqGv4if6/SQ4o7N9Mjn13u1FUgP3Aw5B5QWHI
         JF5m88IkNWEtB89BJOgHewu9UuYELKR0W9sD+KPVsnZKg3eKr3g/hg2OTN1ywVFwcpog
         KZBowc/Kjl+21LU3lSgjNfpGxdvesqrB/eo6W7tV1rtXLvJmq+glNeXGppb5fqxmw1YC
         ojlg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4E222DAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tiwei Bie <tiwei.bie@intel.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4.4 14/44] virtio_console: free buffers after reset
Date: Mon, 30 Apr 2018 12:24:25 -0700
Message-Id: <20180430190946.915174631@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200399540203794?=
X-GMAIL-MSGID: =?utf-8?q?1599200399540203794?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1399,7 +1399,6 @@ static int add_port(struct ports_device
 {
 	char debugfs_name[16];
 	struct port *port;
-	struct port_buffer *buf;
 	dev_t devt;
 	unsigned int nr_added_bufs;
 	int err;
@@ -1510,8 +1509,6 @@ static int add_port(struct ports_device
 	return 0;
 
 free_inbufs:
-	while ((buf = virtqueue_detach_unused_buf(port->in_vq)))
-		free_buf(buf, true);
 free_device:
 	device_destroy(pdrvdata.class, port->dev->devt);
 free_cdev:
@@ -1536,34 +1533,14 @@ static void remove_port(struct kref *kre
 
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
@@ -1788,13 +1765,24 @@ static void control_work_handler(struct
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
@@ -1805,8 +1793,10 @@ static void in_intr(struct virtqueue *vq
 	unsigned long flags;
 
 	port = find_port_by_vq(vq->vdev->priv, vq);
-	if (!port)
+	if (!port) {
+		flush_bufs(vq, false);
 		return;
+	}
 
 	spin_lock_irqsave(&port->inbuf_lock, flags);
 	port->inbuf = get_inbuf(port);
@@ -1981,6 +1971,15 @@ static const struct file_operations port
 
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
