Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+k2hbilKJKMmV0Engtj7Kr4Sx+eVaezkKrJS7LHHfEIWPMcOOZLoFl7Vaye4UyACCCXzBi
ARC-Seal: i=1; a=rsa-sha256; t=1522168474; cv=none;
        d=google.com; s=arc-20160816;
        b=u4MVcOGe+iK3ERXoyih98mNFQ0I1Jg14ysaXLg2A9AetOYsFtTYm/f1iYM410kS+qL
         vUJGUv9zb9Xi6q0FggJBqAHH3crtrT4tSTufTMOQk+aWTTpqnek7FFVQcYah+TyYYxjv
         QWXBekPEKlGCuWtLV1PDfUxmvArSjhDDgrvVX0mFbB+mN2K5nrUQBF3IQWagpoB0zPnr
         wPv1Px74RC6LOtxMp02lFFFZ978yhCjrUklph8lb9ExVh2XNnAEnWtqi8pQqcz6UJuZK
         Ro/8+xbqXGYGMWHwf2MANQrA6g3ljAdvVVYA1Bg1DyyovOgVFrApLooQUWy3wge9nJ4P
         GMig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5+N5yr5Ct3I8y44x3piS/HToflKCVeTDPHRvgLDCKAg=;
        b=Au1js/ZST3583S6vyTOsvOiHXm3//PW1dJXrtaG4Fkh94hsF7/Ozuw8+15bqed1tkz
         e2KOatFmmFK1EDiF9ZEKCeICS2Uz3ahif/gq5mMkCv6mivK/0Gf250r+wLS9sMuLqIKO
         oqTpmbR+M9Wpm7afNO9AdTvE1PSC5/yMqx6AbzNmCZklSDtWVN2WQDep6McmI8D8wBkc
         buICP4Z/oDerAHRg0wngIKDMGhRNbF8cwhniNf+thZAFN2QnPtiv0d1cFsQihaw09COZ
         NYwdRigP8U/s7Hp2kInsXq4emrEqbe/pFirIaBu2LnYHxXpQVxKZXDm3S34QW7uEpApZ
         H3Hg==
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
Subject: [PATCH 4.14 007/101] iio: st_pressure: st_accel: pass correct platform data to init
Date: Tue, 27 Mar 2018 18:26:39 +0200
Message-Id: <20180327162750.472067728@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108960436960316?=
X-GMAIL-MSGID: =?utf-8?q?1596109330055958209?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -794,7 +794,7 @@ int st_accel_common_probe(struct iio_dev
 	if (!pdata)
 		pdata = (struct st_sensors_platform_data *)&default_accel_pdata;
 
-	err = st_sensors_init_sensor(indio_dev, adata->dev->platform_data);
+	err = st_sensors_init_sensor(indio_dev, pdata);
 	if (err < 0)
 		goto st_accel_power_off;
 
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -617,7 +617,7 @@ int st_press_common_probe(struct iio_dev
 	if (!pdata && press_data->sensor_settings->drdy_irq.addr)
 		pdata =	(struct st_sensors_platform_data *)&default_press_pdata;
 
-	err = st_sensors_init_sensor(indio_dev, press_data->dev->platform_data);
+	err = st_sensors_init_sensor(indio_dev, pdata);
 	if (err < 0)
 		goto st_press_power_off;
 
