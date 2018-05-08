Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqyAh9hu8f21fme+ZKVnbYM8k69Ty0cf8VEGo9MrmkvWzRjKMD34rcN8A6BqS+3wwoXn+XE
ARC-Seal: i=1; a=rsa-sha256; t=1525767282; cv=none;
        d=google.com; s=arc-20160816;
        b=dTSbly7ogmlor0j97EdI7QCFGR256zn9JY6JVQLsNjSkgl4alvCcf74Tk7XIYL4kdx
         +Hc7DC5ly9pRdtcKwfAORjZyx19l6rQMXgNK9HFNBhD+CLbM1twpK3Xju9tnnhiC1NnE
         xB+8JklbAm3/WhTGlQie0M3g7c2TBsJOr+d0EW2UTKqdNudBtEJ5pD3I2DkSfczclSI0
         yT/L4+zULdTbCFQI0QzlAGh46TNqzKUDi27buFoxZqhLyQkA10QFnxd10wRBRJP66sDZ
         Cv2Chs9R+lf2wqvYWvrQKM3YgOHShtpuFt20KMYAU2StbcGNFCrXKdM68D+jEcZY/Ub/
         HLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Yktpmr/G2GG36ojIGqS9BNaloENB5IRHp9pRJtmjl24=;
        b=hrkyp5NMYwd84nP2OzT0TPYB3sF5S2fdkr+Y+rtcZNMchRZccZTvLISKqIAaNTLoi3
         5EEnrldm2O5JWb/qI/DP3vQdrjEiNFHOg3wwuChBGdl8aP9rXppRWw2VYUTnoB3StzOc
         K9DccauKM5/Rzhk6bbJUu3d9uAUab6nd6m7a7k8xmDLHIFXkl4JoEe8nUFYDc+eJck/C
         6p465+6m/eYtH3Sdw8k5enRB1REah4SfW5K68DYzi9+C8W3Se5sDK6YGjftDSQVWRVEX
         GiXhLk9j4BHduzS/zDbfyzgFi0+Kih15+X3rUCIRSAMbwNSu5lkLJCee9nljhx1UkCpb
         cmTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=n07dnfsP;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=n07dnfsP;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	DaeRyong Jeong <threeearcat@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 09/43] ALSA: seq: Fix races at MIDI encoding in snd_virmidi_output_trigger()
Date: Tue,  8 May 2018 10:10:28 +0200
Message-Id: <20180508074005.429935815@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882788133987558?=
X-GMAIL-MSGID: =?utf-8?q?1599882954744226598?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
