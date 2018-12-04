Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74792C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A022146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7/kVel3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A022146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbeLDL2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:28:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbeLDK6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:58:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FD68214E0;
        Tue,  4 Dec 2018 10:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921119;
        bh=cMWE5cRHvyCGg9ZddyCNjw3tIRpQAlqgFfRttOOTukc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H7/kVel3S4yXuGnX1Fb9ZTIe3h6yR990D6aw7+axmLNjkuwCfIxGK2D5pU/RA3D/X
         azZturAHNk2wJp1WTmJnRGxaU2EkYX8T9TUBFJ1VZczK9Kp2BfjbvYehybLS9AI54Z
         j8EZ6kUcOcVvxDMO1FHtaeLPDDrZTI34JK1l9jtI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 089/139] ALSA: wss: Fix invalid snd_free_pages() at error path
Date:   Tue,  4 Dec 2018 11:49:30 +0100
Message-Id: <20181204103653.992735764@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


