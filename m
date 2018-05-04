Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbeEDP23 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:28:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41202 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEDP22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:28:28 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: alsa-devel@alsa-project.org
Cc: tglx@linutronix.de, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] ALSA: pcm: Hide local_irq_disable/enable() and local_irqsave/restore()
Date: Fri,  4 May 2018 17:28:10 +0200
Message-Id: <20180504152810.7220-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

The snd_pcm_stream_lock_irq*() functions decouple disabling interrupts
from the actual locking process. This does not work as expected if the
locking primitives are replaced like on preempt-rt.

Provide one function for locking which uses correct locking primitives.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 sound/core/pcm_native.c | 85 +++++++++++++++++++++++++++--------------
 1 file changed, 57 insertions(+), 28 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index d18b3982548b..92c10fc838e9 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -99,6 +99,57 @@ static inline void down_write_nonblock(struct rw_semapho=
re *lock)
 		cond_resched();
 }
=20
+#define PCM_LOCK_DEFAULT	0
+#define PCM_LOCK_IRQ	1
+#define PCM_LOCK_IRQSAVE	2
+
+static unsigned long __snd_pcm_stream_lock_mode(struct snd_pcm_substream *=
substream,
+						unsigned int mode)
+{
+	unsigned long flags =3D 0;
+	if (substream->pcm->nonatomic) {
+		down_read_nested(&snd_pcm_link_rwsem, SINGLE_DEPTH_NESTING);
+		mutex_lock(&substream->self_group.mutex);
+	} else {
+		switch (mode) {
+		case PCM_LOCK_DEFAULT:
+			read_lock(&snd_pcm_link_rwlock);
+			break;
+		case PCM_LOCK_IRQ:
+			read_lock_irq(&snd_pcm_link_rwlock);
+			break;
+		case PCM_LOCK_IRQSAVE:
+			read_lock_irqsave(&snd_pcm_link_rwlock, flags);
+			break;
+		}
+		spin_lock(&substream->self_group.lock);
+	}
+	return flags;
+}
+
+static void __snd_pcm_stream_unlock_mode(struct snd_pcm_substream *substre=
am,
+					 unsigned int mode, unsigned long flags)
+{
+	if (substream->pcm->nonatomic) {
+		mutex_unlock(&substream->self_group.mutex);
+		up_read(&snd_pcm_link_rwsem);
+	} else {
+		spin_unlock(&substream->self_group.lock);
+
+		switch (mode) {
+		case PCM_LOCK_DEFAULT:
+			read_unlock(&snd_pcm_link_rwlock);
+			break;
+		case PCM_LOCK_IRQ:
+			read_unlock_irq(&snd_pcm_link_rwlock);
+			break;
+		case PCM_LOCK_IRQSAVE:
+			read_unlock_irqrestore(&snd_pcm_link_rwlock, flags);
+			break;
+		}
+	}
+}
+
 /**
  * snd_pcm_stream_lock - Lock the PCM stream
  * @substream: PCM substream
@@ -109,13 +160,7 @@ static inline void down_write_nonblock(struct rw_semap=
hore *lock)
  */
 void snd_pcm_stream_lock(struct snd_pcm_substream *substream)
 {
-	if (substream->pcm->nonatomic) {
-		down_read_nested(&snd_pcm_link_rwsem, SINGLE_DEPTH_NESTING);
-		mutex_lock(&substream->self_group.mutex);
-	} else {
-		read_lock(&snd_pcm_link_rwlock);
-		spin_lock(&substream->self_group.lock);
-	}
+	__snd_pcm_stream_lock_mode(substream, PCM_LOCK_DEFAULT);
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stream_lock);
=20
@@ -127,13 +172,7 @@ EXPORT_SYMBOL_GPL(snd_pcm_stream_lock);
  */
 void snd_pcm_stream_unlock(struct snd_pcm_substream *substream)
 {
-	if (substream->pcm->nonatomic) {
-		mutex_unlock(&substream->self_group.mutex);
-		up_read(&snd_pcm_link_rwsem);
-	} else {
-		spin_unlock(&substream->self_group.lock);
-		read_unlock(&snd_pcm_link_rwlock);
-	}
+	__snd_pcm_stream_unlock_mode(substream, PCM_LOCK_DEFAULT, 0);
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stream_unlock);
=20
@@ -147,9 +186,7 @@ EXPORT_SYMBOL_GPL(snd_pcm_stream_unlock);
  */
 void snd_pcm_stream_lock_irq(struct snd_pcm_substream *substream)
 {
-	if (!substream->pcm->nonatomic)
-		local_irq_disable();
-	snd_pcm_stream_lock(substream);
+	__snd_pcm_stream_lock_mode(substream, PCM_LOCK_IRQ);
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stream_lock_irq);
=20
@@ -161,19 +198,13 @@ EXPORT_SYMBOL_GPL(snd_pcm_stream_lock_irq);
  */
 void snd_pcm_stream_unlock_irq(struct snd_pcm_substream *substream)
 {
-	snd_pcm_stream_unlock(substream);
-	if (!substream->pcm->nonatomic)
-		local_irq_enable();
+	__snd_pcm_stream_unlock_mode(substream, PCM_LOCK_IRQ, 0);
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stream_unlock_irq);
=20
 unsigned long _snd_pcm_stream_lock_irqsave(struct snd_pcm_substream *subst=
ream)
 {
-	unsigned long flags =3D 0;
-	if (!substream->pcm->nonatomic)
-		local_irq_save(flags);
-	snd_pcm_stream_lock(substream);
-	return flags;
+	return __snd_pcm_stream_lock_mode(substream, PCM_LOCK_IRQSAVE);
 }
 EXPORT_SYMBOL_GPL(_snd_pcm_stream_lock_irqsave);
=20
@@ -187,9 +218,7 @@ EXPORT_SYMBOL_GPL(_snd_pcm_stream_lock_irqsave);
 void snd_pcm_stream_unlock_irqrestore(struct snd_pcm_substream *substream,
 				      unsigned long flags)
 {
-	snd_pcm_stream_unlock(substream);
-	if (!substream->pcm->nonatomic)
-		local_irq_restore(flags);
+	__snd_pcm_stream_unlock_mode(substream, PCM_LOCK_IRQSAVE, flags);
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stream_unlock_irqrestore);
=20
--=20
2.17.0
