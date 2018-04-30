Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpdJURrsjluVGpnaSmbnqBOClGghs7RNAvh32LEH7clpqkjCY+73X1IZmSfd13Bt3cIgzHu
ARC-Seal: i=1; a=rsa-sha256; t=1525116454; cv=none;
        d=google.com; s=arc-20160816;
        b=FCv68bwtmPmG+AGF22bSTVgPz/UersOkvqHe+/+Q5JPU/FaMVlKRY5MaX5+O5Kf1qb
         BrUgTqMquKHsHkLBPu62VsZY09r2ECb8Ck+LGl9Fmb25fS8hRW6/waYPiJHzXsy5ifas
         /hrSXO65O7dpFFP+5WNXZbGL0+V9p1pYx8UUjEczChxohjDTGtnDfjppozj/EtbF2dhC
         V67OLa6ataf/KgiFDkgY73pg9NU1z7jgQlKGUaSaNzfnycAdCWMUrwvHCDU73AFcGfzQ
         KoPO+WNzGQfXA0guSILukIVRYbMcPdW2QWPhXosgZwRUtMMRa7Vu/rTxDOhu6fWO8GSv
         EynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=350XmWaJxIuYHoVR8mhvd1gPgkcs3cdb0Imf9OWn8yw=;
        b=hlNthptP0B+2itBbIGOVyR1YGsE07dmxDEVTkdn67im5NBYx5BB0Q4Y3dB5fUYLgPJ
         Cuu9QFBK8GXMCSkSBqNPIQOKF1sFUFRDiUTHrNECForuN4Zbs3QrwaXd2J7jBLLJwI6E
         u3651rIyVSJtMaDSSZEGTWKz9jH+SH8qlJuW+isbCWhYQqAhB0yyCy7VN6jL7zB26JEm
         bQVPh0IqiYCwyJulHo+TLcn1/nCv+YcE9juWeYsU1p+PN1TchIO2d8+ZCPGXPkLQihWM
         AE6x8PJD+AUkqDoPdecL0zA4R3NAlHySXu9hoPHsKhO/JN1XHXm6whW7YGzdnmYjphPh
         yLRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ABD322E01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4.14 25/91] virtio_console: drop custom control queue cleanup
Date: Mon, 30 Apr 2018 12:24:07 -0700
Message-Id: <20180430184005.502437854@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200542473275649?=
X-GMAIL-MSGID: =?utf-8?q?1599200511437862924?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
