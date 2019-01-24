Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0758CC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FD2218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfAXNnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:43:33 -0500
Received: from mail1.perex.cz ([77.48.224.245]:43750 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfAXNnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 08:43:32 -0500
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 1E77DA003F;
        Thu, 24 Jan 2019 14:43:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 1E77DA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1548337409; bh=LYmA5xJudYFlot/hNQo0nZS2BIExHwWclwCfWvYcZjY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cYAQoiYuzACFL1KDdNS7D6A/n3NBvPN7lyhJZ17/UGEA6Mj1U6QPHGILBqtR2dt9l
         1pT6fWKJUabgJ8WOatxZ03L3mwsbSjnNZ3MziHllHWKiS04PZyD76aJaAEMQ4yc3ey
         AmnCC44Mt0C5YaE/V+ExCLL8yUHDFFxtk/nNTsJM=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Thu, 24 Jan 2019 14:43:02 +0100 (CET)
Subject: Re: [RFC PATCH] ALSA: core: Add DMA share buffer support
To:     Leo Yan <leo.yan@linaro.org>, Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        arnd@arndb.de, keescook@chromium.org, bgoswami@codeaurora.org,
        sr@denx.de, gustavo@embeddedor.com, philburk@google.com,
        willy@infradead.org, mchehab+samsung@kernel.org, sboyd@kernel.org,
        vkoul@kernel.org, Baolin Wang <baolin.wang@linaro.org>,
        daniel.thompson@linaro.org, mathieu.poirier@linaro.org,
        srinivas.kandagatla@linaro.org, anna-maria@linutronix.de,
        corbet@lwn.net, jmiller@neverware.com,
        ckeepax@opensource.wolfsonmicro.com, joe@perches.com,
        o-takashi@sakamocchi.jp, colyli@suse.de,
        linux-kernel@vger.kernel.org
References: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
 <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz>
 <20190118190805.GF6260@sirena.org.uk> <s5hzhrxzrez.wl-tiwai@suse.de>
 <20190121124053.GA12679@sirena.org.uk>
 <f278bb69-7df0-4d14-5e4f-9bcb57d7f2b6@perex.cz>
 <20190122202535.GK7579@sirena.org.uk> <s5h4l9z4mbo.wl-tiwai@suse.de>
 <20190123124658.GE15906@leoy-ThinkPad-X240s>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <3962daba-f6ed-d706-c618-b791a1ba6b59@perex.cz>
Date:   Thu, 24 Jan 2019 14:43:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190123124658.GE15906@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 23.1.2019 v 13:46 Leo Yan napsal(a):
> Hi all,
> 
> On Wed, Jan 23, 2019 at 12:58:51PM +0100, Takashi Iwai wrote:
>> On Tue, 22 Jan 2019 21:25:35 +0100,
>> Mark Brown wrote:
>>>
>>> On Mon, Jan 21, 2019 at 03:15:43PM +0100, Jaroslav Kysela wrote:
>>>> Dne 21.1.2019 v 13:40 Mark Brown napsal(a):
>>>
>>>>> It was the bit about adding more extended permission control that I was
>>>>> worried about there, not the initial O_APPEND bit.  Indeed the O_APPEND
>>>>> bit sounds like it might also work from the base buffer sharing point of
>>>>> view, I have to confess I'd not heard of that feature before (it didn't
>>>>> come up in the discussion when Eric raised this in Prague).
>>>
>>>> With permissions, I meant to make possible to restrict the file
>>>> descriptor operations (ioctls) for the depending task (like access to
>>>> the DMA buffer, synchronize it for the non-coherent platforms and maybe
>>>> read/write the actual position, delay etc.). It should be relatively
>>>> easy to implement using the snd_pcm_file structure.
>>>
>>> Right, that's what I understood you to mean.  If you want to have a
>>> policy saying "it's OK to export a PCM file descriptor if it's only got
>>> permissions X and Y" the security module is going to need to know about
>>> the mechanism for setting those permissions.  With dma_buf that's all a
>>> bit easier as there's less new stuff, though I've no real idea how much
>>> of a big deal that actually is.
>>
>> There are many ways to implement such a thing, yeah.  If we'd need an
>> implementation that is done solely in the sound driver layer, I can
>> imagine to introduce either a new ioctl or an open flag (like O_EXCL)
>> to specify the restricted sharing.  That is, a kind of master / slave
>> model where only the master is allowed to manipulate the stream while
>> the slave can mmap, read/write and get status.
>
> In order to support EXCLUSIVE mode, it is necessary to convert the
> /dev/snd/ descriptor to an anon_inode:dmabuffer file descriptor.
> SELinux allows that file descriptor to be passed to the client. It can
> also be used by the AAudioService.

Okay, so this is probably the only point which we should resolve for the
already available DMA buffer sharing in ALSA (the O_APPEND flag).

I had another glance to your dma-buf implementation and I see many
things which might cause problems:

- allow to call dma-buf ioctls only when the audio device is in specific
state (stream is not running)

- as Takashi mentioned, if we return another file-descriptor (dma-buf
export) to the user space and the server closes the main pcm
file-descriptor (the client does not) - the result will be a crash (dma
buffer will be freed, but referenced through the dma-buf interface)

- the attach function calls dma_buf_get(fd), but what if fd points to
another dma-buf allocation from a different driver? the unexpected
private data will cause crash - there should be a type checking in the
dma-buf interface

If I look to the dma_buf_fd() implementation:

  fd = get_unused_fd_flags(flags);
  fd_install(fd, dmabuf->file);

.. what if we just add one new ioctl to the ALSA's PCM API which will
return a new anonymous inode descriptor with the restricted access to
the main PCM device to satisfy the SELinux requirements / security
policies? It might be more nice and simple solution than to implement
the full dma-buf interface for the ALSA's PCM devices.

Question: The dma-buf also implements the fencing, but I am not able to
determine, if this mechanism is used in android [1]. It may allow
concurrent mmap and synchronize apps - but the sound server should
manage the access to the DMA buffer anyway. In my opinion, it makes much
sense for the video-pipes when the hardware does some accelerations
(encoding/decoding).

					Jaroslav

> [1] https://source.android.com/devices/audio/aaudio

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
