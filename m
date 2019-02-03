Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C7CC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB9C218F0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfBCNxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:53:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54154 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728469AbfBCNuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:50:07 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9t-0003tp-J8; Sun, 03 Feb 2019 13:50:05 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9o-0007Ly-Ia; Sun, 03 Feb 2019 14:50:00 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.466394633@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 253/305] ALSA: usb-audio: Avoid nested autoresume calls
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 47ab154593827b1a8f0713a2b9dd445753d551d8 upstream.

After the recent fix of runtime PM for USB-audio driver, we got a
lockdep warning like:

  =============================================
  [ INFO: possible recursive locking detected ]
  4.2.0-rc8+ #61 Not tainted
  ---------------------------------------------
  pulseaudio/980 is trying to acquire lock:
   (&chip->shutdown_rwsem){.+.+.+}, at: [<ffffffffa0355dac>] snd_usb_autoresume+0x1d/0x52 [snd_usb_audio]
  but task is already holding lock:
   (&chip->shutdown_rwsem){.+.+.+}, at: [<ffffffffa0355dac>] snd_usb_autoresume+0x1d/0x52 [snd_usb_audio]

This comes from snd_usb_autoresume() invoking down_read() and it's
used in a nested way.  Although it's basically safe, per se (as these
are read locks), it's better to reduce such spurious warnings.

The read lock is needed to guarantee the execution of "shutdown"
(cleanup at disconnection) task after all concurrent tasks are
finished.  This can be implemented in another better way.

Also, the current check of chip->in_pm isn't good enough for
protecting the racy execution of multiple auto-resumes.

This patch rewrites the logic of snd_usb_autoresume() & co; namely,
- The recursive call of autopm is avoided by the new refcount,
  chip->active.  The chip->in_pm flag is removed accordingly.
- Instead of rwsem, another refcount, chip->usage_count, is introduced
  for tracking the period to delay the shutdown procedure.  At
  the last clear of this refcount, wake_up() to the shutdown waiter is
  called.
- The shutdown flag is replaced with shutdown atomic count; this is
  for reducing the lock.
- Two new helpers are introduced to simplify the management of these
  refcounts; snd_usb_lock_shutdown() increases the usage_count, checks
  the shutdown state, and does autoresume.  snd_usb_unlock_shutdown()
  does the opposite.  Most of mixer and other codes just need this,
  and simply returns an error if it receives an error from lock.

Fixes: 9003ebb13f61 ('ALSA: usb-audio: Fix runtime PM unbalance')
Reported-and-tested-by: Alexnader Kuleshov <kuleshovmail@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 3.16:
 - Drop inapplicable changes in mixer quirk functions
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -396,13 +396,15 @@ static int snd_usb_audio_create(struct u
 	}
 
 	mutex_init(&chip->mutex);
-	init_rwsem(&chip->shutdown_rwsem);
+	init_waitqueue_head(&chip->shutdown_wait);
 	chip->index = idx;
 	chip->dev = dev;
 	chip->card = card;
 	chip->setup = device_setup[idx];
 	chip->autoclock = autoclock;
 	chip->probing = 1;
+	atomic_set(&chip->usage_count, 0);
+	atomic_set(&chip->shutdown, 0);
 
 	chip->usb_id = USB_ID(le16_to_cpu(dev->descriptor.idVendor),
 			      le16_to_cpu(dev->descriptor.idProduct));
@@ -525,7 +527,7 @@ snd_usb_audio_probe(struct usb_device *d
 	mutex_lock(&register_mutex);
 	for (i = 0; i < SNDRV_CARDS; i++) {
 		if (usb_chip[i] && usb_chip[i]->dev == dev) {
-			if (usb_chip[i]->shutdown) {
+			if (atomic_read(&usb_chip[i]->shutdown)) {
 				dev_err(&dev->dev, "USB device is in the shutdown state, cannot create a card instance\n");
 				goto __error;
 			}
@@ -610,21 +612,21 @@ static void snd_usb_audio_disconnect(str
 {
 	struct snd_card *card;
 	struct list_head *p;
-	bool was_shutdown;
 
 	if (chip == (void *)-1L)
 		return;
 
 	card = chip->card;
-	down_write(&chip->shutdown_rwsem);
-	was_shutdown = chip->shutdown;
-	chip->shutdown = 1;
-	up_write(&chip->shutdown_rwsem);
 
 	mutex_lock(&register_mutex);
-	if (!was_shutdown) {
+	if (atomic_inc_return(&chip->shutdown) == 1) {
 		struct snd_usb_endpoint *ep;
 
+		/* wait until all pending tasks done;
+		 * they are protected by snd_usb_lock_shutdown()
+		 */
+		wait_event(chip->shutdown_wait,
+			   !atomic_read(&chip->usage_count));
 		snd_card_disconnect(card);
 		/* release the pcm resources */
 		list_for_each(p, &chip->pcm_list) {
@@ -675,28 +677,54 @@ static void usb_audio_disconnect(struct
 				 usb_get_intfdata(intf));
 }
 
-#ifdef CONFIG_PM
-
-int snd_usb_autoresume(struct snd_usb_audio *chip)
+/* lock the shutdown (disconnect) task and autoresume */
+int snd_usb_lock_shutdown(struct snd_usb_audio *chip)
 {
-	int err = -ENODEV;
+	int err;
 
-	down_read(&chip->shutdown_rwsem);
-	if (chip->probing || chip->in_pm)
-		err = 0;
-	else if (!chip->shutdown)
-		err = usb_autopm_get_interface(chip->pm_intf);
-	up_read(&chip->shutdown_rwsem);
+	atomic_inc(&chip->usage_count);
+	if (atomic_read(&chip->shutdown)) {
+		err = -EIO;
+		goto error;
+	}
+	err = snd_usb_autoresume(chip);
+	if (err < 0)
+		goto error;
+	return 0;
 
+ error:
+	if (atomic_dec_and_test(&chip->usage_count))
+		wake_up(&chip->shutdown_wait);
 	return err;
 }
 
+/* autosuspend and unlock the shutdown */
+void snd_usb_unlock_shutdown(struct snd_usb_audio *chip)
+{
+	snd_usb_autosuspend(chip);
+	if (atomic_dec_and_test(&chip->usage_count))
+		wake_up(&chip->shutdown_wait);
+}
+
+#ifdef CONFIG_PM
+
+int snd_usb_autoresume(struct snd_usb_audio *chip)
+{
+	if (atomic_read(&chip->shutdown))
+		return -EIO;
+	if (chip->probing)
+		return 0;
+	if (atomic_inc_return(&chip->active) == 1)
+		return usb_autopm_get_interface(chip->pm_intf);
+	return 0;
+}
+
 void snd_usb_autosuspend(struct snd_usb_audio *chip)
 {
-	down_read(&chip->shutdown_rwsem);
-	if (!chip->shutdown && !chip->probing && !chip->in_pm)
+	if (chip->probing)
+		return;
+	if (atomic_dec_and_test(&chip->active))
 		usb_autopm_put_interface(chip->pm_intf);
-	up_read(&chip->shutdown_rwsem);
 }
 
 static int usb_audio_suspend(struct usb_interface *intf, pm_message_t message)
@@ -744,7 +772,7 @@ static int __usb_audio_resume(struct usb
 	if (--chip->num_suspended_intf)
 		return 0;
 
-	chip->in_pm = 1;
+	atomic_inc(&chip->active); /* avoid autopm */
 	/*
 	 * ALSA leaves material resumption to user space
 	 * we just notify and restart the mixers
@@ -760,7 +788,7 @@ static int __usb_audio_resume(struct usb
 	chip->autosuspended = 0;
 
 err_out:
-	chip->in_pm = 0;
+	atomic_dec(&chip->active); /* allow autopm after this point */
 	return err;
 }
 
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -353,8 +353,10 @@ static void snd_complete_urb(struct urb
 	if (unlikely(urb->status == -ENOENT ||		/* unlinked */
 		     urb->status == -ENODEV ||		/* device removed */
 		     urb->status == -ECONNRESET ||	/* unlinked */
-		     urb->status == -ESHUTDOWN ||	/* device disabled */
-		     ep->chip->shutdown))		/* device disconnected */
+		     urb->status == -ESHUTDOWN))	/* device disabled */
+		goto exit_clear;
+	/* device disconnected */
+	if (unlikely(atomic_read(&ep->chip->shutdown)))
 		goto exit_clear;
 
 	if (usb_pipeout(ep->pipe)) {
@@ -529,7 +531,7 @@ static int deactivate_urbs(struct snd_us
 {
 	unsigned int i;
 
-	if (!force && ep->chip->shutdown) /* to be sure... */
+	if (!force && atomic_read(&ep->chip->shutdown)) /* to be sure... */
 		return -EBADFD;
 
 	clear_bit(EP_FLAG_RUNNING, &ep->flags);
@@ -868,7 +870,7 @@ int snd_usb_endpoint_start(struct snd_us
 	int err;
 	unsigned int i;
 
-	if (ep->chip->shutdown)
+	if (atomic_read(&ep->chip->shutdown))
 		return -EBADFD;
 
 	/* already running? */
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -296,14 +296,11 @@ static int get_ctl_value_v1(struct usb_m
 	int timeout = 10;
 	int idx = 0, err;
 
-	err = snd_usb_autoresume(cval->mixer->chip);
+	err = snd_usb_lock_shutdown(chip);
 	if (err < 0)
 		return -EIO;
 
-	down_read(&chip->shutdown_rwsem);
 	while (timeout-- > 0) {
-		if (chip->shutdown)
-			break;
 		idx = snd_usb_ctrl_intf(chip) | (cval->id << 8);
 		if (snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), request,
 				    USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
@@ -319,8 +316,7 @@ static int get_ctl_value_v1(struct usb_m
 	err = -EINVAL;
 
  out:
-	up_read(&chip->shutdown_rwsem);
-	snd_usb_autosuspend(cval->mixer->chip);
+	snd_usb_unlock_shutdown(chip);
 	return err;
 }
 
@@ -343,21 +339,15 @@ static int get_ctl_value_v2(struct usb_m
 
 	memset(buf, 0, sizeof(buf));
 
-	ret = snd_usb_autoresume(chip) ? -EIO : 0;
+	ret = snd_usb_lock_shutdown(chip) ? -EIO : 0;
 	if (ret)
 		goto error;
 
-	down_read(&chip->shutdown_rwsem);
-	if (chip->shutdown) {
-		ret = -ENODEV;
-	} else {
-		idx = snd_usb_ctrl_intf(chip) | (cval->id << 8);
-		ret = snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), bRequest,
+	idx = snd_usb_ctrl_intf(chip) | (cval->id << 8);
+	ret = snd_usb_ctl_msg(chip->dev, usb_rcvctrlpipe(chip->dev, 0), bRequest,
 			      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 			      validx, idx, buf, size);
-	}
-	up_read(&chip->shutdown_rwsem);
-	snd_usb_autosuspend(chip);
+	snd_usb_unlock_shutdown(chip);
 
 	if (ret < 0) {
 error:
@@ -469,13 +459,12 @@ int snd_usb_mixer_set_ctl_value(struct u
 	value_set = convert_bytes_value(cval, value_set);
 	buf[0] = value_set & 0xff;
 	buf[1] = (value_set >> 8) & 0xff;
-	err = snd_usb_autoresume(chip);
+
+	err = snd_usb_lock_shutdown(chip);
 	if (err < 0)
 		return -EIO;
-	down_read(&chip->shutdown_rwsem);
+
 	while (timeout-- > 0) {
-		if (chip->shutdown)
-			break;
 		idx = snd_usb_ctrl_intf(chip) | (cval->id << 8);
 		if (snd_usb_ctl_msg(chip->dev,
 				    usb_sndctrlpipe(chip->dev, 0), request,
@@ -490,8 +479,7 @@ int snd_usb_mixer_set_ctl_value(struct u
 	err = -EINVAL;
 
  out:
-	up_read(&chip->shutdown_rwsem);
-	snd_usb_autosuspend(chip);
+	snd_usb_unlock_shutdown(chip);
 	return err;
 }
 
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -302,11 +302,10 @@ static int snd_audigy2nx_led_put(struct
 	if (value > 1)
 		return -EINVAL;
 	changed = value != mixer->audigy2nx_leds[index];
-	down_read(&mixer->chip->shutdown_rwsem);
-	if (mixer->chip->shutdown) {
-		err = -ENODEV;
-		goto out;
-	}
+	err = snd_usb_lock_shutdown(mixer->chip);
+	if (err < 0)
+		return err;
+
 	if (mixer->chip->usb_id == USB_ID(0x041e, 0x3042))
 		err = snd_usb_ctl_msg(mixer->chip->dev,
 			      usb_sndctrlpipe(mixer->chip->dev, 0), 0x24,
@@ -323,8 +322,7 @@ static int snd_audigy2nx_led_put(struct
 			      usb_sndctrlpipe(mixer->chip->dev, 0), 0x24,
 			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
 			      value, index + 2, NULL, 0);
- out:
-	up_read(&mixer->chip->shutdown_rwsem);
+	snd_usb_unlock_shutdown(mixer->chip);
 	if (err < 0)
 		return err;
 	mixer->audigy2nx_leds[index] = value;
@@ -418,16 +416,15 @@ static void snd_audigy2nx_proc_read(stru
 
 	for (i = 0; jacks[i].name; ++i) {
 		snd_iprintf(buffer, "%s: ", jacks[i].name);
-		down_read(&mixer->chip->shutdown_rwsem);
-		if (mixer->chip->shutdown)
-			err = 0;
-		else
-			err = snd_usb_ctl_msg(mixer->chip->dev,
+		err = snd_usb_lock_shutdown(mixer->chip);
+		if (err < 0)
+			return;
+		err = snd_usb_ctl_msg(mixer->chip->dev,
 				      usb_rcvctrlpipe(mixer->chip->dev, 0),
 				      UAC_GET_MEM, USB_DIR_IN | USB_TYPE_CLASS |
 				      USB_RECIP_INTERFACE, 0,
 				      jacks[i].unitid << 8, buf, 3);
-		up_read(&mixer->chip->shutdown_rwsem);
+		snd_usb_unlock_shutdown(mixer->chip);
 		if (err == 3 && (buf[0] == 3 || buf[0] == 6))
 			snd_iprintf(buffer, "%02x %02x\n", buf[1], buf[2]);
 		else
@@ -476,17 +473,14 @@ static int snd_emu0204_ch_switch_put(str
 	buf[1] = value ? 0x02 : 0x01;
 
 	changed = value != kcontrol->private_value;
-	down_read(&mixer->chip->shutdown_rwsem);
-	if (mixer->chip->shutdown) {
-		err = -ENODEV;
-		goto out;
-	}
+	err = snd_usb_lock_shutdown(mixer->chip);
+	if (err < 0)
+		return err;
 	err = snd_usb_ctl_msg(mixer->chip->dev,
 		      usb_sndctrlpipe(mixer->chip->dev, 0), UAC_SET_CUR,
 		      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
 		      0x0400, 0x0e00, buf, 2);
- out:
-	up_read(&mixer->chip->shutdown_rwsem);
+	snd_usb_unlock_shutdown(mixer->chip);
 	if (err < 0)
 		return err;
 	kcontrol->private_value = value;
@@ -542,15 +536,14 @@ static int snd_xonar_u1_switch_put(struc
 	else
 		new_status = old_status & ~0x02;
 	changed = new_status != old_status;
-	down_read(&mixer->chip->shutdown_rwsem);
-	if (mixer->chip->shutdown)
-		err = -ENODEV;
-	else
-		err = snd_usb_ctl_msg(mixer->chip->dev,
+	err = snd_usb_lock_shutdown(mixer->chip);
+	if (err < 0)
+		return err;
+	err = snd_usb_ctl_msg(mixer->chip->dev,
 			      usb_sndctrlpipe(mixer->chip->dev, 0), 0x08,
 			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
 			      50, 0, &new_status, 1);
-	up_read(&mixer->chip->shutdown_rwsem);
+	snd_usb_unlock_shutdown(mixer->chip);
 	if (err < 0)
 		return err;
 	mixer->xonar_u1_status = new_status;
@@ -591,15 +584,14 @@ static int snd_nativeinstruments_control
 	u8 tmp;
 	int ret;
 
-	down_read(&mixer->chip->shutdown_rwsem);
-	if (mixer->chip->shutdown)
-		ret = -ENODEV;
-	else
-		ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), bRequest,
-				  USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
-				  0, wIndex,
-				  &tmp, sizeof(tmp), 1000);
-	up_read(&mixer->chip->shutdown_rwsem);
+	ret = snd_usb_lock_shutdown(mixer->chip);
+	if (ret < 0)
+		return ret;
+	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), bRequest,
+			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
+			      0, wIndex,
+			      &tmp, sizeof(tmp), 1000);
+	snd_usb_unlock_shutdown(mixer->chip);
 
 	if (ret < 0) {
 		dev_err(&dev->dev,
@@ -622,15 +614,14 @@ static int snd_nativeinstruments_control
 	u16 wValue = ucontrol->value.integer.value[0];
 	int ret;
 
-	down_read(&mixer->chip->shutdown_rwsem);
-	if (mixer->chip->shutdown)
-		ret = -ENODEV;
-	else
-		ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), bRequest,
-				  USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
-				  wValue, wIndex,
-				  NULL, 0, 1000);
-	up_read(&mixer->chip->shutdown_rwsem);
+	ret = snd_usb_lock_shutdown(mixer->chip);
+	if (ret < 0)
+		return ret;
+	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), bRequest,
+			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
+			      wValue, wIndex,
+			      NULL, 0, 1000);
+	snd_usb_unlock_shutdown(mixer->chip);
 
 	if (ret < 0) {
 		dev_err(&dev->dev,
@@ -792,16 +783,15 @@ static int snd_ftu_eff_switch_get(struct
 	id = pval->bUnitID;
 	validx = pval->validx;
 
-	down_read(&mixer->chip->shutdown_rwsem);
-	if (mixer->chip->shutdown)
-		err = -ENODEV;
-	else
-		err = snd_usb_ctl_msg(chip->dev,
+	err = snd_usb_lock_shutdown(mixer->chip);
+	if (err < 0)
+		return err;
+	err = snd_usb_ctl_msg(chip->dev,
 			usb_rcvctrlpipe(chip->dev, 0), UAC_GET_CUR,
 			USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 			validx << 8, snd_usb_ctrl_intf(chip) | (id << 8),
 			value, val_len);
-	up_read(&mixer->chip->shutdown_rwsem);
+	snd_usb_unlock_shutdown(mixer->chip);
 	if (err < 0)
 		return err;
 
@@ -845,16 +835,15 @@ static int snd_ftu_eff_switch_put(struct
 
 	if (!pval->is_cached) {
 		/* Read current value */
-		down_read(&mixer->chip->shutdown_rwsem);
-		if (mixer->chip->shutdown)
-			err = -ENODEV;
-		else
-			err = snd_usb_ctl_msg(chip->dev,
+		err = snd_usb_lock_shutdown(mixer->chip);
+		if (err < 0)
+			return err;
+		err = snd_usb_ctl_msg(chip->dev,
 				usb_rcvctrlpipe(chip->dev, 0), UAC_GET_CUR,
 				USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 				validx << 8, snd_usb_ctrl_intf(chip) | (id << 8),
 				value, val_len);
-		up_read(&mixer->chip->shutdown_rwsem);
+		snd_usb_unlock_shutdown(mixer->chip);
 		if (err < 0)
 			return err;
 
@@ -866,16 +855,15 @@ static int snd_ftu_eff_switch_put(struct
 	if (cur_val != new_val) {
 		value[0] = new_val;
 		value[1] = 0;
-		down_read(&mixer->chip->shutdown_rwsem);
-		if (mixer->chip->shutdown)
-			err = -ENODEV;
-		else
-			err = snd_usb_ctl_msg(chip->dev,
+		err = snd_usb_lock_shutdown(chip);
+		if (err < 0)
+			return err;
+		err = snd_usb_ctl_msg(chip->dev,
 				usb_sndctrlpipe(chip->dev, 0), UAC_SET_CUR,
 				USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
 				validx << 8, snd_usb_ctrl_intf(chip) | (id << 8),
 				value, val_len);
-		up_read(&mixer->chip->shutdown_rwsem);
+		snd_usb_unlock_shutdown(chip);
 		if (err < 0)
 			return err;
 
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -80,7 +80,7 @@ static snd_pcm_uframes_t snd_usb_pcm_poi
 	unsigned int hwptr_done;
 
 	subs = (struct snd_usb_substream *)substream->runtime->private_data;
-	if (subs->stream->chip->shutdown)
+	if (atomic_read(&subs->stream->chip->shutdown))
 		return SNDRV_PCM_POS_XRUN;
 	spin_lock(&subs->lock);
 	hwptr_done = subs->hwptr_done;
@@ -713,12 +713,11 @@ static int snd_usb_hw_params(struct snd_
 		return -EINVAL;
 	}
 
-	down_read(&subs->stream->chip->shutdown_rwsem);
-	if (subs->stream->chip->shutdown)
-		ret = -ENODEV;
-	else
-		ret = set_format(subs, fmt);
-	up_read(&subs->stream->chip->shutdown_rwsem);
+	ret = snd_usb_lock_shutdown(subs->stream->chip);
+	if (ret < 0)
+		return ret;
+	ret = set_format(subs, fmt);
+	snd_usb_unlock_shutdown(subs->stream->chip);
 	if (ret < 0)
 		return ret;
 
@@ -741,13 +740,12 @@ static int snd_usb_hw_free(struct snd_pc
 	subs->cur_audiofmt = NULL;
 	subs->cur_rate = 0;
 	subs->period_bytes = 0;
-	down_read(&subs->stream->chip->shutdown_rwsem);
-	if (!subs->stream->chip->shutdown) {
+	if (!snd_usb_lock_shutdown(subs->stream->chip)) {
 		stop_endpoints(subs, true);
 		snd_usb_endpoint_deactivate(subs->sync_endpoint);
 		snd_usb_endpoint_deactivate(subs->data_endpoint);
+		snd_usb_unlock_shutdown(subs->stream->chip);
 	}
-	up_read(&subs->stream->chip->shutdown_rwsem);
 	return snd_pcm_lib_free_vmalloc_buffer(substream);
 }
 
@@ -769,11 +767,9 @@ static int snd_usb_pcm_prepare(struct sn
 		return -ENXIO;
 	}
 
-	down_read(&subs->stream->chip->shutdown_rwsem);
-	if (subs->stream->chip->shutdown) {
-		ret = -ENODEV;
-		goto unlock;
-	}
+	ret = snd_usb_lock_shutdown(subs->stream->chip);
+	if (ret < 0)
+		return ret;
 	if (snd_BUG_ON(!subs->data_endpoint)) {
 		ret = -EIO;
 		goto unlock;
@@ -822,7 +818,7 @@ static int snd_usb_pcm_prepare(struct sn
 		ret = start_endpoints(subs, true);
 
  unlock:
-	up_read(&subs->stream->chip->shutdown_rwsem);
+	snd_usb_unlock_shutdown(subs->stream->chip);
 	return ret;
 }
 
@@ -1224,9 +1220,11 @@ static int snd_usb_pcm_close(struct snd_
 
 	stop_endpoints(subs, true);
 
-	if (!as->chip->shutdown && subs->interface >= 0) {
+	if (subs->interface >= 0 &&
+	    !snd_usb_lock_shutdown(subs->stream->chip)) {
 		usb_set_interface(subs->dev, subs->interface, 0);
 		subs->interface = -1;
+		snd_usb_unlock_shutdown(subs->stream->chip);
 	}
 
 	subs->pcm_substream = NULL;
--- a/sound/usb/proc.c
+++ b/sound/usb/proc.c
@@ -46,14 +46,14 @@ static inline unsigned get_high_speed_hz
 static void proc_audio_usbbus_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 {
 	struct snd_usb_audio *chip = entry->private_data;
-	if (!chip->shutdown)
+	if (!atomic_read(&chip->shutdown))
 		snd_iprintf(buffer, "%03d/%03d\n", chip->dev->bus->busnum, chip->dev->devnum);
 }
 
 static void proc_audio_usbid_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 {
 	struct snd_usb_audio *chip = entry->private_data;
-	if (!chip->shutdown)
+	if (!atomic_read(&chip->shutdown))
 		snd_iprintf(buffer, "%04x:%04x\n", 
 			    USB_ID_VENDOR(chip->usb_id),
 			    USB_ID_PRODUCT(chip->usb_id));
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -37,11 +37,12 @@ struct snd_usb_audio {
 	struct usb_interface *pm_intf;
 	u32 usb_id;
 	struct mutex mutex;
-	struct rw_semaphore shutdown_rwsem;
-	unsigned int shutdown:1;
 	unsigned int probing:1;
-	unsigned int in_pm:1;
 	unsigned int autosuspended:1;	
+	atomic_t active;
+	atomic_t shutdown;
+	atomic_t usage_count;
+	wait_queue_head_t shutdown_wait;
 	unsigned int txfr_quirk:1; /* Subframe boundaries on transfers */
 	
 	int num_interfaces;
@@ -116,4 +117,7 @@ struct snd_usb_audio_quirk {
 #define combine_triple(s)  (combine_word(s) | ((unsigned int)(s)[2] << 16))
 #define combine_quad(s)    (combine_triple(s) | ((unsigned int)(s)[3] << 24))
 
+int snd_usb_lock_shutdown(struct snd_usb_audio *chip);
+void snd_usb_unlock_shutdown(struct snd_usb_audio *chip);
+
 #endif /* __USBAUDIO_H */

