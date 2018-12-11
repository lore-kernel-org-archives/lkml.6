Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25FEC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E19820855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543102;
	bh=2VC8tmQWwTPR384aUvuwhymkVlJBxNvCtomMMByjaXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jCtzUXB0AumAg3CwsHVIEnqUD+VcMqYZsG+SQU/6udf+ZD3RtK8tyH7Domp8W2Ho0
	 xVg0HdtFmwZlCwscvqHBDzAHco0bnRplGZfyNActZNe6E/rw1oU3+rt6KcNMl0AhxR
	 nFKLXvtq7u1JbmMCOFmqHfOYblph0ACKNtsTr7fU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E19820855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeLKPpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:45:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727480AbeLKPo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:44:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 958AA20855;
        Tue, 11 Dec 2018 15:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543098;
        bh=2VC8tmQWwTPR384aUvuwhymkVlJBxNvCtomMMByjaXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cxfNB+O3YbCJHfWDNSuqJRf3QOh7qGAbirjOv9zdAhK/yW7BKJdR55Nwb/ZG6jc70
         KJqNp61qureBHOtQSBUWtAIjEN+AAYIfRRRtDFyBLRrqHihazzfuniRRsDTucScr+S
         BtMVTJZXdDU3Nf3gR/rtKAVjwYUBJvNZ3Bj0FrfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+dc09047bce3820621ba2@syzkaller.appspotmail.com,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 12/91] ALSA: control: Fix race between adding and removing a user element
Date:   Tue, 11 Dec 2018 16:40:31 +0100
Message-Id: <20181211151606.925647155@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -346,6 +346,40 @@ static int snd_ctl_find_hole(struct snd_
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
@@ -362,45 +396,18 @@ static int snd_ctl_find_hole(struct snd_
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
@@ -1322,9 +1329,12 @@ static int snd_ctl_elem_add(struct snd_c
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
@@ -1335,10 +1345,10 @@ static int snd_ctl_elem_add(struct snd_c
 	 * which locks the element.
 	 */
 
-	down_write(&card->controls_rwsem);
 	card->user_ctl_count++;
-	up_write(&card->controls_rwsem);
 
+ unlock:
+	up_write(&card->controls_rwsem);
 	return 0;
 }
 


