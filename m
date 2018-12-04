Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1F4C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53958214E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ysfjVG9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53958214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbeLDLIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:08:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:57864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728618AbeLDLI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:08:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32607214E0;
        Tue,  4 Dec 2018 11:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921707;
        bh=B7KZxUgqPvOgTg3cdZXjvc32SvnuyK2ODgIG/ezAXCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ysfjVG9FRXPguGlxrx5rQn96ZFxz2T7of/ZXvZo3daEi1SXN8AzGSM1Df9s36Dcw2
         ty1nWFDCNPUpL+DoBLOMrP2oSbwNHcFkmr4Js0/GGdVy7hTn+96+ZZsQf9NweFMftu
         8S16u2kpyNoKXBlREqrA0JBmQ0q9k2AsHGKHWB4U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 28/50] ALSA: wss: Fix invalid snd_free_pages() at error path
Date:   Tue,  4 Dec 2018 11:50:23 +0100
Message-Id: <20181204103715.928316128@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103714.485546262@linuxfoundation.org>
References: <20181204103714.485546262@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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


