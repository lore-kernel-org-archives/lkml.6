Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AH8x2268EkqEXbRZGTaOPzWndKZQMDI+vXKesgt0x6ZpGN/k3DJl5pbsW7TztYy3PF9og9HGyy1P
ARC-Seal: i=1; a=rsa-sha256; t=1519128609; cv=none;
        d=google.com; s=arc-20160816;
        b=zM86ciO3HiXMKqxtuRIFJTZUTcrOdNCJQpXoRxuwAu7c6yTb46GkhxiYWcJumfIWNi
         cZWUDy64w/O8Q3//Ho9Dj5qoGVB+qvvZDA0+0p2GUAGkRKDJuY6rA2nagaYkzRdn5Xa/
         7d5TcEBN7pPodz7U/09JazwV9XNl4/II1nDQ9mlOgzr4yxX7z+fgmAN545c9AovwBpYC
         k75FbepocB6XLvn4NtHS32GEjn/xHrhYrZc/s7PqgkN5Slw1OpJXPnPzbLrlIVrB65zI
         TVfGAwIgK4kFw7LVo21wwPIELyyg1CoU7OsOMVtVrrufiJFLG19Ky5OvXZ7JiRBQ++dL
         HCKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=jAxc7KU8us48gb9aLunpzQsI/R1WSU6/vVLo28AZXsk=;
        b=0tNIZofBUEa2uU0OnGT3f/Cscb7O8lwchnq1MJj5tDLDkaQLRpjTeH8c9C4kepLpTM
         YMmCopUWMNMhyg3yz/PICAOYzN/NjK3bS82d+Dftc284NNRKXSUG7bOAKleYKne++GEG
         XoZ2k9Bz3UtSC32Gs2fr220Y59VTX/0Ff3JmJSrE8cU8r0kRKp5X+J01g0PQEAuRoHyT
         ILnPsi91S4Y6KT1AdmVk9/qp6kWdBBF1+DU8iFqbGsc9SYMrUfslsfQ/Vks6YUGQQuJu
         gvLairuwg9km2daM/UeZJxHbgCoMplocRWCQwiTkv2OR9Prvrx2Mu21sySdzdcqNdT6E
         TFLg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=ddaVXqmV;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=ddaVXqmV;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
From: Mark Brown <broonie@kernel.org>
To: David Lechner <david@lechnology.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Subject: Applied "regmap: Allow missing device in regmap_name_read_file()" to the regmap tree
In-Reply-To: <1519076582-7687-2-git-send-email-david@lechnology.com>
Message-Id: <E1eo6kJ-0003E2-GT@debutante>
Date: Tue, 20 Feb 2018 12:10:07 +0000
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592921801411794840?=
X-GMAIL-MSGID: =?utf-8?q?1592921801411794840?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   regmap: Allow missing device in regmap_name_read_file()

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

>From 12ae3808c160b7be0de3c633ac4cbe8c5f2937bf Mon Sep 17 00:00:00 2001
From: David Lechner <david@lechnology.com>
Date: Mon, 19 Feb 2018 15:43:01 -0600
Subject: [PATCH] regmap: Allow missing device in regmap_name_read_file()

This fixes a possible NULL pointer dereference oops in
regmap_name_read_file() when the regmap does not have a device
associated with it. For example syscon regmaps retrieved with
syscon_regmap_lookup_by_compatible() don't have a device.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-debugfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index f3266334063e..7eb512ba2828 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -40,6 +40,7 @@ static ssize_t regmap_name_read_file(struct file *file,
 				     loff_t *ppos)
 {
 	struct regmap *map = file->private_data;
+	const char *name = "nodev";
 	int ret;
 	char *buf;
 
@@ -47,7 +48,10 @@ static ssize_t regmap_name_read_file(struct file *file,
 	if (!buf)
 		return -ENOMEM;
 
-	ret = snprintf(buf, PAGE_SIZE, "%s\n", map->dev->driver->name);
+	if (map->dev && map->dev->driver)
+		name = map->dev->driver->name;
+
+	ret = snprintf(buf, PAGE_SIZE, "%s\n", name);
 	if (ret < 0) {
 		kfree(buf);
 		return ret;
-- 
2.16.1
