Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpTBu//g3hQRSWE06psTBk9QsZdKJDwActZxxD15qdK1KHhIRozK1eDjO/PfjKnbKVUz3LB
ARC-Seal: i=1; a=rsa-sha256; t=1526937802; cv=none;
        d=google.com; s=arc-20160816;
        b=cGfve0pqmMnh6lTeGANGlKP4OzUmv103XQSr0YCcPjwMvkVjF35MwvcZobLDHnCy7c
         Jy/DR5cqFJiGk5JLXthZyNEGec1wkqsRIojC0RDIhwRdGwrKv2afUe7kY8cbgabdv12i
         yLWgAGtuAZdrM2wZm6we2Z67VviONCIAyFfEyVe6OS5NlGsZuH09bgXewfwro0rZ3AGv
         yF1lkxHKW5dkm6DYc5wE+rw3NN3uK1/MgGlqS2Bd4bTZhjcSujG69amVaP1etaqwp9qT
         r+sZg4EuhvO3fkY7WJTxI1aF2XtOqaawQ39bH7K+MLNTXF5tcWgvd2/tzP4zZ3myR+UP
         eJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Ju82WGHiABUKgQkvO+jrtW7EfMP755d3JA7Cux8u/yE=;
        b=mKSbWb24sdVqIzWskLKIsTpYm6muTMrTYLZLdYF5rhZHtU68K5mBN8ZLaph6T/TJMt
         wrwlNAHxtqvlivW/O92c+8V3ePJKpQmfhpoo24lBs8ciLOOw81x0XuLJbMXzfimFvWjx
         EfIYuWskF34GX55gFZU2DoyZGisqdTstj5HaGfNFWcLTfaVT3gHwgDdq+8sXHQgkrghj
         xq31UQSkOzzewr0hlyA1W4usx2tOaxlNrkuUBGpbogcfsrM+Ov53xRWkrvwXzOuuu4Jz
         Yluvh7zoIryTCK5AWBz2Fy0eGpgOGt3lNtQ2oHK4eJIxI3i+NByOBst+Mj6msCso96/R
         7jug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kJRxs/fG;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kJRxs/fG;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Subject: [PATCH 4.16 005/110] usbip: usbip_host: fix NULL-ptr deref and use-after-free errors
Date: Mon, 21 May 2018 23:11:02 +0200
Message-Id: <20180521210504.332708338@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109763681798750?=
X-GMAIL-MSGID: =?utf-8?q?1601110332446809035?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan (Samsung OSG) <shuah@kernel.org>

commit 22076557b07c12086eeb16b8ce2b0b735f7a27e7 upstream.

usbip_host updates device status without holding lock from stub probe,
disconnect and rebind code paths. When multiple requests to import a
device are received, these unprotected code paths step all over each
other and drive fails with NULL-ptr deref and use-after-free errors.

The driver uses a table lock to protect the busid array for adding and
deleting busids to the table. However, the probe, disconnect and rebind
paths get the busid table entry and update the status without holding
the busid table lock. Add a new finer grain lock to protect the busid
entry. This new lock will be held to search and update the busid entry
fields from get_busid_idx(), add_match_busid() and del_match_busid().

match_busid_show() does the same to access the busid entry fields.

get_busid_priv() changed to return the pointer to the busid entry holding
the busid lock. stub_probe(), stub_disconnect() and stub_device_rebind()
call put_busid_priv() to release the busid lock before returning. This
changes fixes the unprotected code paths eliminating the race conditions
in updating the busid entries.

Reported-by: Jakub Jirasek
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/stub.h      |    2 ++
 drivers/usb/usbip/stub_dev.c  |   33 +++++++++++++++++++++++----------
 drivers/usb/usbip/stub_main.c |   40 +++++++++++++++++++++++++++++++++++-----
 3 files changed, 60 insertions(+), 15 deletions(-)

--- a/drivers/usb/usbip/stub.h
+++ b/drivers/usb/usbip/stub.h
@@ -73,6 +73,7 @@ struct bus_id_priv {
 	struct stub_device *sdev;
 	struct usb_device *udev;
 	char shutdown_busid;
+	spinlock_t busid_lock;
 };
 
 /* stub_priv is allocated from stub_priv_cache */
@@ -83,6 +84,7 @@ extern struct usb_device_driver stub_dri
 
 /* stub_main.c */
 struct bus_id_priv *get_busid_priv(const char *busid);
+void put_busid_priv(struct bus_id_priv *bid);
 int del_match_busid(char *busid);
 void stub_device_cleanup_urbs(struct stub_device *sdev);
 
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -300,7 +300,7 @@ static int stub_probe(struct usb_device
 	struct stub_device *sdev = NULL;
 	const char *udev_busid = dev_name(&udev->dev);
 	struct bus_id_priv *busid_priv;
-	int rc;
+	int rc = 0;
 
 	dev_dbg(&udev->dev, "Enter probe\n");
 
@@ -317,13 +317,15 @@ static int stub_probe(struct usb_device
 		 * other matched drivers by the driver core.
 		 * See driver_probe_device() in driver/base/dd.c
 		 */
-		return -ENODEV;
+		rc = -ENODEV;
+		goto call_put_busid_priv;
 	}
 
 	if (udev->descriptor.bDeviceClass == USB_CLASS_HUB) {
 		dev_dbg(&udev->dev, "%s is a usb hub device... skip!\n",
 			 udev_busid);
-		return -ENODEV;
+		rc = -ENODEV;
+		goto call_put_busid_priv;
 	}
 
 	if (!strcmp(udev->bus->bus_name, "vhci_hcd")) {
@@ -331,13 +333,16 @@ static int stub_probe(struct usb_device
 			"%s is attached on vhci_hcd... skip!\n",
 			udev_busid);
 
-		return -ENODEV;
+		rc = -ENODEV;
+		goto call_put_busid_priv;
 	}
 
 	/* ok, this is my device */
 	sdev = stub_device_alloc(udev);
-	if (!sdev)
-		return -ENOMEM;
+	if (!sdev) {
+		rc = -ENOMEM;
+		goto call_put_busid_priv;
+	}
 
 	dev_info(&udev->dev,
 		"usbip-host: register new device (bus %u dev %u)\n",
@@ -369,7 +374,9 @@ static int stub_probe(struct usb_device
 	}
 	busid_priv->status = STUB_BUSID_ALLOC;
 
-	return 0;
+	rc = 0;
+	goto call_put_busid_priv;
+
 err_files:
 	usb_hub_release_port(udev->parent, udev->portnum,
 			     (struct usb_dev_state *) udev);
@@ -379,6 +386,9 @@ err_port:
 
 	busid_priv->sdev = NULL;
 	stub_device_free(sdev);
+
+call_put_busid_priv:
+	put_busid_priv(busid_priv);
 	return rc;
 }
 
@@ -417,7 +427,7 @@ static void stub_disconnect(struct usb_d
 	/* get stub_device */
 	if (!sdev) {
 		dev_err(&udev->dev, "could not get device");
-		return;
+		goto call_put_busid_priv;
 	}
 
 	dev_set_drvdata(&udev->dev, NULL);
@@ -432,12 +442,12 @@ static void stub_disconnect(struct usb_d
 				  (struct usb_dev_state *) udev);
 	if (rc) {
 		dev_dbg(&udev->dev, "unable to release port\n");
-		return;
+		goto call_put_busid_priv;
 	}
 
 	/* If usb reset is called from event handler */
 	if (usbip_in_eh(current))
-		return;
+		goto call_put_busid_priv;
 
 	/* shutdown the current connection */
 	shutdown_busid(busid_priv);
@@ -450,6 +460,9 @@ static void stub_disconnect(struct usb_d
 
 	if (busid_priv->status == STUB_BUSID_ALLOC)
 		busid_priv->status = STUB_BUSID_ADDED;
+
+call_put_busid_priv:
+	put_busid_priv(busid_priv);
 }
 
 #ifdef CONFIG_PM
--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -26,6 +26,8 @@ static spinlock_t busid_table_lock;
 
 static void init_busid_table(void)
 {
+	int i;
+
 	/*
 	 * This also sets the bus_table[i].status to
 	 * STUB_BUSID_OTHER, which is 0.
@@ -33,6 +35,9 @@ static void init_busid_table(void)
 	memset(busid_table, 0, sizeof(busid_table));
 
 	spin_lock_init(&busid_table_lock);
+
+	for (i = 0; i < MAX_BUSID; i++)
+		spin_lock_init(&busid_table[i].busid_lock);
 }
 
 /*
@@ -44,15 +49,20 @@ static int get_busid_idx(const char *bus
 	int i;
 	int idx = -1;
 
-	for (i = 0; i < MAX_BUSID; i++)
+	for (i = 0; i < MAX_BUSID; i++) {
+		spin_lock(&busid_table[i].busid_lock);
 		if (busid_table[i].name[0])
 			if (!strncmp(busid_table[i].name, busid, BUSID_SIZE)) {
 				idx = i;
+				spin_unlock(&busid_table[i].busid_lock);
 				break;
 			}
+		spin_unlock(&busid_table[i].busid_lock);
+	}
 	return idx;
 }
 
+/* Returns holding busid_lock. Should call put_busid_priv() to unlock */
 struct bus_id_priv *get_busid_priv(const char *busid)
 {
 	int idx;
@@ -60,13 +70,21 @@ struct bus_id_priv *get_busid_priv(const
 
 	spin_lock(&busid_table_lock);
 	idx = get_busid_idx(busid);
-	if (idx >= 0)
+	if (idx >= 0) {
 		bid = &(busid_table[idx]);
+		/* get busid_lock before returning */
+		spin_lock(&bid->busid_lock);
+	}
 	spin_unlock(&busid_table_lock);
 
 	return bid;
 }
 
+void put_busid_priv(struct bus_id_priv *bid)
+{
+	spin_unlock(&bid->busid_lock);
+}
+
 static int add_match_busid(char *busid)
 {
 	int i;
@@ -79,15 +97,19 @@ static int add_match_busid(char *busid)
 		goto out;
 	}
 
-	for (i = 0; i < MAX_BUSID; i++)
+	for (i = 0; i < MAX_BUSID; i++) {
+		spin_lock(&busid_table[i].busid_lock);
 		if (!busid_table[i].name[0]) {
 			strlcpy(busid_table[i].name, busid, BUSID_SIZE);
 			if ((busid_table[i].status != STUB_BUSID_ALLOC) &&
 			    (busid_table[i].status != STUB_BUSID_REMOV))
 				busid_table[i].status = STUB_BUSID_ADDED;
 			ret = 0;
+			spin_unlock(&busid_table[i].busid_lock);
 			break;
 		}
+		spin_unlock(&busid_table[i].busid_lock);
+	}
 
 out:
 	spin_unlock(&busid_table_lock);
@@ -108,6 +130,8 @@ int del_match_busid(char *busid)
 	/* found */
 	ret = 0;
 
+	spin_lock(&busid_table[idx].busid_lock);
+
 	if (busid_table[idx].status == STUB_BUSID_OTHER)
 		memset(busid_table[idx].name, 0, BUSID_SIZE);
 
@@ -115,6 +139,7 @@ int del_match_busid(char *busid)
 	    (busid_table[idx].status != STUB_BUSID_ADDED))
 		busid_table[idx].status = STUB_BUSID_REMOV;
 
+	spin_unlock(&busid_table[idx].busid_lock);
 out:
 	spin_unlock(&busid_table_lock);
 
@@ -127,9 +152,12 @@ static ssize_t match_busid_show(struct d
 	char *out = buf;
 
 	spin_lock(&busid_table_lock);
-	for (i = 0; i < MAX_BUSID; i++)
+	for (i = 0; i < MAX_BUSID; i++) {
+		spin_lock(&busid_table[i].busid_lock);
 		if (busid_table[i].name[0])
 			out += sprintf(out, "%s ", busid_table[i].name);
+		spin_unlock(&busid_table[i].busid_lock);
+	}
 	spin_unlock(&busid_table_lock);
 	out += sprintf(out, "\n");
 
@@ -204,7 +232,7 @@ static void stub_device_rebind(void)
 	}
 	spin_unlock(&busid_table_lock);
 
-	/* now run rebind */
+	/* now run rebind - no need to hold locks. driver files are removed */
 	for (i = 0; i < MAX_BUSID; i++) {
 		if (busid_table[i].name[0] &&
 		    busid_table[i].shutdown_busid) {
@@ -234,6 +262,8 @@ static ssize_t rebind_store(struct devic
 
 	/* mark the device for deletion so probe ignores it during rescan */
 	bid->status = STUB_BUSID_OTHER;
+	/* release the busid lock */
+	put_busid_priv(bid);
 
 	ret = do_rebind((char *) buf, bid);
 	if (ret < 0)
