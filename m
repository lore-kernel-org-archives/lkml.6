Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3144C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF472151D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF472151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390653AbeHGVNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:13:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34528 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389912AbeHGVNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:13:06 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DA01374;
        Tue,  7 Aug 2018 18:57:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhouyang Jia <jiazhouyang09@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 05/85] ALSA: emu10k1: add error handling for snd_ctl_add
Date:   Tue,  7 Aug 2018 20:51:07 +0200
Message-Id: <20180807172357.557226374@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
References: <20180807172357.357252052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1875,7 +1875,9 @@ int snd_emu10k1_pcm_efx(struct snd_emu10
 	if (!kctl)
 		return -ENOMEM;
 	kctl->id.device = device;
-	snd_ctl_add(emu->card, kctl);
+	err = snd_ctl_add(emu->card, kctl);
+	if (err < 0)
+		return err;
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(emu->pci), 64*1024, 64*1024);
 


