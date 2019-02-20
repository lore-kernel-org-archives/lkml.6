Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8073BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CB12085A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AcLw3j9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfBTNP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:15:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46064 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfBTNP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:15:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id w17so25867458wrn.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 05:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=puOjBPwdyUJ8VgskaoyBatQQgP14EjOb2EGjiXvEVwM=;
        b=AcLw3j9+qMOaWzku8jngwIH+4oJs5oSdFgPw0EtmK708xSQSdktIAoR2imSVbH/uyP
         aVUTdo0KxuW5CwP+xo+YxcBVo72QH7Ldd326Dre69PRvpmFPy2uWooZCNiwpAABJgSET
         DQjzjTpT1H4D1Wtjsh/laXJioXbh2qoguO4UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=puOjBPwdyUJ8VgskaoyBatQQgP14EjOb2EGjiXvEVwM=;
        b=VxfHbn0pXiOupwO66fBPrqNdFxJHu208RvGznC0PYO4a5LrTgMYQe0lf5LDqFp0NPf
         KPNNryhUVwL2LYA5HM53BMruwph4eX7N/SR4AFTuuxSJrljG2eMWBIC38uEo4x04b8t/
         Y8Ho6Sz45pkMs8dy1HliVImxHGV2uMaRf6Xe0LPxHAsHdENjQPMVnhG+L+Eoz0vytIVD
         01onJCRXRq7t4GDuYTu8/q5TccJ4A2U2t+fW5irH/oAr0Q1GC6ybvcEbBJ14hSCOyvw4
         xST+kuSq1O16cxNc423NKV2wqJY4PlrzUaZy44x4gxGMdKS/abKU8jrJNiY3PzGv6y/z
         KBMg==
X-Gm-Message-State: AHQUAuZ6ZU2QDDhoA1ve60eo3U+1qBlUZpslWqKVCgNJq5Afz0ZaDN7b
        wAAnZZuf+v4h/CS1FYTr7B7E7w==
X-Google-Smtp-Source: AHgI3IadQBSwyPvG7soCAv8a5KLWpyXY89KCWcisxT0yEdobPLdQcpZUNNC4QV5MSV4vDhaQwWH22g==
X-Received: by 2002:adf:9f54:: with SMTP id f20mr25205236wrg.88.1550668525064;
        Wed, 20 Feb 2019 05:15:25 -0800 (PST)
Received: from andrea ([89.22.71.151])
        by smtp.gmail.com with ESMTPSA id m4sm6136902wmi.3.2019.02.20.05.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 05:15:24 -0800 (PST)
Date:   Wed, 20 Feb 2019 14:14:56 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Message-ID: <20190220131456.GA3215@andrea>
References: <1550617057-4911-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190220020117.GD11787@linux.ibm.com>
 <20190220092604.GD32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220092604.GD32494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 10:26:04AM +0100, Peter Zijlstra wrote:
> On Tue, Feb 19, 2019 at 06:01:17PM -0800, Paul E. McKenney wrote:
> > On Tue, Feb 19, 2019 at 11:57:37PM +0100, Andrea Parri wrote:
> > > Remove this subtle (and, AFAICT, unused) ordering: we can add it back,
> > > if necessary, but let us not encourage people to rely on this thing.
> > > 
> > > For example, the following "exists" clause can be satisfied with this
> > > change:
> > > 
> > > C dep-rfi
> > > 
> > > { }
> > > 
> > > P0(int *x, int *y)
> > > {
> > > 	WRITE_ONCE(*x, 1);
> > > 	smp_store_release(y, 1);
> > > }
> > > 
> > > P1(int *x, int *y, int *z)
> > > {
> > > 	int r0;
> > > 	int r1;
> > > 	int r2;
> > > 
> > > 	r0 = READ_ONCE(*y);
> > > 	WRITE_ONCE(*z, r0);
> > > 	r1 = smp_load_acquire(z);
> > > 	r2 = READ_ONCE(*x);
> > > }
> > > 
> > > exists (1:r0=1 /\ 1:r2=0)
> > 
> > Any objections?  If I don't hear any in a couple days, I will apply this.
> 
> IIUC you cannot build hardware that allows the above, so why would we
> allow it?

The change/simplification was mainly intended as precautionary measure
(hence the "we can add it back, ..."): I do agree that it shouldn't be
possible to realize the above state; OTOH, you really don't need to be
too "creative" to imagine possible mis-uses/mis-interpretations of the
(dep ; rfi) term ("forget" ONCEs, trick herd7 with "false dependencies"
or simply wrongly assume that control dependencies are part this "dep",
what else? ...).  So, no, I'm not that fond to this term; why should I
be?  or you are simply suggesting to expand the changelog?

I should probably also remark that "such a simplification" wouldn't be
a first time for the LKMM and, in fact, for the ppo term itself:

  https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/LWNLinuxMM/WeakModel.html#Preserved%20Program%20Order

  Andrea
