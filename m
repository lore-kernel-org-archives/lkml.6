Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5250CC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01386262B9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yexXemgv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01386262B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755570AbeFYXc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752998AbeFYXc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:32:27 -0400
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21066262BE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 23:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529969547;
        bh=9HRry7LWVFImHNvpLSVVmGzYeQdnNnK4yMiqVv9UAOY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yexXemgvKyWmwh/9QfhAUTVyvJ2ZJkNvg4mkyWfN3z1E0UyiydKaY6JR5p0SmgghR
         zf870uYD9AXtIdQR3xjV4QsRbvB+7ZqUfXCM2lmIPozjL5EKj/n7DvXrRoPVHKsoaA
         pKOmlzAUQ5s83VvyN5IRgRxqDf0EoTEg3yFcR998=
Received: by mail-wm0-f42.google.com with SMTP id i139-v6so4080171wmf.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 16:32:27 -0700 (PDT)
X-Gm-Message-State: APt69E1T01RwVOrsiwOEBYVQ7q2hIXWFERVgtmSHyz54Vy1bkZzdlqYd
        csa2u/3tWyXU6sUZG7vrLTTWQbnHub6UB5p48LjRfg==
X-Google-Smtp-Source: ADUXVKIGdiYEfkEDfHfMWuI4TkL/9r97hfYBUlwbj3ivNjOq0S1iVuNyet+pZC1RLXErOtRbIwT4urPbqOiAWwxrUHY=
X-Received: by 2002:a1c:f902:: with SMTP id x2-v6mr2258221wmh.116.1529969545658;
 Mon, 25 Jun 2018 16:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com> <20180622055659.GA255098@joelaf.mtv.corp.google.com>
 <20180622132843.GN3593@linux.vnet.ibm.com> <20180622181916.GA13628@joelaf.mtv.corp.google.com>
 <20180622143247.781028b1@gandalf.local.home> <20180622200548.GA114655@joelaf.mtv.corp.google.com>
 <20180625082824.GB21377@X58A-UD3R> <20180625163951.GA52646@joelaf.mtv.corp.google.com>
 <20180625162557.7140664c@gandalf.local.home> <20180625204708.GS3593@linux.vnet.ibm.com>
 <20180625181522.53b5d296@gandalf.local.home>
In-Reply-To: <20180625181522.53b5d296@gandalf.local.home>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 25 Jun 2018 16:32:13 -0700
X-Gmail-Original-Message-ID: <CALCETrVCj_B=wCOsr5DLyFsL9Wc6AWUToLUD6Av=UosdVOrO1A@mail.gmail.com>
Message-ID: <CALCETrVCj_B=wCOsr5DLyFsL9Wc6AWUToLUD6Av=UosdVOrO1A@mail.gmail.com>
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct rcu_dynticks
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        joel@joelfernandes.org, Byungchul Park <byungchul.park@lge.com>,
        byungchul park <max.byungchul.park@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 3:15 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 25 Jun 2018 13:47:08 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
>
> > On Mon, Jun 25, 2018 at 04:25:57PM -0400, Steven Rostedt wrote:
> > > On Mon, 25 Jun 2018 09:39:51 -0700
> > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > >
> > > > For whatever its worth, I made some notes of what I understood from reading
> > > > the code and old posts because I was sure I would otherwise forget
> > > > everything:
> > > > http://www.joelfernandes.org/linuxinternals/2018/06/15/rcu-dynticks.html
> > >
> > > Nice write up. I may point some people to this ;-)
> > >
> > > Anyway "complications due to nested NMIs (yes NMIs can nest!)"
> > >
> > > What arch allows for NMIs to nest. Because we don't let that happen on
> > > x86, and there's code that I know of that is called by NMIs that is not
> > > re-entrant, and can crash if we allow for NMIs to nest. For example
> > > "in_nmi()" will not show that we are in_nmi() if we allow for nesting
> > > of NMIs. It has a single bit that gets incremented when we enter NMI
> > > code, and cleared when we leave it.
> >
> > Last I checked with Andy Lutomirski, there are a number of things that,
> > though not NMIs, act like NMIs and that can interrupt each others'
> > handlers.  This is on x86.
> >
>
> Perhaps things like MCEs, but they don't call nmi_enter(). And usually
> when something does, it probably puts the machine into an unstable
> state. Getting RCU right, may be the least of the worries.
>
> You may want to ask Andy if there's legitimate interruptions of NMIs
> that doesn't mean "please reboot as soon as possible"?
>

Yes, sadly.  CPU A gets an NMI.  While processing it, CPU B has user
code access a faulty NVDIMM address, causing CPU B to generate a
machine check.  CPU A also gets a machine check because someone at
Intel thought it was a good idea.  CPU A will mostly ignore the
machine check, but it still happens.

I think it's reasonable to say that nmi_enter() won't nest, but I
don't see how we can avoid rcu_nmi_enter() nesting.
