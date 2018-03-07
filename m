Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AG47ELuecIekMNZO6YSgkqPl09qVOMYSWTgDlZT4iGwOGibveWdUA5q/miUS+b0aAWHfJDqjm6hC
ARC-Seal: i=1; a=rsa-sha256; t=1520432115; cv=none;
        d=google.com; s=arc-20160816;
        b=OW+aHphNYpH298hoYuoPyih88bjs71q82rSqqHJCpmlXEoMGC2lmnxfT1yXyp5fsTK
         72YEWTzwjBcQVP7Y70yhMFg8CvC1G+c9QlkGcdDqZLDFa5SpYBMYXya0bDBMIMWpVwWx
         esHMGiA6S4begqv/st0p17RyQqhrxwDuGtl+7q78yAUeOPA9AO0+v0yBmTTn+jLvJy11
         YkgVhH6q0CSM9VapafSbKQqFYgmcVV41dPxOpPacaYz4yyVAh5g6uRN7gnZGfdyrH5uY
         dkgHRhYoZjmqCWru++ry2pooXsv51DZqcR891EP/QG3mH9Eb2LFqjzYcdIJfK1J5M+OE
         9U7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=65us4ob7yw2fpkW54kwiEVHuPVT0Ob7Noefm16V1UiQ=;
        b=JB14xqJY499xPwAAV7azV5qlMua5yDV7a6zqXqeYGDOfwugPN6yQ3ak1Hqmvt9N6zy
         dQOO7qggOYEdUBHMlf/0bEg406pwsvS0mhH0KBfw3k4NgKt6m0cYO5YDQEhwsAmFMhs8
         QTwqYmd/ppQFMJGau2EFHP/aTF6m3g18hU22XB4uWU5PuDBYbNZnZ6hkWUCgTXMI4/Hn
         iCMopCyhl07nnHPFlJrO6358ue5tfoOsqbm/2T3Byx0jrxYg0wYrOY8l4Tor99uplERW
         he3aJIngCl7ymbYsRaRkUEp2Vuok8G9oc7MphrchotU0ID4sVu693lCkppU42ETmuQc5
         mn+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=akyTGb+P;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=akyTGb+P;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
From: Mark Brown <broonie@kernel.org>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regmap: debugfs: Free map->debugfs_name when debugfs_create_dir() failed" to the regmap tree
In-Reply-To: <20180306110403.14438-3-jeffy.chen@rock-chips.com>
Message-Id: <E1etZqb-0001Z6-4n@debutante>
Date: Wed, 07 Mar 2018 14:15:13 +0000
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594288625334682792?=
X-GMAIL-MSGID: =?utf-8?q?1594288625334682792?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   regmap: debugfs: Free map->debugfs_name when debugfs_create_dir() failed

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 17cf46cfe975f1dd04db6bd38398923846512d49 Mon Sep 17 00:00:00 2001
From: Jeffy Chen <jeffy.chen@rock-chips.com>
Date: Tue, 6 Mar 2018 19:04:03 +0800
Subject: [PATCH] regmap: debugfs: Free map->debugfs_name when
 debugfs_create_dir() failed

Free map->debugfs_name when debugfs_create_dir() failed to avoid memory
leak.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index dd3a16894e3c..c84f5ceb015a 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -584,6 +584,9 @@ void regmap_debugfs_init(struct regmap *map, const char *name)
 	map->debugfs = debugfs_create_dir(name, regmap_debugfs_root);
 	if (!map->debugfs) {
 		dev_warn(map->dev, "Failed to create debugfs directory\n");
+
+		kfree(map->debugfs_name);
+		map->debugfs_name = NULL;
 		return;
 	}
 
-- 
2.16.2
