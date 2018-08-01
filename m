Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2781C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E262083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E262083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732789AbeHATxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:53:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50150 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405816AbeHATIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:37 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 571A01392;
        Wed,  1 Aug 2018 17:15:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhouyang Jia <jiazhouyang09@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 024/246] ALSA: emu10k1: add error handling for snd_ctl_add
Date:   Wed,  1 Aug 2018 18:48:54 +0200
Message-Id: <20180801165012.852292715@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhouyang Jia <jiazhouyang09@gmail.com>

[ Upstream commit 6d531e7b972cb62ded011c2dfcc2d9f72ea6c421 ]

When snd_ctl_add fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling snd_ctl_add.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/emu10k1/emupcm.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -1850,7 +1850,9 @@ int snd_emu10k1_pcm_efx(struct snd_emu10
 	if (!kctl)
 		return -ENOMEM;
 	kctl->id.device = device;
-	snd_ctl_add(emu->card, kctl);
+	err = snd_ctl_add(emu->card, kctl);
+	if (err < 0)
+		return err;
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(emu->pci), 64*1024, 64*1024);
 


