Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D7AC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B318A20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="1D+te2Cw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbfAUOQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:16:20 -0500
Received: from mail1.perex.cz ([77.48.224.245]:51002 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728912AbfAUOQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:16:13 -0500
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 18F46A003F;
        Mon, 21 Jan 2019 15:16:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 18F46A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1548080170; bh=76PQpHjdWkznrgU8kgzdFeuWWXQJHOzN6h0Tkk8zCkU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=1D+te2CwbmlN2CdKNhj65apbLi5aDoGSUke4Vpj3fvyyOV+uP5BM4jz0wK9v1zqMh
         obWVtAoCcs9hy/YkLiVGtBSvPaeagpQ2qyQWGCLX6QaNYmyQbYgSfHP80OnAFYv9Zt
         LdP0Icqy7iubYqkwHZP4vA8qoEVg/BgiSmVtt0c8=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Mon, 21 Jan 2019 15:15:43 +0100 (CET)
Subject: Re: [RFC PATCH] ALSA: core: Add DMA share buffer support
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, arnd@arndb.de, keescook@chromium.org,
        bgoswami@codeaurora.org, sr@denx.de, gustavo@embeddedor.com,
        philburk@google.com, willy@infradead.org,
        mchehab+samsung@kernel.org, sboyd@kernel.org, vkoul@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        daniel.thompson@linaro.org, leo.yan@linaro.org,
        mathieu.poirier@linaro.org, srinivas.kandagatla@linaro.org,
        anna-maria@linutronix.de, corbet@lwn.net, jmiller@neverware.com,
        ckeepax@opensource.wolfsonmicro.com, joe@perches.com,
        o-takashi@sakamocchi.jp, colyli@suse.de,
        linux-kernel@vger.kernel.org
References: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
 <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz>
 <20190118190805.GF6260@sirena.org.uk> <s5hzhrxzrez.wl-tiwai@suse.de>
 <20190121124053.GA12679@sirena.org.uk>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <f278bb69-7df0-4d14-5e4f-9bcb57d7f2b6@perex.cz>
Date:   Mon, 21 Jan 2019 15:15:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190121124053.GA12679@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 21.1.2019 v 13:40 Mark Brown napsal(a):
> On Fri, Jan 18, 2019 at 08:39:32PM +0100, Takashi Iwai wrote:
>> Mark Brown wrote:
> 
>>>> multiple tasks). I would probably go in this way and add more extended
>>>> permission control for the PCM device, so permissions can be restricted
>>>> for the passed descriptor to the producer or the consumer task. In this
> 
>>> One concern I have with doing some ALSA-specific custom permissions
>>> thing is integration with frameworks like SELinux (they'd presumably
>>> need to learn about the ALSA specific stuff to manage it).  It also
> 
>> Well, I wonder what makes it more difficult by the approach Jaroslav
>> suggested.  With O_APPEND, you can just call mmap() normally, and
>> that's all. What's the merit of dma-buf approach wrt the security?
> 
> It was the bit about adding more extended permission control that I was
> worried about there, not the initial O_APPEND bit.  Indeed the O_APPEND
> bit sounds like it might also work from the base buffer sharing point of
> view, I have to confess I'd not heard of that feature before (it didn't
> come up in the discussion when Eric raised this in Prague).

With permissions, I meant to make possible to restrict the file
descriptor operations (ioctls) for the depending task (like access to
the DMA buffer, synchronize it for the non-coherent platforms and maybe
read/write the actual position, delay etc.). It should be relatively
easy to implement using the snd_pcm_file structure.

Even with the full operation mode, it's difficult imagine what the
depending task can break with the sound interface except probably annoy
users with some cracks for the playback or start/stop the streaming rapidly.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
