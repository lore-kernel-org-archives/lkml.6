Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521451059; cv=none;
        d=google.com; s=arc-20160816;
        b=J750wQ9NNrajRofuMdpnuGOU33Q05MbQGas0mddVuPUoa7QcVQMhub9jLwyOMkw9mh
         GfFgIR8ldgbErMd8I3g2f2AajH/mdEKnZ5LIGOiQ/3ZQQAm/TvQG4t99oOlDvjANL8ED
         CCK2viYpRMATd0G0HQbjMJi+hUjW65MHoeSLQLhrfKWXd+u9dKOXw+MvB11OCg7Ij3t9
         xADTNlliSE3HGblJ/8NOBPcJ6VC85U+cGNbRIzfSzDO86VkFU1e8uVP9eHBHHNEivk6p
         rzromzlhSYss6T0r73voUGV0Db4ObaWcRIvj4ZondQiBOuvWLSQDH1jENmT9krATDfte
         bhBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=+SNIJCGs2/Yfg2YzHX+d8pZbYWGxQS0Sk7s1LLfgYsQ=;
        b=CBkkkPPJ9y4QMb64YD5AUsITrstUggWhXzql5UG0KiLcwr3OCtvsWRHGybMx8a9zgm
         4b88g5Pf9byNxwahVTriex6nPAuiJ+AFVF/2e8UL6DgjWDzYSDmyE7Sh1ia9lS+zya+H
         LJdQ/Wd+4a1KPcql0d2yCaZFsPV2KCg5XqSteCIsFm0KnhWxywXzopWCtVcLw7ACTchb
         cLCwbW7r9MEAn1lu0pQad/8qSsCNQlMDZ5I7xSmBAugjSujo0LNu1BPLb0J4gtJZybUt
         CCLzxJri7M8NC28BI6BRA/ch6fNvv86JCAlgELi6E9W722HjwQNVedFEc1t4xFgKc1Sx
         f/ug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=XD1U84T+;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=XD1U84T+;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELt0QuRIY5a4RZ+xwoxiFULzc8fMTxzoySR8HM2D0qx0TlaGvulE85+/tTFWEOBto3BjYYzr4w==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 13/21] eeprom: at24: readability tweak in at24_probe()
Date: Mon, 19 Mar 2018 10:17:13 +0100
Message-Id: <20180319091721.18193-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357066108530488?=
X-GMAIL-MSGID: =?utf-8?q?1595357066108530488?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use a helper variable for the size we want to allocate with
devm_kzalloc() and save an ugly line break.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/misc/eeprom/at24.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index e4c1997c2b56..ea5e81cb8e8c 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -520,6 +520,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	struct device *dev = &client->dev;
 	unsigned int i, num_addresses;
 	struct at24_data *at24;
+	size_t at24_size;
 	bool writable;
 	u8 test_byte;
 	int err;
@@ -573,8 +574,8 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	regmap_config.reg_bits = (pdata.flags & AT24_FLAG_ADDR16) ? 16 : 8;
 	regmap_config.disable_locking = true;
 
-	at24 = devm_kzalloc(dev, sizeof(struct at24_data) + num_addresses *
-			    sizeof(struct at24_client), GFP_KERNEL);
+	at24_size = sizeof(*at24) + num_addresses * sizeof(struct at24_client);
+	at24 = devm_kzalloc(dev, at24_size, GFP_KERNEL);
 	if (!at24)
 		return -ENOMEM;
 
-- 
2.16.1
