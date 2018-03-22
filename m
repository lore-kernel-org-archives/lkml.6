Return-Path: <k.marinushkin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521754627; cv=none;
        d=google.com; s=arc-20160816;
        b=DJ//ZazVfOrmHtIGCzy8tS1FkIEFY0FaNy1tmipVAuOjISzQWB7cqJs4ftFeuQdYzc
         s3gn3a51IcajyU/0kK6EmMH3ozAIpTIyoOJPSPhqRzzGNaForW7+tUR4gxHyA/Ao0nZX
         +IO4GqzgEX0OZM1nGWBf6GDg/lZQ4gFQNsZAJq8rx3LlD5MSx18MhyDIcAlIPJ/7loi7
         2hEnDoTV/7+qba8UwhapcDEblPPCyX94SShmMOnaOruOdslLMXc5dyA/Xdo+nlUJswef
         YxzESngvcqKRiK+/6tghHtse/Ekn4wJpUiNOoFWEuj8M+g6w/OLQO05uALzCN6/ekuVf
         x2Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=vyRUIJAYwwWc5IerZ7V1nr89MidRm7oG+F2drdSjPSw=;
        b=viWypAQZJx3f2pO5WgVQGp9h+UfidkJC0hvFRN5gyWBaaiYrXC+jTHIG05J3ihUY86
         NX7S25lTsZDeHr9m3DScpT5KKZOzkEd1ALJQY3kPk+IPKucUwF4wMhq+OfB8b5znM7Jo
         zFLr9+XO192F/dctFUWiPBGmFT3ay4OJNiLMPkW6zk3UejgJ3S1Hjg38weT47Nf2ZaNG
         wOQ+zpceYFa/v6h7Gx4Likhkwod5do3m7j/+NdfrxRFqzYINVZvFWmBesjkV1cD22/B4
         dvYmdcOsNyk1NZlM5XL1wI4frO3pWFK4vg14SKY+YRxWHo7jTPToofz7TKgrlOPkQXw1
         Soiw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CzH896Ao;
       spf=pass (google.com: domain of k.marinushkin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=k.marinushkin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CzH896Ao;
       spf=pass (google.com: domain of k.marinushkin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=k.marinushkin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtnT8fuDmEJ5sn+9fR9duKAYurGfvpBehLs8SKoH4TF9iZWHS3SgrJ6oX5zsAlDbxzGQvXF+Q==
From: Kirill Marinushkin <k.marinushkin@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eric Anholt <eric@anholt.net>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Michael Zoran <mzoran@crowfest.net>
Cc: Kirill Marinushkin <k.marinushkin@gmail.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: bcm2835-audio: Release resources on module_exit()
Date: Thu, 22 Mar 2018 22:37:22 +0100
Message-Id: <20180322213722.31822-1-k.marinushkin@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <f35d0f86-04b5-6edb-139f-4632edc493b3@gmail.com>
References: <f35d0f86-04b5-6edb-139f-4632edc493b3@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594075828670099193?=
X-GMAIL-MSGID: =?utf-8?q?1595675380142873932?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In the current implementation, `rmmod snd_bcm2835` does not release
resources properly. It causes an oops when trying to list sound devices.

This commit fixes it.

The details WRT allocation / free are described below.

Device structure WRT allocation:

pdev
  \childdev[]
    \card
      \chip
        \pcm
        \ctl

Allocation / register sequence:

* childdev: devm_kzalloc      - freed during driver detach
* childdev: device_initialize - freed during device_unregister
* pdev: devres_alloc          - freed during driver detach
* childdev: device_add        - removed during device_unregister
* pdev, childdev: devres_add  - freed during driver detach
* card: snd_card_new          - freed during snd_card_free
* chip: kzalloc               - freed during kfree
* card, chip: snd_device_new  - freed during snd_device_free
* chip: new_pcm               - TODO: free pcm
* chip: new_ctl               - TODO: free ctl
* card: snd_card_register     - unregistered during snd_card_free

Free / unregister sequence:

* card: snd_card_free
* card, chip: snd_device_free
* childdev: device_unregister
* chip: kfree

Steps to reproduce the issue before this commit:

~~~~
$ rmmod snd_bcm2835
$ aplay -L
[  138.648130] Unable to handle kernel paging request at virtual address 7f1343c0
[  138.660415] pgd = ad8f0000
[  138.665567] [7f1343c0] *pgd=3864c811, *pte=00000000, *ppte=00000000
[  138.674887] Internal error: Oops: 7 [#1] SMP ARM
[  138.683571] Modules linked in: sha256_generic cfg80211 rfkill snd_pcm snd_timer
 snd fixed uio_pdrv_genirq uio ip_tables x_tables ipv6 [last unloaded: snd_bcm2835
]
[  138.706594] CPU: 3 PID: 463 Comm: aplay Tainted: G        WC       4.15.0-rc1-v
7+ #6
[  138.719833] Hardware name: BCM2835
[  138.726016] task: b877ac00 task.stack: aebec000
[  138.733408] PC is at try_module_get+0x38/0x24c
[  138.740813] LR is at snd_ctl_open+0x58/0x194 [snd]
[  138.748485] pc : [<801c4d5c>]    lr : [<7f0e6b2c>]    psr: 20000013
[  138.757709] sp : aebedd60  ip : aebedd88  fp : aebedd84
[  138.765884] r10: 00000000  r9 : 00000004  r8 : 7f0ed440
[  138.774040] r7 : b7e469b0  r6 : 7f0e6b2c  r5 : afd91900  r4 : 7f1343c0
[  138.783571] r3 : aebec000  r2 : 00000001  r1 : b877ac00  r0 : 7f1343c0
[  138.793084] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  138.803300] Control: 10c5387d  Table: 2d8f006a  DAC: 00000055
[  138.812064] Process aplay (pid: 463, stack limit = 0xaebec210)
[  138.820868] Stack: (0xaebedd60 to 0xaebee000)
[  138.828207] dd60: 00000000 b848d000 afd91900 00000000 b7e469b0 7f0ed440 aebedda4 aebedd88
[  138.842371] dd80: 7f0e6b2c 801c4d30 afd91900 7f0ea4dc 00000000 b7e469b0 aebeddcc aebedda8
[  138.856611] dda0: 7f0e250c 7f0e6ae0 7f0e2464 b8478ec0 b7e469b0 afd91900 7f0ea388 00000000
[  138.870864] ddc0: aebeddf4 aebeddd0 802ce590 7f0e2470 8090ab64 afd91900 afd91900 b7e469b0
[  138.885301] dde0: afd91908 802ce4e4 aebede1c aebeddf8 802c57b4 802ce4f0 afd91900 aebedea8
[  138.900110] de00: b7fa4c00 00000000 00000000 00000004 aebede3c aebede20 802c6ba8 802c56b4
[  138.915260] de20: aebedea8 00000000 aebedf5c 00000000 aebedea4 aebede40 802d9a68 802c6b58
[  138.930661] de40: b874ddd0 00000000 00000000 00000001 00000041 00000000 afd91900 aebede70
[  138.946402] de60: 00000000 00000000 00000002 b7e469b0 b8a87610 b8d6ab80 801852f8 00080000
[  138.962314] de80: aebedf5c aebedea8 00000001 80108464 aebec000 00000000 aebedf4c aebedea8
[  138.978414] dea0: 802dacd4 802d970c b8a87610 b8d6ab80 a7982bc6 00000009 af363019 b9231480
[  138.994617] dec0: 00000000 b8c038a0 b7e469b0 00000101 00000002 00000238 00000000 00000000
[  139.010823] dee0: 00000000 aebedee8 00080000 0000000f aebedf3c aebedf00 802ed7e4 80843f94
[  139.027025] df00: 00000003 00080000 b9231490 b9231480 00000000 00080000 af363000 00000000
[  139.043229] df20: 00000005 00000002 ffffff9c 00000000 00080000 ffffff9c af363000 00000003
[  139.059430] df40: aebedf94 aebedf50 802c6f70 802dac70 aebec000 00000000 00000001 00000000
[  139.075629] df60: 00020000 00000004 00000100 00000001 7ebe577c 0002e038 00000000 00000005
[  139.091828] df80: 80108464 aebec000 aebedfa4 aebedf98 802c7060 802c6e6c 00000000 aebedfa8
[  139.108025] dfa0: 801082c0 802c7040 7ebe577c 0002e038 7ebe577c 00080000 00000b98 e81c8400
[  139.124222] dfc0: 7ebe577c 0002e038 00000000 00000005 7ebe57e4 00a20af8 7ebe57f0 76f87394
[  139.140419] dfe0: 00000000 7ebe55c4 76ec88e8 76df1d9c 60000010 7ebe577c 00000000 00000000
[  139.156715] [<801c4d5c>] (try_module_get) from [<7f0e6b2c>] (snd_ctl_open+0x58/0x194 [snd])
[  139.173222] [<7f0e6b2c>] (snd_ctl_open [snd]) from [<7f0e250c>] (snd_open+0xa8/0x14c [snd])
[  139.189683] [<7f0e250c>] (snd_open [snd]) from [<802ce590>] (chrdev_open+0xac/0x188)
[  139.205465] [<802ce590>] (chrdev_open) from [<802c57b4>] (do_dentry_open+0x10c/0x314)
[  139.221347] [<802c57b4>] (do_dentry_open) from [<802c6ba8>] (vfs_open+0x5c/0x88)
[  139.236788] [<802c6ba8>] (vfs_open) from [<802d9a68>] (path_openat+0x368/0x944)
[  139.248270] [<802d9a68>] (path_openat) from [<802dacd4>] (do_filp_open+0x70/0xc4)
[  139.263731] [<802dacd4>] (do_filp_open) from [<802c6f70>] (do_sys_open+0x110/0x1d4)
[  139.279378] [<802c6f70>] (do_sys_open) from [<802c7060>] (SyS_open+0x2c/0x30)
[  139.290647] [<802c7060>] (SyS_open) from [<801082c0>] (ret_fast_syscall+0x0/0x28)
[  139.306021] Code: e3c3303f e5932004 e2822001 e5832004 (e5943000)
[  139.316265] ---[ end trace 7f3f7f6193b663ed ]---
[  139.324956] note: aplay[463] exited with preempt_count 1
~~~~

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Eric Anholt <eric@anholt.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: Michael Zoran <mzoran@crowfest.net>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: devel@driverdev.osuosl.org
Cc: linux-kernel@vger.kernel.org
---
 .../staging/vc04_services/bcm2835-audio/bcm2835.c  | 50 ++++++++++------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index 8f2d508183b2..b224e0764ba6 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -36,6 +36,10 @@ MODULE_PARM_DESC(enable_compat_alsa,
 static void snd_devm_unregister_child(struct device *dev, void *res)
 {
 	struct device *childdev = *(struct device **)res;
+	struct bcm2835_chip *chip = dev_get_drvdata(childdev);
+	struct snd_card *card = chip->card;
+
+	snd_card_free(card);
 
 	device_unregister(childdev);
 }
@@ -61,6 +65,13 @@ static int snd_devm_add_child(struct device *dev, struct device *child)
 	return 0;
 }
 
+static void snd_devm_release(struct device *dev)
+{
+	struct bcm2835_chip *chip = dev_get_drvdata(dev);
+
+	kfree(chip);
+}
+
 static struct device *
 snd_create_device(struct device *parent,
 		  struct device_driver *driver,
@@ -76,6 +87,7 @@ snd_create_device(struct device *parent,
 	device_initialize(device);
 	device->parent = parent;
 	device->driver = driver;
+	device->release = snd_devm_release;
 
 	dev_set_name(device, "%s", name);
 
@@ -86,18 +98,19 @@ snd_create_device(struct device *parent,
 	return device;
 }
 
-static int snd_bcm2835_free(struct bcm2835_chip *chip)
-{
-	kfree(chip);
-	return 0;
-}
-
 /* component-destructor
  * (see "Management of Cards and Components")
  */
 static int snd_bcm2835_dev_free(struct snd_device *device)
 {
-	return snd_bcm2835_free(device->device_data);
+	struct bcm2835_chip *chip = device->device_data;
+	struct snd_card *card = chip->card;
+
+	/* TODO: free pcm, ctl */
+
+	snd_device_free(card, chip);
+
+	return 0;
 }
 
 /* chip-specific constructor
@@ -122,7 +135,7 @@ static int snd_bcm2835_create(struct snd_card *card,
 
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
 	if (err) {
-		snd_bcm2835_free(chip);
+		kfree(chip);
 		return err;
 	}
 
@@ -130,31 +143,14 @@ static int snd_bcm2835_create(struct snd_card *card,
 	return 0;
 }
 
-static void snd_devm_card_free(struct device *dev, void *res)
-{
-	struct snd_card *snd_card = *(struct snd_card **)res;
-
-	snd_card_free(snd_card);
-}
-
 static struct snd_card *snd_devm_card_new(struct device *dev)
 {
-	struct snd_card **dr;
 	struct snd_card *card;
 	int ret;
 
-	dr = devres_alloc(snd_devm_card_free, sizeof(*dr), GFP_KERNEL);
-	if (!dr)
-		return ERR_PTR(-ENOMEM);
-
 	ret = snd_card_new(dev, -1, NULL, THIS_MODULE, 0, &card);
-	if (ret) {
-		devres_free(dr);
+	if (ret)
 		return ERR_PTR(ret);
-	}
-
-	*dr = card;
-	devres_add(dev, dr);
 
 	return card;
 }
@@ -313,7 +309,7 @@ static int snd_add_child_device(struct device *device,
 		return err;
 	}
 
-	dev_set_drvdata(child, card);
+	dev_set_drvdata(child, chip);
 	dev_info(child, "card created with %d channels\n", numchans);
 
 	return 0;
-- 
2.13.6
