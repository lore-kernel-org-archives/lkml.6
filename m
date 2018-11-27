Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A70DC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C52D2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XGD5lKTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C52D2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbeK0V53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:57:29 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:35095 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbeK0V53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:57:29 -0500
Received: by mail-ed1-f47.google.com with SMTP id x30so18624113edx.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 02:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ejdvGjdynfjwDyOYSvsWobTBWc8XsmggwGTMHO1rrrc=;
        b=XGD5lKToakyJX1oRbQ62pqrRsRBiB4sCTlzami5JwDDhJtrbqUnIfKJp3+6gACzTd3
         Hy4Kus5wvBxh6ds8SlACohNEiM2gRMiVFDrdT3vE/n790RMrEiC7NuVq6upRm/WyN1uC
         k9L+036gIKitcZjOJla01jFZawGP3tKSGT880=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ejdvGjdynfjwDyOYSvsWobTBWc8XsmggwGTMHO1rrrc=;
        b=fJ4GZlpJy0ih+B0YZcnOF7BGbuncJnIV8YufWmDFIXATdfHJ8XitTXrt8xdTg5poYH
         ZrvzyZwqzSQ4svMaoHUrjLfcEv6VDThadCMDD+PlCoTOH1CQlNSnoCm5CdTbx0b/ySHl
         6gmGwMcOgCg/jnzzYY0ev5gFBxX6o9gN2FSdm3TNtlRYpgUaHIlo+Na2FbkKGZFSzNq4
         X+pl94nOxLgN6AvrlDeS+3bHrUR6jRaheub7RRqSYWCdRWE8arOueq7d/V8N/U2OMbX7
         9/YHCtYi2YoOhQHNcn72Hmt62+BHIcbHQnRDMNfVl6qgLR2ZSD0TdMndRK3T54VkGDCM
         EB2A==
X-Gm-Message-State: AGRZ1gKHoZFeuTB1+sp2EBD4/J3B3lg6lscpF1ewp/J64mhiIWbyv6jy
        rUEuQrQlVwoDUAffwrK/pPCIFw==
X-Google-Smtp-Source: AJdET5cfPZ6qNk5VRgCb/a3wIY2Dv9W31azyMNFzSiEuXFmIclf45wN9x7foILa5jY96PKOeIvT64A==
X-Received: by 2002:a17:906:6c97:: with SMTP id s23-v6mr22948184ejr.79.1543316396712;
        Tue, 27 Nov 2018 02:59:56 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id c29sm899438eda.75.2018.11.27.02.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 02:59:56 -0800 (PST)
Date:   Tue, 27 Nov 2018 11:59:50 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Question] atomic_fetch_andnot() in nohz_idle_balance()
Message-ID: <20181127105950.GA5398@andrea>
References: <20181121223453.GA4016@andrea>
 <20181126093051.GV2131@hirez.programming.kicks-ass.net>
 <CAKfTPtDm49JS7thuUn0--ocqpn2Du4qi8qsUeeHzGrAG_F2epw@mail.gmail.com>
 <20181126204414.GA4643@andrea>
 <CAKfTPtBjA-oCBRkO6__npQwL3+HLjzk7riCcPU1R7YdO-EpuZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBjA-oCBRkO6__npQwL3+HLjzk7riCcPU1R7YdO-EpuZg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 10:01:24AM +0100, Vincent Guittot wrote:
> On Mon, 26 Nov 2018 at 21:44, Andrea Parri
> <andrea.parri@amarulasolutions.com> wrote:
> >
> > On Mon, Nov 26, 2018 at 12:37:00PM +0100, Vincent Guittot wrote:
> > > On Mon, 26 Nov 2018 at 10:30, Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Wed, Nov 21, 2018 at 11:34:53PM +0100, Andrea Parri wrote:
> > > > > Hi,
> > > > >
> > > > > The comment for the atomic_fetch_andnot() in nohz_idle_balance() says:
> > > > >
> > > > >   "barrier, pairs with nohz_balance_enter_idle(), ensures ..."
> > > > >
> > > > > which, well, does sound a note of warning... ;-)
> > > > >
> > > > > I see that nohz_balance_enter_idle() has an smp_mb__after_atomic() but
> > > > > the comment for the latter suggests that this barrier is pairing with
> > > > > the smp_mb() in _nohz_idle_balance().
> > > > >
> > > > > So, what is the intended pairing barrier for the atomic_fetch_andnot()?
> > > > > what (which memory accesses) do you want "to order" here?
> > > >
> > > > I can't seem to make sense of that comment either; the best I can come
> > > > up with is that it would order the prior NOHZ_KICK_MASK load vs us then
> > > > changing it.
> > > >
> > > > But that would order against kick_ilb(), not enter_idle.
> > > >
> > > > Vincent?
> > >
> > > I can't come with a good explanation.
> > > After looking into my email archive, the only explanation that i have
> > > is that the comments remains from a previous iteration of the feature
> > > that was based on a nohz.stats_state mechanism
> >
> > I'm afraid I still can't help your comment...  put in other terms, would
> > you feel "unconfortable" with _relax()ing the andnot()?  (and if so ...)
> 
> so I think that the comment is useless and can be removed because it
> was referring to a line code above the comment that was present in a
> previous iteration of the patchset. This line disappeared in final
> version but the comment has stayed.
> 
> If your question is: can we use atomic_fetch_andnot_relaxed() instead
> of atomic_fetch_andnot() in nohz_idle_balance() ?
> I think that it's possible

Ah!, thank you for the clarification.  Just sent a clean-up patch for
the comment (but deferring for the _relaxed() change...).

  Andrea


> 
> >
> >   Andrea
