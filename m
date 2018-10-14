Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F4FC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CBC20876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CBC20876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbeJNXQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:16:51 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36646 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727388AbeJNXQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:16:51 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLv-0004cC-KJ; Sun, 14 Oct 2018 16:30:47 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLV-0000QH-1b; Sun, 14 Oct 2018 16:30:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.960220974@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 206/366] ALSA: usb-audio: Skip broken EU on Dell dock
 USB-audio
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

commit 1d8d6428d1da642ddd75b0be2d1bb1123ff8e017 upstream.

The Dell Dock USB-audio device with 0bda:4014 is behaving notoriously
bad, and we have already applied some workaround to avoid the firmware
hiccup.  Yet we still need to skip one thing, the Extension Unit at ID
4, which doesn't react correctly to the mixer ctl access.

Bugzilla: https://bugzilla.suse.com/show_bug.cgi?id=1090658
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/usb/mixer_maps.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -346,8 +346,11 @@ static struct usbmix_name_map bose_compa
 /*
  * Dell usb dock with ALC4020 codec had a firmware problem where it got
  * screwed up when zero volume is passed; just skip it as a workaround
+ *
+ * Also the extension unit gives an access error, so skip it as well.
  */
 static const struct usbmix_name_map dell_alc4020_map[] = {
+	{ 4, NULL },	/* extension unit */
 	{ 16, NULL },
 	{ 19, NULL },
 	{ 0 }

