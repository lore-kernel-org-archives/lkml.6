Return-Path: <k.marinushkin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524555886; cv=none;
        d=google.com; s=arc-20160816;
        b=Xm+H6giqKE+UIsKTd1vNcZEevqSQ8dOJY+7kUTd2acid9sI447ML3ZFAs5slcAM1sq
         rxI20e7ANiBluTE5ABpdfrKdefgiW5DEf6Fkti7v3kgkosGnUU/0tkTVwlUOvtA8hYex
         JWRJtkTx7eVn64vZCd+fZ0vI58sAq6bmP/WNvocXUTcq9K6aJEYbtjXVV6eyVkzsVEpO
         HZ2z/OwYItNrOxHoFB3e9jPMhHzAuJeERCmWsRCg7qxlCZvQwDe7yRWOX/8H2FRHDL1m
         keEedLadlEG+qyyFqQuGkbXwfZw5uTJPYxwxZ3SUrxgDuK8QR6vVqeLQp9Aes9d8j2tt
         SGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=pdW2A41pcau7pGiol4FKMSzYHf4zKOmNI6Tdq2iiVQ0=;
        b=YHA9JkL91RWIizrMYX9d/luK/00OOeTesI8LVPjhNw8jZoaUxEwtzl3d2vLlgYGhvk
         gEkeMYGHBqRfUGKexNeUkpXV7czudY6OLbA2AkkNDy/WKIQ1FsVl35erzLd+IW2MsG+M
         xoU4hshkVJciDN0lyB7hkg7ESUuH2nu0sdYeTcqce+iexwWjmbiD808ciiTRkB5M7fsz
         1T2tS9VTqD0RAe1scN084t/xP6yqENVuICgqPpmEumPzaTXRZTfe7VbMUxpGuSg0aVDb
         o/CSaxeFfAjXjnWlxiVotT47+FS8PLui0BYK1nVris1WJXDmHWBLYdVZkKQNKujyvWIg
         GHjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=abfPcrfq;
       spf=pass (google.com: domain of k.marinushkin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=k.marinushkin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=abfPcrfq;
       spf=pass (google.com: domain of k.marinushkin@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=k.marinushkin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx487HYkh0D7UbUjI7Xa4e07Nu/8IH9qR/GjQd5XCD56OVUdFdjIbbzvvocB9To7LBNL2ulDIRw==
From: Kirill Marinushkin <k.marinushkin@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Eric Anholt <eric@anholt.net>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: Kirill Marinushkin <k.marinushkin@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] staging: bcm2835-audio: Disconnect and free vchi_instance on module_exit()
Date: Tue, 24 Apr 2018 09:44:59 +0200
Message-Id: <20180424074459.7215-1-k.marinushkin@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180424071618.GB17825@kroah.com>
References: <20180424071618.GB17825@kroah.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597968190615569586?=
X-GMAIL-MSGID: =?utf-8?q?1598612712996703136?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In the current implementation, vchi_instance is inited during the first
call of bcm2835_audio_open_connection(), and is never freed. It causes a
memory leak when the module `snd_bcm2835` is removed.

Here is how this commit fixes it:

* the VCHI context (including vchi_instance) is created once in the
  platform's devres
* the VCHI context is allocated and connected once during module_init()
* all created bcm2835_chips have a pointer to this VCHI context
* bcm2835_audio_open_connection() can access the VCHI context through the
  associated bcm2835_chip
* the VCHI context is disconnected and freed once during module_exit()

After this commit is applied, I don't see other issues with the module's
init/exit, so I also remove the associated TODO task.

Steps to reproduce the memory leak before this commit:

~~~~
root@raspberrypi:/home/pi# aplay test0.wav
Playing WAVE 'test0.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Ster
^CAborted by signal Interrupt...
root@raspberrypi:/home/pi# rmmod snd_bcm2835
root@raspberrypi:/home/pi# modprobe snd_bcm2835
root@raspberrypi:/home/pi# aplay test0.wav
Playing WAVE 'test0.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Ster
^CAborted by signal Interrupt...
root@raspberrypi:/home/pi# echo scan > /sys/kernel/debug/kmemleak
root@raspberrypi:/home/pi# cat /sys/kernel/debug/kmemleak
unreferenced object 0xb6794c00 (size 128):
  comm "aplay", pid 406, jiffies 36870 (age 116.650s)
  hex dump (first 32 bytes):
    08 a5 82 81 01 00 00 00 08 4c 79 b6 08 4c 79 b6  .........Ly..Ly.
    00 00 00 00 00 00 00 00 ad 4e ad de ff ff ff ff  .........N......
  backtrace:
    [<802af5e0>] kmem_cache_alloc_trace+0x294/0x3d0
    [<806ce620>] vchiq_initialise+0x98/0x1b0
    [<806d0b34>] vchi_initialise+0x24/0x34
    [<7f1311ec>] 0x7f1311ec
    [<7f1303bc>] 0x7f1303bc
    [<7f130590>] 0x7f130590
    [<7f111fd8>] snd_pcm_open_substream+0x68/0xc4 [snd_pcm]
    [<7f112108>] snd_pcm_open+0xd4/0x248 [snd_pcm]
    [<7f112334>] snd_pcm_playback_open+0x4c/0x6c [snd_pcm]
    [<7f0e250c>] snd_open+0xa8/0x14c [snd]
    [<802ce590>] chrdev_open+0xac/0x188
    [<802c57b4>] do_dentry_open+0x10c/0x314
    [<802c6ba8>] vfs_open+0x5c/0x88
    [<802d9a68>] path_openat+0x368/0x944
    [<802dacd4>] do_filp_open+0x70/0xc4
    [<802c6f70>] do_sys_open+0x110/0x1d4
~~~~

Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Eric Anholt <eric@anholt.net>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: devel@driverdev.osuosl.org
Cc: linux-kernel@vger.kernel.org
---
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c    | 64 +++++++++++++---------
 .../staging/vc04_services/bcm2835-audio/bcm2835.c  | 43 ++++++++++++++-
 .../staging/vc04_services/bcm2835-audio/bcm2835.h  | 12 ++++
 3 files changed, 91 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 3c6f1d91d22d..389a18f9350a 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -33,7 +33,6 @@
 
 /* ---- Include Files -------------------------------------------------------- */
 
-#include "interface/vchi/vchi.h"
 #include "vc_vchi_audioserv_defs.h"
 
 /* ---- Private Constants and Types ------------------------------------------ */
@@ -371,14 +370,46 @@ static int vc_vchi_audio_deinit(struct bcm2835_audio_instance *instance)
 	return 0;
 }
 
+int bcm2835_new_vchi_ctx(struct bcm2835_vchi_ctx *vchi_ctx)
+{
+	int ret;
+
+	/* Initialize and create a VCHI connection */
+	ret = vchi_initialise(&vchi_ctx->vchi_instance);
+	if (ret) {
+		LOG_ERR("%s: failed to initialise VCHI instance (ret=%d)\n",
+			__func__, ret);
+
+		return -EIO;
+	}
+
+	ret = vchi_connect(NULL, 0, vchi_ctx->vchi_instance);
+	if (ret) {
+		LOG_ERR("%s: failed to connect VCHI instance (ret=%d)\n",
+			__func__, ret);
+
+		kfree(vchi_ctx->vchi_instance);
+		vchi_ctx->vchi_instance = NULL;
+
+		return -EIO;
+	}
+
+	return 0;
+}
+
+void bcm2835_free_vchi_ctx(struct bcm2835_vchi_ctx *vchi_ctx)
+{
+	/* Close the VCHI connection - it will also free vchi_instance */
+	WARN_ON(vchi_disconnect(vchi_ctx->vchi_instance));
+
+	vchi_ctx->vchi_instance = NULL;
+}
+
 static int bcm2835_audio_open_connection(struct bcm2835_alsa_stream *alsa_stream)
 {
-	static VCHI_INSTANCE_T vchi_instance;
-	static VCHI_CONNECTION_T *vchi_connection;
-	static int initted;
 	struct bcm2835_audio_instance *instance =
 		(struct bcm2835_audio_instance *)alsa_stream->instance;
-	int ret;
+	struct bcm2835_vchi_ctx *vhci_ctx = alsa_stream->chip->vchi_ctx;
 
 	LOG_INFO("%s: start\n", __func__);
 	BUG_ON(instance);
@@ -390,28 +421,9 @@ static int bcm2835_audio_open_connection(struct bcm2835_alsa_stream *alsa_stream
 		return 0;
 	}
 
-	/* Initialize and create a VCHI connection */
-	if (!initted) {
-		ret = vchi_initialise(&vchi_instance);
-		if (ret) {
-			LOG_ERR("%s: failed to initialise VCHI instance (ret=%d)\n",
-				__func__, ret);
-
-			return -EIO;
-		}
-		ret = vchi_connect(NULL, 0, vchi_instance);
-		if (ret) {
-			LOG_ERR("%s: failed to connect VCHI instance (ret=%d)\n",
-				__func__, ret);
-
-			kfree(vchi_instance);
-			return -EIO;
-		}
-		initted = 1;
-	}
-
 	/* Initialize an instance of the audio service */
-	instance = vc_vchi_audio_init(vchi_instance, &vchi_connection, 1);
+	instance = vc_vchi_audio_init(vhci_ctx->vchi_instance,
+				      &vhci_ctx->vchi_connection, 1);
 
 	if (IS_ERR(instance)) {
 		LOG_ERR("%s: failed to initialize audio service\n", __func__);
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index 9030d71a3d0b..009c972d93d6 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -65,6 +65,36 @@ static int snd_devm_add_child(struct device *dev, struct device *child)
 	return 0;
 }
 
+static void bcm2835_devm_free_vchi_ctx(struct device *dev, void *res)
+{
+	struct bcm2835_vchi_ctx *vchi_ctx = res;
+
+	bcm2835_free_vchi_ctx(vchi_ctx);
+}
+
+static int bcm2835_devm_add_vchi_ctx(struct device *dev)
+{
+	struct bcm2835_vchi_ctx *vchi_ctx;
+	int ret;
+
+	vchi_ctx = devres_alloc(bcm2835_devm_free_vchi_ctx, sizeof(*vchi_ctx),
+				GFP_KERNEL);
+	if (!vchi_ctx)
+		return -ENOMEM;
+
+	memset(vchi_ctx, 0, sizeof(*vchi_ctx));
+
+	ret = bcm2835_new_vchi_ctx(vchi_ctx);
+	if (ret) {
+		devres_free(vchi_ctx);
+		return ret;
+	}
+
+	devres_add(dev, vchi_ctx);
+
+	return 0;
+}
+
 static void snd_bcm2835_release(struct device *dev)
 {
 	struct bcm2835_chip *chip = dev_get_drvdata(dev);
@@ -106,8 +136,6 @@ static int snd_bcm2835_dev_free(struct snd_device *device)
 	struct bcm2835_chip *chip = device->device_data;
 	struct snd_card *card = chip->card;
 
-	/* TODO: free pcm, ctl */
-
 	snd_device_free(card, chip);
 
 	return 0;
@@ -133,6 +161,13 @@ static int snd_bcm2835_create(struct snd_card *card,
 
 	chip->card = card;
 
+	chip->vchi_ctx = devres_find(card->dev->parent,
+				     bcm2835_devm_free_vchi_ctx, NULL, NULL);
+	if (!chip->vchi_ctx) {
+		kfree(chip);
+		return err;
+	}
+
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
 	if (err) {
 		kfree(chip);
@@ -403,6 +438,10 @@ static int snd_bcm2835_alsa_probe_dt(struct platform_device *pdev)
 			 numchans);
 	}
 
+	err = bcm2835_devm_add_vchi_ctx(dev);
+	if (err)
+		return err;
+
 	err = snd_add_child_devices(dev, numchans);
 	if (err)
 		return err;
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index f1e43e45fd67..1c82c2ee47dc 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -26,6 +26,8 @@
 #include <sound/pcm-indirect.h>
 #include <linux/workqueue.h>
 
+#include "interface/vchi/vchi.h"
+
 /*
  * #define AUDIO_DEBUG_ENABLE
  * #define AUDIO_VERBOSE_DEBUG_ENABLE
@@ -97,6 +99,11 @@ enum snd_bcm2835_ctrl {
 	PCM_PLAYBACK_DEVICE,
 };
 
+struct bcm2835_vchi_ctx {
+	VCHI_INSTANCE_T vchi_instance;
+	VCHI_CONNECTION_T *vchi_connection;
+};
+
 /* definition of the chip-specific record */
 struct bcm2835_chip {
 	struct snd_card *card;
@@ -115,6 +122,8 @@ struct bcm2835_chip {
 	unsigned int opened;
 	unsigned int spdif_status;
 	struct mutex audio_mutex;
+
+	struct bcm2835_vchi_ctx *vchi_ctx;
 };
 
 struct bcm2835_alsa_stream {
@@ -153,6 +162,9 @@ int snd_bcm2835_new_simple_pcm(struct bcm2835_chip *chip,
 int snd_bcm2835_new_hdmi_ctl(struct bcm2835_chip *chip);
 int snd_bcm2835_new_headphones_ctl(struct bcm2835_chip *chip);
 
+int bcm2835_new_vchi_ctx(struct bcm2835_vchi_ctx *vchi_ctx);
+void bcm2835_free_vchi_ctx(struct bcm2835_vchi_ctx *vchi_ctx);
+
 int bcm2835_audio_open(struct bcm2835_alsa_stream *alsa_stream);
 int bcm2835_audio_close(struct bcm2835_alsa_stream *alsa_stream);
 int bcm2835_audio_set_params(struct bcm2835_alsa_stream *alsa_stream,
-- 
2.13.6
