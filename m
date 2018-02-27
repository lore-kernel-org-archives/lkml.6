Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x226EQOrwzqyTlO09H0Hr4KPQjWp7xM1YbRDxbyGFcGyGdr3HVCDHc4bdO96aIPVferyjW5bv
ARC-Seal: i=1; a=rsa-sha256; t=1519773673; cv=none;
        d=google.com; s=arc-20160816;
        b=tqgZrTYo22knCIRhfYRgoo+kNzY1mG/2rp1zbydQc9ncPuEr7aFUvzr28ybsPkjb6p
         pEKbphXqARjBHllQFa9wdk+Fn3cs7IcHJ7/DGnPnFd/RPRaeERQsEvp3cQeRK44v2Gax
         6p7/u4F40ERS8U1i45i7rchiav5YzUal0ZdYKIDwSgjN9HnMttIfrfacaYhUyXTqfeQF
         mrdelstUOEGJq3GQUe2xPpwAf21JVqeMJ6XkXGKPtBtP6nO1PnAQgJ6m+rJnPK6qu2ss
         tNgF+gFzQdeHcUiXvUICiWO75RW9WO+ij11GQF5JI5EZ6WxSmJZW05kCjZGCZL5YDc5I
         YbnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=CwAfji42l1hb7jCIsodVrBJhgD2xiJ87njkyQKB/pQo=;
        b=EBmlWAYGjKTgxZOBaCF/y30UElWMXTzB63DV0v7LZAef5KM8cyhYTK/OAVGCyts/oD
         ABDcxKpH2uG+SA0rkHOhp5FbrPb7pRQaoAtTgaZLQyjyESUAL2n3Aqt/xMCMhRG4DQeL
         H1AuuZorNoi4llr83NMnxNX7JeDHCKi1sWXB8+XMbiMils/SGq45EWbjdp6nZ5yyDxnF
         IwC3Y9GXUMnKIZeoQqd2BpX77AwgVTm965FOztAwr2gg67K2Mz48BrLHzHNXNvQd3Err
         37IczE/ZD4KQfs2AxUrmEdN/9f9kTzeJr6KldnGw53q1JuwC8Ebu5tJsQ2cErGyuuXK/
         Zfvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CF8217BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: cantabile.desu@gmail.com
Cc: kubakici@wp.pl,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	linux-wireless@vger.kernel.org,
	keescook@chromium.org,
	shuah@kernel.org,
	mfuzzey@parkeon.com,
	zohar@linux.vnet.ibm.com,
	dhowells@redhat.com,
	pali.rohar@gmail.com,
	tiwai@suse.de,
	arend.vanspriel@broadcom.com,
	zajec5@gmail.com,
	nbroeking@me.com,
	markivx@codeaurora.org,
	stephen.boyd@linaro.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [RFT 6/7] firmware: add request_firmware_cache() to help with cache on reboot
Date: Tue, 27 Feb 2018 15:21:00 -0800
Message-Id: <20180227232101.20786-7-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180227232101.20786-1-mcgrof@kernel.org>
References: <20180227232101.20786-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593598199703654538?=
X-GMAIL-MSGID: =?utf-8?q?1593598199703654538?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some devices have an optimization in place to enable the firmware to
be retaineed during a system reboot, so after reboot the device can skip
requesting and loading the firmware. This can save up to 1s in load
time. The mt7601u 802.11 device happens to be such a device.

When these devices retain the firmware on a reboot and then suspend
they can miss looking for the firmware on resume. To help with this we
need a way to cache the firmware when such an optimization has taken
place.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 .../driver-api/firmware/request_firmware.rst       | 14 +++++++++++++
 drivers/base/firmware_loader.c                     | 24 ++++++++++++++++++++++
 include/linux/firmware.h                           |  3 +++
 3 files changed, 41 insertions(+)

diff --git a/Documentation/driver-api/firmware/request_firmware.rst b/Documentation/driver-api/firmware/request_firmware.rst
index cc0aea880824..b554f4338859 100644
--- a/Documentation/driver-api/firmware/request_firmware.rst
+++ b/Documentation/driver-api/firmware/request_firmware.rst
@@ -44,6 +44,20 @@ request_firmware_nowait
 .. kernel-doc:: drivers/base/firmware_class.c
    :functions: request_firmware_nowait
 
+Special optimizations on reboot
+===============================
+
+Some devices have an optimization in place to enable the firmware to be
+retained during system reboot. When such optimizations are used the driver
+author must ensure the firmware is still available on resume from suspend,
+this can be done with request_firmware_cache() insted of requesting for the
+firmare to be loaded.
+
+request_firmware_cache()
+-----------------------
+.. kernel-doc:: drivers/base/firmware_class.c
+   :functions: request_firmware_load
+
 request firmware API expected driver use
 ========================================
 
diff --git a/drivers/base/firmware_loader.c b/drivers/base/firmware_loader.c
index 99c540164074..c122f6431e0c 100644
--- a/drivers/base/firmware_loader.c
+++ b/drivers/base/firmware_loader.c
@@ -656,6 +656,30 @@ int request_firmware_direct(const struct firmware **firmware_p,
 }
 EXPORT_SYMBOL_GPL(request_firmware_direct);
 
+/**
+ * request_firmware_cache: - cache firmware for suspend so resume can use it
+ * @name: name of firmware file
+ * @device: device for which firmware should be cached for
+ *
+ * There are some devices with an optimization that enables the device to not
+ * require loading firmware on system reboot. This optimization may still
+ * require the firmware present on resume from suspend. This routine can be
+ * used to ensure the firmware is present on resume from suspend in these
+ * situations. This helper is not compatible with drivers which use
+ * request_firmware_into_buf() or request_firmware_nowait() with no uevent set.
+ **/
+int request_firmware_cache(struct device *device, const char *name)
+{
+	int ret;
+
+	mutex_lock(&fw_lock);
+	ret = fw_add_devm_name(device, name);
+	mutex_unlock(&fw_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(request_firmware_cache);
+
 /**
  * request_firmware_into_buf - load firmware into a previously allocated buffer
  * @firmware_p: pointer to firmware image
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index d4508080348d..166867910ebc 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -85,4 +85,7 @@ static inline int request_firmware_into_buf(const struct firmware **firmware_p,
 }
 
 #endif
+
+int request_firmware_cache(struct device *device, const char *name);
+
 #endif
-- 
2.16.2
