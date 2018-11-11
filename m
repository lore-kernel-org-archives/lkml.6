Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB713C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2F02080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2F02080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbeKLGDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:03:46 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52822 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726816AbeKLGDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:03:46 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvtD-0000l8-Ks; Sun, 11 Nov 2018 19:59:23 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsO-0001OW-9Q; Sun, 11 Nov 2018 19:58:32 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>,
        "Takashi Sakamoto" <o-takashi@sakamocchi.jp>,
        "Connor McAdams" <conmanx360@gmail.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.911898147@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 031/366] ALSA: hda/ca0132: fix build failure when a
 local macro is defined
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

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit 8e142e9e628975b0dddd05cf1b095331dff6e2de upstream.

DECLARE_TLV_DB_SCALE (alias of SNDRV_CTL_TLVD_DECLARE_DB_SCALE) is used but
tlv.h is not included. This causes build failure when local macro is
defined by comment-out.

This commit fixes the bug. At the same time, the alias macro is replaced
with a destination macro added at a commit 46e860f76804 ("ALSA: rename
TLV-related macros so that they're friendly to user applications")

Reported-by: Connor McAdams <conmanx360@gmail.com>
Fixes: 44f0c9782cc6 ('ALSA: hda/ca0132: Add tuning controls')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/pci/hda/patch_ca0132.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -38,6 +38,10 @@
 /* Enable this to see controls for tuning purpose. */
 /*#define ENABLE_TUNING_CONTROLS*/
 
+#ifdef ENABLE_TUNING_CONTROLS
+#include <sound/tlv.h>
+#endif
+
 #define FLOAT_ZERO	0x00000000
 #define FLOAT_ONE	0x3f800000
 #define FLOAT_TWO	0x40000000
@@ -3037,8 +3041,8 @@ static int equalizer_ctl_put(struct snd_
 	return 1;
 }
 
-static const DECLARE_TLV_DB_SCALE(voice_focus_db_scale, 2000, 100, 0);
-static const DECLARE_TLV_DB_SCALE(eq_db_scale, -2400, 100, 0);
+static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(voice_focus_db_scale, 2000, 100, 0);
+static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(eq_db_scale, -2400, 100, 0);
 
 static int add_tuning_control(struct hda_codec *codec,
 				hda_nid_t pnid, hda_nid_t nid,

