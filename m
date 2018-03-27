Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+LTlyDPcXwUapdcace3u9Zbl5J3rdWIpztULHVl6KSjU0PQ6sFBbRpEKiuTrwQZKU5AmdS
ARC-Seal: i=1; a=rsa-sha256; t=1522168806; cv=none;
        d=google.com; s=arc-20160816;
        b=Er6FS9mLcKPI1X+2tAvmiI8mu4TxSeUBYbw7A7poFT95dxXyxwbL0CYHcHiygUKpo4
         F114+8Wzi8gnXSBEWV20oV2Rk9wGJT4j9Vz5VqjcV/wt10iUjA6f3hGQjwgqNqJln3Us
         qreBKB1ECAuI21NFV0JxO9NXqoyPNLeq12GBrxUO2V7p+BFj1FxAsYRTMo6yKBfhl8fE
         hhNOPkMD5D5vNcXpcTUUV7ZbdzSMZ7yT7xiHZTv9pbXctw2n+csoRdoX+5JTLbQpxBhZ
         gnaMRZW8WAwVYGpPSzci3Ga9Ddkyo/8hG/GaYylC+2T10q0ihB87Ru59et39c9W3GSBw
         Jmdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Sj7UUczSFAxUwWBGQCxSyKZasz2h+kgxgAcARkf0y2s=;
        b=NVn1N3YDjKH2HZelmv/oAHpOGr3Q9CvZxbPx63fdZ8JmAf1CxwXSO6jm8fTpXPBcc7
         BFUK7kxxCqMcGRX4s2faXMhdEG/QPXQN4UoTX/HGnJefy2V3cTAa9iXwFlD2PxdrZwE6
         P1C2cD2M7SlXHXu+EZHltxA7/aecANBEGvghWW02wBDY0eXpcPpywD3XrnboP3fNMw84
         bUOjGg5WnRTZxUD1e7eGpy0egCw5iuSy4PzciLhs2CwLxyNPL9XsTNyNmDEInSckI3Na
         aI4xr8WC8MHbWQfkQZrL6iEMQ2qJjua1GdK8mh6Mv1Xy2+jCWP2FJufnZ/4xhbh1v6HY
         OYpA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Nosthoff <committed@heine.so>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.15 007/105] iio: st_pressure: st_accel: pass correct platform data to init
Date: Tue, 27 Mar 2018 18:26:47 +0200
Message-Id: <20180327162758.159347233@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108960436960316?=
X-GMAIL-MSGID: =?utf-8?q?1596109678834738653?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Nosthoff <committed@heine.so>

commit 8b438686a001db64c21782d04ef68111e53c45d9 upstream.

Commit 7383d44b added a pointer pdata which get set to the default
platform_data when non was defined in the device. But it did not
pass this pointer to the st_sensors_init_sensor call but still
used the maybe uninitialized platform_data from dev.

This breaks initialization when no platform_data is given and
the optional st,drdy-int-pin devicetree option is not set.

This commit fixes this.

Cc: stable@vger.kernel.org
Fixes: 7383d44b ("iio: st_pressure: st_accel: Initialise sensor platform data properly")
Signed-off-by: Michael Nosthoff <committed@heine.so>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/accel/st_accel_core.c       |    2 +-
 drivers/iio/pressure/st_pressure_core.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -951,7 +951,7 @@ int st_accel_common_probe(struct iio_dev
 	if (!pdata)
 		pdata = (struct st_sensors_platform_data *)&default_accel_pdata;
 
-	err = st_sensors_init_sensor(indio_dev, adata->dev->platform_data);
+	err = st_sensors_init_sensor(indio_dev, pdata);
 	if (err < 0)
 		goto st_accel_power_off;
 
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -640,7 +640,7 @@ int st_press_common_probe(struct iio_dev
 		       press_data->sensor_settings->drdy_irq.int2.addr))
 		pdata =	(struct st_sensors_platform_data *)&default_press_pdata;
 
-	err = st_sensors_init_sensor(indio_dev, press_data->dev->platform_data);
+	err = st_sensors_init_sensor(indio_dev, pdata);
 	if (err < 0)
 		goto st_press_power_off;
 
