Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19EDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A252070B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550501074;
	bh=rFWW+UWnfgofx/csO13m3dk01FhYadQnihIx6kBZ/ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MGPNZfby1qOdlBa0cek+aKjovumX5AuoUKKKCbnk+/Foc0AJXWVK9OLVVL2ycP6BI
	 o5amCcCs77DUNVx8+cegmSbaVM7a8j+7yOF3BzTd1rT0ISHpcaa3RW61kYYSg/pZz+
	 bJGrDIiNDNSpvbsN1jLp1cn+nA42+aKzs4nSMP2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbfBROod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:44:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729511AbfBRNsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:48:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51ECB21903;
        Mon, 18 Feb 2019 13:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497697;
        bh=rFWW+UWnfgofx/csO13m3dk01FhYadQnihIx6kBZ/ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xULf5Nvi+fw+owbwdcHpjtjfFX1M1NWaNoBFZzmLb7oYU4Lsi2UL18smigNUBkWfX
         eVBzEB5PFJVGyOdW0CYvOuG/gjDBaIYYLGzsBb98Zr261MhAU09chwm2ayv7xH84tI
         lLlXFXO0t01P3V+TQJ87hw5fF+lu1TWd4okuMUAE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.20 58/92] ALSA: pcm: Revert capture stream behavior change in blocking mode
Date:   Mon, 18 Feb 2019 14:43:01 +0100
Message-Id: <20190218133500.292260555@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 00a399cad1a063e7665f06b6497a807db20441fd upstream.

In the commit 62ba568f7aef ("ALSA: pcm: Return 0 when size <
start_threshold in capture"), we changed the behavior of
__snd_pcm_lib_xfer() to return immediately with 0 when a capture
stream has a high start_threshold.  This was intended to be a
correction of the behavior consistency and looked harmless, but this
was the culprit of the recent breakage reported by syzkaller, which
was fixed by the commit e190161f96b8 ("ALSA: pcm: Fix tight loop of
OSS capture stream").

At the time for the OSS fix, I didn't touch the behavior for ALSA
native API, as assuming that this behavior actually is good.  But this
turned out to be also broken actually for a similar deployment,
e.g. one thread goes to a write loop in blocking mode while another
thread controls the start/stop of the stream manually.

Overall, the original commit is harmful, and it brings less merit to
keep that behavior.  Let's revert it.

Fixes: 62ba568f7aef ("ALSA: pcm: Return 0 when size < start_threshold in capture")
Fixes: e190161f96b8 ("ALSA: pcm: Fix tight loop of OSS capture stream")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/pcm_lib.c |   20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2112,13 +2112,6 @@ int pcm_lib_apply_appl_ptr(struct snd_pc
 	return 0;
 }
 
-/* allow waiting for a capture stream that hasn't been started */
-#if IS_ENABLED(CONFIG_SND_PCM_OSS)
-#define wait_capture_start(substream)	((substream)->oss.oss)
-#else
-#define wait_capture_start(substream)	false
-#endif
-
 /* the common loop for read/write data */
 snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 				     void *data, bool interleaved,
@@ -2184,16 +2177,11 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(str
 		snd_pcm_update_hw_ptr(substream);
 
 	if (!is_playback &&
-	    runtime->status->state == SNDRV_PCM_STATE_PREPARED) {
-		if (size >= runtime->start_threshold) {
-			err = snd_pcm_start(substream);
-			if (err < 0)
-				goto _end_unlock;
-		} else if (!wait_capture_start(substream)) {
-			/* nothing to do */
-			err = 0;
+	    runtime->status->state == SNDRV_PCM_STATE_PREPARED &&
+	    size >= runtime->start_threshold) {
+		err = snd_pcm_start(substream);
+		if (err < 0)
 			goto _end_unlock;
-		}
 	}
 
 	avail = snd_pcm_avail(substream);


