Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqYS8HNsnr9KdRChcw6+FJF6ii1TLs8rt/OcIlCvAbbWdU48liYxGVv0WMcP7s7YpvELJsx
ARC-Seal: i=1; a=rsa-sha256; t=1525116437; cv=none;
        d=google.com; s=arc-20160816;
        b=iX4xpgSVRQt1JKDhS1FrmS5lpB5pJB/EEnqryqyLuJboPhcSYLuyz5EcrT1UWd4wIw
         sQNd0KMVZJD3WIVl9zlydFdFcBqIVzl8KBWeP4ScIc9Hf0DBGVELLeNEwBVolKbqtrrJ
         oD2G1pNr3PGFpDiUxkx2CrRgVOdva+EC3aj4CJzyRj74qi5y0lqeuBBwfG/arhfLQMxT
         6Acn4HIXROU2FCP/WMDx0t5Gf0GB9qdyEf8H0fJ4iTMp6vqP4+SjwAwTtQzgmLOJrSgV
         LGw24HsuSi0bovoTi07dNVF4n0vmYf+ls+zP1IYHeHbOL9nPM/NfuZU5VRyHN94bGDJR
         Wt0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=VzKtW0VjuELLdlU8XaZdhSbr70Q4V10jWubJkY7xz+E=;
        b=rP5E1XU+vjeVNHXb71KBpOxZ1CMsu6M+P2gkZ+2NXsGSxicA0mgD0c2zxayIEQtYEQ
         1on7Yzu5cyizCVKQgtNQ30RKc5zz4r/WOKFUkIUrlVR2NnMbkDZ/EReEHxpvctwfvkUu
         1FXoi4E0uvYlCPrG5CcfiY453yw127yrb+u4H0bdLDyR2Kt1o57ylppAvNq27RZofR55
         tGaBT89diNUKzim6EGV7QmyhFzZV3DtJOiCqC1Lh8TqVB5fMAPG/7L8qC3uZofpsoIW6
         +W5yM22LjMz93SCj9ElzHHpc5EeNac254sxOhfe9KqkVC54YvGrkEFbcw3I51DvKU/zf
         8ooQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3202622DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4.14 27/91] virtio_console: reset on out of memory
Date: Mon, 30 Apr 2018 12:24:09 -0700
Message-Id: <20180430184005.596384989@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200493836963780?=
X-GMAIL-MSGID: =?utf-8?q?1599200493836963780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael S. Tsirkin <mst@redhat.com>

commit 5c60300d68da32ca77f7f978039dc72bfc78b06b upstream.

When out of memory and we can't add ctrl vq buffers,
probe fails. Unfortunately the error handling is
out of spec: it calls del_vqs without bothering
to reset the device first.

To fix, call the full cleanup function in this case.

Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/virtio_console.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2090,6 +2090,7 @@ static int virtcons_probe(struct virtio_
 
 	spin_lock_init(&portdev->ports_lock);
 	INIT_LIST_HEAD(&portdev->ports);
+	INIT_LIST_HEAD(&portdev->list);
 
 	virtio_device_ready(portdev->vdev);
 
@@ -2107,8 +2108,15 @@ static int virtcons_probe(struct virtio_
 		if (!nr_added_bufs) {
 			dev_err(&vdev->dev,
 				"Error allocating buffers for control queue\n");
-			err = -ENOMEM;
-			goto free_vqs;
+			/*
+			 * The host might want to notify mgmt sw about device
+			 * add failure.
+			 */
+			__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
+					   VIRTIO_CONSOLE_DEVICE_READY, 0);
+			/* Device was functional: we need full cleanup. */
+			virtcons_remove(vdev);
+			return -ENOMEM;
 		}
 	} else {
 		/*
@@ -2139,11 +2147,6 @@ static int virtcons_probe(struct virtio_
 
 	return 0;
 
-free_vqs:
-	/* The host might want to notify mgmt sw about device add failure */
-	__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
-			   VIRTIO_CONSOLE_DEVICE_READY, 0);
-	remove_vqs(portdev);
 free_chrdev:
 	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
 free:
