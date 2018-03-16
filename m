Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvWaaeWt43xlZQfAUkw0xNeVcwEhXtv9MbIZQ31Az2VoKA3xdaM8UV53FfPPfHofObV3ZVZ
ARC-Seal: i=1; a=rsa-sha256; t=1521214597; cv=none;
        d=google.com; s=arc-20160816;
        b=s49B/XBZeI/zH+5Sny7hKQyMONJvbvhFDSnTwZmuIFEwmEZe0ozoU0L0QNdJVBrF8b
         Nli0e6PZ9zvkhphuZmqanJuf/Br/oyD8138TLFjr1AoccOkMCX5+YIEMHrqLOHg4IaRp
         WGUcXQUrhJee/PS6/B2hDca4Cgg3z0CNvj6AvwtWYtUUbj/gnqNaviIjEqcLdQQ8WVpG
         W9EcXDTe+IoWOmWY9wUCGhX2NSl7cbVTp36brtAVHePS6g+JxEdKtmNJQLG/zTCJ7K7U
         uCOPTdweWDocASbQm3cjraKxtuXniOQHol9lMH4qXKVKOG3E2Z049bfxfk9eR/NhxoyN
         sEgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KY4YCBdnUdw8w1WdnpKFEePWqd68s8IDZX+llExnfbM=;
        b=WLYhzVFTj+bu65QKJWoHd3VZ7Fr+d8DXDUYUUBRBxC4GazNpRlMaNMwn3t3O0fPpf0
         L+QQ8OxC3Fu9/pD5SjSu7xnsK1VItWpUcJD5E2FtULMD3ACGTQc0sWcCFZP6kTQCSB8Z
         w/ZUFMbtZZYL6jX9rpM/VPwFh+jXSr2dckvzz/OVg7c2FbYNkZRvWm2Jj3AAt8pP/PDL
         wxKBFiksBRD62GM2nTuMDaDGVraEYfph5KpbsmvGDfz7v57/1n7e/JPjAAwrlh9yuaHl
         NIUg/pgI8hPDoQwq6YjspTDUzHVnIs+LmpnMYaEvar8/aAtFeubLhACch8pzT2AVxD4R
         V/8w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <matt.ranostay@konsulko.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 061/109] iio: health: max30102: Add power enable parameter to get_temp function
Date: Fri, 16 Mar 2018 16:23:30 +0100
Message-Id: <20180316152333.272341014@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109117575127443?=
X-GMAIL-MSGID: =?utf-8?q?1595109117575127443?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>


[ Upstream commit a9c47abbdd71dceeaf1b923e5ce10e700e036905 ]

Chip must not be in shutdown for reading temperature, so briefly leave
shutdown if buffer is not already running

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/health/max30102.c |   36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -329,20 +329,31 @@ static int max30102_read_temp(struct max
 	return 0;
 }
 
-static int max30102_get_temp(struct max30102_data *data, int *val)
+static int max30102_get_temp(struct max30102_data *data, int *val, bool en)
 {
 	int ret;
 
+	if (en) {
+		ret = max30102_set_powermode(data, true);
+		if (ret)
+			return ret;
+	}
+
 	/* start acquisition */
 	ret = regmap_update_bits(data->regmap, MAX30102_REG_TEMP_CONFIG,
 				 MAX30102_REG_TEMP_CONFIG_TEMP_EN,
 				 MAX30102_REG_TEMP_CONFIG_TEMP_EN);
 	if (ret)
-		return ret;
+		goto out;
 
 	msleep(35);
+	ret = max30102_read_temp(data, val);
+
+out:
+	if (en)
+		max30102_set_powermode(data, false);
 
-	return max30102_read_temp(data, val);
+	return ret;
 }
 
 static int max30102_read_raw(struct iio_dev *indio_dev,
@@ -355,20 +366,19 @@ static int max30102_read_raw(struct iio_
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		/*
-		 * Temperature reading can only be acquired while engine
-		 * is running
+		 * Temperature reading can only be acquired when not in
+		 * shutdown; leave shutdown briefly when buffer not running
 		 */
 		mutex_lock(&indio_dev->mlock);
-
 		if (!iio_buffer_enabled(indio_dev))
-			ret = -EBUSY;
-		else {
-			ret = max30102_get_temp(data, val);
-			if (!ret)
-				ret = IIO_VAL_INT;
-		}
-
+			ret = max30102_get_temp(data, val, true);
+		else
+			ret = max30102_get_temp(data, val, false);
 		mutex_unlock(&indio_dev->mlock);
+		if (ret)
+			return ret;
+
+		ret = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 1000;  /* 62.5 */
