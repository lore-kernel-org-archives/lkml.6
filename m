Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqG/aT8qTXhVx96Tvki9fAqfRl2EK8yVLxqlqD8sGT1XsQzhZ1wf0XFkxR6DarWFjudxvUL
ARC-Seal: i=1; a=rsa-sha256; t=1526280606; cv=none;
        d=google.com; s=arc-20160816;
        b=F4a2sl1pFO7BrftbmUzgBdfd/cfcVkbvPTONt1MDuMdTZNxGoItPBI1zXQwH8rFZxI
         fcHUuF/8YEQCm0a7rhr7Z4ZSp6jQ9dHD3wAjJkzo/362YZHuCnLSY7pc6rS3vHzBjmJP
         CjBumWmRo12tsiWNflo9DTBF2gSJnTb5PV1RWynj+G3fj5e6fz6XEVPGn0MiCWRvTzpj
         rwUMNW/nHp9nMeFeJsIziuKInTH5HX4nZwbKakqEQIRr5TCPAEU4+ZD9QbZ6dIUMO3R/
         btegx05+NqMwxlRO/zRFdEFrmSsRZygwNV7sI1QxJ1sF32PMsNIPF7ZvYCfYFdcRL+lB
         4qdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=1ye0rHM9oDSBDvjsMlIe7pPMfqT09D9Oi7zoexmArEg=;
        b=Aiu3/meIh8syn1KPy4owqWBf7rSOYvM/lipUCLthlSrn8QoJEoYX2AWNCmaY7cr+TT
         o5L79PaWWvvoCAaeCkFc7ZbzbU8t7Wfpw/J3aEwnADWWUK+7kpyK9XDJK0WE6wuSjmdx
         CFRx0k41IsYamwFedXXHS7sALed1QAG2CWQOPhg0IB9Zxlk/vdjkXWIgZkG4U2hLr2Q7
         Sfx4/5fUGrbhcZLJbtQQJAnfulpT06hfuPjPcvTGRw7tNp2KiokMbDS+zh1u63Zv7jbT
         xVVjc8WShBxSjCTfieG6F4dI0Sd4ywILlt3DfjQGAc+u2u2OojMhGd21eMN9vCeTKXYm
         FGmw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=FECJo41e;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=FECJo41e;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	DaeRyong Jeong <threeearcat@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 05/23] ALSA: seq: Fix races at MIDI encoding in snd_virmidi_output_trigger()
Date: Mon, 14 May 2018 08:48:34 +0200
Message-Id: <20180514064704.287680554@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064704.046463679@linuxfoundation.org>
References: <20180514064704.046463679@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421213805070323?=
X-GMAIL-MSGID: =?utf-8?q?1600421213805070323?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
