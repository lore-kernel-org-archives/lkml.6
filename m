Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E339C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5396520880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543066;
	bh=r/gkRGtVA1ZkJbfvUkZilPipJzOSgl6VJWyi5YgTsL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hBk/RdkU+MZl+MEwLmZyBxeE+kRJ0+uzGZJAi1+Gva7LUNaWywNpsWrkivT10Q2tB
	 l9Sxw3pdJ7RTvI306MwtrL7obytqJFIFECj6rZJQFtMty+esb69E89oMrBh3Vurahn
	 NjgaCUXzkcNYaginvVpCd443wp8yUKDGVfuSkD7w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5396520880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeLKPoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:44:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727831AbeLKPoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:44:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5D822082F;
        Tue, 11 Dec 2018 15:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543061;
        bh=r/gkRGtVA1ZkJbfvUkZilPipJzOSgl6VJWyi5YgTsL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s5saVBMM/yrrDKkSi6HUQ2iySHXXfJM3vbS3jQIecifpXTUF9atagr5br/X8N2mTc
         CFuIYfryP5d+T1SWM3DnWtrNuXoT48EghMyzZpulDkOalHWPhKBVU6Eb1evny+yVVc
         X6ZlcA3t40yd8RfyZ80YAzl61QYzOOSmWyqywhd4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 07/54] ALSA: sparc: Fix invalid snd_free_pages() at error path
Date:   Tue, 11 Dec 2018 16:40:55 +0100
Message-Id: <20181211151546.383933950@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151546.010073210@linuxfoundation.org>
References: <20181211151546.010073210@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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


