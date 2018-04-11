Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/CufQwpMbYfUMSe2onnGNb5VH1wWfr41C0XCgIVIzodk5mrVl5KtUMiVE/KQyvmnCavZB9
ARC-Seal: i=1; a=rsa-sha256; t=1523472976; cv=none;
        d=google.com; s=arc-20160816;
        b=mBGqGVjNwPoOVTsCAUl5JLW6Ixb/fSpkjf/STbtWr2bio5ADQjQDQDLEpQQKUU8p+b
         2J8ysmNK18dvveSf0PWUwUgOAsn5WIoLM/qML4EcYJq1JOotjq4KQdJyq3sm/0aVVVtk
         d0+cWIYsMgS4MAIwySl/PArHJRK7hJFfuQp8v3i0H5CJDxjKfx4BkVuPM/gwoKXAiP25
         JnkATGlzLw5nXjoGLyusLwoTZ79f1xnxv227YyXM3eHmEDIYXPOKcU26MEh5rj+CHmdv
         e9xg1Feoj/LwX5g90EHPj2YU8rMX+8JGy9SbqQ0qrl23GYNO+Tyxc1CzbAM/m1RwJhyj
         xtbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oF30Mnckzo7Zyu/xVg2rPRHNPUGXxn9GA9b2a7DQrNk=;
        b=NaDvwlcn/is+tCkH6L+FoSzGP3Pw3w0LqrXu67AHI8gzT12QS/Z4l5xDuQSlUxyrFK
         Ch9fewDMhxteK1tCPpVD87j70RZ97CbCekx9NhBt1qz8dv1fW/Isd9xb1/dOvaXwRGaP
         F50DRaUZpKGsOsEdYbgp3RNmY6uSEXrVQPA3Ecz/JNI6Gl6f1rxXiQwN7Cku+fnRjjz7
         tcYAK0OHiyWS7xFxTLi6bsae6u3EBhhZ4vGJcB6r0dNYvo1zIRPOdBDOU/27bMoiTHnh
         mi9W1kogh+YMXh9Lah0PVd77nJI2vV+KlO0ippjKsC6z8fcLXnDLyBjZ3uMjk4w8mt1l
         OhaA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 084/310] iio: hi8435: cleanup reset gpio
Date: Wed, 11 Apr 2018 20:33:43 +0200
Message-Id: <20180411183625.894021382@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476549159999487?=
X-GMAIL-MSGID: =?utf-8?q?1597477199350242041?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>


[ Upstream commit 61305664a542f874283f74bf0b27ddb31f5045d7 ]

Reset GPIO is active low.

Currently driver uses gpiod_set_value(1) to clean reset, which depends
on device tree to contain GPIO_ACTIVE_HIGH - that does not match reality.

This fixes driver to use _raw version of gpiod_set_value() to enforce
active-low semantics despite of what's written in device tree. Allowing
device tree to override that only opens possibility for errors and does
not add any value.

Additionally, use _cansleep version to make things work with i2c-gpio
and other sleeping gpio drivers.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/hi8435.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -453,13 +453,15 @@ static int hi8435_probe(struct spi_devic
 	priv->spi = spi;
 
 	reset_gpio = devm_gpiod_get(&spi->dev, NULL, GPIOD_OUT_LOW);
-	if (IS_ERR(reset_gpio)) {
-		/* chip s/w reset if h/w reset failed */
+	if (!IS_ERR(reset_gpio)) {
+		/* need >=100ns low pulse to reset chip */
+		gpiod_set_raw_value_cansleep(reset_gpio, 0);
+		udelay(1);
+		gpiod_set_raw_value_cansleep(reset_gpio, 1);
+	} else {
+		/* s/w reset chip if h/w reset is not available */
 		hi8435_writeb(priv, HI8435_CTRL_REG, HI8435_CTRL_SRST);
 		hi8435_writeb(priv, HI8435_CTRL_REG, 0);
-	} else {
-		udelay(5);
-		gpiod_set_value(reset_gpio, 1);
 	}
 
 	spi_set_drvdata(spi, idev);
