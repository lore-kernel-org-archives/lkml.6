Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AH8x2278vr2UoPSyjOyF+V6DEo5kn2vEkLbE3dXKwjKPd6LGHolNPykNzF+OOD73hbqkZcHDbIXM
ARC-Seal: i=1; a=rsa-sha256; t=1519128607; cv=none;
        d=google.com; s=arc-20160816;
        b=n0huvcu/4M4rdA//YbqdYA48GgEuV6K1J/mI8ZfgowXVdS44fMsQx8FnL15UwM6bJo
         ILmnmlRHQQeb/K4rhOcPBGrNxZ72C6DPSre2+mTwRE30Mwa2Wss0HmO3b5vxQbNNE/ZT
         /NqBBE3SQCdzTP8ZsZQkodnBy8AB0gtP7xGW52FjvDxX0RnuRGfxRw7sUDG+cYj7ro1+
         B6ZRHrXl5GFw+gNFAjTa7HS7IgP/PXyXFwws/8BglqUqlitFG9281uqOk6iNPhmIeq1J
         ERb1I0I9Yoo4K/0P9rT3YxTpl96c3evU5bLJClhdFsNMOm3IAb5lOxKNjPD7QtOZ3BcQ
         3Y2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=cOZocLN/rLckiBu27jS3/OgIaGpp1BVfRLJGft+Ddv8=;
        b=eqPYi9Kasy+MCvG8WOcskjsGZ/53CSsnhwy00Rka9q4/UUzLk0I0LstwymU8e+jA7l
         V4dKuqGdLNfsQtx1ljt7wCjsh1IH07KsiMbVuGgptMLBsHMVEeEfQo1rCLAieTbw93iE
         0pbrnAuhPL24208kj/ruaElvgaX85o2pgzTTQys9w0Y1/jW9nJMeozgh27M4sXilc9L/
         IsF8LrjVwiKE6wmea/45+K4AlhNA/z4qQLHOqY1YuHFLQC4ZqKmSx0bItpKSjH7D6FGY
         aS2IAW4TAYK32WKbmqTiPvIfudxdz+ZChJ5y74ixv1ZZawqHZNMbOhzq8I6VPn/lcwGr
         1tPg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=W912aPvR;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=W912aPvR;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
From: Mark Brown <broonie@kernel.org>
To: David Lechner <david@lechnology.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Subject: Applied "regmap: use debugfs even when no device" to the regmap tree
In-Reply-To: <1516748023-17235-3-git-send-email-david@lechnology.com>
Message-Id: <E1eo6kG-0003DD-C7@debutante>
Date: Tue, 20 Feb 2018 12:10:04 +0000
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592921798638352603?=
X-GMAIL-MSGID: =?utf-8?q?1592921798638352603?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   regmap: use debugfs even when no device

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

>From 9b947a13e7f6017f18470f665992dbae267852b3 Mon Sep 17 00:00:00 2001
From: David Lechner <david@lechnology.com>
Date: Mon, 19 Feb 2018 15:43:02 -0600
Subject: [PATCH] regmap: use debugfs even when no device

This registers regmaps with debugfs even when they do not have an
associated device. For example, this is common for syscon regmaps.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index ee302ccdfbc8..f5fa1ddc65e9 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1116,6 +1116,8 @@ struct regmap *__regmap_init(struct device *dev,
 		ret = regmap_attach_dev(dev, map, config);
 		if (ret != 0)
 			goto err_regcache;
+	} else {
+		regmap_debugfs_init(map, config->name);
 	}
 
 	return map;
-- 
2.16.1
