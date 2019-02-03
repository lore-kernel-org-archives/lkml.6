Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C3CC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEC42084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbfBCOVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:21:34 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55830 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730503AbfBCOV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:29 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIeF-0006RY-GV; Sun, 03 Feb 2019 14:21:27 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9n-0007KI-GH; Sun, 03 Feb 2019 14:49:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Takashi Iwai" <tiwai@suse.de>, "Chanho Min" <chanho.min@lge.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.210233518@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 245/305] ALSA: pcm: Call snd_pcm_unlink()
 conditionally at closing
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

commit b51abed8355e5556886623b2772fa6b7598d2282 upstream.

Currently the PCM core calls snd_pcm_unlink() always unconditionally
at closing a stream.  However, since snd_pcm_unlink() invokes the
global rwsem down, the lock can be easily contended.  More badly, when
a thread runs in a high priority RT-FIFO, it may stall at spinning.

Basically the call of snd_pcm_unlink() is required only for the linked
streams that are already rare occasion.  For normal use cases, this
code path is fairly superfluous.

As an optimization (and also as a workaround for the RT problem
above in normal situations without linked streams), this patch adds a
check before calling snd_pcm_unlink() and calls it only when needed.

Reported-by: Chanho Min <chanho.min@lge.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/pcm_native.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2025,7 +2025,8 @@ int snd_pcm_hw_constraints_complete(stru
 
 static void pcm_release_private(struct snd_pcm_substream *substream)
 {
-	snd_pcm_unlink(substream);
+	if (snd_pcm_stream_linked(substream))
+		snd_pcm_unlink(substream);
 }
 
 void snd_pcm_release_substream(struct snd_pcm_substream *substream)

