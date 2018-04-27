Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757252AbeD0BtI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 21:49:08 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34642 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756854AbeD0BtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 21:49:07 -0400
X-Google-Smtp-Source: AB8JxZoJTJ/5QstcZpi2X+jprlCZyjn88szGDtCHqCJCPj2x4x+CcyJkxl0hNZz5N/0aPvP2KypamA==
Date: Fri, 27 Apr 2018 10:48:59 +0900
From: DaeRyong Jeong <threeearcat@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, alsa-devel@alsa-project.org, kt0755@gmail.com,
        bammanag@purdue.edu, byoungyoung@purdue.edu,
        linux-kernel@vger.kernel.org
Subject: Re: Unable to handle kernel paging request in snd_seq_oss_readq_puts
Message-ID: <20180427014858.GA23026@dragonet.kaist.ac.kr>
References: <20180426045223.GA15307@dragonet.kaist.ac.kr>
 <s5h1sf2v3l2.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h1sf2v3l2.wl-tiwai@suse.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 09:17:45AM +0200, Takashi Iwai wrote:
> On Thu, 26 Apr 2018 06:52:27 +0200,
> DaeRyong Jeong wrote:
> > 
> > We report the crash:
> > unable to handle kernel paging request in snd_seq_oss_readq_puts
> > 
> > This crash has been found in v4.16 using RaceFuzzer (a modified
> > version of Syzkaller), which we describe more at the end of this
> > report. Our analysis shows that the race occurs when invoking two
> > syscalls concurrently, write$eventfd and write$sndseq.
> > 
> > Analysis:
> > We think the concurrent execution of snd_virmidi_output_trigger() and
> > snd_midi_event_encode_byte() causes the crash. Since the first call site
> > of snd_seq_kernel_client_dispatch() in snd_virmidi_output_trigger() is not
> > protected by substream->runtime->lock, it is possible that
> > snd_seq_oss_readq_puts() and snd_midi_event_encode_byte() are executed
> > concurrently in the call sequences as below, and snd_seq_oss_readq_puts()
> > accesses ev->data.ex.ptr before it is initialized.
> 
> Thanks for the bug report and analysis.
> 
> I guess that it's not about initialization but rather other way
> round.  The first task sends the pending event with SYSEX that
> contains the buffer pointer in the event packet.  Meanwhile, the
> second task now starts processing the MIDI stream and overwrites this
> event packet.  So the data address that is being processed is
> overwritten, and it leads to the crash.
> 
> Below is the fix patch.  It's totally untested, and I'd love to hear
> if this really works.  Could you give it a try?
> 
> 
> thanks,
> 
> Takashi
> 
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: seq: Fix races at MIDI encoding in
>  snd_virmidi_output_trigger()
> 
> The sequencer virmidi code has an open race at its output trigger
> callback: namely, virmidi keeps only one event packet for processing
> while it doesn't protect for concurrent output trigger calls.
> 
> snd_virmidi_output_trigger() tries to process the previously
> unfinished event before starting encoding the given MIDI stream, but
> this is done without any lock.  Meanwhile, if another rawmidi stream
> starts the output trigger, this proceeds further, and overwrites the
> event package that is being processed in another thread.  This
> eventually corrupts and may lead to the invalid memory access if the
> event type is like SYSEX.
> 
> The fix is just to move the spinlock to cover both the pending event
> and the new stream.
> 
> The bug was spotted by a new fuzzer, RaceFuzzer.
> 
> BugLink: http://lkml.kernel.org/r/20180426045223.GA15307@dragonet.kaist.ac.kr
> Reported-by: DaeRyong Jeong <threeearcat@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/seq/seq_virmidi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/core/seq/seq_virmidi.c b/sound/core/seq/seq_virmidi.c
> index f48a4cd24ffc..289ae6bb81d9 100644
> --- a/sound/core/seq/seq_virmidi.c
> +++ b/sound/core/seq/seq_virmidi.c
> @@ -174,12 +174,12 @@ static void snd_virmidi_output_trigger(struct snd_rawmidi_substream *substream,
>  			}
>  			return;
>  		}
> +		spin_lock_irqsave(&substream->runtime->lock, flags);
>  		if (vmidi->event.type != SNDRV_SEQ_EVENT_NONE) {
>  			if (snd_seq_kernel_client_dispatch(vmidi->client, &vmidi->event, in_atomic(), 0) < 0)
> -				return;
> +				goto out;
>  			vmidi->event.type = SNDRV_SEQ_EVENT_NONE;
>  		}
> -		spin_lock_irqsave(&substream->runtime->lock, flags);
>  		while (1) {
>  			count = __snd_rawmidi_transmit_peek(substream, buf, sizeof(buf));
>  			if (count <= 0)
> -- 
> 2.16.3
> 

I'm really sorry to say this. Since we are implementing our fuzzer and 
our reproducer is not complete, we don't have a reproducer for this bug.
We manually analyzed the crash using the crash log to spot where the race
occurs.
The patch looks good for me who don't understand the ALSA subsystem, but
we can't test the patch.

I'm sorry.

Daeryong Jeong
