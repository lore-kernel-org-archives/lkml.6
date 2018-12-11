Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCA0C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89DD52081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544424;
	bh=cytI//1q16QsOm+IQheVfSKGOrBwLnbo1DytQnlu8CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LJLioco3+JiF0BZozOwydVlm4VXJwTM7hI9VzDK+B41LRxt30gc9pVuNexb2HB4Dw
	 t+6uR+WQ4PsgrXhN8stjw/RAG4/z9LpNlN9K6DctIkxVTz2cM2EEMLmPn+ih8zL+0A
	 4dGvwkaRYEhaEEtWdss5DzQdsN2NR2P6hTfRCy8c=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DD52081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbeLKQHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:07:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730047AbeLKPyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:54:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 268DE20855;
        Tue, 11 Dec 2018 15:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543641;
        bh=cytI//1q16QsOm+IQheVfSKGOrBwLnbo1DytQnlu8CM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t2cXP6FCz087olFmN77fK5u6iYUpHjnGNacAMXtprjNGzkgaoa1pZL9PprIMMSgMy
         2VMRx1H6kaYRh4fyXIS69jFUD6btCsKiplUQErP907XyOSlbXqGs/GTk49rJJGBK66
         p6J9mrqXcrtUeUrh8R8nzElA2l1TOgfn3/puLqKA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wonmin Jung <wonmin.jung@lge.com>,
        Chanho Min <chanho.min@lge.com>, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 36/67] ALSA: pcm: Fix starvation on down_write_nonblock()
Date:   Tue, 11 Dec 2018 16:41:36 +0100
Message-Id: <20181211151632.228099839@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
 /**
@@ -1935,7 +1936,7 @@ static int snd_pcm_link(struct snd_pcm_s
 		res = -ENOMEM;
 		goto _nolock;
 	}
-	down_write_nonblock(&snd_pcm_link_rwsem);
+	down_write_nonfifo(&snd_pcm_link_rwsem);
 	write_lock_irq(&snd_pcm_link_rwlock);
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN ||
 	    substream->runtime->status->state != substream1->runtime->status->state ||
@@ -1982,7 +1983,7 @@ static int snd_pcm_unlink(struct snd_pcm
 	struct snd_pcm_substream *s;
 	int res = 0;
 
-	down_write_nonblock(&snd_pcm_link_rwsem);
+	down_write_nonfifo(&snd_pcm_link_rwsem);
 	write_lock_irq(&snd_pcm_link_rwlock);
 	if (!snd_pcm_stream_linked(substream)) {
 		res = -EALREADY;


