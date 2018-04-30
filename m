Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZof+WRdFSZ0lBJjOSjQ/xJoiyjSJaDD8JS6TEtnGryquRlpf8l7h69Thy9QCEcmKieJveEs
ARC-Seal: i=1; a=rsa-sha256; t=1525116430; cv=none;
        d=google.com; s=arc-20160816;
        b=LXG1IzZnwnDmz5DwTAXXDTGj0NrkvIMwZQPf3Ujr8mtzsyMHHHBQpD6NsDT72tIk+H
         LWOo4UT190dQmXrM/eGfu4McjnmyZnS6uQHHdR82OSZPIoKupLE189gBzk5XCdyv96gP
         jgoSNXWeI/EM1jeGcS1g3QY7PHQL7hxG7PBkdyx19PBnhn/7BHggkogSnaGpVgD9Kstf
         Sg2923QbcO/B9Oxk9x4cFTeph/Ij809MOAKd3kBYXNOeSVp418riO4Kqv32f4Y2C79fC
         Ng4UtzUoeTYZc45OX/DKUkNaqFWIBc9hX2uOKX+8YyjmFdCOaC+MH0NFPbqlAPQxEMzD
         gtMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=0Nyo+YZV68eg/+S37+IldbqUzCf8J+SRZ9ItBXaa1IQ=;
        b=W6tYVWZ9dAOYGVOY7rGUvwvu6XOTJvE5WYOS/eEihnxXxwGG/wVc6yqUhGxH0hZWKZ
         HEJJxkI5TWjmhi2bYi6bBFOZ8s1MZjxKEFU8s1GasR6Uecaga9zLhejYBPmcr23nHBfU
         rob5UAYItv1XCRdguklsxgjm1i8HDDQS3di5KYSKDYm8cU2+i8pON+quH3+iDQNi0eJC
         AHcCXe5umb0PBkCG7ufh80JWS1mYswWkwCS3iCUBcR2hrz6UugSYcejigu+azWaXI9il
         E5sWDeWvxbQwAqBK139n2BKEycS0wd0tOFxkIL8EMisOrT891ROUGTS7sl9PZbfhxnSu
         vo7w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4360122DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4.14 26/91] virtio_console: move removal code
Date: Mon, 30 Apr 2018 12:24:08 -0700
Message-Id: <20180430184005.549463558@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200486103081336?=
X-GMAIL-MSGID: =?utf-8?q?1599200486103081336?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael S. Tsirkin <mst@redhat.com>

commit aa44ec867030a72e8aa127977e37dec551d8df19 upstream.

Will make it reusable for error handling.

Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/virtio_console.c |   72 +++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1988,6 +1988,42 @@ static void remove_vqs(struct ports_devi
 	kfree(portdev->out_vqs);
 }
 
+static void virtcons_remove(struct virtio_device *vdev)
+{
+	struct ports_device *portdev;
+	struct port *port, *port2;
+
+	portdev = vdev->priv;
+
+	spin_lock_irq(&pdrvdata_lock);
+	list_del(&portdev->list);
+	spin_unlock_irq(&pdrvdata_lock);
+
+	/* Disable interrupts for vqs */
+	vdev->config->reset(vdev);
+	/* Finish up work that's lined up */
+	if (use_multiport(portdev))
+		cancel_work_sync(&portdev->control_work);
+	else
+		cancel_work_sync(&portdev->config_work);
+
+	list_for_each_entry_safe(port, port2, &portdev->ports, list)
+		unplug_port(port);
+
+	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
+
+	/*
+	 * When yanking out a device, we immediately lose the
+	 * (device-side) queues.  So there's no point in keeping the
+	 * guest side around till we drop our final reference.  This
+	 * also means that any ports which are in an open state will
+	 * have to just stop using the port, as the vqs are going
+	 * away.
+	 */
+	remove_vqs(portdev);
+	kfree(portdev);
+}
+
 /*
  * Once we're further in boot, we get probed like any other virtio
  * device.
@@ -2116,42 +2152,6 @@ fail:
 	return err;
 }
 
-static void virtcons_remove(struct virtio_device *vdev)
-{
-	struct ports_device *portdev;
-	struct port *port, *port2;
-
-	portdev = vdev->priv;
-
-	spin_lock_irq(&pdrvdata_lock);
-	list_del(&portdev->list);
-	spin_unlock_irq(&pdrvdata_lock);
-
-	/* Disable interrupts for vqs */
-	vdev->config->reset(vdev);
-	/* Finish up work that's lined up */
-	if (use_multiport(portdev))
-		cancel_work_sync(&portdev->control_work);
-	else
-		cancel_work_sync(&portdev->config_work);
-
-	list_for_each_entry_safe(port, port2, &portdev->ports, list)
-		unplug_port(port);
-
-	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
-
-	/*
-	 * When yanking out a device, we immediately lose the
-	 * (device-side) queues.  So there's no point in keeping the
-	 * guest side around till we drop our final reference.  This
-	 * also means that any ports which are in an open state will
-	 * have to just stop using the port, as the vqs are going
-	 * away.
-	 */
-	remove_vqs(portdev);
-	kfree(portdev);
-}
-
 static struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_CONSOLE, VIRTIO_DEV_ANY_ID },
 	{ 0 },
