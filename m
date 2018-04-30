Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp9fHiUcIohwBLRsxtyVPbVJxrTG7i3LZAV0lVY61IyopAcxOG8+qg14WIvqsu1ZbBnA8pZ
ARC-Seal: i=1; a=rsa-sha256; t=1525116483; cv=none;
        d=google.com; s=arc-20160816;
        b=uwc3I2E2F2BNz4xsttjACG8z3F/Zx9va5vJFbZqrqpi8A8OfZm+gbAKmWWR3k3aaHf
         t/ldunGYabyv0HDyqrjoIryEy3Dg1kOabSiyGZNVEgspQa12xPRXiAN0AMOCz0C9Jj6c
         vgoH/gbJ7Ya/E3mTDb1L5m+Pch9dPLh1aMirdjM/W5KMc4mOBWG6N8PsFKzs886VrSyk
         Ax3Hs0u0ZHnaApNQcAnBOlH/+L3iK/Yl+p9gA5pazBtBGiKdHih2FrVUhGeDkXjwU7qD
         MFI1iR+vmzihNG4/XOrPPsVG8O813ty340S9NMG+ggMNdP4BesBa0qmYBD5srLK0Gg8Q
         gcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=GYgGUbD3XG/E9LG7ckVJeKs9lFqA6zckexaanj3nW4M=;
        b=JTRCNq1lIxZ3kuU8Eiw5Rle2ADyquGxH6OpDGV8P0McCmP3Ra7p7uzsTGoO95+1pyx
         Q1supNus+eNDtkmHZ615WPIHQo2TGZsGhjN/IqYQh7m0G3UO8og4s4PMMZZUQ0U1fZ88
         8NL/pr3hiDPCpQ6zZtC8o+v8t+AcPm8bFD8BgnFYL9ayz0soDIbUIG1WEUCS8wbBKpCx
         zo1EsPRMf/w6eSw5dYLEsuNLkXGIAPSs3hZZKR0eDDads3VgfKCAu0BXuIahL3sFWmng
         EQux9kAYaBad+PTZSl+Cmw51YwiFxxCHzVYt4dzjICij78CxB35iqhLUhftRV7ZAVxQX
         sUOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA28822DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4.16 025/113] virtio_console: dont tie bufs to a vq
Date: Mon, 30 Apr 2018 12:23:56 -0700
Message-Id: <20180430184016.139579045@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200479987044089?=
X-GMAIL-MSGID: =?utf-8?q?1599200541512949152?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael S. Tsirkin <mst@redhat.com>

commit 2855b33514d290c51d52d94e25d3ef942cd4d578 upstream.

an allocated buffer doesn't need to be tied to a vq -
only vq->vdev is ever used. Pass the function the
just what it needs - the vdev.

Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/virtio_console.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -422,7 +422,7 @@ static void reclaim_dma_bufs(void)
 	}
 }
 
-static struct port_buffer *alloc_buf(struct virtqueue *vq, size_t buf_size,
+static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size,
 				     int pages)
 {
 	struct port_buffer *buf;
@@ -445,16 +445,16 @@ static struct port_buffer *alloc_buf(str
 		return buf;
 	}
 
-	if (is_rproc_serial(vq->vdev)) {
+	if (is_rproc_serial(vdev)) {
 		/*
 		 * Allocate DMA memory from ancestor. When a virtio
 		 * device is created by remoteproc, the DMA memory is
 		 * associated with the grandparent device:
 		 * vdev => rproc => platform-dev.
 		 */
-		if (!vq->vdev->dev.parent || !vq->vdev->dev.parent->parent)
+		if (!vdev->dev.parent || !vdev->dev.parent->parent)
 			goto free_buf;
-		buf->dev = vq->vdev->dev.parent->parent;
+		buf->dev = vdev->dev.parent->parent;
 
 		/* Increase device refcnt to avoid freeing it */
 		get_device(buf->dev);
@@ -838,7 +838,7 @@ static ssize_t port_fops_write(struct fi
 
 	count = min((size_t)(32 * 1024), count);
 
-	buf = alloc_buf(port->out_vq, count, 0);
+	buf = alloc_buf(port->portdev->vdev, count, 0);
 	if (!buf)
 		return -ENOMEM;
 
@@ -957,7 +957,7 @@ static ssize_t port_fops_splice_write(st
 	if (ret < 0)
 		goto error_out;
 
-	buf = alloc_buf(port->out_vq, 0, pipe->nrbufs);
+	buf = alloc_buf(port->portdev->vdev, 0, pipe->nrbufs);
 	if (!buf) {
 		ret = -ENOMEM;
 		goto error_out;
@@ -1374,7 +1374,7 @@ static unsigned int fill_queue(struct vi
 
 	nr_added_bufs = 0;
 	do {
-		buf = alloc_buf(vq, PAGE_SIZE, 0);
+		buf = alloc_buf(vq->vdev, PAGE_SIZE, 0);
 		if (!buf)
 			break;
 
