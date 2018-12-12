Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D2AC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D786B2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D786B2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeLLSEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:04:46 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:55208 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727808AbeLLSEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:04:45 -0500
Received: (qmail 4736 invoked by uid 2102); 12 Dec 2018 13:04:44 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Dec 2018 13:04:44 -0500
Date:   Wed, 12 Dec 2018 13:04:44 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
cc:     David Goldblatt <davidtgoldblatt@gmail.com>,
        <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>, <triegel@redhat.com>,
        <libc-alpha@sourceware.org>, <andrea.parri@amarulasolutions.com>,
        <will.deacon@arm.com>, <peterz@infradead.org>,
        <boqun.feng@gmail.com>, <npiggin@gmail.com>, <dhowells@redhat.com>,
        <j.alglave@ucl.ac.uk>, <luc.maranget@inria.fr>, <akiyks@gmail.com>,
        <dlustig@nvidia.com>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Linux: Implement membarrier function
In-Reply-To: <20181212170706.GA17397@linux.ibm.com>
Message-ID: <Pine.LNX.4.44L0.1812121302270.1543-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018, Paul E. McKenney wrote:

> > > > Or am I still missing something here?
> > > 
> > > You tell me...
> > 
> > I think I am on board.  ;-)
> 
> And more to the point, here is a three-process variant showing a cycle
> that is permitted:
> 
> 
>          P0      P1      P2
>          Wa=2    Wb=2    Wc=2
>          mb0s
>                  [mb01]  [mb02]
>          mb0e
>          Rb=0    Rc=0    Ra=0
> 
> As can be seen by reordering it as follows:
> 
>          P0      P1      P2
>                          Ra=0
>          Wa=2
>          mb0s
>                  [mb01]
>                  Rc=0
>                          Wc=2
>                          [mb02]
>          mb0e
>          Rb=0
>                  Wb=2
> 
> Make sense?

You got it!

Alan

