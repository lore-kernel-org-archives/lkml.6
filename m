Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034296AbeE1K06 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034259AbeE1K0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:26:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 007/329] ALSA: timer: Fix pause event notification
Date: Mon, 28 May 2018 11:58:56 +0200
Message-Id: <20180528100242.720040019@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

commit 3ae180972564846e6d794e3615e1ab0a1e6c4ef9 upstream.

Commit f65e0d299807 ("ALSA: timer: Call notifier in the same spinlock")
combined the start/continue and stop/pause functions, and in doing so
changed the event code for the pause case to SNDRV_TIMER_EVENT_CONTINUE.
Change it back to SNDRV_TIMER_EVENT_PAUSE.

Fixes: f65e0d299807 ("ALSA: timer: Call notifier in the same spinlock")
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: stable@vger.kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/timer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -547,7 +547,7 @@ static int snd_timer_stop1(struct snd_ti
 	else
 		timeri->flags |= SNDRV_TIMER_IFLG_PAUSED;
 	snd_timer_notify1(timeri, stop ? SNDRV_TIMER_EVENT_STOP :
-			  SNDRV_TIMER_EVENT_CONTINUE);
+			  SNDRV_TIMER_EVENT_PAUSE);
  unlock:
 	spin_unlock_irqrestore(&timer->lock, flags);
 	return result;
@@ -569,7 +569,7 @@ static int snd_timer_stop_slave(struct s
 		list_del_init(&timeri->ack_list);
 		list_del_init(&timeri->active_list);
 		snd_timer_notify1(timeri, stop ? SNDRV_TIMER_EVENT_STOP :
-				  SNDRV_TIMER_EVENT_CONTINUE);
+				  SNDRV_TIMER_EVENT_PAUSE);
 		spin_unlock(&timeri->timer->lock);
 	}
 	spin_unlock_irqrestore(&slave_active_lock, flags);
