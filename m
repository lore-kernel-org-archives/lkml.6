Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuUi6EMmK/0OGCedQdNuOycbbQuTEuSRhebthDWXQUiGVwPrL7uqbH/fKA1RNNKKwfLJ1xw
ARC-Seal: i=1; a=rsa-sha256; t=1520451596; cv=none;
        d=google.com; s=arc-20160816;
        b=paWf3MaPAGBpPHUOKrisLFHGv8rZrC57U82jTGUuKUfkQykJLKAfqVF8nJFKrww+yC
         U3IBHC0gfS8tCoqOcdLV9z80guEefnj6Oemj5ZJ+8slqPKLDYz39Wj0yoFNAnzSoE8yh
         N5l/ssPMf3Ks+++iq3PBh2MTQCSVJRNOaoKtopHTBVXqRpBpJl3WtynVZpi0nqOr8hAp
         edwO+XNA6xIHYohNOUx/nYyraKnt3T9JbhLDFAjf4qnJXZyWPTa733dfXbw46s9Fxjv9
         3SwJabU4eysSnuF2MggDxMKX6K7mB6nGv97pMrPSGEcr4IcQytF0iKXHWlV7+0hxD5vj
         iEiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NnnRudTh57P7hbpXOTWVQ4ULqY/h+JIo2YyJtYCe1GI=;
        b=Z+PqU0x8TzrItiDkN/CkeIEIHnLqHan+jZGJerBLN8L58V4ECj/3jEgpROK2WBedaY
         XhAOy7lFqanjIsdaIJQkUCVckdwxZfwfiRAIfoU8iVCP/FSVWwF9NVe70HumewL6AmrW
         fzBD+TcvUExyl2ldernwRSiaM5CB+/gH4PStsXIfKM+WNhTLhru+bGfSW8pM4cYnxvdV
         pvv0RQHvSdpGEudG2JmEikIdrxfqd5s9recLrcS5lTg6I6V4wq/pF8JHBcHyY4aHzg2Z
         4j3DetoHJc7mosEAPmdEdCjEjWiVL7uhYpdkGhFBrIZUk0Br56gTio5r0aqW6NhmRA7K
         EfrA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.15 015/122] ALSA: x86: Fix missing spinlock and mutex initializations
Date: Wed,  7 Mar 2018 11:37:07 -0800
Message-Id: <20180307191731.440623401@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309053271613885?=
X-GMAIL-MSGID: =?utf-8?q?1594309053271613885?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
