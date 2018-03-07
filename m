Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4025272-1520451901-2-16020675158554896754
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520451901; b=G/FWGBbeMSWESekah+4lHwbTEL9TX28UIgNs1LlKPGjleQ3
    bozkQvFExs0v0mluLE4GGI8z5HqK0JAj9R1iYfG+r+rKS7dBjGBv+OQajswQr5wT
    htTyOVPmRQV2zs8rPB+KK+ktW6Ww3tjr0hzbBKVbl269SFvJV9SHO43vyzpDAxdC
    Cu1YRCZ0VXiwDJqElVehz8/A9aB0oy92RRXLWIR0Vgqyyibp98jEqw2TyL/ovge+
    jlsGVyNxwlwIs0ieWoftE2XHM/beoP/uHvfu/fAuYG105Tt+ELtYwhg3tFEl2PuW
    phds+Qy34j/WSv7HVf48XUOdqNsQ1Ie3LOjPOBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520451901; bh=qe//PYxLKMQqgNJBZFtNQhmJWr
    2pOFMZXZGqniaK0NY=; b=EYtQYJH6LIZHALhVAvr7gx9VattvoivedhO1FkIEj7
    cIUPbWBFCQCFNzCABG1btyYNNbzCKiBrLO5tN4gZuOsNnYLMQNDAkdfgV8sbATsX
    alLTn7EGuaSjLU40NjrMa/ORPueUtmkFgOHnxVXzltI6jaegvF/5IY6zvtgPhS7i
    1wJhI4hcqvnwmpYsbV8PloQsL7PxQNP5jTx/2o/OtkWqcp2QLxTffLo04fmYFQr5
    cmXy0bnpSlPhEWOnvcAvoWn6VddEE7juiFfnmRUeYKJOnoLIY7kcMH8VtSr4FLSj
    bXby4Xiy/gYZjXOcJso8FCrWibDS/QpWSxvKcZP1RNaw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965186AbeCGTo5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:44:57 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:43984 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965182AbeCGToy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:44:54 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 012/110] ALSA: x86: Fix missing spinlock and mutex initializations
Date: Wed,  7 Mar 2018 11:37:55 -0800
Message-Id: <20180307191041.291642482@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 350144069abf351c743d766b2fba9cb9b7cd32a1 upstream.

The commit change for supporting the multiple ports moved involved
some code shuffling, and there the initializations of spinlock and
mutex in snd_intelhad object were dropped mistakenly.

This patch adds the missing initializations again for each port.

Fixes: b4eb0d522fcb ("ALSA: x86: Split snd_intelhad into card and PCM specific structures")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/x86/intel_hdmi_audio.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1827,6 +1827,8 @@ static int hdmi_lpe_audio_probe(struct p
 		ctx->port = port;
 		ctx->pipe = -1;
 
+		spin_lock_init(&ctx->had_spinlock);
+		mutex_init(&ctx->mutex);
 		INIT_WORK(&ctx->hdmi_audio_wq, had_audio_wq);
 
 		ret = snd_pcm_new(card, INTEL_HAD, port, MAX_PB_STREAMS,
