Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA2CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455A420C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KTWspeQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455A420C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389520AbeGKP7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:59:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52280 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732411AbeGKP7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:59:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id w16-v6so2881323wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 08:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0NiVOQl85yPhLiBSFHhmGg9rxycMtbbw4a1glDcPLjc=;
        b=KTWspeQN5zZzDEdpFmgNsgAHsBQGjOLm6Gv60DBSYHYIxqSR4Ekl0F8lt+QKlSu9Dk
         +/Tui4stQ74EswHDMXRGMTbyi2vodfx0OrfmN/qlKc/quuKSsXywW9/xw6sjHae1mWTB
         vZ55wYL2B+CcscN3Zm5JP35t3NZQZjwrucz4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0NiVOQl85yPhLiBSFHhmGg9rxycMtbbw4a1glDcPLjc=;
        b=k1MbGNxDIWopUJP70mbaF8TUoHxilHrZmOcRkyIEiJXZKtFwJeclEIW5k0qG8CzW2y
         U09ugkabDnBreyOXQoS41MUHcJ/HbL8Tv2J/llXppkpRjwHDLpf6mcxZ8TeMsTSX4ScO
         zOhn/4Dq8F8AEVyu6SvXfE9mu4EYED/SOaJKZISh403cHb7exR/ZY5FwB21OUa9/9e2S
         QReH2lJZ3pG7uI2SVMEZLy93seL4UVTGIBvKoCtixpJt3+BLjLANqVWa0/3kqDOToNgI
         7vSwyHiXWL7+quF4toGs7HQyfL8WfMNFWG30dezZXowC91T4TRNgbLPz8B9mH0vxfrs/
         aqow==
X-Gm-Message-State: APt69E2ejo0Fupa75PVLWGAMMqLLLmr61DFPDTngXxBRcKwjN7YezsWY
        9FDz2c8VaMYjthNFQanfnaRlHA==
X-Google-Smtp-Source: AAOMgpeTh+4i89VdFA+B0t+Off1AW7YW6XMp7H8a2PriDQscXYiMleromtW1dhvTw6cZgM5sh8oHyQ==
X-Received: by 2002:a1c:7c13:: with SMTP id x19-v6mr19106956wmc.27.1531324441364;
        Wed, 11 Jul 2018 08:54:01 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id b190-v6sm3712157wma.24.2018.07.11.08.54.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 08:54:00 -0700 (PDT)
Date:   Wed, 11 Jul 2018 17:53:55 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] doc: Replace smp_cond_acquire() with
 smp_cond_load_acquire()
Message-ID: <20180711154830.GA14348@andrea>
References: <1531216943-6382-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1531314530-11624-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20180711153840.GS3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711153840.GS3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 08:38:40AM -0700, Paul E. McKenney wrote:
> On Wed, Jul 11, 2018 at 03:08:50PM +0200, Andrea Parri wrote:
> > Amend commit 1f03e8d2919270 ("locking/barriers: Replace smp_cond_acquire()
> > with smp_cond_load_acquire()") by updating the documentation accordingly.
> > Also remove some obsolete information related to the implementation.
> > 
> > Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> > Cc: Luc Maranget <luc.maranget@inria.fr>
> > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > Cc: Akira Yokosawa <akiyks@gmail.com>
> > Cc: Daniel Lustig <dlustig@nvidia.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > ---
> >  Documentation/memory-barriers.txt | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> I have queued this for further review, thank you!  Just to confirm,
> the reason that the old passage was obsolete is because ARMv8 implements
> smp_cond_load_acquire() as a straight acquire load, correct?

Thanks.  Yes; the generic code builds on a control dependency and an
smp_acquire__after_ctrl_dep() (which defaults to smp_rmb()); but the
required ordering on arm64 is given by (its) smp_load_acquire().

I thought that entering this level of details (and keeping it up-to-
date ;) wasn't really worth/needed for this high-level doc.

  Andrea


> 
> 							Thanx, Paul
> 
> > diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> > index 0d8d7ef131e9a..c1d913944ad8b 100644
> > --- a/Documentation/memory-barriers.txt
> > +++ b/Documentation/memory-barriers.txt
> > @@ -471,8 +471,7 @@ And a couple of implicit varieties:
> >       operations after the ACQUIRE operation will appear to happen after the
> >       ACQUIRE operation with respect to the other components of the system.
> >       ACQUIRE operations include LOCK operations and both smp_load_acquire()
> > -     and smp_cond_acquire() operations. The later builds the necessary ACQUIRE
> > -     semantics from relying on a control dependency and smp_rmb().
> > +     and smp_cond_load_acquire() operations.
> > 
> >       Memory operations that occur before an ACQUIRE operation may appear to
> >       happen after it completes.
> > -- 
> > 2.7.4
> > 
> 
