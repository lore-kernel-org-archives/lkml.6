Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FEEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E324217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Qzmh+etT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbfAILYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:24:41 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39999 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729843AbfAILYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:24:40 -0500
Received: by mail-ed1-f67.google.com with SMTP id g22so6981847edr.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 03:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LUhYFMnYK7TypITgbyRnAJd8zP8Pz991VZzwgNQwYeM=;
        b=Qzmh+etTP1/CVAoMadrJ3qZbdFCSwwuL+f+uc2nmPjFdXjLItbAAwquDBQOLPfB6d2
         rYVOPR1WnajGBkqN08KCPDkSNF9qbvvF+GUBpoBPEnuuqXeRYp8u2DUCTc3R1n1nib6c
         nLzmE0tz8Qp4C+K8DKXLZxO+V9ZNnH1/GkNKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LUhYFMnYK7TypITgbyRnAJd8zP8Pz991VZzwgNQwYeM=;
        b=PRR8XjIrgc/QQ4qnqtk54VXNZkxXiWY0OjlyGU64vTeERambLt5WQRZXvYIjjYpJ1e
         oXYqWLgFgOm86/PJZ3XjMbcrXx0lZ86+xxi62Enor6SBeBvrSQxVYAVxPuik5lme+Pvf
         hzRZiDO2cEiGX1b4jqsxjX3qHl6ZffrXpQHM3Ubg4JicOueODLdA8fEyUz2s6BkidNGN
         nwMEvBU+mD0FkvlZuIFmJ2fsWLyrYqIEWabj7bvS7WlOWyPHzDn969JCBgN59sE9Xexh
         3VVDRdaYdpWZy6u5H0vpzGRw76leK7u8tqhi63oeaLi7VZQc9OJcJxBQIdI68ydWbnUp
         7lOw==
X-Gm-Message-State: AJcUukc2SFDvu/RCYIU5EzNcd5NAG43Pvxda1g5sjCwOJvv4DJN74rgG
        6CC4PGYoLhZpTl6V/sHqqiYbmA==
X-Google-Smtp-Source: ALg8bN5VV4Ch+i0YqmapN3/el3yA9cef6wxy9AOjmVMqGqrtMmVX8euThxuvDuSLUz7sH8HpTF3SMQ==
X-Received: by 2002:aa7:c152:: with SMTP id r18mr5744708edp.258.1547033078973;
        Wed, 09 Jan 2019 03:24:38 -0800 (PST)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id r1sm909432eds.1.2019.01.09.03.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 03:24:38 -0800 (PST)
Date:   Wed, 9 Jan 2019 12:24:32 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Anatol Pomozov <anatol.pomozov@gmail.com>
Cc:     fw@strlen.de, Dmitry Vyukov <dvyukov@google.com>,
        Paul McKenney <paulmck@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: seqcount usage in xt_replace_table()
Message-ID: <20190109112432.GA6351@andrea>
References: <CAOMFOmU=t9YbE68YpoQn0Ug0XN1F+0iuJp9J=htCRRrbdaPSVA@mail.gmail.com>
 <20190109000214.GA5907@andrea>
 <CAOMFOmUSttpLyeiRLjxw4rSN0tOiAq1jbwK=kRdCkuOKPOC3Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMFOmUSttpLyeiRLjxw4rSN0tOiAq1jbwK=kRdCkuOKPOC3Rg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 04:36:46PM -0800, Anatol Pomozov wrote:
> Hello
> 
> On Tue, Jan 8, 2019 at 4:02 PM Andrea Parri
> <andrea.parri@amarulasolutions.com> wrote:
> >
> > Hi Anatol,
> >
> > On Tue, Jan 08, 2019 at 11:33:39AM -0800, Anatol Pomozov wrote:
> > > Hello folks,
> > >
> > > A bit of context what I am doing. I am trying to port KTSAN (Kernel
> > > Thread Sanitizer) tool to v4.20. That tool tracks shared data usage
> > > and makes sure it is accessed in a thread-safe manner.
> >
> > Interesting!  FYI, some LKMM's maintainers (Paul included) had and
> > continued to have some "fun" discussing topics related to "thread-
> > safe memory accesses": I'm sure that they'll be very interested in
> > such work of yours and eager to discuss your results.
> 
> Thread Sanitizer is a great tool to find thread-safety issues with
> user-space code. The tool been developed by a team of smart people
> from Google [1].
> 
> KTSAN is an attempt to bring the same ideas to Linux kernel [2]. A
> bunch of work been done there but the project is still at
> proof-of-concept point.

Yes, I have been aware of these tools since at least  ;-)

  https://groups.google.com/forum/#!msg/ktsan/bVZ1c6H2NE0/Dxrw55bfBAAJ


> 
> I am not a part of Google's dynamic tools team. But I've decided to
> pick something to do during the New Year holidays so started porting
> KTSAN from v4.2 to v4.20. The work is "almost completed" but I need to
> fix a few crashes [3].

I guess my first reaction would remain

  "it's kind of hard (to use an euphemism) to review 7,582 additions
  or so for a data race detector without a clear/an accepted (by the
  community) notion of data race..."

  Andrea


> 
> [1] https://github.com/google/sanitizers
> [2] https://github.com/google/ktsan/wiki
> [3] https://github.com/anatol/linux/tree/ktsan_4.20
