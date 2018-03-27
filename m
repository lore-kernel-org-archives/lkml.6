Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48vg82/TdkwiyM//kTSNH0F6+3p+1k0i1y2+rTduc4z6gclC/zlcJBonDKgZVVE4ofixLD7
ARC-Seal: i=1; a=rsa-sha256; t=1522168985; cv=none;
        d=google.com; s=arc-20160816;
        b=MnrVs8T9eNtB6DP+K8PF20Hlj3WnMI5pmvjZ9j9Zl1TECPOO5B8ZPoePnnLKlH85MA
         MpJIOk+JlPcC5H6R/Be4517OYgeZSzjgJFcob1bNrntNlfpx9VGeRlDZ3C5tzlT5I8d/
         fVK1Swf4sRS/6TGCiCcteJBuvTvraLI9ChBB8ebnb70YOz/DQbuXLmj8FqaMQkbKEsHE
         274Vv3ae5wbC8kre5ok/2cO+I80d4pkx+NVlfe7x+T4A3J67OmLtYEB8OhFt7teuydu4
         +K7ndhVqQbCTk6Xrg22rqt22BSJc5sm8vSFw20tho/mFEiAoQLB3RXpEbs5W1AaJOIan
         2KpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=16FTKyBRNLzb1zyjBlpA3Ueeby8c8l5bsReCkLZq4CY=;
        b=RRBBNAPWgo3bA0EkPyAV8DwWwUgB2/uLfNOLUS5rmilAjEZfZG50+dZvUBPvtKTu49
         2DOKx8cARbQW/V8HKq5DdLIAspQZkEWpHLGygYECeLknIZxYZpaR0g+9p9qgFSlv8OO3
         zdXA1WgEXWQAeTZLSvuCkHWNYBKyoB4NsSsDK4huU1JBcbBK1POttKz96y1m8E9Q8Lg6
         hWOF+FC481kBvWK0IF4xnmDyTSTpGOwSuNzB1Oh3Ba/qmdDOLgOziqVW0z1F6gCYlk7F
         xadYIYYPFhAWk6cAJFCJdPiURDzzqg78NNsPNvb1IUf8Eb25ksmAE/v717lm8Tbyti34
         RB4w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.15 101/105] iio: imu: st_lsm6dsx: introduce conf_lock mutex
Date: Tue, 27 Mar 2018 18:28:21 +0200
Message-Id: <20180327162804.123578343@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109865238927687?=
X-GMAIL-MSGID: =?utf-8?q?1596109865238927687?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

commit 335eaedce461c9092e133ce0c6247f5a0b0baf69 upstream.

Add conf_lock mutex to prevent concurrent FIFO configuration update

Fixes: 290a6ce11d93 (iio: imu: add support to lsm6dsx driver)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        |    2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c |   21 +++++++++++++--------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   |    6 ++++++
 3 files changed, 21 insertions(+), 8 deletions(-)

--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -130,6 +130,7 @@ struct st_lsm6dsx_sensor {
  * @irq: Device interrupt line (I2C or SPI).
  * @lock: Mutex to protect read and write operations.
  * @fifo_lock: Mutex to prevent concurrent access to the hw FIFO.
+ * @conf_lock: Mutex to prevent concurrent FIFO configuration update.
  * @fifo_mode: FIFO operating mode supported by the device.
  * @enable_mask: Enabled sensor bitmask.
  * @sip: Total number of samples (acc/gyro) in a given pattern.
@@ -144,6 +145,7 @@ struct st_lsm6dsx_hw {
 
 	struct mutex lock;
 	struct mutex fifo_lock;
+	struct mutex conf_lock;
 
 	enum st_lsm6dsx_fifo_mode fifo_mode;
 	u8 enable_mask;
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -325,38 +325,40 @@ static int st_lsm6dsx_update_fifo(struct
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 	int err;
 
+	mutex_lock(&hw->conf_lock);
+
 	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS) {
 		err = st_lsm6dsx_flush_fifo(hw);
 		if (err < 0)
-			return err;
+			goto out;
 	}
 
 	if (enable) {
 		err = st_lsm6dsx_sensor_enable(sensor);
 		if (err < 0)
-			return err;
+			goto out;
 	} else {
 		err = st_lsm6dsx_sensor_disable(sensor);
 		if (err < 0)
-			return err;
+			goto out;
 	}
 
 	err = st_lsm6dsx_set_fifo_odr(sensor, enable);
 	if (err < 0)
-		return err;
+		goto out;
 
 	err = st_lsm6dsx_update_decimators(hw);
 	if (err < 0)
-		return err;
+		goto out;
 
 	err = st_lsm6dsx_update_watermark(sensor, sensor->watermark);
 	if (err < 0)
-		return err;
+		goto out;
 
 	if (hw->enable_mask) {
 		err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
 		if (err < 0)
-			return err;
+			goto out;
 
 		/*
 		 * store enable buffer timestamp as reference to compute
@@ -365,7 +367,10 @@ static int st_lsm6dsx_update_fifo(struct
 		sensor->ts = iio_get_time_ns(iio_dev);
 	}
 
-	return 0;
+out:
+	mutex_unlock(&hw->conf_lock);
+
+	return err;
 }
 
 static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -528,7 +528,12 @@ static int st_lsm6dsx_set_watermark(stru
 	if (val < 1 || val > hw->settings->max_fifo_size)
 		return -EINVAL;
 
+	mutex_lock(&hw->conf_lock);
+
 	err = st_lsm6dsx_update_watermark(sensor, val);
+
+	mutex_unlock(&hw->conf_lock);
+
 	if (err < 0)
 		return err;
 
@@ -739,6 +744,7 @@ int st_lsm6dsx_probe(struct device *dev,
 
 	mutex_init(&hw->lock);
 	mutex_init(&hw->fifo_lock);
+	mutex_init(&hw->conf_lock);
 
 	hw->dev = dev;
 	hw->irq = irq;
