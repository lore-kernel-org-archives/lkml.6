Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521451052; cv=none;
        d=google.com; s=arc-20160816;
        b=Fc7OquUrLiqJriiyn8mFWn8MTAAwGJ8D7Wn3vA/7gykX08IoIX9njj760FVojsZEwe
         P6NbbkU3/qW02AOsD7A7G3Y8EYcFkn3uk9U6rsSBvS06zbTrxPGqTqWMPIf/yE6OztaA
         QQ6lX7TDIviK42Gy9vbrUo95zumI8DPaDSGLrXH2D3qZ2vH+BSrhX/QKWfaIMlFggQqv
         grUotSxkF3jwVHty6mI3iTreMnmZeTXr8HvHWg7iy8YyWAPk49KDpInvD8PG2cWm9s3E
         UirHugTkkT8GrjoUh+vSxT9iwOmrZlh0QygFNOXgJa9/0cS2foeJNVQIvXcDVWlvgPjv
         wayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=xc5v/DKfrEPeCKkcFcZKhc/8WmOk6XS2lRMMNbCK2kE=;
        b=T9RVe+aMxaajcNYfS/O0q9sm8exyC3afoe4S0O6i2eu9LCxpXU4AsHY5dO7yIXUdZ8
         cBS2UVpjxBKAR8PbByXPUOqSF+VVSSOl6VNvZZRIIf7CQpYXQuVoYEgG4YCXBrk8ZN4a
         NL/YCU6Kf6T1vxX1QHD+EtVJ/yQwR5NgdXackiGpBJX9MSF332Ap9G11YryvsMCv5X+3
         egbHwTayFszLGLmL+PX1r/Y3jIZQ/zdDvn11t6dV8zfbpMzNq4leuiozSeOf+AfzpsGE
         EWn4eMYGyAvZ70olFkMF6edPbHUQFmUMkrXN/V4YWuMFS9yZoA77uoQnVIBwnFqfutKJ
         RkgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=aWHK40bD;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=aWHK40bD;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELuFenlnAUcskWPkHAf2vxw/Rpd/g9aoajUACnHOxe5P0E2NPI1dsSDhpAel09225Ph4dfXxOw==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 06/21] eeprom: at24: drop redundant variable in at24_read()
Date: Mon, 19 Mar 2018 10:17:06 +0100
Message-Id: <20180319091721.18193-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357058637703701?=
X-GMAIL-MSGID: =?utf-8?q?1595357058637703701?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We can reuse ret instead of defining a loop-local status variable.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/misc/eeprom/at24.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index d1ad73d94fa8..ff7eb8e382c2 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -392,17 +392,15 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 	mutex_lock(&at24->lock);
 
 	while (count) {
-		int	status;
-
-		status = at24_regmap_read(at24, buf, off, count);
-		if (status < 0) {
+		ret = at24_regmap_read(at24, buf, off, count);
+		if (ret < 0) {
 			mutex_unlock(&at24->lock);
 			pm_runtime_put(dev);
-			return status;
+			return ret;
 		}
-		buf += status;
-		off += status;
-		count -= status;
+		buf += ret;
+		off += ret;
+		count -= ret;
 	}
 
 	mutex_unlock(&at24->lock);
-- 
2.16.1
