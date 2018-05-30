Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753705AbeE3Lqq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:46:46 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60658 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751765AbeE3LG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:06:57 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Adam Goode" <agoode@google.com>,
        "Takashi Iwai" <tiwai@suse.de>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.35827910@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 015/153] ALSA: seq: correctly detect input buffer overflow
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Adam Goode <agoode@google.com>

commit 21fd3e956ee8a307a06bc6e095f5767a00eb2a7e upstream.

snd_seq_event_dup returns -ENOMEM in some buffer-full conditions,
but usually returns -EAGAIN. Make -EAGAIN trigger the overflow
condition in snd_seq_fifo_event_in so that the fifo is cleared
and -ENOSPC is returned to userspace as stated in the alsa-lib docs.

Signed-off-by: Adam Goode <agoode@google.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/seq/seq_fifo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/core/seq/seq_fifo.c
+++ b/sound/core/seq/seq_fifo.c
@@ -127,7 +127,7 @@ int snd_seq_fifo_event_in(struct snd_seq
 	snd_use_lock_use(&f->use_lock);
 	err = snd_seq_event_dup(f->pool, event, &cell, 1, NULL); /* always non-blocking */
 	if (err < 0) {
-		if (err == -ENOMEM)
+		if ((err == -ENOMEM) || (err == -EAGAIN))
 			atomic_inc(&f->overflow);
 		snd_use_lock_free(&f->use_lock);
 		return err;
