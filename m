Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AG47ELvq4CE0yiFJke3sAap0R1289O5pU8zTueH1UT02bVx15ny5Ub32aNTQokHhMsyXfW6gvn4D
ARC-Seal: i=1; a=rsa-sha256; t=1520691336; cv=none;
        d=google.com; s=arc-20160816;
        b=fLLz81MFQTI3B4HoDMXi+EaZkTCNwM22s16rDxPt/nMmkVuBlaSyju9BOYlHTqn7GX
         H1W11FEQbG4HIpSig8KbXLl7arJzBP7xKrdU5NrU0+Dpmt2/y+5Guq6SvbGF8efM57FP
         yTUDfWvVg8FUGb6fK8b3KbmS1gH71GoRqti18cdLVJYYkBId/ZPCMeRUkkgWk1VIYNEq
         OiZkMxJcu8FHSPhnGI0kGXV73qFYaBoKetW2YxPL7coGP2uGhujF1GBJohMDzTkZ0QWd
         SL9O7GWb7QNdVn8gII9jSWDncQH5xP05olfXJxNfHU17E170sYWwzJJnPBQmXF7wTZf6
         B+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=xWZq61tGkwxl7GT0aBWYE6fOeXBFZCpKKFxkSinR6lM=;
        b=elTNUHwdvv9XVy/wN7QClwedkLs2aURX0LduYYhjvsgabjGdU0tAvs652d8RUIEPKl
         OzI0GWxbla9DfmUToLyfmA2GlxKm+StfgdeRI/UbBu/LGPnH6lBuA6l5mRQPxZrxbT8V
         gOl/zctHyp49FosTbZutphkJMGg7siqrtQKXt+THIpakzlWwVaxA4mwlTai0OWjfRzt4
         6vQSQ3AjdMrbSI02Or3mSYF4fmTwktst+OKeMmAnGHV/Wxi335Dj5XEFTe1xrfpOmWBU
         hS+MPnGDm3E+a+sONtVccFEuxe2Actz+RC/rTJ/HEK5DY2bgyZEUUT4wzh2+E6gTvJI2
         hN8g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33777217D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	cantabile.desu@gmail.com,
	kubakici@wp.pl,
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
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	ast@fb.com,
	andresx7@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v3 19/20] firmware: add request_firmware_cache() to help with cache on reboot
Date: Sat, 10 Mar 2018 06:15:00 -0800
Message-Id: <20180310141501.2214-20-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180310141501.2214-1-mcgrof@kernel.org>
References: <20180310141501.2214-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594560438545867805?=
X-GMAIL-MSGID: =?utf-8?q?1594560438545867805?=
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
 drivers/base/firmware_loader/main.c                | 24 ++++++++++++++++++++++
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
 
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 2913bb0e5e7b..04bf853f60e9 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
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
