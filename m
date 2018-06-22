Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A201BC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6031F2412C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LwwnoD6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6031F2412C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbeFVL0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:26:02 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44106 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbeFVL0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:26:01 -0400
Received: by mail-wr0-f193.google.com with SMTP id p12-v6so4730922wrn.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 04:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C0KzWf+zEU3XSMoJL5Q33CEk8TLAG+TRW0TBcIn/UPA=;
        b=LwwnoD6S4tukVUc4gYe0u4lxiuucDsnm7mkODloW6lWemOyrs7BQmXLM2GoXm2ox/K
         m1cV3/5AbuqhS0qFGUbsTrG1KbINWVs2U2EojUyEfbfi6Ry40NqZYOm5Mx/wQ6OYM7s7
         9MyVuCus2PQ8Ba6guZMyjk8L9AP3ypyihwjps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C0KzWf+zEU3XSMoJL5Q33CEk8TLAG+TRW0TBcIn/UPA=;
        b=Gdr+lWLojh9iaQ8kZKJiv1oiChTJGlu2MN30o2T5xcDcg/Nyf4+AiENC+XwseSIMXI
         jVcPVjhPjPHiMBduLv/kz2ruXuJkRfNt7lHkMVuUczOZX/KAm3Unc/RAhAlcNMaZPzN/
         fhg2cY4bhLS9nJCcVLw5ONJFVMB8Wm7CiwONJIAqcxnTs/lUH40tuxhiMXklLGzkKgbp
         8AkZeoI4JmyAkDBrt3JGkKhIwf0U3IqqFpm3hp2VQwZQP7Ogp+diRY3Wwcgqn2z3s5Nd
         3BtNvyqzqkdnv05vfruWqgUQiUgF4ei6wad33qoQk1A+w5g17GeylppCyZmjog05ZC9Y
         w3yQ==
X-Gm-Message-State: APt69E2hAZKnyjAZHHIl2JIZEGTGclCFqS9S61QtAq9htqc/8PIaDuFR
        mo+1uN+IXvYqWOjbo9u+O5S4PQ==
X-Google-Smtp-Source: AAOMgpdXC+Vpyg5/Kug+4gINwQgv8S9AtSZ++KWUr4ibD+3W9f79w4OrgbLnJ55/uRSRDA0UrdFErw==
X-Received: by 2002:adf:8af5:: with SMTP id z50-v6mr1257010wrz.22.1529666760407;
        Fri, 22 Jun 2018 04:26:00 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id v10-v6sm10807079wrn.97.2018.06.22.04.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 04:25:59 -0700 (PDT)
Date:   Fri, 22 Jun 2018 13:25:53 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Message-ID: <20180622112553.GA10658@andrea>
References: <Pine.LNX.4.44L0.1806211322160.2381-100000@iolanthe.rowland.org>
 <20180622080928.GB7601@arm.com>
 <20180622095547.GE7601@arm.com>
 <20180622103129.GQ2476@hirez.programming.kicks-ass.net>
 <20180622103838.GF7601@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622103838.GF7601@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I also just realised that this prevents Power from using ctrl+isync to
> > > implement acquire, should they wish to do so.
> > 
> > They in fact do so on chips lacking LWSYNC, see how PPC_ACQUIRE_BARRIER
> > (as used by atomic_*_acquire) turns into ISYNC (note however that they
> > do not use PPC_ACQUIRE_BARRIER for smp_load_acquire -- because there's
> > no CTRL there).
> 
> Right, so the example in the commit message is broken on PPC then. I think
> it's also broken on RISC-V, despite the claim.

I agree for RISC-V (and I missed it in my earlier review): the 2nd
snippet from the commit message would map to something like

   fence rw, w
   STORE #1,[x]
   LOAD  [x]
   fence r ,rw
   STORE #1,[y]

and there would be no guarantee that the stores to x and y will be
propagated in program order to another CPU, AFAICT.  Thank you for
pointing this out.

  Andrea
