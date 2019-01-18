Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A5FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92E52086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfARJob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:44:31 -0500
Received: from mail1.perex.cz ([77.48.224.245]:56018 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbfARJoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:44:30 -0500
X-Greylist: delayed 496 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Jan 2019 04:44:28 EST
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id F3820A003F;
        Fri, 18 Jan 2019 10:36:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz F3820A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1547804171; bh=ti7yUL0m7wtfC5n2oQVV/pTJXNgp+X6Oiw03dQgEj18=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P+8e8Qhn2JPWGfZ1QdbH4K0EMCtTlb7zkZQRBwv7k05YYN6eRaCeWdkLvL3+1YqyT
         G2MS85kUditDrC2lCRr8ojSlh7vpFBsqjHlXpaxrM7oPR07lCMQx6bsOHln5oqraLW
         sovk4rUq1yOkUmL8OwFO/dP1VXyfjlQTiNpOUtZo=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Fri, 18 Jan 2019 10:35:44 +0100 (CET)
Subject: Re: [RFC PATCH] ALSA: core: Add DMA share buffer support
To:     Baolin Wang <baolin.wang@linaro.org>, tiwai@suse.com,
        broonie@kernel.org, leo.yan@linaro.org
Cc:     sboyd@kernel.org, colyli@suse.de, corbet@lwn.net,
        mathieu.poirier@linaro.org, ckeepax@opensource.wolfsonmicro.com,
        mchehab+samsung@kernel.org, gustavo@embeddedor.com,
        joe@perches.com, vkoul@kernel.org, o-takashi@sakamocchi.jp,
        keescook@chromium.org, jmiller@neverware.com,
        anna-maria@linutronix.de, willy@infradead.org, sr@denx.de,
        bgoswami@codeaurora.org, philburk@google.com,
        srinivas.kandagatla@linaro.org, arnd@arndb.de,
        daniel.thompson@linaro.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz>
Date:   Fri, 18 Jan 2019 10:35:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 18.1.2019 v 05:55 Baolin Wang napsal(a):
> This patch adds dma share buffer support, which allows a dma-buf to be shared
> between processes by passing file descriptors between them, allowing multiple
> processes to cooperate in filling the DMA buffer used by the audio hardware
> without the need to copy data around. This reduces both latency and CPU load,
> especially in configurations where only one application is playing audio and
> so context switches can be avoided.
> 
> In userspace, we can use ioctl:SNDRV_PCM_IOCTL_DMABUF_EXPORT to export one
> dma buffer to a PCM, and use ioctl:SNDRV_PCM_IOCTL_DMABUF_ATTACH and
> ioctl:SNDRV_PCM_IOCTL_DMABUF_DETACH to attach or detach one device to the
> dma buffer. Morevoer we can use dma buffer ioctl:DMA_BUF_IOCTL_SYNC to
> guarantee the cache coherency of the DMA buffer.
> 
> You can refer to below patches [1] created by Leo Yan to use the dma buffer
> in userspace.
> 
> [1] https://github.com/tinyalsa/tinyalsa/pull/126
> 
> Welcome any comments. Thanks.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Hi,
> 
> Before sending to ALSA mailing list, we had some internal discussion off line,
> so I posted them to follow up.
> 
> 1. One issue proposed by Srinivas Kandagatla, he proposed one use case example:
> DSP1 pre-process(compress-to-pcm) the buffers, pass the fd to DSP2/audio-ip
> to play pcm data. The dmabuf exporter (DSP1) is a different device than
> audio device in this instance, so the DSP1 device cannot call
> snd_pcm_dmabuf_export() to export one dma buffer and pass to the DSP2/audio-ip.
> 
> Our original design is, the dma buffer should be associated with one PCM
> device, since different PCM devices may need different buffer types (see
> SNDRV_DMA_TYPE_XXX) to play PCM data, and need consider the PCM device's
> coherent capability for DMA memory. My concern is, if we let other
> non-audio device to allocate one buffer and export it, how to guarantee
> the dma buffer can be used by PCM device and have the same coherent capability
> with the PCM device.
> 
> So I am not sure for this issue and need more suggestion to get a consensus.
> 
> 2. Second question raised by Srinivas Kandagatla, he wondered:
> "Am still unclear on the whole idea making a audio device dmabuf exporter
> in Linux systems, unless you are sharing the dmabuf fd with other devices.
> 
> If you are working with just one device we could just live with mmap,
> isn't it?"
> 
> Mark Brown gave the answer:
> "The issue is permissions management. We've got a sound server that owns
> all the sound hardware and needs to be able to retain administrative control
> over it which means that permissions for the sound devices are locked down to
> it. For performance reasons on systems where it's practical (eg, where there's
> multiple audio streams the system can use to play data to the hardware) we
> want to be able to have that server allow other applications with lower
> permissions to stream data to/from the hardware without going through it. The
> applications can't mmap() the device directly as that's too painful to do that
> securely from a permission management point of view so we want to be able to
> have the sound server do the mmap() then hand the mapped buffer off to the
> application for it to use via a FD over a pipe. That way the only thing with
> direct access to the devices is the sound server but the clients have a data
> path that doesn't need to bounce through another process.
> 
> Practically speaking the only use case I can think of in an audio context is
> for one reader and one writer (AIUI Android is envisioning this as one hardware
> and one software), it's difficult to see how you could usefully chain multiple
> in place transformations together in the way that you can with video applications
> but I'm possibly not thinking of something here."

Hi,

  the tinyalsa implementation does not show much - it's equal to the
standard mmap access for the PCM devices. Even considering the Mark's
text, there must be an arbiter (sound server) which communicates with
the producer or consumer to control the data flow. I really would like
to see a real usage for this.

  It seems to me that the only point to implement this is the
permissions. We already have O_APPEND mode for the PCM file descriptor
which can reuse the PCM device multiple times (mmap the buffer to
multiple tasks). I would probably go in this way and add more extended
permission control for the PCM device, so permissions can be restricted
for the passed descriptor to the producer or the consumer task. In this
way, the restricted task might reuse other control mechanism offered buy
the PCM file descriptor without requesting the arbiter to do so (like
read the actual position in the DMA buffer, get the audio delay or so -
reduce context switches).

					Thanks,
						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
