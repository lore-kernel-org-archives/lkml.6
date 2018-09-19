Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C7CECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4289020880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XPeSh8ti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4289020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbeISUdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:33:44 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39057 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732140AbeISUdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:33:44 -0400
Received: by mail-it0-f65.google.com with SMTP id h1-v6so8098560itj.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xH4y7kvmORxlxFfnG18CNVyty3Oc4ukgRsJoryKIF9k=;
        b=XPeSh8tiZ0OwMAN1APNILeYKyCObzmvvgFbS3Kk3YJs6bsef3ZIhDF2Xu3UxIOK150
         2rgyKZfYpXlclJNRxIZlI7ohqsaS1ff/SvtVadGXWopDqaHiSvcXwHvvqvXDGKyYUinI
         NomiH+W9NT4KMLGtHSjVx2ln93dy8F4qgs1wLuFOk3a+wv8fgCoHGz//JlRBuv88U4+w
         DBDKZWVaE42g+P8KG2XzXk7HXOeGTHBtanwNxg/UZFthU+wzyJMTtMDU8VsqhDB40dPe
         PRWqduukscDcZV2vIhUo8R/N9gwA2C6ylsozLLln4cgbfgNhtBzEGPavLd2r9eY638km
         h/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xH4y7kvmORxlxFfnG18CNVyty3Oc4ukgRsJoryKIF9k=;
        b=QEiaCi5x22/KtjaFk/JxQ0uWMp3KpuV/U0L1ktJ8IgvCfkhHAsuu34jN26Jm1lPi1W
         n5ROIEI54SfAzvkaeUzyeWSt8uItYnM4Lkqh3EAXuHPqaW1iKlzhmxO1tyy/1h5Vvm54
         yOR3sFurN9ml+lh+eeOIj1dna2/3gK0OKLQ+2Migz6Z9Ucb6fF+xQgeZ9JQeIfDrsKEN
         m3qcnehixoQBkzylzT0tUF5yOagzIxc6qthlYIacQmhilEv+4jG/Mh6a+CUcq1DrHwXF
         D2Kg44NAPul/KHDPX4E5Ej8LLwOeqH/4qL3JfVEK7dTVncsql5JVheNsIomqDkxp4MP2
         vCzQ==
X-Gm-Message-State: APzg51Bkbgk8X/RpeqbfVGyYxYvrORVesYSqG4brqg0ekTL5OEP3bcN6
        IpCX55xqj12iywGDIAWwOR1VWW0ZEh5N6lmQFSc5jw==
X-Google-Smtp-Source: ANB0Vdad/jaC5uGCs6z3SGDZuCVYUohBj+4lCoJLt59WmDb11O0I8G1xwpXfsdjxEzaQ4mXo8sFXiVMt3MzjWRxiKwY=
X-Received: by 2002:a02:55c2:: with SMTP id e185-v6mr32751481jab.141.1537368925230;
 Wed, 19 Sep 2018 07:55:25 -0700 (PDT)
MIME-Version: 1.0
References: <153736009982.24033.13696245431713246950.stgit@localhost.localdomain>
In-Reply-To: <153736009982.24033.13696245431713246950.stgit@localhost.localdomain>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 19 Sep 2018 07:55:11 -0700
Message-ID: <CANn89iJ1UnwLFv5+AwXgeb1BUhYg8UJYTJLtiipavJee+2SWxQ@mail.gmail.com>
Subject: Re: [RFC] net;sched: Try to find idle cpu for RPS to handle packets
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>, tom@quantonium.net,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 5:29 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> Many workloads have polling mode of work. The application
> checks for incomming packets from time to time, but it also
> has a work to do, when there is no packets. This RFC
> tries to develop an idea to queue RPS packets on idle
> CPU in the the L3 domain of the consumer, so backlog
> processing of the packets and the application can execute
> in parallel.
>
> We require this in case of network cards does not
> have enough RX queues to cover all online CPUs (this seems
> to be the most cards), and  get_rps_cpu() actually chooses
> remote cpu, and SMP interrupt is sent. Here we may try
> our best, and to find idle CPU nearly the consumer's CPU.
> Note, that in case of consumer works in poll mode and it
> does not waits for incomming packets, its CPU will be not
> idle, while CPU of a sleeping consumer may be idle. So,
> not polling consumers will still be able to have skb
> handled on its CPU.
>
> In case of network card has many queues, the device
> interrupts will come on consumer's CPU, and this patch
> won't try to find idle cpu for them.
>
> I've tried simple netperf test for this:
> netserver -p 1234
> netperf -L 127.0.0.1 -p 1234 -l 100
>
> Before:
>  87380  16384  16384    100.00   60323.56
>  87380  16384  16384    100.00   60388.46
>  87380  16384  16384    100.00   60217.68
>  87380  16384  16384    100.00   57995.41
>  87380  16384  16384    100.00   60659.00
>
> After:
>  87380  16384  16384    100.00   64569.09
>  87380  16384  16384    100.00   64569.25
>  87380  16384  16384    100.00   64691.63
>  87380  16384  16384    100.00   64930.14
>  87380  16384  16384    100.00   62670.15
>
> The difference between best runs is +7%,
> the worst runs differ +8%.
>
> What do you think about following somehow in this way?

Hi Kirill

In my experience, scheduler has a poor view of softirq processing
happening on various cpus.
A cpu spending 90% of its cycles processing IRQ might be considered 'idle'

So please run a real workload (it is _very_ uncommon anyone set up RPS
on lo interface !)

Like 400 or more concurrent netperf -t TCP_RR on a 10Gbit NIC.

Thanks.

PS: Idea of playing with L3 domains is interesting, I have personally
tried various strategies in the past but none of them
demonstrated a clear win.
