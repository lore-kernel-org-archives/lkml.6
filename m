Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521451055; cv=none;
        d=google.com; s=arc-20160816;
        b=dSxRFs8YapfnkOX/Mp2gCDlwKI79FxN3ezv9D39Rp2SI+viBHH5Hwaw+L4Gpmxhiza
         AzXTgrwqsotzxNkisywWFg3glm87QQA8aSpfaVdtzz91Y7SnfgarYg51jqfQeXL8C0R0
         EjzSCZaIAs8HU5M4NXWOG3LHiArNJ5+C6I2cTK/noCm5gNZnG3R9kTPshM9c14NWOysy
         zGxuxOUM7Qnil8SLreJztIE2pv0qtd+itf9ykyPDMrFbjcr1sCPik48c+wUDmZnjHEF/
         6PWZkXYvdL+XfwEhzDwwY1fF/zbnV/wqBznco0tQZVco59/6oIH2HAY4jauSQhrY6qQl
         lxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=UtFnWg7V6FmZa4JSUArH8c801Vcn7nSKOVRaaRoEpPw=;
        b=qlBLX1Dr5uPGrjxkTXalBZituijqKnnBmvK/8Uhv43FGuEdHxTJkFzdEcp0aeinFRU
         nxOmd8/GqEzj1IyeSRbFJq263fvx/sHrzuWxa3Q2CBNrxm77wE7nT4tjudE0tiYcQV6h
         sUg1oMvay1pXhPLngCHvNd8ulm30v+RoC0/WTbYIzYfw+E9/3OmgfudV49dBDpkR2axo
         EEmBllLtrNKk04M99QqzaR+G/KMyS7/73B27ZEFpoxXrVqY3ChetnPirNlWQZqyDeJyC
         Htc3o9Z1KLNPTvHMU+fK+IiueEiJLvdrr4iN+/IyKTumORa2kG8Th8LOojtnVVEM5wYu
         VEyw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=zxBq/p6L;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=zxBq/p6L;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELs+rcgXmxHLAhXkT6RWsC7G7wdEiz8c08urdCEIjsxclr0jKrzNZU0r1yJn1NrVyRqMuaSqkw==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 09/21] eeprom: at24: don't check if byte_len is a power of 2
Date: Mon, 19 Mar 2018 10:17:09 +0100
Message-Id: <20180319091721.18193-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357061251717279?=
X-GMAIL-MSGID: =?utf-8?q?1595357061251717279?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We support certain models the size of which is not a power of 2. This
is not a reason to emit a warning.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/misc/eeprom/at24.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 83a9223e62fb..d386df6b6100 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -550,9 +550,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		at24_get_pdata(&client->dev, &chip);
 	}
 
-	if (!is_power_of_2(chip.byte_len))
-		dev_warn(&client->dev,
-			"byte_len looks suspicious (no power of 2)!\n");
 	if (!chip.page_size) {
 		dev_err(&client->dev, "page_size must not be 0!\n");
 		return -EINVAL;
-- 
2.16.1
