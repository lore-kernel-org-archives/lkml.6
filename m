Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23C5C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9772920855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544226;
	bh=KPNbV4y3ql7m9SLJSEpHzwzMTmc4euLZAqvQayaX5SY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mj1WeutB/dOdi03DQGAWJxgvbq0uNUGzFfkRs/arEsxWxcz+Tn9LqcjcFyZbzaL62
	 FC6Q5gJZkZS2eDePiTij7EL+5iukclQDcDF26uSMZdFAhGWqwUKWwkTgkHx5C8zM2N
	 D5aUoCw033bc4Zg8KVTPoyhr6LU02oZSSolZ61Oo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9772920855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbeLKP43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:56:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:45224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730561AbeLKP40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:56:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1E992086D;
        Tue, 11 Dec 2018 15:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543786;
        bh=KPNbV4y3ql7m9SLJSEpHzwzMTmc4euLZAqvQayaX5SY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZPPTAlqfEpA/O0Em+fNTG5QcGWiVbTNTpHH6he4pgveQS1q2F0zaXcI/T1jVc+nrr
         SHWLdZLLISZ0ujoji0jR6K5Ctyw5PZYRuu8VxEf7BZXqcBa2RDKbobxvC1cAfbgs02
         vJTf+DiDc1mPvXA6pDeUekzFpu+hwpi6vxIIqXAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wonmin Jung <wonmin.jung@lge.com>,
        Chanho Min <chanho.min@lge.com>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 063/118] ALSA: pcm: Fix starvation on down_write_nonblock()
Date:   Tue, 11 Dec 2018 16:41:22 +0100
Message-Id: <20181211151646.780620595@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

From: Chanho Min <chanho.min@lge.com>

commit b888a5f713e4d17faaaff24316585a4eb07f35b7 upstream.

Commit 67ec1072b053 ("ALSA: pcm: Fix rwsem deadlock for non-atomic PCM
stream") fixes deadlock for non-atomic PCM stream. But, This patch
causes antother stuck.
If writer is RT thread and reader is a normal thread, the reader
thread will be difficult to get scheduled. It may not give chance to
release readlocks and writer gets stuck for a long time if they are
pinned to single cpu.

The deadlock described in the previous commit is because the linux
rwsem queues like a FIFO. So, we might need non-FIFO writelock, not
non-block one.

My suggestion is that the writer gives reader a chance to be scheduled
by using the minimum msleep() instaed of spinning without blocking by
writer. Also, The *_nonblock may be changed to *_nonfifo appropriately
to this concept.
In terms of performance, when trylock is failed, this minimum periodic
msleep will have the same performance as the tick-based
schedule()/wake_up_q().

[ Although this has a fairly high performance penalty, the relevant
  code path became already rare due to the previous commit ("ALSA:
  pcm: Call snd_pcm_unlink() conditionally at closing").  That is, now
  this unconditional msleep appears only when using linked streams,
  and this must be a rare case.  So we accept this as a quick
  workaround until finding a more suitable one -- tiwai ]

Fixes: 67ec1072b053 ("ALSA: pcm: Fix rwsem deadlock for non-atomic PCM stream")
Suggested-by: Wonmin Jung <wonmin.jung@lge.com>
Signed-off-by: Chanho Min <chanho.min@lge.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/pcm_native.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -36,6 +36,7 @@
 #include <sound/timer.h>
 #include <sound/minors.h>
 #include <linux/uio.h>
+#include <linux/delay.h>
 
 #include "pcm_local.h"
 
@@ -91,12 +92,12 @@ static DECLARE_RWSEM(snd_pcm_link_rwsem)
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
@@ -1967,7 +1968,7 @@ static int snd_pcm_link(struct snd_pcm_s
 		res = -ENOMEM;
 		goto _nolock;
 	}
-	down_write_nonblock(&snd_pcm_link_rwsem);
+	down_write_nonfifo(&snd_pcm_link_rwsem);
 	write_lock_irq(&snd_pcm_link_rwlock);
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN ||
 	    substream->runtime->status->state != substream1->runtime->status->state ||
@@ -2014,7 +2015,7 @@ static int snd_pcm_unlink(struct snd_pcm
 	struct snd_pcm_substream *s;
 	int res = 0;
 
-	down_write_nonblock(&snd_pcm_link_rwsem);
+	down_write_nonfifo(&snd_pcm_link_rwsem);
 	write_lock_irq(&snd_pcm_link_rwlock);
 	if (!snd_pcm_stream_linked(substream)) {
 		res = -EALREADY;


