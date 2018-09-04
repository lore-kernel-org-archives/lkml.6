Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16795C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D003D20645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D003D20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbeIDU0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:26:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:50976 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727769AbeIDUYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:24:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68879B0AC;
        Tue,  4 Sep 2018 15:59:02 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/29] staging: bcm2835-audio: Add 10ms period constraint
Date:   Tue,  4 Sep 2018 17:58:46 +0200
Message-Id: <20180904155858.8001-18-tiwai@suse.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904155858.8001-1-tiwai@suse.de>
References: <20180904155858.8001-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that the resolution of vc04 callback is in 10 msec; i.e. the
minimal period size is also 10 msec.

This patch adds the corresponding hw constraint.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index 9659c25b9f9d..6d89db6e14e4 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -145,6 +145,11 @@ static int snd_bcm2835_playback_open_generic(
 				   SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
 				   16);
 
+	/* position update is in 10ms order */
+	snd_pcm_hw_constraint_minmax(runtime,
+				     SNDRV_PCM_HW_PARAM_PERIOD_TIME,
+				     10 * 1000, UINT_MAX);
+
 	chip->alsa_stream[idx] = alsa_stream;
 
 	chip->opened |= (1 << idx);
-- 
2.18.0

