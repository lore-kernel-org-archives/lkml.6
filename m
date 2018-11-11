Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E64C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959932080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959932080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbeKLGBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:01:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52534 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727101AbeKLGBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:01:33 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvtA-0000lF-6Y; Sun, 11 Nov 2018 19:59:20 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsP-0001Qh-8A; Sun, 11 Nov 2018 19:58:33 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Tzung-Bi Shih" <tzungbi@google.com>,
        "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.785617361@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 058/366] ALSA: core: Assure control device to be
 registered at last
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit dc82e52492f684dcd5ed9e4773e72dbf2203d75e upstream.

The commit 289ca025ee1d ("ALSA: Use priority list for managing device
list") changed the way to register/disconnect/free devices via a
single priority list.  This helped to make behavior consistent, but it
also changed a slight behavior change: namely, the control device is
registered earlier than others, while it was supposed to be the very
last one.

I've put SNDRV_DEV_CONTROL in the current position as the release of
ctl elements often conflict with the private ctl elements some PCM or
other components may create, which often leads to a double-free.
But, the order of register and disconnect should be indeed fixed as
expected in the early days: the control device gets registered at
last, and disconnected at first.

This patch changes the priority list order to move SNDRV_DEV_CONTROL
as the last guy to assure the register / disconnect order.  Meanwhile,
for keeping the messy resource release order, manually treat the
control and lowlevel devices as last freed one.

Additional note:
The lowlevel device is the device where a card driver creates at
probe.  And, we still keep the release order control -> lowlevel, as
there might  be link from a control element back to a lowlevel object.

Fixes: 289ca025ee1d ("ALSA: Use priority list for managing device list")
Reported-by: Tzung-Bi Shih <tzungbi@google.com>
Tested-by: Tzung-Bi Shih <tzungbi@google.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/sound/core.h | 2 +-
 sound/core/device.c  | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -51,7 +51,6 @@ struct completion;
  */
 enum snd_device_type {
 	SNDRV_DEV_LOWLEVEL,
-	SNDRV_DEV_CONTROL,
 	SNDRV_DEV_INFO,
 	SNDRV_DEV_BUS,
 	SNDRV_DEV_CODEC,
@@ -62,6 +61,7 @@ enum snd_device_type {
 	SNDRV_DEV_SEQUENCER,
 	SNDRV_DEV_HWDEP,
 	SNDRV_DEV_JACK,
+	SNDRV_DEV_CONTROL,	/* NOTE: this must be the last one */
 };
 
 enum snd_device_state {
--- a/sound/core/device.c
+++ b/sound/core/device.c
@@ -219,6 +219,15 @@ void snd_device_free_all(struct snd_card
 
 	if (snd_BUG_ON(!card))
 		return;
+	list_for_each_entry_safe_reverse(dev, next, &card->devices, list) {
+		/* exception: free ctl and lowlevel stuff later */
+		if (dev->type == SNDRV_DEV_CONTROL ||
+		    dev->type == SNDRV_DEV_LOWLEVEL)
+			continue;
+		__snd_device_free(dev);
+	}
+
+	/* free all */
 	list_for_each_entry_safe_reverse(dev, next, &card->devices, list)
 		__snd_device_free(dev);
 }

