Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZq+gVph7L8lp9ord7xfWZ8EOLTddqATpWSHXpynNfSKDZYaVMZK5XPudXq6iDH3ZNezuTPD
ARC-Seal: i=1; a=rsa-sha256; t=1526937799; cv=none;
        d=google.com; s=arc-20160816;
        b=FnbSNDi5XkJhWC+n4D685d9dOKf4mhYLOWgDbLsrZ287E/ipwbBEiuEUVHWA9/ZdkZ
         7EOFmicnzycxjLCsDj+fWJdj+dXomy31S/OuEcC5ChF5O3+KGrp3GDcNgHbgXju56YK8
         GpeDOk22kKIN/1RolMwBsxOq62MC7kQbIXk+3f7ZpNjjVRip0YiK6jaVSa3/DQ7qujpj
         fc65Oc5dVoF2R5XailuNDH0Y4+uGxkqhYjRPZJXuhwuYr7cshPVvR/VHRhQJFzY09MYC
         tD3gqDiZVZYMFZSJUFC9F3vfaz5o9qEwrJf61zbP0FGaX45YJCpqxuBBvNe5bHiVwiyY
         kBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=UZaIWnPMrMnRzCD52wxNm2tQ7Sf/AeHxPd8+uODhCLI=;
        b=i9GO0aSO0kDZE2YDHeNSVIzs2z5dvTIe46qRHmzgJe1KB6MG0sktdTPFXvfm/MjtZg
         2ARdR8+xCD8Oticuijqi4D2FaGsuWQlyd2md2DF7LQioENoU2AACDtvQYBqyInTzgLCv
         X6o4uY3IGG+q/NFmz5p0IYzfbU16DCMhiTy5uj9QhzzMW7qzw75LVSnGO8BWwZRAVqf/
         jCTTIbuzr9Z6744P03E9YnO+RjNynynMRevdxKAJWGSkLL7SsFEFn5NZvw9mERGJgXbj
         GjxY2dVzzUotLI7wnr6CsoVSyTpL4N3579bh32Q/BW4pM+N80e5qexsib0yBG/EeBDNQ
         f0Nw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EudKvMOl;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EudKvMOl;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Subject: [PATCH 4.16 004/110] usbip: usbip_host: run rebind from exit when module is removed
Date: Mon, 21 May 2018 23:11:01 +0200
Message-Id: <20180521210504.225926526@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109761016461702?=
X-GMAIL-MSGID: =?utf-8?q?1601110329882210191?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan (Samsung OSG) <shuah@kernel.org>

commit 7510df3f29d44685bab7b1918b61a8ccd57126a9 upstream.

After removing usbip_host module, devices it releases are left without
a driver. For example, when a keyboard or a mass storage device are
bound to usbip_host when it is removed, these devices are no longer
bound to any driver.

Fix it to run device_attach() from the module exit routine to restore
the devices to their original drivers. This includes cleanup changes
and moving device_attach() code to a common routine to be called from
rebind_store() and usbip_host_exit().

Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/stub_dev.c  |    6 ----
 drivers/usb/usbip/stub_main.c |   60 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 52 insertions(+), 14 deletions(-)

--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -448,12 +448,8 @@ static void stub_disconnect(struct usb_d
 	busid_priv->sdev = NULL;
 	stub_device_free(sdev);
 
-	if (busid_priv->status == STUB_BUSID_ALLOC) {
+	if (busid_priv->status == STUB_BUSID_ALLOC)
 		busid_priv->status = STUB_BUSID_ADDED;
-	} else {
-		busid_priv->status = STUB_BUSID_OTHER;
-		del_match_busid((char *)udev_busid);
-	}
 }
 
 #ifdef CONFIG_PM
--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -14,6 +14,7 @@
 #define DRIVER_DESC "USB/IP Host Driver"
 
 struct kmem_cache *stub_priv_cache;
+
 /*
  * busid_tables defines matching busids that usbip can grab. A user can change
  * dynamically what device is locally used and what device is exported to a
@@ -169,6 +170,51 @@ static ssize_t match_busid_store(struct
 }
 static DRIVER_ATTR_RW(match_busid);
 
+static int do_rebind(char *busid, struct bus_id_priv *busid_priv)
+{
+	int ret;
+
+	/* device_attach() callers should hold parent lock for USB */
+	if (busid_priv->udev->dev.parent)
+		device_lock(busid_priv->udev->dev.parent);
+	ret = device_attach(&busid_priv->udev->dev);
+	if (busid_priv->udev->dev.parent)
+		device_unlock(busid_priv->udev->dev.parent);
+	if (ret < 0) {
+		dev_err(&busid_priv->udev->dev, "rebind failed\n");
+		return ret;
+	}
+	return 0;
+}
+
+static void stub_device_rebind(void)
+{
+#if IS_MODULE(CONFIG_USBIP_HOST)
+	struct bus_id_priv *busid_priv;
+	int i;
+
+	/* update status to STUB_BUSID_OTHER so probe ignores the device */
+	spin_lock(&busid_table_lock);
+	for (i = 0; i < MAX_BUSID; i++) {
+		if (busid_table[i].name[0] &&
+		    busid_table[i].shutdown_busid) {
+			busid_priv = &(busid_table[i]);
+			busid_priv->status = STUB_BUSID_OTHER;
+		}
+	}
+	spin_unlock(&busid_table_lock);
+
+	/* now run rebind */
+	for (i = 0; i < MAX_BUSID; i++) {
+		if (busid_table[i].name[0] &&
+		    busid_table[i].shutdown_busid) {
+			busid_priv = &(busid_table[i]);
+			do_rebind(busid_table[i].name, busid_priv);
+		}
+	}
+#endif
+}
+
 static ssize_t rebind_store(struct device_driver *dev, const char *buf,
 				 size_t count)
 {
@@ -189,16 +235,9 @@ static ssize_t rebind_store(struct devic
 	/* mark the device for deletion so probe ignores it during rescan */
 	bid->status = STUB_BUSID_OTHER;
 
-	/* device_attach() callers should hold parent lock for USB */
-	if (bid->udev->dev.parent)
-		device_lock(bid->udev->dev.parent);
-	ret = device_attach(&bid->udev->dev);
-	if (bid->udev->dev.parent)
-		device_unlock(bid->udev->dev.parent);
-	if (ret < 0) {
-		dev_err(&bid->udev->dev, "rebind failed\n");
+	ret = do_rebind((char *) buf, bid);
+	if (ret < 0)
 		return ret;
-	}
 
 	/* delete device from busid_table */
 	del_match_busid((char *) buf);
@@ -323,6 +362,9 @@ static void __exit usbip_host_exit(void)
 	 */
 	usb_deregister_device_driver(&stub_driver);
 
+	/* initiate scan to attach devices */
+	stub_device_rebind();
+
 	kmem_cache_destroy(stub_priv_cache);
 }
 
