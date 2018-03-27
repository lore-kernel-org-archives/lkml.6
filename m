Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49MnXOxCkMDxtXoDfvUSxuCtqJGWQsI3nYVyH8UuiDdnjmuyS1+D0CXtaZ1lXmhd4Z0vVXX
ARC-Seal: i=1; a=rsa-sha256; t=1522168803; cv=none;
        d=google.com; s=arc-20160816;
        b=gL1Sk086kdrnj7/0yMocYHG9ask72Io0woVVEoZjB5nCZqIcy3DeAjqR2cFhqgyxKM
         pgSFV/3uYeuXIsL7suhAQsEjNfNBRRNhSh2PRxtZHN9REDdKlz+MTlfIl7snUaS2rYcG
         /UswLOi2niI2zrnallcwpPCoCeOaFpkbX9oJhwaJx21PxlgsvDAEBTJCCSLveBQcUMGC
         GOAeF4SRZoX2JRa+eSSIe2w95tUwddr9rXKgvnyKyqshBc4YQbV1IodY5CGBEOkYkobn
         g/6mYToNqp66KG+ODmJ2lQcmNH38e1qffh80AB+EjNtdJdAcOyv5rhwPDLL1Y2NK2lcf
         rtIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eMgZ5j2QzaEVU43Ww03S+l6rp+A8ofVkO+RxPyir9v4=;
        b=HPpud29HzlWIpA/E1b+EjDt7aEvseAHZuqWS7RssCYa7KV/w4jSZpB9x3HFzvbA8QR
         /MR2PCp0UAotZAGOa7K/qBulA9dfDuZbt1JV8+zr5w37kDeu9j2FyMQTOySBsObzL5va
         /7QpS8bveGJkTEPuOAnNIpVTIPpCrUimJqWRH5ZmXIPIDYjuacU3kZlBkhe8WGwtiKM0
         WahjFwYLlbcIfpKeWzB9qxSeT0pEKAJxrhshYfbV4zbWsMKyA43aDl4gz5wHNRvNSM3F
         nf7XZH8F1hKM/TWZM2WzHamCjL7oyEe9ej3bzzjnGHd6sbCa9FBbhifxsZjwfT0EcypT
         GHCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Richard Lai <richard@richardman.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.15 006/105] iio: chemical: ccs811: Corrected firmware boot/application mode transition
Date: Tue, 27 Mar 2018 18:26:46 +0200
Message-Id: <20180327162758.111015515@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109327046964573?=
X-GMAIL-MSGID: =?utf-8?q?1596109675213923862?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Lai <richard@richardman.com>

commit b91e146c38b003c899710ede6d05fc824675e386 upstream.

CCS811 has different I2C register maps in boot and application mode. When
CCS811 is in boot mode, register APP_START (0xF4) is used to transit the
firmware state from boot to application mode. However, APP_START is not a
valid register location when CCS811 is in application mode (refer to
"CCS811 Bootloader Register Map" and "CCS811 Application Register Map" in
CCS811 datasheet). The driver should not attempt to perform a write to
APP_START while CCS811 is in application mode, as this is not a valid or
documented register location.

When prob function is being called, the driver assumes the CCS811 sensor
is in boot mode, and attempts to perform a write to APP_START. Although
CCS811 powers-up in boot mode, it may have already been transited to
application mode by previous instances, e.g. unload and reload device
driver by the system, or explicitly by user. Depending on the system
design, CCS811 sensor may be permanently connected to system power source
rather than power controlled by GPIO, hence it is possible that the sensor
is never power reset, thus the firmware could be in either boot or
application mode at any given time when driver prob function is being
called.

This patch checks the STATUS register before attempting to send a write to
APP_START. Only if the firmware is not in application mode and has valid
firmware application loaded, then it will continue to start transiting the
firmware boot to application mode.

Signed-off-by: Richard Lai <richard@richardman.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/chemical/ccs811.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -133,6 +133,9 @@ static int ccs811_start_sensor_applicati
 	if (ret < 0)
 		return ret;
 
+	if ((ret & CCS811_STATUS_FW_MODE_APPLICATION))
+		return 0;
+
 	if ((ret & CCS811_STATUS_APP_VALID_MASK) !=
 	    CCS811_STATUS_APP_VALID_LOADED)
 		return -EIO;
