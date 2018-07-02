Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E56C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325312490F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 325312490F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752867AbeGBQab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:30:31 -0400
Received: from smtp1.de.adit-jv.com ([62.225.105.245]:45328 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbeGBQa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:30:29 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 92FCE3C09AC;
        Mon,  2 Jul 2018 18:30:27 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PzOysug6OwaE; Mon,  2 Jul 2018 18:30:19 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id CAE203C0160;
        Mon,  2 Jul 2018 18:30:19 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 2 Jul 2018
 18:30:19 +0200
Date:   Mon, 2 Jul 2018 18:30:13 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Julian Scheel <julian@jusst.de>
CC:     Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCHv2 3/3] usb: gadget: f_uac*: Support multiple sampling
 rates
Message-ID: <20180702162436.GA3496@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2333fe05-da2e-e6f6-931a-16fce2980f17@jusst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julian,

[CC:Takashi, since we are discussing sound-related parts of USB]

On Mon, Jul 02, 2018 at 04:07:19PM +0200, Julian Scheel wrote:
> Hi Eugeniu,
> 
> On 30.06.2018 20:16, Eugeniu Rosca wrote:
> > Would it be possible to revive the uac2 multiple sampling rate
> > patch-set [1] by rebasing it onto the most recent kernel? If you
> > don't have time for this, I could help you.
> 
> I have this on my todo-list for a while now... In fact I fixed the build
> errors reported by the robot last year, but didn't had the time to
> verify all of it and push again.
> Still, I'd be happy to get this merged, so I'll try to check the state
> of this within the next days and either post to the list or get back to
> you if more work needs to be done.

We've been living with an internally developed uac2 multiple rate
support since June 2015, initially written on top of v3.14. Due to
significant refactoring of uac2 driver brought by v4.13 commit [1], I
went through the comparison between the in-house implementation (which
no more applied cleanly to post-[1] vanilla) and your proposal from [2].

I found a lot things in common, but also a number of differences. The
latter were caused, as example, by internal requirements like:

---<-snip->---
When enabling multiple rates, the application must be aware of this and
needs to reconfigure the device according to the current assigned rate.
ALSA hw parameter refinement is dynamically limited to the actual
assigned rate, the application does not need to close the device on rate
change but just need to restart configuration (snd_pcm_hw_free(),
snd_pcm_hw_params_any()...). snd_hw_params_any() will always provide
the actual assigned rate.
---<-snip->---

The above frees the need for amixer notifications. A PoC/dirty patch
which makes `arecord` work according to this principle is shown in [3].
The way it was tested on our side is:

prereq > connect USB gadget port of H3-Salvator-X to Ubuntu PC
target > create uac2 gadget (scripted)
target > aplay -C -c 2 -r 48000 -f S16_LE -D plughw:UAC2Gadget \
       | aplay    -c 2 -r 48000 -f S16_LE -D entertainment_main
host   > ls -1 sample-*.wav
	sample-11025_hz.wav
	sample-16000_hz.wav
	sample-22000_hz.wav
	sample-32000_hz.wav
	sample-44100_hz.wav
	sample-48000_hz.wav
	sample-8000_hz.wav
	sample-96000_hz.wav
host   > aplay -D hw:<gadget-card-name> -c 2 sample-*.wav
target > Playback of all files is perceived on the target
         (alternatively, the gadget stream can be recorded and compared
	 to original wav files).

Another internal requirement defines the exact behavior of the
target/gadget, depending on the moment at which the host requests
the sample rate change (from gadget point of view):

---<-snip->---
 - If rate changes while refinement is not finished, the call
   to snd_pcm_prepare() will fail and user has to restart again.
 - If rate changes after prepare is done, but stream is not running,
   the call to snd_pcm_start() will fail and user has to restart again.
 - If rate changes while stream is running, it will be signaled as
   xrun (after providing pending frames on capture, as described above).
---<-snip->---

Due to these mentioned requirements, our final solution was a mix
between your and our approaches. I hope we can reach some
understanding what is best suitable for the regular users, so that at
least some core part of the feature is accepted in mainline.

Any comments from Takashi would be greatly appreciated.
I look forward for your re-based patches. Thank you.

Best regards,
Eugeniu.

[1] eb9fecb9e69b ("usb: gadget: f_uac2: split out audio core")
[2] https://lkml.org/lkml/2017/6/26/91 ("[PATCH 0/3] USB Audio Gadget: \
    Support multiple sampling rates")
[3] https://github.com/erosca/alsa-utils/commit/uac2_test
