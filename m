Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs2nes5fumtYnSIyg9UAAJLnFvYbUpx0LIh120S5G5z1O1vYG1EvJ5evDSYtwhkIqr1MWaH
ARC-Seal: i=1; a=rsa-sha256; t=1521800091; cv=none;
        d=google.com; s=arc-20160816;
        b=xTUWkoenna2XkKH3zXkD9IOunzLo/kG7QRWq/XDgx6hcntWGheS0o/F/Ucj/8rttlm
         CmLUvcEuW9R+SFxPatgu3/uG3GANCBkubwzsH2WZkqsoi9tzt/0gKOGLfVcDYAj52swR
         i/M8Nip39q7k0nwU2bL8AKUIN/+lA82y8ryfdVP9WRd6L+IVHA/Kiiw2qafNLzcvQqOw
         SYPO1Vvtdldq0hCFRTSbqZYGncE0xq2Vn6pLxQatsSxj/VwTPqbgxqIPrUeukqtg3qOh
         aCdvVXdCVIU0KqqNYzHPkcJYofOZNBqXVPu14vkcNe7xVYKj9vu5WHd1RUcTfrUftcOu
         uoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=M/zHva4BOPF2rqgJO7kQkNQs42RdwtLuemZyDe6G3pM=;
        b=dq8bmBg4uyEzsU6EBHAmsZt0A3StnvvTv0T4U1JocgCcbVMLb3ouRcbfUofs5ECR0n
         dJbP67sbergUXnyv8blVhI1yX/rHXNm7rHDqQaNNHrsFBFBsMYs4rmzoh4TGWOe3F9Hq
         67WLo7xZvZT5/ZWKaAX/9ztdOaKI9RAHNDQAglv35Upd8eqfoj8kvcqK9vGFljIchty9
         fAvw9aGBBs39BCUb4WdGmQHaZCVbuM8Wm8FNHDSRbKB+34RlXLyuD8aL/SrlfoWfzWgM
         S4dbD56W2CLBXxXYlKKFOBtVbfsyBNr0+6Z7GvD3OyxYWMKwMNLB2VQKYGOoMtIn28oj
         7QTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 46/97] iio: st_pressure: st_accel: Initialise sensor platform data properly
Date: Fri, 23 Mar 2018 10:54:33 +0100
Message-Id: <20180323094200.211751647@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722647032251285?=
X-GMAIL-MSGID: =?utf-8?q?1595723053141201749?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shrirang Bagul <shrirang.bagul@canonical.com>


[ Upstream commit 7383d44b84c94aaca4bf695a6bd8a69f2295ef1a ]

This patch fixes the sensor platform data initialisation for st_pressure
and st_accel device drivers. Without this patch, the driver fails to
register the sensors when the user removes and re-loads the driver.

1. Unload the kernel modules for st_pressure
$ sudo rmmod st_pressure_i2c
$ sudo rmmod st_pressure

2. Re-load the driver
$ sudo insmod st_pressure
$ sudo insmod st_pressure_i2c

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/accel/st_accel_core.c       |    7 ++++---
 drivers/iio/pressure/st_pressure_core.c |    8 ++++----
 2 files changed, 8 insertions(+), 7 deletions(-)

--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -628,6 +628,8 @@ static const struct iio_trigger_ops st_a
 int st_accel_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *adata = iio_priv(indio_dev);
+	struct st_sensors_platform_data *pdata =
+		(struct st_sensors_platform_data *)adata->dev->platform_data;
 	int irq = adata->get_irq_data_ready(indio_dev);
 	int err;
 
@@ -652,9 +654,8 @@ int st_accel_common_probe(struct iio_dev
 					&adata->sensor_settings->fs.fs_avl[0];
 	adata->odr = adata->sensor_settings->odr.odr_avl[0].hz;
 
-	if (!adata->dev->platform_data)
-		adata->dev->platform_data =
-			(struct st_sensors_platform_data *)&default_accel_pdata;
+	if (!pdata)
+		pdata = (struct st_sensors_platform_data *)&default_accel_pdata;
 
 	err = st_sensors_init_sensor(indio_dev, adata->dev->platform_data);
 	if (err < 0)
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -436,6 +436,8 @@ static const struct iio_trigger_ops st_p
 int st_press_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *press_data = iio_priv(indio_dev);
+	struct st_sensors_platform_data *pdata =
+		(struct st_sensors_platform_data *)press_data->dev->platform_data;
 	int irq = press_data->get_irq_data_ready(indio_dev);
 	int err;
 
@@ -464,10 +466,8 @@ int st_press_common_probe(struct iio_dev
 	press_data->odr = press_data->sensor_settings->odr.odr_avl[0].hz;
 
 	/* Some devices don't support a data ready pin. */
-	if (!press_data->dev->platform_data &&
-				press_data->sensor_settings->drdy_irq.addr)
-		press_data->dev->platform_data =
-			(struct st_sensors_platform_data *)&default_press_pdata;
+	if (!pdata && press_data->sensor_settings->drdy_irq.addr)
+		pdata =	(struct st_sensors_platform_data *)&default_press_pdata;
 
 	err = st_sensors_init_sensor(indio_dev, press_data->dev->platform_data);
 	if (err < 0)
