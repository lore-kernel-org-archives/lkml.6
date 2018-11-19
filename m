Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B6BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EE520831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 13:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EE520831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbeKTAHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 19:07:35 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45944 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbeKTAHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 19:07:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id v6so10257149wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 05:43:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UNdh24OgljeNzNAVQrGrAEsZQ5CXN58xq5RU/xcXQZ0=;
        b=DbsFiC3iWmbCFV7M+EyWQXwgpDQFTA4opGLbBIdUG2iNk7O7tGNNPEpWiPuBlYGHTt
         c6ZOP94hIdP4D1tL5h9RbK9kuFy510YGOPnAk0cvvybNORyAqeHe3K2hDvfKmAQFOr9r
         4uCg7xZZ4cqdz9a3u268eHIMYjzUXiLt9weJ+ur0MWxFPT+cY6VHc+gRZsNbdjO0AZ0x
         h2MAaKjtwXe5tKXK6qgpNVUq10zn8XaJsoLXdGq2+AJcn+lp30ZqDYYiYTAlBPThAvC/
         CbpBfwiJ3OekQvMFEJJGAtvafnr75zCFCDGudSnZiSKNIF2okqNbspXhTTup2LJ+Dqge
         +V5A==
X-Gm-Message-State: AA+aEWZqj+N5Hzm8CbPXyY6+IHXc1pq2leKUxA8hI11ZubFh1hmMjm/w
        3d/Dxqx5X+N0gXUZXhMnwunmtw==
X-Google-Smtp-Source: AFSGD/UrZb4I4PfjlyYaGE3WufyeNIDlAlrPh7GY15NLCkdxZEJgyC30IAkv5SDsGdpek/oHIbJ7Tw==
X-Received: by 2002:a05:6000:120a:: with SMTP id e10mr16504827wrx.85.1542635033224;
        Mon, 19 Nov 2018 05:43:53 -0800 (PST)
Received: from localhost.localdomain ([151.15.226.84])
        by smtp.gmail.com with ESMTPSA id e16sm15060982wrn.72.2018.11.19.05.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 05:43:52 -0800 (PST)
Date:   Mon, 19 Nov 2018 14:43:49 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     luca abeni <luca.abeni@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+119ba87189432ead09b4@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, x86@kernel.org,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: WARNING in enqueue_task_dl
Message-ID: <20181119134349.GA2119@localhost.localdomain>
References: <000000000000b5e346057af4da06@google.com>
 <alpine.DEB.2.21.1811190921190.9459@nanos.tec.linutronix.de>
 <20181119130718.69eddf46@luca64>
 <20181119125241.GC9761@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119125241.GC9761@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/11/18 13:52, Peter Zijlstra wrote:
> On Mon, Nov 19, 2018 at 01:07:18PM +0100, luca abeni wrote:
> 
> > > On Sun, 18 Nov 2018, syzbot wrote:
> 
> > > > WARNING: CPU: 1 PID: 6351 at kernel/sched/deadline.c:628
> > > > enqueue_task_dl+0x22da/0x38a0 kernel/sched/deadline.c:1504
> > 
> > Here, it looks like a task is invoking sched_setattr() to become
> > SCHED_DEADLINE when dl_boosted is set...
> > 
> > Is this possible / correct?
> 
> Possible, clearly. Correct, only in so far as that it is not a malformed
> program, but it is very poor design to actually trigger this (of course
> the fuzzer doesn't care about that).
> 
> > If this (sched_setattr() with dl_boosted set) should not be possible,
> > then we have a bug that we need to investigate...
> > 
> > Otherwise, I suspect we can just remove the WARN_ON at line 628 of
> > deadline.c
> 
> I wonder why we put that WARN in there to begin with... git-blame gives
> us:
> 
>   98b0a8578050 ("sched/deadline: Remove useless parameter from setup_new_dl_entity()")
> 
> So the problem seems to be that if we're boosted, we should maybe not be
> using our own (newly set) parameters, but those of the donor task.
> 
> Specifically, our 'suboptimal' deadline inheritance scheme 'requires' us
> to use the inherited deadline, not our own. So in that respect I think
> the WARN is valid, although I'm not sure what, apart from actually
> finishing that PE patch-set we can do about it just now.

Mmm, but, as it was written in the comment that was removed by 295d6d5
("sched/deadline: Fix switching to -deadline"), I was still expecting
that for a boosted task setup_new_dl_entity() shouldn't be called.
Wonder if this is another manifestation of the problems we have with
clocks. Need to think more about it.
