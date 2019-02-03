Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEDFC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7FB2073D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbfBCOaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:30:24 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55340 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729777AbfBCOUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:17 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqId4-0006Fp-TM; Sun, 03 Feb 2019 14:20:15 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9m-0007I9-2U; Sun, 03 Feb 2019 14:49:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        syzbot+dc09047bce3820621ba2@syzkaller.appspotmail.com,
        "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.862862343@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 231/305] ALSA: control: Fix race between adding and
 removing a user element
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

commit e1a7bfe3807974e66f971f2589d4e0197ec0fced upstream.

The procedure for adding a user control element has some window opened
for race against the concurrent removal of a user element.  This was
caught by syzkaller, hitting a KASAN use-after-free error.

This patch addresses the bug by wrapping the whole procedure to add a
user control element with the card->controls_rwsem, instead of only
around the increment of card->user_ctl_count.

This required a slight code refactoring, too.  The function
snd_ctl_add() is split to two parts: a core function to add the
control element and a part calling it.  The former is called from the
function for adding a user control element inside the controls_rwsem.

One change to be noted is that snd_ctl_notify() for adding a control
element gets called inside the controls_rwsem as well while it was
called outside the rwsem.  But this should be OK, as snd_ctl_notify()
takes another (finer) rwlock instead of rwsem, and the call of
snd_ctl_notify() inside rwsem is already done in another code path.

Reported-by: syzbot+dc09047bce3820621ba2@syzkaller.appspotmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 3.16:
 - In snd_ctl_elem_add(), free _kctl on error, not kctl
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/control.c | 80 +++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 35 deletions(-)

--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -318,6 +318,40 @@ static int snd_ctl_find_hole(struct snd_
 	return 0;
 }
 
+/* add a new kcontrol object; call with card->controls_rwsem locked */
+static int __snd_ctl_add(struct snd_card *card, struct snd_kcontrol *kcontrol)
+{
+	struct snd_ctl_elem_id id;
+	unsigned int idx;
+	unsigned int count;
+
+	id = kcontrol->id;
+	if (id.index > UINT_MAX - kcontrol->count)
+		return -EINVAL;
+
+	if (snd_ctl_find_id(card, &id)) {
+		dev_err(card->dev,
+			"control %i:%i:%i:%s:%i is already present\n",
+			id.iface, id.device, id.subdevice, id.name, id.index);
+		return -EBUSY;
+	}
+
+	if (snd_ctl_find_hole(card, kcontrol->count) < 0)
+		return -ENOMEM;
+
+	list_add_tail(&kcontrol->list, &card->controls);
+	card->controls_count += kcontrol->count;
+	kcontrol->id.numid = card->last_numid + 1;
+	card->last_numid += kcontrol->count;
+
+	id = kcontrol->id;
+	count = kcontrol->count;
+	for (idx = 0; idx < count; idx++, id.index++, id.numid++)
+		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_ADD, &id);
+
+	return 0;
+}
+
 /**
  * snd_ctl_add - add the control instance to the card
  * @card: the card instance
@@ -334,45 +368,18 @@ static int snd_ctl_find_hole(struct snd_
  */
 int snd_ctl_add(struct snd_card *card, struct snd_kcontrol *kcontrol)
 {
-	struct snd_ctl_elem_id id;
-	unsigned int idx;
-	unsigned int count;
 	int err = -EINVAL;
 
 	if (! kcontrol)
 		return err;
 	if (snd_BUG_ON(!card || !kcontrol->info))
 		goto error;
-	id = kcontrol->id;
-	if (id.index > UINT_MAX - kcontrol->count)
-		goto error;
 
 	down_write(&card->controls_rwsem);
-	if (snd_ctl_find_id(card, &id)) {
-		up_write(&card->controls_rwsem);
-		dev_err(card->dev, "control %i:%i:%i:%s:%i is already present\n",
-					id.iface,
-					id.device,
-					id.subdevice,
-					id.name,
-					id.index);
-		err = -EBUSY;
-		goto error;
-	}
-	if (snd_ctl_find_hole(card, kcontrol->count) < 0) {
-		up_write(&card->controls_rwsem);
-		err = -ENOMEM;
-		goto error;
-	}
-	list_add_tail(&kcontrol->list, &card->controls);
-	card->controls_count += kcontrol->count;
-	kcontrol->id.numid = card->last_numid + 1;
-	card->last_numid += kcontrol->count;
-	id = kcontrol->id;
-	count = kcontrol->count;
+	err = __snd_ctl_add(card, kcontrol);
 	up_write(&card->controls_rwsem);
-	for (idx = 0; idx < count; idx++, id.index++, id.numid++)
-		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_ADD, &id);
+	if (err < 0)
+		goto error;
 	return 0;
 
  error:
@@ -1261,14 +1268,17 @@ static int snd_ctl_elem_add(struct snd_c
 	_kctl->private_data = ue;
 	for (idx = 0; idx < _kctl->count; idx++)
 		_kctl->vd[idx].owner = file;
-	err = snd_ctl_add(card, _kctl);
-	if (err < 0)
-		return err;
-
 	down_write(&card->controls_rwsem);
+	err = __snd_ctl_add(card, _kctl);
+	if (err < 0) {
+		snd_ctl_free_one(_kctl);
+		goto unlock;
+	}
+
 	card->user_ctl_count++;
-	up_write(&card->controls_rwsem);
 
+ unlock:
+	up_write(&card->controls_rwsem);
 	return 0;
 }
 

