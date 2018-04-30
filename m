Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpxdz4qVbu9Eam0fcHsuhsNMrxmNL3uoUjw+R8Oua+smuXWWVbAqfaMmNB87zBDphcuLrou
ARC-Seal: i=1; a=rsa-sha256; t=1525116484; cv=none;
        d=google.com; s=arc-20160816;
        b=rIW0fC3uxT+h0jSRNyeQPEdXmVEAzvVBOipi0xdD2iwQ8fYyKofkivtv2HMZHiakJF
         4Oajpi3KyHzjn5pLVKpedI9Oafqa+jy7EHF91qhk/6j3H7ATL7veAB8hO+29nJWTa5X9
         Y4k/H+e4SJwCoSPqfSjHv2wisUqQTr5BV8hKAV45FW9RNC7YvE1dVPAASPpt8KdE0Mmz
         IbXFDXNy5sL/0Ts8TRQUbGRsicU/NDaWm42CQvhmaF3L2+X2hfzVb6WpC/nlJkzsgk1A
         psOy98U6xPis+PPdyO9ChbCwER5cY7LiRsjt3vOlrDLmBEenooNvlMToDc2tPETvcnjh
         zVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=zCY0YK8wwbE3oEGbhquhcEoOQ2cIRCtia4TJyOZJBeE=;
        b=LLwlhiYjqZs6hb6Tp97IMlYCuIc0RUMzck6lBu9IFi/7HLKCb1TsEnawdFDTp1U4Ty
         QNCfJxAvdTpxuMfc6oi3phGPzKT3xm/Ts+xJmpAxdsiLG1Tzu8dRtKdv4T0+bDetOh2f
         ubK3Ncrpnv9Hh400LovS/FoaIizvI121njaYFzr5r6GjQDrB+KnruKcFdvwPrGGLebD2
         v1S562IxzawlanGKhC+yo5hRK4Axpdy8O11umk5+UTRczc/ODv/rPIIC+DXhlv4SLIW8
         AAst1XT7jRGObntTKN34L/kEhi42sN5jRCpg4Lc9E1pMIkOxnd3mT/oWQtRB6gLbMS9C
         aYxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E2A22DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4.16 027/113] virtio_console: drop custom control queue cleanup
Date: Mon, 30 Apr 2018 12:23:58 -0700
Message-Id: <20180430184016.216294156@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200542473275649?=
X-GMAIL-MSGID: =?utf-8?q?1599200542473275649?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael S. Tsirkin <mst@redhat.com>

commit 61a8950c5c5708cf2068b29ffde94e454e528208 upstream.

We now cleanup all VQs on device removal - no need
to handle the control VQ specially.

Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/virtio_console.c |   17 -----------------
 1 file changed, 17 deletions(-)

--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1988,21 +1988,6 @@ static void remove_vqs(struct ports_devi
 	kfree(portdev->out_vqs);
 }
 
-static void remove_controlq_data(struct ports_device *portdev)
-{
-	struct port_buffer *buf;
-	unsigned int len;
-
-	if (!use_multiport(portdev))
-		return;
-
-	while ((buf = virtqueue_get_buf(portdev->c_ivq, &len)))
-		free_buf(buf, true);
-
-	while ((buf = virtqueue_detach_unused_buf(portdev->c_ivq)))
-		free_buf(buf, true);
-}
-
 /*
  * Once we're further in boot, we get probed like any other virtio
  * device.
@@ -2163,7 +2148,6 @@ static void virtcons_remove(struct virti
 	 * have to just stop using the port, as the vqs are going
 	 * away.
 	 */
-	remove_controlq_data(portdev);
 	remove_vqs(portdev);
 	kfree(portdev);
 }
@@ -2208,7 +2192,6 @@ static int virtcons_freeze(struct virtio
 	 */
 	if (use_multiport(portdev))
 		virtqueue_disable_cb(portdev->c_ivq);
-	remove_controlq_data(portdev);
 
 	list_for_each_entry(port, &portdev->ports, list) {
 		virtqueue_disable_cb(port->in_vq);
