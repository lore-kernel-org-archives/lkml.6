Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B13C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1C520827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA1C520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeJ3UFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:05:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41646 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeJ3UFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:05:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id x12-v6so12100464wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 04:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ghItDxlpwhIE9XfKIUQsqiPKgZs52Zb1A5m2LoH9p9U=;
        b=X0fzieibELQsshcKTrNO9UTxEkqyPx2yTOmwqJIdjvcZszF8ZEnMQwaJSZmRPax0+n
         TTUaGZp1hMuGwWBUz+lwhy4R2t4xU0DWBUa3J/Y7lXSutmwi5jrJbgYY/wFNbgHxNeTw
         4R4SWq/p/xxgY4kKOywctO9NI2NXE45utK0VK1UjiTR7yiS3MviPtGETiWXtlMgzAwwO
         Ui3q+T0PNGNDiYf0VJeSoY4qaYR+NDUG+KHjM8X5KjxxyBIZl1N1pl8fiyITdKuXVn8F
         qC/lywgBcWGxxA6AgU6MdzEw2949lNRQ2Ev8Odw+h+atnpedbtZRs6vELpYvNezjEMTB
         A/eg==
X-Gm-Message-State: AGRZ1gKNROLL6pSaZBV7hygg3b+QNX7CuOTdUYRILUJ5KIEcujo7JR7e
        6b44xHmJZT8P98r//WUJWc6LYw==
X-Google-Smtp-Source: AJdET5esfVTbwttNY/Rkef/wgrOBGRZKzdrna/1DrX0jem5G60TcZPXqFa4vaPTaeMn2KP5K1G3jcw==
X-Received: by 2002:adf:c389:: with SMTP id p9-v6mr18746731wrf.68.1540897946356;
        Tue, 30 Oct 2018 04:12:26 -0700 (PDT)
Received: from localhost.localdomain ([151.68.156.111])
        by smtp.gmail.com with ESMTPSA id p125-v6sm13749971wmp.2.2018.10.30.04.12.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 04:12:25 -0700 (PDT)
Date:   Tue, 30 Oct 2018 12:12:21 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     luca abeni <luca.abeni@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@gmail.com>,
        syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        nstange@suse.de, syzkaller-bugs@googlegroups.com, henrik@austad.us,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: INFO: rcu detected stall in do_idle
Message-ID: <20181030111221.GA18091@localhost.localdomain>
References: <alpine.DEB.2.21.1810161643540.7787@nanos.tec.linutronix.de>
 <20181016153608.GH9130@localhost.localdomain>
 <20181018082838.GA21611@localhost.localdomain>
 <20181018122331.50ed3212@luca64>
 <20181018104713.GC21611@localhost.localdomain>
 <20181018130811.61337932@luca64>
 <20181019113942.GH3121@hirez.programming.kicks-ass.net>
 <20181019225005.61707c64@nowhere>
 <20181024120335.GE29272@localhost.localdomain>
 <20181030104554.GB8177@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030104554.GB8177@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/18 11:45, Peter Zijlstra wrote:

[...]

> Hurm.. right. We knew of this issue back when we did it.
> I suppose now it hurts and we need to figure something out.
> 
> By virtue of being a real-time class, we do indeed need to have deadline
> on the wall-clock. But if we then don't account runtime on that same
> clock, but on a potentially slower clock, we get the problem that we can
> run longer than our period/deadline, which is what we're running into
> here I suppose.
> 
> And yes, at some point RT workloads need to be aware of the jitter
> injected by things like IRQs and such. But I believe the rationale was
> that for soft real-time workloads this current semantic was 'easier'
> because we get to ignore IRQ overhead for workload estimation etc.

Right. In this case the task is self injecting IRQ load, but it maybe
doesn't make a big difference on how we need to treat it (supposing we
can actually distinguish).

> What we could maybe do is track runtime in both rq_clock_task() and
> rq_clock() and detect where the rq_clock based one exceeds the period
> and then push out the deadline (and add runtime).
> 
> Maybe something along such lines; does that make sense?

Yeah, I think I've got the gist of the idea. I'll play with it.

Thanks,

- Juri
