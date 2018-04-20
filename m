Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1524242377; cv=none;
        d=google.com; s=arc-20160816;
        b=YcjAcf0b+RbkPQ7z+yAXyA1x7QltvFw+Co+c/Z8V6vOWwkHt5AATWmhenHgGfbD9f8
         xs4apzTuyHi4AGneWdCDn94XFfDKTILoziFEDYLKitkohfmbhhbMa3ZoMfp5tSmSTQBS
         96G8CX4W9b71MHVNQtFy0L9b9Oz9kpQv3L9QdUlS4snuH1VMzAZ1uqMixV9gDn0BcVlQ
         9sEFzBz44nAxt7UmFSnYYphBz7aMW3iu2wRJoccsms3+y7DcNWsAHUeRftfvQXuZ/Cqp
         fbaEC9ErMMroKbz3YvCh/dhlEpvpr3FAkbEaxikmAd8oVRJav45kw0CxL/AM28MDXNYA
         VK0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=/FbSSdYp1gjWKOV01HFqwiZmte1+zluuFolP/TPBZlo=;
        b=vv5Vb9TZUJ27zc+NyZO4L38QN468aMaxY2WgLk50hRU28KmN3OxKDknOxmabXO22yD
         un/ovXFNgwIeX5o75cvi1EdgprXPHcFyQYqyfVEYKjysdC4lc6WLNIt73WLzWCRSXhO7
         7TWRYMTma5QjJEUM5zvEHGTNjrc7Dc5/5MaDs/OBqXjIovGuEUwvE2vL3AJU3RtWb2JM
         UwVvJxJbzkdRqRZ/IIOUR/Cjtor35W0TfndyHqf+70Rm+G5J5BYuH1Ly7jiGPww0r3z0
         m7KRgWz3hYSDNqdeNQmJAToOL5qJR9B58nl4+/8gz5GuI6cEtgM7hM/0t87nf0r2hSE5
         707g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=pnE6dH23;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=pnE6dH23;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AIpwx4/xIAQPHokMiP0zxy5W3cG5rAA1jsj7nm6DefiTBcmaspcbyd3HY+g1hRMJiINiWznwGt/raQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/2] platform: provide early_platform_add_device()
Date: Fri, 20 Apr 2018 18:39:23 +0200
Message-Id: <20180420163924.5227-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180420163924.5227-1-brgl@bgdev.pl>
References: <20180420163924.5227-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598283974785300729?=
X-GMAIL-MSGID: =?utf-8?q?1598283974785300729?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently we only have early_platform_add_devices() which takes struct
platform_device ** as argument, requiring the users to have an
intermediate array of platform_device pointers even if we're only
adding a single device. Provide a helper for adding a single device at
a time.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/platform_device.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 49f634d96118..80942ed0f728 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -301,6 +301,11 @@ extern int early_platform_driver_register(struct early_platform_driver *epdrv,
 					  char *buf);
 extern void early_platform_add_devices(struct platform_device **devs, int num);
 
+static inline void early_platform_add_device(struct platform_device *pdev)
+{
+	early_platform_add_devices(&pdev, 1);
+}
+
 static inline int is_early_platform_device(struct platform_device *pdev)
 {
 	return !pdev->dev.driver;
-- 
2.17.0
