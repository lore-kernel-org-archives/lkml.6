Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C6AC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 07:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336032086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 07:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 336032086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbeKXSUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 13:20:39 -0500
Received: from lgeamrelo13.lge.com ([156.147.23.53]:44168 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726125AbeKXSUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 13:20:38 -0500
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.53 with ESMTP; 24 Nov 2018 16:33:07 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO kernel.lge.com) (165.186.175.97)
        by 156.147.1.125 with ESMTP; 24 Nov 2018 16:33:07 +0900
X-Original-SENDERIP: 165.186.175.97
X-Original-MAILFROM: chanho.min@lge.com
From:   Chanho Min <chanho.min@lge.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Daniel Mentz <danielmentz@google.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Seungho Park <seungho1.park@lge.com>,
        Jongsung Kim <neidhard.kim@lge.com>,
        Wonmin Jung <wonmin.jung@lge.com>,
        Jaehyun Kim <jehn.kim@lge.com>,
        Hyonwoo Park <hyonwoo.park@lge.com>,
        Chanho Min <chanho.min@lge.com>
Subject: [PATCH] ALSA: pcm: Fix starvation on down_write_nonblock()
Date:   Sat, 24 Nov 2018 16:32:43 +0900
Message-Id: <1543044763-31843-1-git-send-email-chanho.min@lge.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 67ec1072b053 (ALSA: pcm: Fix rwsem deadlock for non-atomic PCM stream)
fixes deadlock for non-atomic PCM stream. But, This patch causes antother stuck.
If writer is RT thread and reader is a normal thread, the reader thread will
be difficult to get scheduled. It may not give chance to release read locks
and writer gets stuck for a long time or forever if they are pinned to single
cpu.

To fix this, The writer gives reader a chance to be scheduled by using the
minimum msleep() instaed of spinning. This is for concept, We may need to
change the function name and comments or suggest another approach.

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 sound/core/pcm_native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 66c90f4..88d4aab 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -96,7 +96,7 @@ static DECLARE_RWSEM(snd_pcm_link_rwsem);
 static inline void down_write_nonblock(struct rw_semaphore *lock)
 {
 	while (!down_write_trylock(lock))
-		cond_resched();
+		msleep(1);
 }
 
 #define PCM_LOCK_DEFAULT	0
-- 
2.1.4

