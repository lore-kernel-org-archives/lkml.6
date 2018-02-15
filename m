Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2268AMbISpE+Vf+JoLQ1sNAe/hoBbcZDPK4t3vbaHAPVzprN2RD71M3VvpEiVB8mg5ptg0nr
ARC-Seal: i=1; a=rsa-sha256; t=1518708356; cv=none;
        d=google.com; s=arc-20160816;
        b=NzNA6KPluDg7J+/iukBSYUTXUdVqBsdD0AX0o7pPoBjc36V8ifzzxv4GNHFJljftvO
         g1KDUo32Sas4jTvq+dwnHvQS39MB+2vRKMvEQv/JRAWl3JsJfzuwxBrYNZj7UBtLSWp2
         wMEhg5dyQJUxyNiPqXfMCbzdDar6PMBCn9UVv8AJI3scr2VN++JfSo+hY+mMds3M91fw
         mLnMxntrbMLqruq8WUiAeCJipkBJGORxMNO1AV6HMdkmhlaFLRCtXNP58tjICjlbd26K
         rfR7hkiF1knuvrVYf2dgdl3YiQoIL7epYnkDJt2NoshwNknJOvNSLEdNJM87mIHy5oiG
         Zucg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=exJc8aYvKkeu6/fAzoXBoHNGW3DIWMjh6XOtdVJ4sec=;
        b=cOC3ay5/VMZPpXZ+RPDRAUY3s0OSvyKTTxqxs01TGgUdEBgbhk2itQ2M8fn47u1iut
         JWbaGjwvjm37sTWBs25qMbadA5hHwzsH36pULBZMWbib2mBt4MqhN7FBuVVjleiJkeD0
         wTuVneldoDO5Ms6BeCKbSvJE2UIqwNksARFYA3miYsRo6CjnEqAEo73PzRc/ztATZwV8
         eG2lcDGA/HWPbvFcLZKfgXmTQWvI2aZCzi3QgffPZYU39A/meNYxyf4Ss7n6QZe2lsvL
         M8frLtblVEjc8DPkdFtYQlX36DOUOFwHmIfqcQyKyS5bTypTKFfT2s9iS1N9GNQ6Cku1
         FjYw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arvind Yadav <arvind.yadav.cs@gmail.com>,
	Andrey Konovalov <andreyknvl@google.com>,
	Hans Verkuil <hans.verkuil@cisco.com>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 14/88] media: hdpvr: Fix an error handling path in hdpvr_probe()
Date: Thu, 15 Feb 2018 16:16:41 +0100
Message-Id: <20180215151224.695159399@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481133975542082?=
X-GMAIL-MSGID: =?utf-8?q?1592481133975542082?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arvind Yadav <arvind.yadav.cs@gmail.com>

commit c0f71bbb810237a38734607ca4599632f7f5d47f upstream.

Here, hdpvr_register_videodev() is responsible for setup and
register a video device. Also defining and initializing a worker.
hdpvr_register_videodev() is calling by hdpvr_probe at last.
So no need to flush any work here.
Unregister v4l2, free buffers and memory. If hdpvr_probe() will fail.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Reported-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/hdpvr/hdpvr-core.c |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

--- a/drivers/media/usb/hdpvr/hdpvr-core.c
+++ b/drivers/media/usb/hdpvr/hdpvr-core.c
@@ -295,7 +295,7 @@ static int hdpvr_probe(struct usb_interf
 	/* register v4l2_device early so it can be used for printks */
 	if (v4l2_device_register(&interface->dev, &dev->v4l2_dev)) {
 		dev_err(&interface->dev, "v4l2_device_register failed\n");
-		goto error;
+		goto error_free_dev;
 	}
 
 	mutex_init(&dev->io_mutex);
@@ -304,7 +304,7 @@ static int hdpvr_probe(struct usb_interf
 	dev->usbc_buf = kmalloc(64, GFP_KERNEL);
 	if (!dev->usbc_buf) {
 		v4l2_err(&dev->v4l2_dev, "Out of memory\n");
-		goto error;
+		goto error_v4l2_unregister;
 	}
 
 	init_waitqueue_head(&dev->wait_buffer);
@@ -342,13 +342,13 @@ static int hdpvr_probe(struct usb_interf
 	}
 	if (!dev->bulk_in_endpointAddr) {
 		v4l2_err(&dev->v4l2_dev, "Could not find bulk-in endpoint\n");
-		goto error;
+		goto error_put_usb;
 	}
 
 	/* init the device */
 	if (hdpvr_device_init(dev)) {
 		v4l2_err(&dev->v4l2_dev, "device init failed\n");
-		goto error;
+		goto error_put_usb;
 	}
 
 	mutex_lock(&dev->io_mutex);
@@ -356,7 +356,7 @@ static int hdpvr_probe(struct usb_interf
 		mutex_unlock(&dev->io_mutex);
 		v4l2_err(&dev->v4l2_dev,
 			 "allocating transfer buffers failed\n");
-		goto error;
+		goto error_put_usb;
 	}
 	mutex_unlock(&dev->io_mutex);
 
@@ -364,7 +364,7 @@ static int hdpvr_probe(struct usb_interf
 	retval = hdpvr_register_i2c_adapter(dev);
 	if (retval < 0) {
 		v4l2_err(&dev->v4l2_dev, "i2c adapter register failed\n");
-		goto error;
+		goto error_free_buffers;
 	}
 
 	client = hdpvr_register_ir_rx_i2c(dev);
@@ -397,13 +397,17 @@ static int hdpvr_probe(struct usb_interf
 reg_fail:
 #if IS_ENABLED(CONFIG_I2C)
 	i2c_del_adapter(&dev->i2c_adapter);
+error_free_buffers:
 #endif
+	hdpvr_free_buffers(dev);
+error_put_usb:
+	usb_put_dev(dev->udev);
+	kfree(dev->usbc_buf);
+error_v4l2_unregister:
+	v4l2_device_unregister(&dev->v4l2_dev);
+error_free_dev:
+	kfree(dev);
 error:
-	if (dev) {
-		flush_work(&dev->worker);
-		/* this frees allocated memory */
-		hdpvr_delete(dev);
-	}
 	return retval;
 }
 
