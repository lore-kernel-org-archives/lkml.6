Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79034C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D846208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D846208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404613AbeHGVP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:15:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35084 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388802AbeHGVP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:15:26 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A94AAD54;
        Tue,  7 Aug 2018 18:59:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 36/85] ALSA: emu10k1: Rate-limit error messages about page errors
Date:   Tue,  7 Aug 2018 20:51:38 +0200
Message-Id: <20180807172358.670726980@linuxfoundation.org>
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

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 11d42c81036324697d367600bfc16f6dd37636fd ]

The error messages at sanity checks of memory pages tend to repeat too
many times once when it hits, and without the rate limit, it may flood
and become unreadable.  Replace such messages with the *_ratelimited()
variant.

Bugzilla: http://bugzilla.opensuse.org/show_bug.cgi?id=1093027
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/emu10k1/memory.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/sound/pci/emu10k1/memory.c
+++ b/sound/pci/emu10k1/memory.c
@@ -237,13 +237,13 @@ __found_pages:
 static int is_valid_page(struct snd_emu10k1 *emu, dma_addr_t addr)
 {
 	if (addr & ~emu->dma_mask) {
-		dev_err(emu->card->dev,
+		dev_err_ratelimited(emu->card->dev,
 			"max memory size is 0x%lx (addr = 0x%lx)!!\n",
 			emu->dma_mask, (unsigned long)addr);
 		return 0;
 	}
 	if (addr & (EMUPAGESIZE-1)) {
-		dev_err(emu->card->dev, "page is not aligned\n");
+		dev_err_ratelimited(emu->card->dev, "page is not aligned\n");
 		return 0;
 	}
 	return 1;
@@ -334,7 +334,7 @@ snd_emu10k1_alloc_pages(struct snd_emu10
 		else
 			addr = snd_pcm_sgbuf_get_addr(substream, ofs);
 		if (! is_valid_page(emu, addr)) {
-			dev_err(emu->card->dev,
+			dev_err_ratelimited(emu->card->dev,
 				"emu: failure page = %d\n", idx);
 			mutex_unlock(&hdr->block_mutex);
 			return NULL;


