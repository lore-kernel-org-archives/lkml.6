Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2FFC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979FE20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bh7fQNt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979FE20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbeLDK6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:58:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:43328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbeLDK6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:58:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 740B92087F;
        Tue,  4 Dec 2018 10:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921125;
        bh=P50WxyPqsRLjb07+AVptViZV8wwuBNq9wYCbtEIOpJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bh7fQNt9OaoEueUIjsEhcfWB6GEFgMkYazKvjYnEqjSetFcHw3KtOwKtxdCZPaQN/
         sVfhISTyAEYO+dh+uYR8YasxamlsBPjSonSC4xrm9F0tj+BFlhfwv3EceZAXR40RBi
         oE8C7fBz/2YlmoyH3Szw1iKXUsPCRTn0Oo5k6OsA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+dc09047bce3820621ba2@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 091/139] ALSA: control: Fix race between adding and removing a user element
Date:   Tue,  4 Dec 2018 11:49:32 +0100
Message-Id: <20181204103654.084810935@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/control.c |   80 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 35 deletions(-)

--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -348,6 +348,40 @@ static int snd_ctl_find_hole(struct snd_
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
@@ -364,45 +398,18 @@ static int snd_ctl_find_hole(struct snd_
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
@@ -1361,9 +1368,12 @@ static int snd_ctl_elem_add(struct snd_c
 		kctl->tlv.c = snd_ctl_elem_user_tlv;
 
 	/* This function manage to free the instance on failure. */
-	err = snd_ctl_add(card, kctl);
-	if (err < 0)
-		return err;
+	down_write(&card->controls_rwsem);
+	err = __snd_ctl_add(card, kctl);
+	if (err < 0) {
+		snd_ctl_free_one(kctl);
+		goto unlock;
+	}
 	offset = snd_ctl_get_ioff(kctl, &info->id);
 	snd_ctl_build_ioff(&info->id, kctl, offset);
 	/*
@@ -1374,10 +1384,10 @@ static int snd_ctl_elem_add(struct snd_c
 	 * which locks the element.
 	 */
 
-	down_write(&card->controls_rwsem);
 	card->user_ctl_count++;
-	up_write(&card->controls_rwsem);
 
+ unlock:
+	up_write(&card->controls_rwsem);
 	return 0;
 }
 


