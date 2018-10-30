Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA2AC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133CC20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="eSgcc4KS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133CC20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbeJaHT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 03:19:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43662 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbeJaHT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 03:19:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id n10-v6so6343464pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 15:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oe5QtiDK/OS64H7tq/cpZ3z20ZKnhrmdK6D5mIbUFDU=;
        b=eSgcc4KSTxvsuxzKe4DSjb13QbTwe/1jU2Nl0oGQD19mk7Eml0bOmO0OmVxgICIG8m
         J5vhxR5j4JAQzRzzMr8I1HcKkeS9FtiQmPNf4SbTKFJcpywzKjtUc638g/jQQ6BLXeuO
         sNhZtyo12r8WiY5FVSjK0yIxjyyQDQipaLt0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oe5QtiDK/OS64H7tq/cpZ3z20ZKnhrmdK6D5mIbUFDU=;
        b=B544Y6Ju1FvSPQ1GualYK1V4sWQgze8cRWXGKUEV7KpjH3/G5kCNFtCC9o4zJlxaM8
         TdlrVDclT6Rnya/CS0hsMdAUAFAw31NNGkkt4tLjIy2olSitUKJlllYzl/Oeq47VMEKw
         RkxzmkGgDeIoe6sF58zdB4HBE8/KVG0r9TMB9Y13JheJqpgkCLgeIcZb8xCYAJ2xCEt1
         +F4fFMVTZWRlqNhtjru5JvE67eVwcAGROZRkEf+WaHmxcLmiCr3vCsv/GVT4ZF4ee6lX
         Z5Mug8Kr1XQzVzWbxVNrjHrZrKblQgo0vvCdAXCDB6HzjNG6S3RWFqSb451qv0hrokkP
         CA4A==
X-Gm-Message-State: AGRZ1gJzYayfaQQSWFtV0IN2es0IdD3VQ3yLxc3IJqB0VUQKtKUqhOpI
        S5bXkiNXONpoybJtzYqSGMEVMg==
X-Google-Smtp-Source: AJdET5cEOmDti7eSA6NHuxKEUHaC564RPUM7jl6Z1woRTM39JrbH6zD+4vgBCcpZPsPuqOSAbFGDWA==
X-Received: by 2002:a63:2109:: with SMTP id h9mr510972pgh.277.1540938247076;
        Tue, 30 Oct 2018 15:24:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id g7-v6sm8893216pfo.139.2018.10.30.15.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 15:24:05 -0700 (PDT)
Date:   Tue, 30 Oct 2018 15:24:05 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     Joel Fernandes <joelaf@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>
Subject: Re: [RFC PATCH] Minimal non-child process exit notification support
Message-ID: <20181030222405.GC44036@joelaf.mtv.corp.google.com>
References: <20181029175322.189042-1-dancol@google.com>
 <CAJWu+opR5bU7b0ux5GZjO-Wu+=2F8sARke-E_y4PpH0XSubx9g@mail.gmail.com>
 <CAKOZuetEeP2QgowUL60LYoOgavN7e-WX52adzTdMQhZX0bZn-Q@mail.gmail.com>
 <CAJWu+orRE9HL2KWRzEhr2B2Owi=66x-mgjYiJV=cje-rgOeSxQ@mail.gmail.com>
 <CAKOZuetNC8Z4a5HAZkm2D4RMrTOCWj71rLJXOOtuoFaF3gGEpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuetNC8Z4a5HAZkm2D4RMrTOCWj71rLJXOOtuoFaF3gGEpA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 08:59:25AM +0000, Daniel Colascione wrote:
> On Tue, Oct 30, 2018 at 3:06 AM, Joel Fernandes <joelaf@google.com> wrote:
> > On Mon, Oct 29, 2018 at 1:01 PM Daniel Colascione <dancol@google.com> wrote:
> >>
> >> Thanks for taking a look.
> >>
> >> On Mon, Oct 29, 2018 at 7:45 PM, Joel Fernandes <joelaf@google.com> wrote:
> >> >
> >> > On Mon, Oct 29, 2018 at 10:53 AM Daniel Colascione <dancol@google.com> wrote:
> >> > >
> >> > > This patch adds a new file under /proc/pid, /proc/pid/exithand.
> >> > > Attempting to read from an exithand file will block until the
> >> > > corresponding process exits, at which point the read will successfully
> >> > > complete with EOF.  The file descriptor supports both blocking
> >> > > operations and poll(2). It's intended to be a minimal interface for
> >> > > allowing a program to wait for the exit of a process that is not one
> >> > > of its children.
> >> > >
> >> > > Why might we want this interface? Android's lmkd kills processes in
> >> > > order to free memory in response to various memory pressure
> >> > > signals. It's desirable to wait until a killed process actually exits
> >> > > before moving on (if needed) to killing the next process. Since the
> >> > > processes that lmkd kills are not lmkd's children, lmkd currently
> >> > > lacks a way to wait for a proces to actually die after being sent
> >> > > SIGKILL; today, lmkd resorts to polling the proc filesystem pid
> >> >
> >> > Any idea why it needs to wait and then send SIGKILL? Why not do
> >> > SIGKILL and look for errno == ESRCH in a loop with a delay.
> >>
> >> I want to get polling loops out of the system. Polling loops are bad
> >> for wakeup attribution, bad for power, bad for priority inheritance,
> >> and bad for latency. There's no right answer to the question "How long
> >> should I wait before checking $CONDITION again?". If we can have an
> >> explicit waitqueue interface to something, we should. Besides, PID
> >> polling is vulnerable to PID reuse, whereas this mechanism (just like
> >> anything based on struct pid) is immune to it.
> >
> > The argument sounds Ok to me. I would also more details in the commit
> > message about the alternate methods to do this (such as kill polling
> > or ptrace) and why they don't work well etc so no one asks any
> > questions. Like maybe under a "other ways to do this" section. A bit
> > of googling also showed a netlink way of doing it without polling
> > (though I don't look into that much and wouldn't be surprised if its
> > more complicated)
> 
> Thanks for taking a look. I'll add to the commit message.
> 
> Re: netlink isn't enabled everywhere and is subject to lossy buffy
> overruns, AIUI. You could also monitor process exit by setting up
> ftrace and watching events, or by installing BPF that watched for
> process exit and sent a perf event. :-) All of these interfaces feel
> like abusing a "monitoring" API for controlling system operations, and
> this kind of abuse tends to have ugly failure modes. I'm looking for
> something a bit more explicit and robust.

Sounds good to me!

 - Joel

