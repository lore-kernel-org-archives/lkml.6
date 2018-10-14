Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F8BC7112B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C8720835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C8720835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbeJNXMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:12:05 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36276 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728155AbeJNXMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:03 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLr-0004cA-DK; Sun, 14 Oct 2018 16:30:43 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLW-0000Up-N4; Sun, 14 Oct 2018 16:30:22 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        syzbot+1dac3a4f6bc9c1c675d4@syzkaller.appspotmail.com,
        "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.527603169@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 248/366] ALSA: pcm: Check PCM state at xfern compat ioctl
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

commit f13876e2c33a657a71bcbb10f767c0951b165020 upstream.

Since snd_pcm_ioctl_xfern_compat() has no PCM state check, it may go
further and hit the sanity check pcm_sanity_check() when the ioctl is
called right after open.  It may eventually spew a kernel warning, as
triggered by syzbot, depending on kconfig.

The lack of PCM state check there was just an oversight.  Although
it's no real crash, the spurious kernel warning is annoying, so let's
add the proper check.

Reported-by: syzbot+1dac3a4f6bc9c1c675d4@syzkaller.appspotmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/pcm_compat.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/sound/core/pcm_compat.c
+++ b/sound/core/pcm_compat.c
@@ -334,6 +334,8 @@ static int snd_pcm_ioctl_xfern_compat(st
 		return -ENOTTY;
 	if (substream->stream != dir)
 		return -EINVAL;
+	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN)
+		return -EBADFD;
 
 	if ((ch = substream->runtime->channels) > 128)
 		return -EINVAL;

