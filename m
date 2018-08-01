Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A2BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E68208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E68208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bfs.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389313AbeHAOtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:49:31 -0400
Received: from mx01-sz.bfs.de ([194.94.69.67]:54277 "EHLO mx01-sz.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388930AbeHAOtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:49:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by mx01-sz.bfs.de (Postfix) with ESMTP id DBC646017C;
        Wed,  1 Aug 2018 15:03:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at bfs.de
Received: from mx01-sz.bfs.de ([127.0.0.1])
        by localhost (mx01-sz.bfs.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6NMHFo8n-J-F; Wed,  1 Aug 2018 15:03:47 +0200 (CEST)
Received: from mail-sz.bfs.de (mail-sz.bfs.de [10.129.18.200])
        by mx01-sz.bfs.de (Postfix) with ESMTPS;
        Wed,  1 Aug 2018 15:03:47 +0200 (CEST)
Received: from null (ox-groupware01-sz.bfs.de [10.129.18.42])
        by mail-sz.bfs.de (Postfix) with ESMTPS id EE2697F45D;
        Wed,  1 Aug 2018 15:03:45 +0200 (CEST)
Date:   Wed, 1 Aug 2018 15:03:45 +0200 (CEST)
From:   Walter Harms <wharms@bfs.de>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jaya Kumar <jayakumar.alsa@gmail.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <220787354.139798.1533128625826@ox-groupware.bfs.de>
Subject: re: [PATCH 3/9] ALSA: emu10k1: remove redundant variable attn
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev31
X-Originating-Client: com.openexchange.ox.gui.dhtml
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable attn is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'attn' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/emu10k1/emupcm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index 69f9b100bd24..26f6eda3e766 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -290,7 +290,7 @@ static void snd_emu10k1_pcm_init_voice(struct snd_emu10k1
*emu,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned int silent_page, tmp;
 	int voice, stereo, w_16;
-	unsigned char attn, send_amount[8];
+	unsigned char send_amount[8];
 	unsigned char send_routing[8];
 	unsigned long flags;
 	unsigned int pitch_target;
@@ -313,7 +313,6 @@ static void snd_emu10k1_pcm_init_voice(struct snd_emu10k1
*emu,
  	/* volume parameters */
 	if (extra) {
-		attn = 0;
 		memset(send_routing, 0, sizeof(send_routing));
 		send_routing[0] = 0;
 		send_routing[1] = 1;


IMHO, this code is a bit fishy.
The memset() sould go in the init section
and in the else branch tmp is set, maybe its an idea
to set it here also (for symmetry)
just my 2 cents,

re,
 wh



-- 
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
