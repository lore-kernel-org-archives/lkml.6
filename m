Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118B9C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74422077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74422077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbeJNXij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:38:39 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37586 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727813AbeJNXii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:38:38 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM9-0004cS-Dn; Sun, 14 Oct 2018 16:31:01 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLQ-0000GK-CR; Sun, 14 Oct 2018 16:30:16 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        syzbot+8e62ff4e07aa2ce87826@syzkaller.appspotmail.com,
        "Takashi Iwai" <tiwai@suse.de>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.643402943@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 091/366] ALSA: pcm: Fix UAF at PCM release via PCM
 timer access
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit a820ccbe21e8ce8e86c39cd1d3bc8c7d1cbb949b upstream.

The PCM runtime object is created and freed dynamically at PCM stream
open / close time.  This is tracked via substream->runtime, and it's
cleared at snd_pcm_detach_substream().

The runtime object assignment is protected by PCM open_mutex, so for
all PCM operations, it's safely handled.  However, each PCM substream
provides also an ALSA timer interface, and user-space can access to
this while closing a PCM substream.  This may eventually lead to a
UAF, as snd_pcm_timer_resolution() tries to access the runtime while
clearing it in other side.

Fortunately, it's the only concurrent access from the PCM timer, and
it merely reads runtime->timer_resolution field.  So, we can avoid the
race by reordering kfree() and wrapping the substream->runtime
clearance with the corresponding timer lock.

Reported-by: syzbot+8e62ff4e07aa2ce87826@syzkaller.appspotmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/pcm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -28,6 +28,7 @@
 #include <sound/core.h>
 #include <sound/minors.h>
 #include <sound/pcm.h>
+#include <sound/timer.h>
 #include <sound/control.h>
 #include <sound/info.h>
 
@@ -1002,8 +1003,13 @@ void snd_pcm_detach_substream(struct snd
 #ifdef CONFIG_SND_PCM_XRUN_DEBUG
 	kfree(runtime->hwptr_log);
 #endif
-	kfree(runtime);
+	/* Avoid concurrent access to runtime via PCM timer interface */
+	if (substream->timer)
+		spin_lock_irq(&substream->timer->lock);
 	substream->runtime = NULL;
+	if (substream->timer)
+		spin_unlock_irq(&substream->timer->lock);
+	kfree(runtime);
 	put_pid(substream->pid);
 	substream->pid = NULL;
 	substream->pstr->substream_opened--;

