Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521451047; cv=none;
        d=google.com; s=arc-20160816;
        b=k5m1C5MSJApbaaDZFqxDcXcC9ITKMU17xiG2yEcGQwkZUSjox64zjSJ/o/T9eCnGnu
         A+g1u0EpqRbtonniXKLYsRHLubVTyD8g8IVvgVutx44qtZt4BBsc0GqG4LHFJjdz+nIw
         kWvfJRXdwiHqOLT9xdcIpEOxkuz1MaV2kFcy5NDKtZEQY0agnT9XyMbp7br3F/zBOPEm
         DBf5x2dki3nxirsb7PNE3rYEeP3qaQ4ScOWN8OFAVVmWH+MnTDqB8bhwKjTYIC/TWce0
         S5387jwBYRj5hrc2sG8fFr+KB37ycu+FMDDOHxlOIvnIAqjV9nI0cr98z7vwD/ng6sVm
         iVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=LgfDVC8cZTE95HDPmAwDOVPFF1GRJuTT/gFr8dHfVww=;
        b=vDLoen6KxiiKcFmSv9sVEYRgpp+4VlSQjnUR4UD6jD9KsYPYRETpQDh0s88Kl6HUch
         O1pz+yr4L1kI1u3Xu89rsglqc5aWAUi2KUW9C9TSnoCj+2ID29Aj9ZO7+Y0ar30jWQYK
         JIlgRiP3VsfFemtyvZ+O4CVJCeD9+Q+bESi3xz2mZ9/vyyZsnUgJd6sd+34pLijv1RWq
         u4Da9sEDQk/sO/5PrOE+lbEIoIOzB1CtzzWSyvfNVoGkWKNUo24P52IcnVXeZMBN/XCz
         SSvy6RIr3LQULBDbkIREbRJepR6ns8ywhQ2Tz0CQJyucAg2oFsurGFgvGd9ElYKn/Z+j
         yL8g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=oTQFko+P;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=oTQFko+P;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELt/CHKdMmm9uJ82lwzxvGUoXms1LNi9aUFE7D1TnlhMlgKKl/DrkDq73sB6uIgIBcH77YY/ug==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 01/21] eeprom: at24: disable regmap locking
Date: Mon, 19 Mar 2018 10:17:01 +0100
Message-Id: <20180319091721.18193-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357052984374653?=
X-GMAIL-MSGID: =?utf-8?q?1595357052984374653?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We use our own mutex for locking. Disable the regmap-specific locking.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/misc/eeprom/at24.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 01f9c4921c50..73af6c5a2d73 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -577,6 +577,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	regmap_config.val_bits = 8;
 	regmap_config.reg_bits = (chip.flags & AT24_FLAG_ADDR16) ? 16 : 8;
+	regmap_config.disable_locking = true;
 
 	at24 = devm_kzalloc(&client->dev, sizeof(struct at24_data) +
 		num_addresses * sizeof(struct at24_client), GFP_KERNEL);
-- 
2.16.1
