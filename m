Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B209C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 05:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962B320865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 05:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962B320865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbeKZQ3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 11:29:48 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:56777 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726144AbeKZQ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 11:29:48 -0500
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.52 with ESMTP; 26 Nov 2018 14:36:48 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO kernel.lge.com) (165.186.175.97)
        by 156.147.1.126 with ESMTP; 26 Nov 2018 14:36:48 +0900
X-Original-SENDERIP: 165.186.175.97
X-Original-MAILFROM: chanho.min@lge.com
From:   Chanho Min <chanho.min@lge.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Daniel Mentz <danielmentz@google.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Seungho Park <seungho1.park@lge.com>,
        Jongsung Kim <neidhard.kim@lge.com>,
        Wonmin Jung <wonmin.jung@lge.com>,
        Jaehyun Kim <jehn.kim@lge.com>,
        Hyonwoo Park <hyonwoo.park@lge.com>,
        Chanho Min <chanho.min@lge.com>
Subject: [PATCH] ALSA: pcm: Fix starvation on down_write_nonblock()
Date:   Mon, 26 Nov 2018 14:36:37 +0900
Message-Id: <1543210597-6717-1-git-send-email-chanho.min@lge.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 67ec1072b053 ("ALSA: pcm: Fix rwsem deadlock for non-atomic PCM stream")
fixes deadlock for non-atomic PCM stream. But, This patch causes antother stuck.
If writer is RT thread and reader is a normal thread, the reader thread will
be difficult to get scheduled. It may not give chance to release readlocks
and writer gets stuck for a long time if they are pinned to single cpu.

The deadlock described in the previous commit is because the linux rwsem
queues like a FIFO. So, we might need non-FIFO writelock, not non-block one.

My suggestion is that the writer gives reader a chance to be scheduled by using
the minimum msleep() instaed of spinning without blocking by writer. Also,
The *_nonblock may be changed to *_nonfifo appropriately to this concept.
In terms of performance, when trylock is failed, this minimum periodic msleep
will have the same performance as the tick-based schedule()/wake_up_q().

Suggested-by: Wonmin Jung <wonmin.jung@lge.com>
Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 sound/core/pcm_native.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 66c90f4..bdca0e1 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -36,6 +36,7 @@
 #include <sound/timer.h>
 #include <sound/minors.h>
 #include <linux/uio.h>
+#include <linux/delay.h>
 
 #include "pcm_local.h"
 
@@ -91,12 +92,12 @@ static DECLARE_RWSEM(snd_pcm_link_rwsem);
  * and this may lead to a deadlock when the code path takes read sem
  * twice (e.g. one in snd_pcm_action_nonatomic() and another in
  * snd_pcm_stream_lock()).  As a (suboptimal) workaround, let writer to
- * spin until it gets the lock.
+ * sleep until all the readers are completed without blocking by writer.
  */
-static inline void down_write_nonblock(struct rw_semaphore *lock)
+static inline void down_write_nonfifo(struct rw_semaphore *lock)
 {
 	while (!down_write_trylock(lock))
-		cond_resched();
+		msleep(1);
 }
 
 #define PCM_LOCK_DEFAULT	0
@@ -1967,7 +1968,7 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 		res = -ENOMEM;
 		goto _nolock;
 	}
-	down_write_nonblock(&snd_pcm_link_rwsem);
+	down_write_nonfifo(&snd_pcm_link_rwsem);
 	write_lock_irq(&snd_pcm_link_rwlock);
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN ||
 	    substream->runtime->status->state != substream1->runtime->status->state ||
@@ -2014,7 +2015,7 @@ static int snd_pcm_unlink(struct snd_pcm_substream *substream)
 	struct snd_pcm_substream *s;
 	int res = 0;
 
-	down_write_nonblock(&snd_pcm_link_rwsem);
+	down_write_nonfifo(&snd_pcm_link_rwsem);
 	write_lock_irq(&snd_pcm_link_rwlock);
 	if (!snd_pcm_stream_linked(substream)) {
 		res = -EALREADY;
-- 
2.1.4

