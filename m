Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrR2308uaeSNtwUVz9Z6UvDjd/xxkLgIX5JULS2I0pi2CSfidY6PB7J4BzaOygRtxmyhXh5
ARC-Seal: i=1; a=rsa-sha256; t=1526280668; cv=none;
        d=google.com; s=arc-20160816;
        b=dHWqMjf0+GrbZXsck6GQgDyh747E5W7Q+gZWyezBO1M+rH9grLU03Z5XNGfcGWFAn/
         4Udy/I4nN3W8dFYzaLOvFSxEzYV2WJeGQ+xe2onSYb9WerxYN0ATIBf60pRCEFr5TLCh
         Tiphun4N+YONW/Yc6P4qXYimEjPGmirm0NzeYl7+vNL7jhagGwJoX5Zk/5WCof/O5RTA
         zi17TdKiXBg7vQ2AF6nQq/xJ+sKIiWLgtPzgbplP4+nmZxh+xr9B1Tg9Tbl8Jbpy2BiJ
         am4WY6wTEYKQ+4E9CmsVeI+6EAsA8Cu1qu50nZcL2M/yy8CowxJ00uhJTvGNgOF3IoxD
         XzdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=R/vljVRSEqJBoX9TUyiqQQaOSfgybLGJMgZeOz5eoZ8=;
        b=W2UOi9kl+2sK2shaoDmZ2MRgd2bExQnLNVVC3lGCB/6A/6FsIkytGi0QHC0CvByJfk
         6KwLPxavz/oJkGR8nXT/J9Pp89n/H3zYdnNe/uWs8eWzyrucKqK5IuIa2CtWz+ZOpWSV
         m0gza198y6IOr1qu+oJhPAm30FnVYEVYJGzyc18CEPnEnIPODrIIrrmNc+neahSDsTZ5
         oO8N9DHgRi+J0aEBwgSQmhW6qPWdAx6RsKKplxY2xh77y82QC1d1RA3JHO4uMqX7lukG
         toug94fNXgi8PssbhO+smg37mnHbkgOXOweu6qQ0DFAwOwRU9u2sEtElZkWXYuGn5BoN
         0j5A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TZfk0a3X;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TZfk0a3X;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	DaeRyong Jeong <threeearcat@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 13/56] ALSA: seq: Fix races at MIDI encoding in snd_virmidi_output_trigger()
Date: Mon, 14 May 2018 08:48:18 +0200
Message-Id: <20180514064756.323603786@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421213805070323?=
X-GMAIL-MSGID: =?utf-8?q?1600421278536961649?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
