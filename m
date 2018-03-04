Return-Path: <masneyb@onstation.org>
X-Google-Smtp-Source: AG47ELs6iQRh6M0e7ZiOqHni7NCyj7me3rskxwxUIHVAbW2z7v8ENNzy5kSW7B40Vwp2nf/w32nM
ARC-Seal: i=1; a=rsa-sha256; t=1520128194; cv=none;
        d=google.com; s=arc-20160816;
        b=xOqLkEl/nkTII4ihxaztKTZaB8FBbJfZ9myejsQzsIvwTJXMXowtxXjpU1E6xxNGYb
         BJPi+6iu+0CRynA2NPre64daLE1ysgszRJlfysOD2QSKeFhmJ2Bdmc1LBF4zWNkJPrEY
         vlrZEyDQVmvK3nrMHjSH17UnNR9ao5tT+an3uAlpjHWN5mTBA3jV85dMLIBVRvWo9bPv
         k9IGiUsZWTJ05X5dTFR4kLSR5HYbfbj/xYCDSRXvubY0AiO3RDs4xU213ynltySgqIYm
         Sg9sJDlji+lV47XdbgHatuQ5vUZiVjbzL87qnexzO3zNjE1UHbBfqq+lp/6ElWfs2n+/
         koZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=18nZ9BeU73ewRqf/AnOnwy4aRQFQzUq9x0gCFLWD60I=;
        b=SeSOPVuaiYLtqnFBV+wdUoElkHJX21qgJ+wKdAYYnRdGRdnkL6WVNtdK9JYum+uFDi
         wMSLvlhNrWMz67Bb2r4qHNnW2BrVwNBSD4jLpunvbs8Kfp0FTK8d+RpyqZncl6Cep5pn
         TjzrPE3bZv75NTd7xEjIC2PnFaCqByzoS6pG9c9yes3wjS1xgoYVV/kx2IdMVr7Bvx3w
         0UYtOazA/u/sODCw2cm7inocRlD7DJAAsNEyqLXegiei6howuNYuUp7Q5X6h74VNzh+k
         yfaLEDAM9INbkfUrBuSjdTfB+NOfUNO65MPv2g6Ziy+j3/miqDKdyE/JrPfQhMYbfYnJ
         QFtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=Ws5dyQQX;
       spf=pass (google.com: best guess record for domain of masneyb@onstation.org designates 52.200.56.107 as permitted sender) smtp.mailfrom=masneyb@onstation.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@onstation.org header.s=default header.b=Ws5dyQQX;
       spf=pass (google.com: best guess record for domain of masneyb@onstation.org designates 52.200.56.107 as permitted sender) smtp.mailfrom=masneyb@onstation.org
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 09/12] staging: iio: tsl2x7x: add missing error checks
Date: Sat,  3 Mar 2018 20:49:39 -0500
Message-Id: <20180304014942.18727-10-masneyb@onstation.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180304014942.18727-1-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593969942094549142?=
X-GMAIL-MSGID: =?utf-8?q?1593969942094549142?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The functions in_illuminance0_calibrate_store() and
in_illuminance0_lux_table_store() did not have complete error handling
in place. This patch adds the missing error handling.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 8adc6db44790..da7a4e025083 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -940,8 +940,11 @@ static ssize_t in_illuminance0_calibrate_store(struct device *dev,
 	if (strtobool(buf, &value))
 		return -EINVAL;
 
-	if (value)
-		tsl2x7x_als_calibrate(indio_dev);
+	if (value) {
+		ret = tsl2x7x_als_calibrate(indio_dev);
+		if (ret < 0)
+			return ret;
+	}
 
 	ret = tsl2x7x_invoke_change(indio_dev);
 	if (ret < 0)
@@ -1006,8 +1009,11 @@ static ssize_t in_illuminance0_lux_table_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING)
-		tsl2x7x_chip_off(indio_dev);
+	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING) {
+		ret = tsl2x7x_chip_off(indio_dev);
+		if (ret < 0)
+			return ret;
+	}
 
 	/* Zero out the table */
 	memset(chip->tsl2x7x_device_lux, 0, sizeof(chip->tsl2x7x_device_lux));
-- 
2.14.3
