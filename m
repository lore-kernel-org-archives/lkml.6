Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0689C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC8320843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rgLXT/on"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC8320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbeIDMfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:35:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33038 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeIDMfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:35:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id d8-v6so2553149edv.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SY6hL+KOZVIvJWGE6JEJGD430REn1VGv4J5nTNdxQfA=;
        b=rgLXT/onGKIOxkidTPPwdgzz7iHILIzyD5qex/DZwTeh0AgjIbh8QNyPkutk420GNp
         xfuovPDVmugJOJ9ci2XbWMGHidAfkVIYRJE+QFYEseucmBKvPQRiekee4xRXrdP6F7s0
         6f6aTwWAnJHfpIZl8XLZymX2uN/l7JloSmfQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SY6hL+KOZVIvJWGE6JEJGD430REn1VGv4J5nTNdxQfA=;
        b=SUE0x6xXF5EZWgaCA6/YS4zSCt9tDw3rYHhgEWQrjE3z60eXuYRED/KJSVImxEFCOe
         dRzUbuCT0CDkiVMjF86/WtK6FKaNhXQzP9ioiiwRPZPC68AcOd04frtOvjkjbxQBlNGo
         g5zuXZiDNvdNiHGjw9De7xSu728jwEbnYdsgJyYOOKavqVL8iucbclOgLNL2oDxl3OXV
         C9bFJNYGoMg6ATp8+B5ANadreRe3ibXSBMPtnaaoyNfClH7bXHrKuKYHBT1eyh/AwR0E
         66w6i5fnxAlVef/4mhK5nMqCcnT9r7Zzlh5xiqmIJbhGLYiBacc85RW67g1Wk73kUGAw
         ZfKw==
X-Gm-Message-State: APzg51A3p4bTMxIb7VXhaDLq+SvZUgvhjh9CdkgnNGR/+Zfy1DQEd6Zi
        FLo8d8KRwPbEID4PKMuSddUDlA==
X-Google-Smtp-Source: ANB0VdZ/W3ncG1mKvg0Xudi8PPHT2b7sFkEXPl1JC+z5b0gbBO3oi6wHkVTj5K9ZqVEioQ2GXEYNFQ==
X-Received: by 2002:a50:c8c3:: with SMTP id k3-v6mr22552776edh.193.1536048711042;
        Tue, 04 Sep 2018 01:11:51 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id r44-v6sm13267940edd.87.2018.09.04.01.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 01:11:50 -0700 (PDT)
Date:   Tue, 4 Sep 2018 10:11:44 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20180904081144.GA4137@andrea>
References: <20180831091641.GA3634@andrea>
 <Pine.LNX.4.44L0.1808311042340.4901-100000@netrider.rowland.org>
 <20180831160640.GG30626@arm.com>
 <20180831182845.GA4673@andrea>
 <20180903090153.GA4560@andrea>
 <20180903170412.GL6954@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903170412.GL6954@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > In Cat speak,
> > 
> > diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> > index 59b5cbe6b6240..fd9c0831adf0a 100644
> > --- a/tools/memory-model/linux-kernel.cat
> > +++ b/tools/memory-model/linux-kernel.cat
> > @@ -38,7 +38,7 @@ let strong-fence = mb | gp
> >  (* Release Acquire *)
> >  let acq-po = [Acquire] ; po ; [M]
> >  let po-rel = [M] ; po ; [Release]
> > -let rfi-rel-acq = [Release] ; rfi ; [Acquire]
> > +let po-rel-rf-acq-po = po ; [Release] ; rf ; [Acquire] ; po
> >  
> >  (**********************************)
> >  (* Fundamental coherence ordering *)
> > @@ -60,13 +60,13 @@ let dep = addr | data
> >  let rwdep = (dep | ctrl) ; [W]
> >  let overwrite = co | fr
> >  let to-w = rwdep | (overwrite & int)
> > -let to-r = addr | (dep ; rfi) | rfi-rel-acq
> > +let to-r = addr | (dep ; rfi)
> >  let fence = strong-fence | wmb | po-rel | rmb | acq-po
> > -let ppo = to-r | to-w | fence
> > +let ppo = to-r | to-w | fence | (po-rel-rf-acq-po & int)
> >  
> >  (* Propagation: Ordering from release operations and strong fences. *)
> >  let A-cumul(r) = rfe? ; r
> > -let cumul-fence = A-cumul(strong-fence | po-rel) | wmb
> > +let cumul-fence = A-cumul(strong-fence | po-rel) | wmb | po-rel-rf-acq-po
> >  let prop = (overwrite & ext)? ; cumul-fence* ; rfe?
> >  
> >  (*
> 
> Isn't the job of the memory model to formalise the guarantees provided by
> the implementation? Your diff appears to do exactly the opposite.

This wouldn't be the first time..., but what am I missing?


> 
> > I take this opportunity to summarize my viewpoint on these matters:
> > 
> > Someone would have to write the commit message for the above diff ...
> > that is, to describe -why- we should go RCtso (and update the documen-
> > tation accordingly); by now, the only argument for this appears to be:
> > "(most) people expect strong ordering" _and they will be "lazy enough"
> > to not check their expectations by using the LKMM tool (paraphrasing
> > from [1]); IAC, Linux "might work" better if we add this ordering to
> > the LKMM.  Agreeing on such an approach would mean agreeing that this
> > argument "wins" over:
> > 
> >   "We want new architectures to implement acquire/release efficiently,
> >    and it's not unlikely that they will have acquire loads that are
> >    similar in semantics to LDAPR." [2]
> > 
> >   "RISC-V probably would have been RCpc [...]  it takes extra fences
> >    to go from RCpc to either "RCtso" or RCsc." [3]
> > 
> > (or similar instances) since, of course, there is no such thing as a
> > "free strong ordering"; and I'm not only talking about "efficiency",
> > I'm also thinking at the fact that someone will have to maintain that
> > ordering across all the architectures and in the LKMM.
> > 
> > If, OTOH, we agree that the above "win"/assumption is valid only for
> > locks or, in other/better words, if we agree that we should maintain
> > _two_ distinct release-acquire orderings (a first one for unlock-lock
> > sequences and a second one for ordinary/atomic release-acquire, say,
> > as proposed in the patch under RFC), I ask that we audit and modify
> > the generic code accordingly/as suggested in other posts _before_ we
> > upstream the changes for the LKMM: we should identify those places
> > where (the newly introduced) _gap_ between unlock-lock and the other
> > release-acquire is not admissible and fix those places (notice that
> > this entails, in part., agreeing on what/where the generic code is).
> 
> This is completely unrealistic. Have we already audited the kernel for the
> current definition of the memory model? Should we revert it until we have?

??  The fact that we've not audited the entire kernel does not mean
that we should throw away what has been already audited and verified
(over time).

IIUC, you're telling that we have a bunch of acquire/release spread
across generic locking code _and_ responsible for providing the lock
/unlock ordering guarantees, BUT we have no means to identify them.

I would have said "hard", but hear you say "unrealistic" represents
for me a very strong ARGUMENT AGAINST that "let us have two release-
acquire..."


> 
> Of course not.
> 
> Right now, LKMM offers stronger guarantees that can portably be relied upon
> in the codebase. Alan's patch fixes that, and holding back a fix for a known
> issue runs counter to kernel development best practices.

Then say so (and explain) in the commit message; AFAICT, failing to
do so would also run counter best practices.


> 
> > Finally, if we don't agree with the above assumption at all (that is,
> > no matter if we are considering unlock-lock or other release-acquire
> > sequences), then we should go RCpc [4].
> > 
> > I described three different approaches (which are NOT "independent",
> > clearly; let us find an agreement...); even though some of them look
> > insane to me, I'm currently open to all of them: thoughts?
> 
> I'm very confused by your statements hypothesising about where our opinions
> may lie. We've discussed this to death, and it's clear that everybody who's
> commented apart from you is happy to weaken acquire/release but leave
> locking alone. Alan's written a patch to that effect which, again, only you
> seem to have a problem with.

Heh, your confusion might be the reflection of mine... ;-)  That was
indeed a long and not conclusive discussion (meaning there're pending
issues); and I cannot claim to find "arguments" such as:

  "More than one kernel developer has expressed the opinion that
   the LKMM should enforce ordering of writes by locking."

particularly helpful (I do tend to be convinced by arguments rather
than by opinions).  In fact, you can take the following as my only
current "constructive argument" against the patch [1,2]:

  THE COMMIT MESSAGE IS RIDICULOUS; PLEASE EXPAND ON IT, AND DO
  SO BY LEVERAGING BOTH PROS AND CONS OF THE APPLIED CHANGES


> 
> The problem isn't about "if we agree foo" or "if we don't agree bar", the
> problem is that you're the only person raising an objection, so please can
> you provide a constructive argument against Alan's patch, rather than a
> confusing monologue of "what-if"s and unreasonable demands of anonymous
> contributors? We don't have to solve all of our problems before we can
> make any progress.

Hope the above can help,

  Andrea

[1] http://lkml.kernel.org/r/20180710093821.GA5414@andrea
[2] http://lkml.kernel.org/r/20180830125045.GA6936@andrea


> 
> Thanks,
> 
> Will
