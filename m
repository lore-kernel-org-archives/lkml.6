Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A53C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADE2208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADE2208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389674AbeKPUSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:18:15 -0500
Received: from ozlabs.org ([203.11.71.1]:43101 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389478AbeKPUSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:18:13 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42xDQx0jRsz9sBQ;
        Fri, 16 Nov 2018 21:06:33 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        benh@kernel.crashing.org, paulus@samba.org, joe@perches.com,
        darren@stevens-zone.net, christophe.leroy@c-s.fr,
        geoff@infradead.org
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/powerpc: Use dma_zalloc_coherent
In-Reply-To: <CAJr6mf1nOouU31WF_xb_46wDebPQ-7+NTCiSKBjLyQta2mny6w@mail.gmail.com>
References: <5bdfb8db.1c69fb81.c8f62.9586@mx.google.com> <CAJr6mf1nOouU31WF_xb_46wDebPQ-7+NTCiSKBjLyQta2mny6w@mail.gmail.com>
Date:   Fri, 16 Nov 2018 21:06:32 +1100
Message-ID: <87sh012v6f.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sabyasachi Gupta <sabyasachi.linux@gmail.com> writes:

> On Mon, Nov 5, 2018 at 8:58 AM Sabyasachi Gupta
> <sabyasachi.linux@gmail.com> wrote:
>>
>> Replaced dma_alloc_coherent + memset with dma_zalloc_coherent
>>
>> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
>
> Any comment on this patch?

Wait longer :)

I'm still chasing bugs in 4.20-rc2, I haven't started merging many
patches for 4.21 yet.

Your patches are tracked in patchwork here:
  https://patchwork.ozlabs.org/project/linuxppc-dev/list/?submitter=75253


If they're still in "new" state around rc5 then feel free to ping me
again.

cheers


>> diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
>> index 53384eb..d18d164 100644
>> --- a/arch/powerpc/platforms/pasemi/dma_lib.c
>> +++ b/arch/powerpc/platforms/pasemi/dma_lib.c
>> @@ -255,15 +255,13 @@ int pasemi_dma_alloc_ring(struct pasemi_dmachan *chan, int ring_size)
>>
>>         chan->ring_size = ring_size;
>>
>> -       chan->ring_virt = dma_alloc_coherent(&dma_pdev->dev,
>> +       chan->ring_virt = dma_zalloc_coherent(&dma_pdev->dev,
>>                                              ring_size * sizeof(u64),
>>                                              &chan->ring_dma, GFP_KERNEL);
>>
>>         if (!chan->ring_virt)
>>                 return -ENOMEM;
>>
>> -       memset(chan->ring_virt, 0, ring_size * sizeof(u64));
>> -
>>         return 0;
>>  }
>>  EXPORT_SYMBOL(pasemi_dma_alloc_ring);
>> --
>> 2.7.4
>>
