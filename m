Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23029C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7DD2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5wPeqMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7DD2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeLDLGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:06:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbeLDLGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:06:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 781882146D;
        Tue,  4 Dec 2018 11:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921584;
        bh=keFjtEDnoUXurLg24Cc+X0jX0uPzXDZKQ1P+vifyw3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f5wPeqMMvFfCHYvUNqbHL6dsGiUsEgKCpsO9OcJYOhT3eLbc3FtDJh3uQ+XRrMpy1
         Fc8obDbX7iz2oykM5W7lcXY9+XpHUMxLO+FMDk0GtDySeLeK9hy56l9XNyl6kvZNbf
         aORZiKOjtg9O82M0Ex2LiA5tUlL2+aLrnUebJa3A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 128/146] ALSA: sparc: Fix invalid snd_free_pages() at error path
Date:   Tue,  4 Dec 2018 11:50:14 +0100
Message-Id: <20181204103731.979794979@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 9a20332ab373b1f8f947e0a9c923652b32dab031 upstream.

Some spurious calls of snd_free_pages() have been overlooked and
remain in the error paths of sparc cs4231 driver code.  Since
runtime->dma_area is managed by the PCM core helper, we shouldn't
release manually.

Drop the superfluous calls.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/sparc/cs4231.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -1146,10 +1146,8 @@ static int snd_cs4231_playback_open(stru
 	runtime->hw = snd_cs4231_playback;
 
 	err = snd_cs4231_open(chip, CS4231_MODE_PLAY);
-	if (err < 0) {
-		snd_free_pages(runtime->dma_area, runtime->dma_bytes);
+	if (err < 0)
 		return err;
-	}
 	chip->playback_substream = substream;
 	chip->p_periods_sent = 0;
 	snd_pcm_set_sync(substream);
@@ -1167,10 +1165,8 @@ static int snd_cs4231_capture_open(struc
 	runtime->hw = snd_cs4231_capture;
 
 	err = snd_cs4231_open(chip, CS4231_MODE_RECORD);
-	if (err < 0) {
-		snd_free_pages(runtime->dma_area, runtime->dma_bytes);
+	if (err < 0)
 		return err;
-	}
 	chip->capture_substream = substream;
 	chip->c_periods_sent = 0;
 	snd_pcm_set_sync(substream);


