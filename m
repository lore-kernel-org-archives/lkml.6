Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48rQE6fsWE7bNT4EBVx84iWXK5n4KeC9oYyZLOUFsKI8KWJ95XyxY/NdEvf2PSqcFlcRN44
ARC-Seal: i=1; a=rsa-sha256; t=1522168249; cv=none;
        d=google.com; s=arc-20160816;
        b=F9HtpeiG79lAVbdFaGe+aeuns+Z2zv2JoSLpyjuagUFyY9b8WnVbdsuzg8e1mB0Ksj
         vCzW71SMXBi1STuQBlDGhID/qTGDjUUx9R7FHuTMvtHXz9yeOiUqINswWsj6cM9nEHCc
         HJ/aj9MqAwSOsy4mvwfFHPzEykEnc7Fh1RHxPM9udd48zd06PmJqGf7+gLCdEBKyQkwt
         vBTFh0SR2wSYAV0Da9jn7zEZvC93JfLzfDFzVHrLgBWdcLdeI1umvlkQKOurPlLU4XSP
         XCoCFOxcI7pmWD3gxXOF+WyXoXKH1xI2RXA+w2kHNh4FROQAGg29zYI65vIrO2L4To23
         hq+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tb8qVtCYSbUELcyse/LeZZrgyR2K8ao4bLrq+/KZumQ=;
        b=lMcViXndYI3XbR8GBeIckrnXuSowWXD9MkAP09qSv9Sv1vUUPvcFCldLwUMtVBJCiH
         8fT4lN05EoYgfIWzHievIZAg+XlSzjyBCIO1+THUD/M7+XdcPTBDEbxSZ5FPMoUv5tL2
         ewOjoHgQYl1t+hvFbAI/j0d9XSPWKjiyUvV+Yj2wwNVHP4BpylMqF3nT9j85q4KSiOCV
         N24WGZbcEBuwkMLFsRTQqQo8IMzxbo9DLWkI7BzjpWEId2ggDwCdntxxOXT4BPGW9jeW
         O9oh7HeUleXC88AIQtmzZjpEucAPq9qYjGVQSt2AdD5XDTf8eoRJWc9VA97DtSk401Sc
         0h6w==
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
Subject: [PATCH 4.9 02/67] iio: st_pressure: st_accel: pass correct platform data to init
Date: Tue, 27 Mar 2018 18:26:54 +0200
Message-Id: <20180327162726.824005009@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108960436960316?=
X-GMAIL-MSGID: =?utf-8?q?1596109094623655821?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -858,7 +858,7 @@ int st_accel_common_probe(struct iio_dev
 	if (!pdata)
 		pdata = (struct st_sensors_platform_data *)&default_accel_pdata;
 
-	err = st_sensors_init_sensor(indio_dev, adata->dev->platform_data);
+	err = st_sensors_init_sensor(indio_dev, pdata);
 	if (err < 0)
 		goto st_accel_power_off;
 
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -678,7 +678,7 @@ int st_press_common_probe(struct iio_dev
 	if (!pdata && press_data->sensor_settings->drdy_irq.addr)
 		pdata =	(struct st_sensors_platform_data *)&default_press_pdata;
 
-	err = st_sensors_init_sensor(indio_dev, press_data->dev->platform_data);
+	err = st_sensors_init_sensor(indio_dev, pdata);
 	if (err < 0)
 		goto st_press_power_off;
 
