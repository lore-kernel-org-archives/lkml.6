Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AH8x226syDgc9dbPs8rDY55D6PWzQHqbO3i2YIWtdDUvCY4EmGexu5LbJ81Q74RuCWOIS/3NmbW7
ARC-Seal: i=1; a=rsa-sha256; t=1518104509; cv=none;
        d=google.com; s=arc-20160816;
        b=Y7uSI9/Q58VJnHiFvD5/6XMh6dElH5b9hGSUMsevrMpUt/1fx5lWJ0KmG6sr8BfqH8
         gl8VO8rNu0sB9Kb1sSMwGRLdG0PY5hMdtDrNG4kEtyF4nb2wHi4nA1RQ5yPCQW/Lq/le
         nxRRCCw86kZHaK3AByvbTlQTWHKqa6pGGDaIJIFBzp893+P47lW47HrpnKiWxB+w2X2r
         UK0nSoyv3x5Xyrtktyhy0BhWLdou4/N8q/Lcu+V/serVmjV5hoBfwYDB84+MCDX8MhQn
         fSU0oOFVR9M+C+jPkZ4BGNCAnTxH5asXhfBgbpgQkD5XafniUzMTNPggM1JSH1MMqs77
         gEEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=9nSj5Yz+7o6NxRL0oimm6ivY6aABmJijw4kqUbuvByQ=;
        b=hW6nVLlCL9U87TZQOG8V4co0XfLl0Yi2wFg1qzlOHDbo4b2iSpLJKp2VTmmkYpDyB8
         JuAD/ly9RWIH4Pcm4EC0Px43LOACGm+52Z0LVi9JDwzJZvoAGAnTFQRDWOQwMYpyfnQF
         oCOTYWmbhmmDmxi4f+2Zn7T3/8stT+yOrihMu6ZJnFnLmPZu2M7BCOzTAeGagR++f+ZS
         fmQkoP3vcvJgcZLw5rmM/uir66lrJm2grnxfM0iUgVKZ71MDpV4qzHUlnhMPsBmx6e9C
         EofLv70hc0Ci2+8SqSwgM/WX0FwN0jzzs6msO3Zw+0V7jB+1DrJEDo+12y/SLimZ3m8u
         zlYA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=anBOl8QI;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=anBOl8QI;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
From: Mark Brown <broonie@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>, Markus Pargmann <mpa@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regmap-i2c: Off by one in regmap_i2c_smbus_i2c_read/write()" to the regmap tree
In-Reply-To: <20180208072528.GB18158@mwanda>
Message-Id: <E1ejoKX-0008Uq-88@debutante>
Date: Thu, 08 Feb 2018 15:41:45 +0000
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591847953762061807?=
X-GMAIL-MSGID: =?utf-8?q?1591847953762061807?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   regmap-i2c: Off by one in regmap_i2c_smbus_i2c_read/write()

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

>From 86effbe0d198aaf57459ec9ad3855e88e29ecb1c Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 8 Feb 2018 10:25:28 +0300
Subject: [PATCH] regmap-i2c: Off by one in regmap_i2c_smbus_i2c_read/write()

The commit message says that we are allowed to read and write up to 32
bytes but the code only allows us to write 31 bytes.  In other words,
the ">=" should be changed to ">".  But this is already checked in
regmap_raw_read()/write() so we can just remove the if statemetents.

Fixes: 29332534e2b6 ("regmap-i2c: Add smbus i2c block support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-i2c.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index 4735318f4268..056acde5e7d3 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -217,8 +217,6 @@ static int regmap_i2c_smbus_i2c_write(void *context, const void *data,
 
 	if (count < 1)
 		return -EINVAL;
-	if (count >= I2C_SMBUS_BLOCK_MAX)
-		return -E2BIG;
 
 	--count;
 	return i2c_smbus_write_i2c_block_data(i2c, ((u8 *)data)[0], count,
@@ -235,8 +233,6 @@ static int regmap_i2c_smbus_i2c_read(void *context, const void *reg,
 
 	if (reg_size != 1 || val_size < 1)
 		return -EINVAL;
-	if (val_size >= I2C_SMBUS_BLOCK_MAX)
-		return -E2BIG;
 
 	ret = i2c_smbus_read_i2c_block_data(i2c, ((u8 *)reg)[0], val_size, val);
 	if (ret == val_size)
-- 
2.15.1
