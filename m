Return-Path: <bleung@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521913244; cv=none;
        d=google.com; s=arc-20160816;
        b=wyUkOJbzMLKIRo53sM9cIFloXdJt+DL5oBZWS3UNvMqvbuhgGLDk6ulAWLAxJU76QH
         4sDqisd0vMParDjoacPO0CP8N4CKwBEd0TflJUMnjy3dZ6ksIY/yCDQFnNb4x3Q84wJW
         VJYBnQwdkSDw1d81+rL10pVv8fDbVTeLosvnjoHzRbkZqixa/oRPDdC30P5OyC7gOri2
         RB8WDC0wmfV0D7y/C/jaPZVZFFO2Lt7iOBte0nXrdtHYt+PXSk55ze8ALfdPURBA+m7r
         dznIq5QEQmaJVvwHmXKOQnMBeMgrLYUp5Jxmc0t0VYPY0P6iVma9h5Iv/6Q4RBh32PxG
         GKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=JF1ATzAMg8HuaWJA7IAuD0xeneByWMNo31MTUdTpoR8=;
        b=DsnGWMVMSOgWe7zYjboDs7B46JrsoZoFo/HuEfTlU+wVD3JnuQCOdIADZ8zUtqTiGF
         azE+kpoy6Tv8j2UbgRySntrpWv7aY15QD/3LJxzVdQV2qJt4lGjFb2DUWglmjYhg7y6x
         VYluH73k221nw6y4+7yJqPkDvs1rNoFwW+pahKgcuQ9XjGwAiGRZx+XwXcGvMw1lcc2j
         so9GZwEQToNFmsLcZhQTzWcfYvpV9pL0w7F2RS3p3Ixx/4CXJenS4m+NPZxjWmDBWMs8
         lvOhvD9DTp2Y0mcg0kn2MjTc/rbBuXiXTju9BZmM0MzfLmNNDFSDjfqMoLvTd/CWhvV5
         0NoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=HdNrQ9mZ;
       spf=pass (google.com: domain of bleung@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bleung@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=HdNrQ9mZ;
       spf=pass (google.com: domain of bleung@chromium.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bleung@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELsYkZBJJG7gTFoMxTIq4/ViH7rO+3oWiMhAA231SFo6NYjEBB3JQMpGRZbu/XQzDSNT5kzBBQ==
From: Benson Leung <bleung@chromium.org>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stern@rowland.harvard.edu
Cc: achant@google.com,
	bleung@google.com,
	Benson Leung <bleung@chromium.org>
Subject: [PATCH v3] USB: announce bcdDevice as well as idVendor, idProduct.
Date: Sat, 24 Mar 2018 10:40:27 -0700
Message-Id: <20180324174027.12522-1-bleung@chromium.org>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
In-Reply-To: <20180324003330.180726-1-bleung@chromium.org>
References: <20180324003330.180726-1-bleung@chromium.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595777100282268882?=
X-GMAIL-MSGID: =?utf-8?q?1595841702685089669?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Print bcdDevice which is used by vendors to identify different versions
of the same product (or different versions of firmware).

Adding this to the logs will be useful for support purposes.

Match the %2x.%02x formatting that's used by lsusb -v for this same value.

Signed-off-by: Benson Leung <bleung@chromium.org>
---

v3: Remove unnecessary whitespace changes.
v2: Format for decimal output.

 drivers/usb/core/hub.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index aaeef03c0d83..779725836cf5 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2192,9 +2192,13 @@ static void show_string(struct usb_device *udev, char *id, char *string)
 
 static void announce_device(struct usb_device *udev)
 {
-	dev_info(&udev->dev, "New USB device found, idVendor=%04x, idProduct=%04x\n",
+	u16 bcdDevice = le16_to_cpu(udev->descriptor.bcdDevice);
+
+	dev_info(&udev->dev,
+		"New USB device found, idVendor=%04x, idProduct=%04x, bcdDevice=%2x.%02x\n",
 		le16_to_cpu(udev->descriptor.idVendor),
-		le16_to_cpu(udev->descriptor.idProduct));
+		le16_to_cpu(udev->descriptor.idProduct),
+		bcdDevice >> 8, bcdDevice & 0xff);
 	dev_info(&udev->dev,
 		"New USB device strings: Mfr=%d, Product=%d, SerialNumber=%d\n",
 		udev->descriptor.iManufacturer,
-- 
2.17.0.rc0.231.g781580f067-goog
