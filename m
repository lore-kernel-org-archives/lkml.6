Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CF9C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C812A20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KKHngPJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C812A20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbeICNVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:21:14 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43432 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeICNVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:21:14 -0400
Received: by mail-ed1-f68.google.com with SMTP id z27-v6so198024edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 02:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BhyGaEiW0TQATt0rsMOO5ZpjXwenfIn0ANTVymX1oOE=;
        b=KKHngPJPJ7Nle90v+KO2SVa8EAim8R20XZiOiBwlouM+6gJ3BG1P1Gxg6G+zJzC5NQ
         +ZUlng4CK8G10OMzRkYhlhpnCVyCNAEf+DC6HwlzzkzWT0I8HMXA+5LjYE8QsXc96piZ
         c4BCpzHlZkWt+d9NeeG0TDybxE3QMVhzH2FNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BhyGaEiW0TQATt0rsMOO5ZpjXwenfIn0ANTVymX1oOE=;
        b=IQVTwjDhYGpE4Q9dFswo7q2RMGPPRXOJLpQlHI7CU9PgxAO+3M3k+nkL7hpg1qu6Fg
         9QKa/7Mp2BgHTKauI7NJ8Hdeq1BO/jHgp8Gph94HE64WkBr/zJIKWWFyGFNkw2qznhj6
         gvdzw6nhyeBFf8S+IkWrqq19ZWKZPLM5QLSufAYEc1Gm0qOwaBEbcRUek163OlV9iGaS
         0XqibVR4+Q9o+xBH3Gf44krMKefjmW1ywHvfJMy2bI39gWd95Lb4hYwsZSatDM0RcFyS
         3akY+yAvjQboBZpGl1lviOB/8iMQJcSawhsxVgxd//SG52Q4JgxLSZW2hjJi3KaDo46i
         PwEQ==
X-Gm-Message-State: APzg51BMEw3nCaNftuDo9/QxJOWqvGzT3ZDnnos22npWQKtZsiY7Wl3n
        CmgseyRh0d5yCdz87LlSObIgFQ==
X-Google-Smtp-Source: ANB0VdZe2NXaDk27GpN44QEVqZ3H5SDxsnnPqCW1/9K2hCVgFgtGq/ms7TrA/Xlq2my1As/du4qKfA==
X-Received: by 2002:a50:908d:: with SMTP id c13-v6mr31745763eda.179.1535965321027;
        Mon, 03 Sep 2018 02:02:01 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id w3-v6sm11015143edb.16.2018.09.03.02.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 02:02:00 -0700 (PDT)
Date:   Mon, 3 Sep 2018 11:01:53 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20180903090153.GA4560@andrea>
References: <20180831091641.GA3634@andrea>
 <Pine.LNX.4.44L0.1808311042340.4901-100000@netrider.rowland.org>
 <20180831160640.GG30626@arm.com>
 <20180831182845.GA4673@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831182845.GA4673@andrea>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 08:28:46PM +0200, Andrea Parri wrote:
> > > Yes, it's true that implementing locks with atomic_cmpxchg_acquire 
> > > should be correct on all existing architectures.  And Paul has invited 
> > > a patch to modify the LKMM accordingly.  If you feel that such a change 
> > > would be a useful enhancement to the LKMM's applicability, please write 
> > > it.
> > 
> > Yes, please! That would be the "RmW" discussion which Andrea partially
> > quoted earlier on, so getting that going independently from this patch
> > sounds like a great idea to me.
> 
> That was indeed one of the proposal we discussed.  As you recalled, that
> proposal only covered RmWs load-acquire (and ordinary store-release); in
> particular, I realized that comments such as:
> 
>   "The atomic_cond_read_acquire() call above has provided the
>    necessary acquire semantics required for locking."
> 
>    [from kernel/locking/qspinlock.c]
> 
> (for example)  would still _not have "generic validity" _if we added the
> above po-unlock-rf-lock-po term... (which, again, makes me somehow uncon-
> fortable);  Would to have _all_ the acquire be admissible for you?

In Cat speak,

diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 59b5cbe6b6240..fd9c0831adf0a 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -38,7 +38,7 @@ let strong-fence = mb | gp
 (* Release Acquire *)
 let acq-po = [Acquire] ; po ; [M]
 let po-rel = [M] ; po ; [Release]
-let rfi-rel-acq = [Release] ; rfi ; [Acquire]
+let po-rel-rf-acq-po = po ; [Release] ; rf ; [Acquire] ; po
 
 (**********************************)
 (* Fundamental coherence ordering *)
@@ -60,13 +60,13 @@ let dep = addr | data
 let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int)
-let to-r = addr | (dep ; rfi) | rfi-rel-acq
+let to-r = addr | (dep ; rfi)
 let fence = strong-fence | wmb | po-rel | rmb | acq-po
-let ppo = to-r | to-w | fence
+let ppo = to-r | to-w | fence | (po-rel-rf-acq-po & int)
 
 (* Propagation: Ordering from release operations and strong fences. *)
 let A-cumul(r) = rfe? ; r
-let cumul-fence = A-cumul(strong-fence | po-rel) | wmb
+let cumul-fence = A-cumul(strong-fence | po-rel) | wmb | po-rel-rf-acq-po
 let prop = (overwrite & ext)? ; cumul-fence* ; rfe?
 
 (*

I take this opportunity to summarize my viewpoint on these matters:

Someone would have to write the commit message for the above diff ...
that is, to describe -why- we should go RCtso (and update the documen-
tation accordingly); by now, the only argument for this appears to be:
"(most) people expect strong ordering" _and they will be "lazy enough"
to not check their expectations by using the LKMM tool (paraphrasing
from [1]); IAC, Linux "might work" better if we add this ordering to
the LKMM.  Agreeing on such an approach would mean agreeing that this
argument "wins" over:

  "We want new architectures to implement acquire/release efficiently,
   and it's not unlikely that they will have acquire loads that are
   similar in semantics to LDAPR." [2]

  "RISC-V probably would have been RCpc [...]  it takes extra fences
   to go from RCpc to either "RCtso" or RCsc." [3]

(or similar instances) since, of course, there is no such thing as a
"free strong ordering"; and I'm not only talking about "efficiency",
I'm also thinking at the fact that someone will have to maintain that
ordering across all the architectures and in the LKMM.

If, OTOH, we agree that the above "win"/assumption is valid only for
locks or, in other/better words, if we agree that we should maintain
_two_ distinct release-acquire orderings (a first one for unlock-lock
sequences and a second one for ordinary/atomic release-acquire, say,
as proposed in the patch under RFC), I ask that we audit and modify
the generic code accordingly/as suggested in other posts _before_ we
upstream the changes for the LKMM: we should identify those places
where (the newly introduced) _gap_ between unlock-lock and the other
release-acquire is not admissible and fix those places (notice that
this entails, in part., agreeing on what/where the generic code is).

Finally, if we don't agree with the above assumption at all (that is,
no matter if we are considering unlock-lock or other release-acquire
sequences), then we should go RCpc [4].

I described three different approaches (which are NOT "independent",
clearly; let us find an agreement...); even though some of them look
insane to me, I'm currently open to all of them: thoughts?

  Andrea

[1] http://lkml.kernel.org/r/20180712134821.GT2494@hirez.programming.kicks-ass.net
    http://lkml.kernel.org/r/CA+55aFwKpkU5C23OYt1HCiD3X5bJHVh1jz5G2dSnF1+kVrOCTA@mail.gmail.com
[2] http://lkml.kernel.org/r/20180622183007.GD1802@arm.com
[3] http://lkml.kernel.org/r/11b27d32-4a8a-3f84-0f25-723095ef1076@nvidia.com
[4] http://lkml.kernel.org/r/20180711123421.GA9673@andrea
    http://lkml.kernel.org/r/Pine.LNX.4.44L0.1807132133330.26947-100000@netrider.rowland.org
