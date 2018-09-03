Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9751C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C22D2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 18:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OSF/b+3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C22D2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeICWth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:49:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44298 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbeICWth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:49:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id s10-v6so1384600edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 11:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jw8iGV0M/ViOfc7T+GBwUwyuTaeGsQVXV+V8obSCGD0=;
        b=OSF/b+3LaGSJMvSezVtQ625iK21MfiXd32a4sjiyklNkckx+CSx84s0KQorU6vfVUY
         Z0ZHAfbRrRCB8j55HV17PxYTjgOfvhknh3YkvN9EvDLmvyBBA80qIDbh1VrObozApT0g
         HVOrHbOGlELc19cGul+Bdp/gLyiRWK2hKMmlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jw8iGV0M/ViOfc7T+GBwUwyuTaeGsQVXV+V8obSCGD0=;
        b=e14gwpVD3lGB2k84ipKHxQ3xZc0yw68KZtSPkVO/ZSD+65Z7x6foaoSRNhM/5crahN
         NsRSdZrz/t+Oejoy8F8xVsBHVN/qrD+pySvu007l5YjLkOdtgCbcOE0Eh2Hw9lrN65Ie
         YziwuS00R6uANhBgwTJFxRjrSVKfrnk5Ezn+L5jD0aVpj/dguhOnFcZidumhTcQplofD
         IHV+RcEPHq3XQUX0lrWOlN2uvZEf3BWMyVnUv/OQYJP7xzBJ62Yr6uiEk6qQsZ2l0rYF
         7cb4DEWwptcju3fH33Ccv2YKd7WmHT7WHT80gKXmBUbwbRgGpPDv/O/iWDA1A/+5WZO0
         gzGw==
X-Gm-Message-State: APzg51DF4WHxRi558d0raE8LjxnDkB2HPBbULGs5ZS+Id6oEor3hhLxQ
        HEzp0invbT3lZmK9h98FZNCqww==
X-Google-Smtp-Source: ANB0VdZvMEPXTuvW1Vjo45K3p9lxbWPgZQKLpBcAMBeHbQE67EHxU8wlP04RsYbhjtMGmSOyirc6NQ==
X-Received: by 2002:a50:86cf:: with SMTP id 15-v6mr33820233edu.266.1535999292078;
        Mon, 03 Sep 2018 11:28:12 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id m35-v6sm8168629ede.14.2018.09.03.11.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 11:28:11 -0700 (PDT)
Date:   Mon, 3 Sep 2018 20:28:05 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Will Deacon <will.deacon@arm.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Message-ID: <20180903182805.GA6848@andrea>
References: <20180903090153.GA4560@andrea>
 <Pine.LNX.4.44L0.1809031346300.1940-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1809031346300.1940-100000@netrider.rowland.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 01:52:07PM -0400, Alan Stern wrote:
> On Mon, 3 Sep 2018, Andrea Parri wrote:
> 
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
> I thought the goal you were aiming for was a patch making
> atomic-acquire/ordinary-release be RCtso (along with lock/unlock),
> while leaving ordinary-acquire/ordinary-release to remain RCpc.  

Such a patch would belong to the second approach (the "two distinct
release-acquire" approach from my previous email).


> Clearly that is not what this patch does.

I meant the above ;-)  to illustrate yet another approach (not that
it makes me happy, as should be clear from previous posts ;-).

  Andrea


> 
> Alan
> 
