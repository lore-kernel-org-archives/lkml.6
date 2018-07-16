Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28734ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97DD208FC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97DD208FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbeGPJQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:16:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43121 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbeGPJQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:16:04 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fezCM-0002XM-OS; Mon, 16 Jul 2018 08:49:38 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: gus: remove redundant pointer private_data
Date:   Mon, 16 Jul 2018 09:49:38 +0100
Message-Id: <20180716084938.15733-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer private_data is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'private_data' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/isa/gus/gus_reset.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/isa/gus/gus_reset.c b/sound/isa/gus/gus_reset.c
index 3d1fed0c2620..59b3f683d49b 100644
--- a/sound/isa/gus/gus_reset.c
+++ b/sound/isa/gus/gus_reset.c
@@ -292,7 +292,6 @@ void snd_gf1_free_voice(struct snd_gus_card * gus, struct snd_gus_voice *voice)
 {
 	unsigned long flags;
 	void (*private_free)(struct snd_gus_voice *voice);
-	void *private_data;
 
 	if (voice == NULL || !voice->use)
 		return;
@@ -300,7 +299,6 @@ void snd_gf1_free_voice(struct snd_gus_card * gus, struct snd_gus_voice *voice)
 	snd_gf1_clear_voices(gus, voice->number, voice->number);
 	spin_lock_irqsave(&gus->voice_alloc, flags);
 	private_free = voice->private_free;
-	private_data = voice->private_data;
 	voice->private_free = NULL;
 	voice->private_data = NULL;
 	if (voice->pcm)
-- 
2.17.1

