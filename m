Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD743C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFEF2082B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Gqz7mivE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFEF2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeJKEfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:35:25 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38437 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeJKEfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:35:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id q19-v6so23917pll.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 14:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PDuqIALn1i+X2vOVw+K7nCtjRp1s1GJq7dtezCzIKno=;
        b=Gqz7mivETC0VPDC2/7p0ZP4H56lCH28iu9ljJp9l4kbfmRkYnBpepyWoFnSzuXuoF7
         1UFk7IgMPWX9dgphZS3lAvoPGmq0LTcoKiCu0ULEMnGzyzinjTUHmdKtgZ4asrzq1V1Y
         iJfhhew9o/8y0DpvaR6Rh8qxXZsc6M7IRtdZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PDuqIALn1i+X2vOVw+K7nCtjRp1s1GJq7dtezCzIKno=;
        b=myu5aEUK7iDH+toHLr4g2gf851OMH/NNCtM6512KiA1Ya6yog2hfVrdQO1YwpXExk9
         OXw7nYCRWwzaE2tJg+sTVX69HhIxY7C/tmyXmKJmgf2uI+yxuYMwCw1BknQkdr35lxyv
         pwYLKuWBqpNabPiO/Z6JOfoAwsRrfAqndUielTuTjAu5Ioz0PBuVdyV0Byrq0d/ECCFS
         iYv0V7NvWD9OH+pL2MaRPSnS9cyVDJKNJ4mMb7Dxn3ZXroiHQwFGGvRHYB2z/DdRhgIp
         4wHlHLcpWs/oC9OdyoLlCdUDEAPteyzoiaBy4FUPi0cW/gmL0GcT/ura1Uymns5OBDEy
         GwjQ==
X-Gm-Message-State: ABuFfohXOp1ij+79iyJRozRsV1AFVKtI7ihqhlpyAz7xqU6TBpniTE3h
        +TGdBM3z3SY1cDS1hnKYz5guOw==
X-Google-Smtp-Source: ACcGV60vsp39FCaVToGxwPu+3vlKM8k8a4U2aN8dV6iYpXpND4RA0mWfX/vQJfvemJZYv0ZUVwCziQ==
X-Received: by 2002:a17:902:b08e:: with SMTP id p14-v6mr34787431plr.241.1539205887364;
        Wed, 10 Oct 2018 14:11:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id u62-v6sm34355648pfu.69.2018.10.10.14.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 14:11:26 -0700 (PDT)
Date:   Wed, 10 Oct 2018 14:11:25 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        Kees Cook <keescook@chromium.org>
Subject: Re: First coccinelle script, need some help.
Message-ID: <20181010211125.GA128537@joelaf.mtv.corp.google.com>
References: <20181010193854.GA93016@joelaf.mtv.corp.google.com>
 <alpine.DEB.2.21.1810102217260.2479@hadrien>
 <20181010204517.GA109962@joelaf.mtv.corp.google.com>
 <alpine.DEB.2.21.1810102249410.2479@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810102249410.2479@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 10:51:28PM +0200, Julia Lawall wrote:
> 
> 
> On Wed, 10 Oct 2018, Joel Fernandes wrote:
> 
> > On Wed, Oct 10, 2018 at 10:23:18PM +0200, Julia Lawall wrote:
> > >
> > >
> > > On Wed, 10 Oct 2018, Joel Fernandes wrote:
> > >
> > > >
> > > > Hi!
> > > >
> > > > I am trying to determine if a function argument is used across the whole
> > > > kernel for a certain kernel function.
> > > >
> > > > I mustered up enough courage to write my first coccinelle script after a few
> > > > late nights of reading up about it :)
> > > >
> > > > Here is .cocci script. I am trying to find if address is used at all in any
> > > > possible definitions of pte_alloc():
> > > >
> > > > $ cat ~/pte_alloc.cocci
> > > > virtual report
> > > >
> > > > @pte_args depends on report@
> > > > identifier E1, E2;
> > > > type T1, T2;
> > > > position p;
> > > > @@
> > > >
> > > >  pte_alloc@p(T1 E1, T2 E2)
> > > >  {
> > > > ...
> > > > (
> > > > ...
> > > >  E2
> > > > ...
> > > > )
> > > > ...
> > > >  }
> > >
> > >
> > > In report mode, by default, the pattern has to match on all paths.  Also
> > > when you have ... before or after E2, there can be no occurrence of E2 in
> > > the code matched by the ...  So your rule requires that on every possible
> > > execution path through the function, there is exactly one occurrence of
> > > E2.
> > >
> > > You can try the following instead:
> > >
> > > virtual report
> > >
> > > @pte_args depends on report exists@
> > > identifier E1, E2;
> > > type T1, T2;
> > > position p;
> > > @@
> > >
> > >  pte_alloc@p(T1 E1, T2 E2)
> > >  {
> > >  ... when any
> > >  E2
> > >  ... when any
> > >  }
> >
> > Thanks for the quick reply.
> > If I just add 'depends on report exists' to the rule, then my original
> > example works fine now. I did not need to add the 'when any'. Do you mind
> > taking my original simple test.c example and modify it and let me know under
> > what situation would it not work?
> >
> > I even added address = 1 outside of the if block and it works fine, I see the
> > warning as I expect without 'when any' in pront of the "...".
> >
> > struct page *pte_alloc(struct mm_struct *mm, unsigned long address)
> > {
> > 	 address = 1;
> >          if (condition()) {
> > 		 while (1) {
> > 			address++;
> > 		 }
> >                 return NULL;
> >         }
> > }
> 
> This works, because there exists a path through the function that has only
> one use of address, ie the path where condition() is false.  It should
> break if you put address = 2; just under address = 1, for example.
> 
Ok, thanks. This fact really is a bit subtle I'd say but hopefully will not
be once I get past the learning curve. Interestingly, if I do the following
then that works too without needing 'exists':

virtual report

@pte_args depends on report@
identifier E1, E2;
type T1, T2;
position p;
@@

 pte_alloc@p(T1 E1, T2 E2)
 {
<+...
 E2
...+>
 }

@script:python depends on report@
p << pte_args.p;
@@
coccilib.report.print_report(p[0], "WARNING: found definition of pte_alloc with
address used in the body")

thanks,

 - Joel

