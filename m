Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD356C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343642402A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CMq+K9iL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343642402A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753955AbeGESip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:38:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44277 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753801AbeGESio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:38:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so1824026wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 11:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cbWeiiWjQG4J0l9cQArX/tn4RYhC0qL2JDK3ilfR7TM=;
        b=CMq+K9iLtV5A0sXgk7W9NmOo22DIvScH+cbuPPx4U4dFVAd4KBVlNxs4PQPMm7FpiG
         38eoE8dWfZTcbybumVINJ+cN9ewm7G+Q75xAE+gzK9REQMRx8ueBRq7gVX9rES8/2HfW
         nQCUZgRjCM/TnTMyukRva4C2UumIQFnbXKosQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cbWeiiWjQG4J0l9cQArX/tn4RYhC0qL2JDK3ilfR7TM=;
        b=FgIzN5Z7LX+AKXXeb4jfHPLmUyAPu1GjL02KpSdAdgLTFGQ0WzuvhvROij/bpte8ul
         zbES/Lbw8P54eBf2M4jlyn9rEa48VnrBUYsKwtKa1jjuYdDxbie17BE3fDnPkGBVA6jD
         u2zh1sYP5DFijbo79spmBaaLrG8UaLky+yLbij5Aqy5dBg4Tka5PovDaFK4Z0+suMiKd
         sXrr3IZFkiif7ifknvQzrZgNFCu5RJrF+5hIOXdPQM+ttR5ji69bKeLIEHQSyAz8tPVc
         IfEweJBMt4IfdUdn0tNaYKp9SJp82wFgiSIwy3hUJB6X21XjUAkW+4JQ9KqdrcOYe6eT
         w6vA==
X-Gm-Message-State: APt69E3iiubZQgOaRqIHZhoNQpgxALXGeiL6KL01tKWTGiWIn6vR+g+M
        Mq87/lorSLGcQdUmPWZ7k7G1fA==
X-Google-Smtp-Source: AAOMgpfsKrdBYbpThsk9Dw7TyiGtrvHqmzopT0TDJmpbmpYmpgbvmlF/m7RcZY+GyIIvvW7RwihRrA==
X-Received: by 2002:a5d:41c1:: with SMTP id e1-v6mr5436479wrq.25.1530815923070;
        Thu, 05 Jul 2018 11:38:43 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id o21-v6sm3068836wmg.28.2018.07.05.11.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 11:38:42 -0700 (PDT)
Date:   Thu, 5 Jul 2018 20:38:36 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Daniel Lustig <dlustig@nvidia.com>
Cc:     paulmck@linux.vnet.ibm.com, Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Message-ID: <20180705183836.GA3175@andrea>
References: <20180704121103.GB26941@arm.com>
 <Pine.LNX.4.44L0.1807051010380.1697-100000@iolanthe.rowland.org>
 <20180705153140.GO3593@linux.vnet.ibm.com>
 <b41849a8-76cd-2375-dd80-c1bdeb9ea7d2@nvidia.com>
 <20180705162225.GH14470@arm.com>
 <20180705165602.GQ3593@linux.vnet.ibm.com>
 <eeaf2ad2-39a0-2ce9-b628-6775baad4e8a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeaf2ad2-39a0-2ce9-b628-6775baad4e8a@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> No, I'm definitely not pushing for anything stronger.  I'm still just
> wondering if the name "RCsc" is right for what you described.  For
> example, Andrea just said this in a parallel email:
> 
> > "RCsc" as ordering everything except for W -> R, without the [extra]
> > barriers

And I already regret it: the point is, different communities/people have
different things in mind when they use terms such as "RCsc" or "ordering"
and different communities seems to be represented in LKMM.

Really, I don't think that this is simply a matter of naming (personally,
I'd be OK with "foo" or whather you suggested below! ;-)). My suggestion
would be: "get in there!! ;-) please let's refrain from using terms such
as these (_overly_ overloaded) "RCsc" and "order" when talking about MCM
let's rather talk, say, about "ppo", "cumul-fence" ...

  Andrea


> 
> If it's "RCsc with exceptions", doesn't it make sense to find a
> different name, rather than simply overloading the term "RCsc" with
> a subtly different meaning, and hoping nobody gets confused?
> 
> I suppose on x86 and ARM you'd happen to get "true RCsc" anyway, just
> due to the way things are currently mapped: LOCKed RMWs and "true RCsc"
> instructions, respectively.  But on Power and RISC-V, it would really
> be more "RCsc with a W->R exception", right?
> 
> In fact, the more I think about it, this doesn't seem to be RCsc at all.
> It seems closer to "RCpc plus extra PC ordering between critical
> sections".  No?
> 
> The synchronization accesses themselves aren't sequentially consistent
> with respect to each other under the Power or RISC-V mappings, unless
> there's a hwsync in there somewhere that I missed?  Or a rule
> preventing stw from forwarding to lwarx?  Or some other higher-order
> effect preventing it from being observed anyway?
> 
> So that's all I'm suggesting here.  If you all buy that, maybe "RCpccs"
> for "RCpc with processor consistent critical section ordering"?
> I don't have a strong opinion on the name itself; I just want to find
> a name that's less ambiguous or overloaded.
> 
> Dan
