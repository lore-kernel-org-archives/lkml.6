Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1524242378; cv=none;
        d=google.com; s=arc-20160816;
        b=S4BIr2Ro9qrHokF7rpA1ygHSq3Jzg+KTG/7miY7T4yXwWS5Y8Q2ldaChi8Mz8sI5m0
         MjYdMukPByk7/nFrIaS6BqU/RXIFxKphl895CZqaeQbai8/Y/Fgfz9DDbMUR4V5xicyN
         hmpAWSIdlRtPbJL3XtYyHrL/B5RRN/wN0Jap9FlXGRsUQ7gfbB7B4KwFMvu8eKz/4f7Z
         TJrrifaaoPH/fCKRw34jAe/kyUEwH8Nch+/LiDNay7QB7+2hjLy7Jzchl4XSbO/1LAZf
         FrpuFt/MzNWHvxhOFW+HhIh6LRvHlMWk3HDXRj7zhliZaeY2ejbMMq5Qw6+A4Bito4y6
         tzVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=KlF1iVgssa5vw9WYerKTfEzGG+RGfJzSWe5qVhtRmmk=;
        b=DMLHPtItJbPYukikTvB/VK3Y5xjaCYagCNwARMJ52PdGblPgFxF5fAjDHvWpGuAkNC
         YR6QhtiR20JNqgzwsoQ1/HBxvPwCsVJQQSsEXbhJ68Yoj85pdWdmVxsor4cMxGecKb3R
         64n3Drn6h/SCOzl+VBj5y9GzHdbbBS5OpHqV2B2ZuMorlACOGrG+sdoHyi99b9h5sXwG
         fnHELenmjGObBykBzTqXVxhhrC5vKYFCrcFjW8UiSg97uAErGH2Jr0+6x0C5lcun451c
         zH/GlB81T5UBmQDTjZUOIcsRzunEoeLIwRA0yj/xZRTe1qVHG6XRLh/3ivSkrrywL+vU
         f3/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=D+blKKRA;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=D+blKKRA;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AIpwx4/GcEzzH/bGIufWPcBvHd8rA5YOZsA9TQ3DZGpgRmjPqTPBt8YYKFgV9+cT3NKtC2Gzq64JfQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/2] platform: provide early_platform_driver_register_probe_all()
Date: Fri, 20 Apr 2018 18:39:24 +0200
Message-Id: <20180420163924.5227-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180420163924.5227-1-brgl@bgdev.pl>
References: <20180420163924.5227-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598283975809385348?=
X-GMAIL-MSGID: =?utf-8?q?1598283975809385348?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

All users of early_platform_driver_register_all() subsequently call
early_platform_driver_probe(). Provide a helper that calls both
functions.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/platform_device.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 80942ed0f728..a06b194ba30b 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -314,6 +314,15 @@ static inline int is_early_platform_device(struct platform_device *pdev)
 extern void early_platform_driver_register_all(char *class_str);
 extern int early_platform_driver_probe(char *class_str,
 				       int nr_probe, int user_only);
+
+static inline int early_platform_driver_register_probe_all(char *class_str,
+							   int nr_probe,
+							   int user_only)
+{
+	early_platform_driver_register_all(class_str);
+	return early_platform_driver_probe(class_str, nr_probe, user_only);
+}
+
 extern void early_platform_cleanup(void);
 
 #define early_platform_init(class_string, platdrv)		\
-- 
2.17.0
