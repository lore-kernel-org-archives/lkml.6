Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp00HdYcCbfn/HkZyf/Z1+zvTv/iahJuICh9Jo/CcnCd5IGSANJbq0isCs3Q2k1g1Py7Lgy
ARC-Seal: i=1; a=rsa-sha256; t=1525116485; cv=none;
        d=google.com; s=arc-20160816;
        b=WPBT/bSGHtTbGGnOgV3UG8fztJSDJpD2SeZPYzx8zoGMuWvJ+dUpCp7X6uPZxio9Jq
         YxNZ/niDaHKHnNHPBhMXsJBzzezL6IxuYv1cKvOT8WlzGlRCbjqtOTmOXZThBipBsNDJ
         4Q9zTrTVlbMdCYCCzkdQhAHB0OO3fmzSW2U+CZtqodq1DGhZTjg8LNn6gF0FjAxJAgTk
         TfrD+KDv/LQ825amTJGrtIO3MXtn8AdnuGQaY7FkSkR6dg4TlOiUpyo4NdZBAqgUMcFw
         v+nNFBFmL78K0eCxID8mH3jUOeUOkE6SWdWA9roEs5kZKfQPNL8EGtYOWgJqK0JvyzuP
         Ehwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=eOQ8Gmyg5wGJZcbae1czQbizyn9Mq4d4lfZ3vphn81g=;
        b=s9yCBsaQ4sA4T8bTsG/AxRr7kNEJppwzVN57F5mrIUopqy2+muYgbcB0hOinLQ4Pmq
         9yStViWG4FX8oRlkTGxo0g4O/sV4zA8Z8274zHp2LkbJLDyLPqR6Jgtc6iFFLHyt7hAQ
         KHyls5ymw7AfUZFhmG6Qs9tmCP73L9BRYFvCHsFqJWH4lhX6SvaMXcssjwx8XwxtPwZ4
         S3iIVO+wLAN7ZJAXDWSphBTs3VsuYTzLNFXvs6twzT7nZbabY6B6hJML5tQvL4K8ol2W
         spOcUm3TQL3LlAlMLG9diq3HVKZgkV2rbnmD2fJXi4n7qpIKIfXPzUsXeYjj4XqEbnfX
         I4BQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F1022DC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4.16 028/113] virtio_console: move removal code
Date: Mon, 30 Apr 2018 12:23:59 -0700
Message-Id: <20180430184016.257130742@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200486103081336?=
X-GMAIL-MSGID: =?utf-8?q?1599200543674502487?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
