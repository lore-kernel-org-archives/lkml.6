Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C2FC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA7520672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544542962;
	bh=aq39aArnhCLGGHBTpMfz/Kxiky2ZQX/pCEycvZWLTzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g1L+wVvO7yQC1z9bKwhww4lMZdzpIndZi1ASSbe5fZ7P3TnMApYXAKzu2H2EdWqZZ
	 ySNj5eRQBUr94tZJ287vlvJF/GZSQRJzRWG6tSlndB2y2lf36rIgIlXvPFFcyZNdAC
	 hKWs+8aN++eoRDs8e8AOWf6LFZmgdzYFxmnFZz2o=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA7520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeLKPml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:42:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727291AbeLKPmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:42:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10D1120672;
        Tue, 11 Dec 2018 15:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544542958;
        bh=aq39aArnhCLGGHBTpMfz/Kxiky2ZQX/pCEycvZWLTzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4yhnKy2QAFkmBPe45wPH/KtWMklv9Kf8WRvFV8m4kaGzulMAtsvv7VH/pa7uz/te
         FfCv8ftnrrzp9Yv9kiiUA7ukFUtumcLS0Tir5zkDgvTYaDDg53miOfEn32ktO07O71
         mdROD2OcN5TpLoPfwwn/60+ylAxu2bk2zWvQ6k8E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 05/54] ALSA: wss: Fix invalid snd_free_pages() at error path
Date:   Tue, 11 Dec 2018 16:40:53 +0100
Message-Id: <20181211151546.295773949@linuxfoundation.org>
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

commit 7b69154171b407844c273ab4c10b5f0ddcd6aa29 upstream.

Some spurious calls of snd_free_pages() have been overlooked and
remain in the error paths of wss driver code.  Since runtime->dma_area
is managed by the PCM core helper, we shouldn't release manually.

Drop the superfluous calls.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/isa/wss/wss_lib.c |    2 --
 1 file changed, 2 deletions(-)

--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -1531,7 +1531,6 @@ static int snd_wss_playback_open(struct
 	if (err < 0) {
 		if (chip->release_dma)
 			chip->release_dma(chip, chip->dma_private_data, chip->dma1);
-		snd_free_pages(runtime->dma_area, runtime->dma_bytes);
 		return err;
 	}
 	chip->playback_substream = substream;
@@ -1572,7 +1571,6 @@ static int snd_wss_capture_open(struct s
 	if (err < 0) {
 		if (chip->release_dma)
 			chip->release_dma(chip, chip->dma_private_data, chip->dma2);
-		snd_free_pages(runtime->dma_area, runtime->dma_bytes);
 		return err;
 	}
 	chip->capture_substream = substream;


