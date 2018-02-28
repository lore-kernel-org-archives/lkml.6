Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519836158-2-13913790443589406507
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519836157; b=mDMq4nmvbsMuwlzoYrGV2Rm+pt88DkzJ5w8ksMjIll9AEVG
    I0Fp5dXhSM0DyeMK5Az1Zg77SwwEd1m2f5lEcfcmBmV6VTCPeht/6+3r6BBrZw0n
    mxG8XBtAs4ZdETsIw8EhLrkaMyWZokppZw8Z9GCjFiV936Qr5+6Sm+k3Kj78hvZe
    +Xx3/t7nsol53LhB0QiaAERuvVPwxvNoXdNYOkWk6/tagPJ1GahVAhHLIZVcaKu5
    mnmFDwQaRDufiegGn3NFM5pn4DmQQBXAoWBDH00TvPlLAupx8/0dPLAs+qj+VMlW
    Y5AmYKgGXOvFK8pLsBl6nprsLjcnfhMrFXWmZDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836157; bh=3HIowupGOGTgMdjaOsr
    eQU90i/f3wXVQCxxXRwVtFcw=; b=txY2q5Q1iYRwJxzVbG9j7vCotagznvD89QY
    NOZVUOwORVWA+tTeYQQphO9Dktb0IO968etYFApmEK7ZNrqeSoXvOGpa9i+ld+0V
    wZ51ZFUFDNywa8qpsZFTisXk3eALmlWHHhkXX0p0lpevQSopkJSzwNHuVSP3sDh7
    10Lc1xvKZStcGM7+H9NxoGIffqcMV3M/ygV+AJZxeIuC5SyqnwKbDlWUInmztdxS
    /5w0mrhlYnXvFvwktDWkFbzWjEQd+iHaGU/8l4cQ0frU/ui6oeeeeQm1fZNivU8x
    633eYn762jZibIPJwY3Er3RJruS565Ji9hS4sA0nnsNXq+dl2UA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753266AbeB1QmZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:42:25 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34762 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932854AbeB1QDW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:03:22 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.456703498@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 182/254] ALSA: pcm: Allow aborting mutex lock at OSS
 read/write loops
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 900498a34a3ac9c611e9b425094c8106bdd7dc1c upstream.

PCM OSS read/write loops keep taking the mutex lock for the whole
read/write, and this might take very long when the exceptionally high
amount of data is given.  Also, since it invokes with mutex_lock(),
the concurrent read/write becomes unbreakable.

This patch tries to address these issues by replacing mutex_lock()
with mutex_lock_interruptible(), and also splits / re-takes the lock
at each read/write period chunk, so that it can switch the context
more finely if requested.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/core/oss/pcm_oss.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1370,8 +1370,11 @@ static ssize_t snd_pcm_oss_write1(struct
 
 	if ((tmp = snd_pcm_oss_make_ready(substream)) < 0)
 		return tmp;
-	mutex_lock(&runtime->oss.params_lock);
 	while (bytes > 0) {
+		if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
+			tmp = -ERESTARTSYS;
+			break;
+		}
 		if (bytes < runtime->oss.period_bytes || runtime->oss.buffer_used > 0) {
 			tmp = bytes;
 			if (tmp + runtime->oss.buffer_used > runtime->oss.period_bytes)
@@ -1415,18 +1418,18 @@ static ssize_t snd_pcm_oss_write1(struct
 			xfer += tmp;
 			if ((substream->f_flags & O_NONBLOCK) != 0 &&
 			    tmp != runtime->oss.period_bytes)
-				break;
+				tmp = -EAGAIN;
 		}
+ err:
+		mutex_unlock(&runtime->oss.params_lock);
+		if (tmp < 0)
+			break;
 		if (signal_pending(current)) {
 			tmp = -ERESTARTSYS;
-			goto err;
+			break;
 		}
+		tmp = 0;
 	}
-	mutex_unlock(&runtime->oss.params_lock);
-	return xfer;
-
- err:
-	mutex_unlock(&runtime->oss.params_lock);
 	return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
 }
 
@@ -1474,8 +1477,11 @@ static ssize_t snd_pcm_oss_read1(struct
 
 	if ((tmp = snd_pcm_oss_make_ready(substream)) < 0)
 		return tmp;
-	mutex_lock(&runtime->oss.params_lock);
 	while (bytes > 0) {
+		if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
+			tmp = -ERESTARTSYS;
+			break;
+		}
 		if (bytes < runtime->oss.period_bytes || runtime->oss.buffer_used > 0) {
 			if (runtime->oss.buffer_used == 0) {
 				tmp = snd_pcm_oss_read2(substream, runtime->oss.buffer, runtime->oss.period_bytes, 1);
@@ -1506,16 +1512,16 @@ static ssize_t snd_pcm_oss_read1(struct
 			bytes -= tmp;
 			xfer += tmp;
 		}
+ err:
+		mutex_unlock(&runtime->oss.params_lock);
+		if (tmp < 0)
+			break;
 		if (signal_pending(current)) {
 			tmp = -ERESTARTSYS;
-			goto err;
+			break;
 		}
+		tmp = 0;
 	}
-	mutex_unlock(&runtime->oss.params_lock);
-	return xfer;
-
- err:
-	mutex_unlock(&runtime->oss.params_lock);
 	return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
 }
 
