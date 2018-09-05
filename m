Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C37C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D4C2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dlO6izT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D4C2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbeIEM3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:29:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58004 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeIEM3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Bccg/sqRmHoYryjYvfS8XDjyIJWrKKmY7wopmwauC3M=; b=dlO6izT4Gi+2NiVHVie8fGGP2
        fUxqSV/qj9zDBP9UJHwu5bHjPRJkruvFWfX0xleb9uAJAjEj2G5mz8MwUQeXBM3vAgsGNu6CIJPCU
        VPV/0NnRyKsiaQS5ba/f4IbjVkHrAj74CTQ+D02SX6XUIGcD5wp+6QlphYmtHNGOfjhitn/b+ahVA
        d5474rJT6xA4cJU/PhM3VJpWG8TVfKAUVwOiiHD8C0VUwNnAwp2UNHUAI+cq6kYBiU9moFHUGGk7x
        coyyQT1dw7oADON3XCUToyOURk6BMt5trGXK00PiMxk+S2TCz1A1b2v1YLWvzkKMH5zqN2GIPkLM2
        Rcpv7oqYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxSji-0003ky-0t; Wed, 05 Sep 2018 08:00:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D8D4C20191BFF; Wed,  5 Sep 2018 10:00:24 +0200 (CEST)
Date:   Wed, 5 Sep 2018 10:00:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 1/3] ptrace: Provide ___ptrace_may_access() that can
 be applied on arbitrary tasks
Message-ID: <20180905080024.GP24124@hirez.programming.kicks-ass.net>
References: <nycvar.YFH.7.76.1808312242130.25787@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809041619510.15880@cbobk.fhfr.pm>
 <alpine.LRH.2.00.1809041639340.14475@gjva.wvxbf.pm>
 <31436186-88da-324e-88a0-8fdca7bf60ac@linux.intel.com>
 <nycvar.YFH.7.76.1809041932590.15880@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1809041932590.15880@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 07:35:29PM +0200, Jiri Kosina wrote:
> On Tue, 4 Sep 2018, Tim Chen wrote:
> 
> > > Current ptrace_may_access() implementation assumes that the 'source' task is
> > > always the caller (current).
> > > 
> > > Expose ___ptrace_may_access() that can be used to apply the check on arbitrary
> > > tasks.
> > 
> > Casey recently has proposed putting the decision making of whether to
> > do IBPB in the security module.
> > 
> > https://lwn.net/ml/kernel-hardening/20180815235355.14908-4-casey.schaufler@intel.com/
> > 
> > That will have the advantage of giving the administrator a more flexibility
> > of when to turn on IBPB.  The policy is very similar to what you have proposed here
> > but I think the security module is a more appropriate place for the security policy.
> 
> Yeah, well, honestly, I have a bit hard time buying the "generic 
> sidechannel prevention security module" idea, given how completely 
> different in nature all the mitigations have been so far. I don't see that 
> trying to abstract this somehow provides more clarity.
> 
> So if this should be done in LSM, it'd probably have to be written by 
> someone else than me :) who actually understands how the "sidechannel LSM" 
> idea works.

Yeah, I'm not convinced on LSM either. Lets just do these here patches
first and then Casey can try and convince us later.
