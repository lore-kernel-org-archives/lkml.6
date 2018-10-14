Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19945C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E054E2087D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E054E2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeJNXOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:14:36 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36326 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728188AbeJNXMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:05 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLs-0004cF-MT; Sun, 14 Oct 2018 16:30:44 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLW-0000UW-I3; Sun, 14 Oct 2018 16:30:22 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>,
        "DaeRyong Jeong" <threeearcat@gmail.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.178060863@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 244/366] ALSA: aloop: Add missing cable lock to ctl
 API callbacks
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 76b3421b39bd610546931fc923edcf90c18fa395 upstream.

Some control API callbacks in aloop driver are too lazy to take the
loopback->cable_lock and it results in possible races of cable access
while it's being freed.  It eventually lead to a UAF, as reported by
fuzzer recently.

This patch covers such control API callbacks and add the proper mutex
locks.

Reported-by: DaeRyong Jeong <threeearcat@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/drivers/aloop.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -829,9 +829,11 @@ static int loopback_rate_shift_get(struc
 {
 	struct loopback *loopback = snd_kcontrol_chip(kcontrol);
 	
+	mutex_lock(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] =
 		loopback->setup[kcontrol->id.subdevice]
 			       [kcontrol->id.device].rate_shift;
+	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
 
@@ -863,9 +865,11 @@ static int loopback_notify_get(struct sn
 {
 	struct loopback *loopback = snd_kcontrol_chip(kcontrol);
 	
+	mutex_lock(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] =
 		loopback->setup[kcontrol->id.subdevice]
 			       [kcontrol->id.device].notify;
+	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
 
@@ -877,12 +881,14 @@ static int loopback_notify_put(struct sn
 	int change = 0;
 
 	val = ucontrol->value.integer.value[0] ? 1 : 0;
+	mutex_lock(&loopback->cable_lock);
 	if (val != loopback->setup[kcontrol->id.subdevice]
 				[kcontrol->id.device].notify) {
 		loopback->setup[kcontrol->id.subdevice]
 			[kcontrol->id.device].notify = val;
 		change = 1;
 	}
+	mutex_unlock(&loopback->cable_lock);
 	return change;
 }
 
@@ -890,13 +896,16 @@ static int loopback_active_get(struct sn
 			       struct snd_ctl_elem_value *ucontrol)
 {
 	struct loopback *loopback = snd_kcontrol_chip(kcontrol);
-	struct loopback_cable *cable = loopback->cables
-			[kcontrol->id.subdevice][kcontrol->id.device ^ 1];
+	struct loopback_cable *cable;
+
 	unsigned int val = 0;
 
+	mutex_lock(&loopback->cable_lock);
+	cable = loopback->cables[kcontrol->id.subdevice][kcontrol->id.device ^ 1];
 	if (cable != NULL)
 		val = (cable->running & (1 << SNDRV_PCM_STREAM_PLAYBACK)) ?
 									1 : 0;
+	mutex_unlock(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] = val;
 	return 0;
 }
@@ -939,9 +948,11 @@ static int loopback_rate_get(struct snd_
 {
 	struct loopback *loopback = snd_kcontrol_chip(kcontrol);
 	
+	mutex_lock(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] =
 		loopback->setup[kcontrol->id.subdevice]
 			       [kcontrol->id.device].rate;
+	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
 
@@ -961,9 +972,11 @@ static int loopback_channels_get(struct
 {
 	struct loopback *loopback = snd_kcontrol_chip(kcontrol);
 	
+	mutex_lock(&loopback->cable_lock);
 	ucontrol->value.integer.value[0] =
 		loopback->setup[kcontrol->id.subdevice]
 			       [kcontrol->id.device].channels;
+	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
 

