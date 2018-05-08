Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpDpqZT8sGGIbQlEsWE0bf5l5VLgVely/ptpuYtvC9oNomHN922i9SGOJXapdL4WTQCKZyD
ARC-Seal: i=1; a=rsa-sha256; t=1525767440; cv=none;
        d=google.com; s=arc-20160816;
        b=cgfydwtoC5di7SAL1rHJNyY151IGEwMFNBtPQiEbR5t2FjWIpQXEt430TW1zJQHFZY
         ps/8v+bcmmuCNKtpSHRkf3mqnB7vcDtaKexwqAjjQihGGIprrn2NZF639zwTZJHUJV6Z
         AJ/zU39w9A8hlYalIo+LH7mFHj/5ptHq+4a2astFxjd0iLTB4UTvakpM3ZLAAFl0qN5l
         +q7/4SOr3fmMNLRLrM8ZSSqt3rKV1tYn6gSYmHIOV6rLf3V+09nVBYgnJ3JMDNmUzFxt
         8jO5BGaYd1Vtdq7QyOH3NDyoYN7+od4P2ORf02fdS3DoVY+GOW6rqo39n+/h39mbrWgB
         Z+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=jOSHbgu2Znh1pvZLsbGI+27HuphrXToLtds0XbsGkdc=;
        b=jtbukwwF7ieiS589HDicBPgfF68+z5UDmuGWuoSB3Qd/eZFYV5RxvAKC4yJLkT0iwj
         CKQIoGmq0qvAuVPIB6NUbFvTwrgat/7VcIyIMqBFV2vHcZLW3Fuel3avp0J7MUXippCz
         zYSdmqGBkrY75E1N/dZ12wSbnBAjDRf5K9H3/9Oy/dH5aRUqRsu4DDXGH917f//nMqZJ
         sRSXpFEZCRRFCoWY4uYpsri9pY0tHyOMo617cZ57WndLveOGouE62cQVbZLymO5sELr0
         3/nrj/c1IdL9QBJXt4u2WL2pdOsrd0+zchEE2BIbazbYF7Ieq+gVeZey/1BtqyhVBodg
         9Ebw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qPaJ9vxI;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=qPaJ9vxI;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	DaeRyong Jeong <threeearcat@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 09/32] ALSA: seq: Fix races at MIDI encoding in snd_virmidi_output_trigger()
Date: Tue,  8 May 2018 10:10:49 +0200
Message-Id: <20180508074010.330421454@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882788133987558?=
X-GMAIL-MSGID: =?utf-8?q?1599883119447133876?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 8f22e52528cc372b218b5f100457469615c733ce upstream.

The sequencer virmidi code has an open race at its output trigger
callback: namely, virmidi keeps only one event packet for processing
while it doesn't protect for concurrent output trigger calls.

snd_virmidi_output_trigger() tries to process the previously
unfinished event before starting encoding the given MIDI stream, but
this is done without any lock.  Meanwhile, if another rawmidi stream
starts the output trigger, this proceeds further, and overwrites the
event package that is being processed in another thread.  This
eventually corrupts and may lead to the invalid memory access if the
event type is like SYSEX.

The fix is just to move the spinlock to cover both the pending event
and the new stream.

The bug was spotted by a new fuzzer, RaceFuzzer.

BugLink: http://lkml.kernel.org/r/20180426045223.GA15307@dragonet.kaist.ac.kr
Reported-by: DaeRyong Jeong <threeearcat@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/seq/seq_virmidi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/core/seq/seq_virmidi.c
+++ b/sound/core/seq/seq_virmidi.c
@@ -174,12 +174,12 @@ static void snd_virmidi_output_trigger(s
 			}
 			return;
 		}
+		spin_lock_irqsave(&substream->runtime->lock, flags);
 		if (vmidi->event.type != SNDRV_SEQ_EVENT_NONE) {
 			if (snd_seq_kernel_client_dispatch(vmidi->client, &vmidi->event, in_atomic(), 0) < 0)
-				return;
+				goto out;
 			vmidi->event.type = SNDRV_SEQ_EVENT_NONE;
 		}
-		spin_lock_irqsave(&substream->runtime->lock, flags);
 		while (1) {
 			count = __snd_rawmidi_transmit_peek(substream, buf, sizeof(buf));
 			if (count <= 0)
