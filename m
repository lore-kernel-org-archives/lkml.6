Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x224Q2UmDR4n6BLREi5wOM8vEobJWp8i9os8DsJ3K2NtUCZZjeO05er8M2sDJ3B+KUyFZGY1f
ARC-Seal: i=1; a=rsa-sha256; t=1519773675; cv=none;
        d=google.com; s=arc-20160816;
        b=dmkM9sOfNcn9qsoWvJMJ3NQTz5cM8NWxpRGVkdJ/9heEdruJJoJWxWXmGULaQ7i3mu
         rfk1bYczIz2W68If48nQsn8fqXmZfgdu72zfwl72zO3+khvO9DbSMe5l7ZiBMtCDp3oC
         xGKcwjz3uIQ5KDfVvHV6NM3YY9rzYLesl8abXUEGy0AQWVwMHf1FoFQJIdZAyZzIYp3w
         QfSckKf3sQBdjvDluLIJ3eVJp5TbcJmv1zQQSfW8j8bt9D/BiTZavnY+j7mcGSPtmBoX
         MlXdhmd9y7r5lg4fCRmDgw5o5TdWMYRjdsYC8P69+2mJNKwIv8fv8QmBFM4leedpfk2Y
         yqUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=w1hoISkQjakyllEvRUeJbpJ61C+mgnKboUac8aTCEzM=;
        b=CUHWHbd8emFZ1qdkLWopza1s7vHzCBX87APhRQuSPv5v+skD3VEHib1JoYrfPyDaRt
         tK3YCCO83EYPjE2xXUoGF3WP2evNrEokjn0PZ5snJU1M7qtp8VduCEhc1fvVCldNUJ2v
         y6a7SOwX6IYrfs5k36tzOxnZvO2EcawSAsCH2sZrquLal+1WdhyFXjY+BYXcwJFuPXJm
         pzEjGCslcJ0HTA9HauKcu3Cb842E1OIHONknnyihCii/eo8Gb6yBguQyhN4Xk7a/WUo+
         Ak1L09tTuw2sSKg9RlHI3+04KUb7W37WAA8SzhYWrTHta6QY6PYf0vvK2AbsxFYcLVee
         KZWg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D891D217BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: cantabile.desu@gmail.com
Cc: kubakici@wp.pl,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
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
	stephen.boyd@linaro.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [RFT 7/7] mt7601u: use request_firmware_cache() to address cache on reboot
Date: Tue, 27 Feb 2018 15:21:01 -0800
Message-Id: <20180227232101.20786-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180227232101.20786-1-mcgrof@kernel.org>
References: <20180227232101.20786-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593598201046679435?=
X-GMAIL-MSGID: =?utf-8?q?1593598201046679435?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

request_firmware_cache() will ensure the firmware is available on resume
from suspend if on reboot the device retains the firmware.

This optimization is in place given otherwise on reboot we have to
reload the firmware, the opmization saves us about max 1s, minimum 10ms.

Reported-by: Cantabile <cantabile.desu@gmail.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/net/wireless/mediatek/mt7601u/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt7601u/mcu.c b/drivers/net/wireless/mediatek/mt7601u/mcu.c
index 65a8004418ea..b90456a4b4d7 100644
--- a/drivers/net/wireless/mediatek/mt7601u/mcu.c
+++ b/drivers/net/wireless/mediatek/mt7601u/mcu.c
@@ -421,7 +421,7 @@ static int mt7601u_load_firmware(struct mt7601u_dev *dev)
 					 MT_USB_DMA_CFG_TX_BULK_EN));
 
 	if (firmware_running(dev))
-		return 0;
+		return request_firmware_cache(dev->dev, MT7601U_FIRMWARE);
 
 	ret = request_firmware(&fw, MT7601U_FIRMWARE, dev->dev);
 	if (ret)
-- 
2.16.2
