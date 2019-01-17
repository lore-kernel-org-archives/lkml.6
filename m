Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D00BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4592420859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gb3Z2a5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfAQINc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:13:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42296 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfAQINb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y4uxIJ+NmKS4i1/qDFOJcjGOWHA5fYMzGvsJDpvLNMk=; b=Gb3Z2a5/SgLc7y6cDeKRsD6/b
        UGyiZaiVvFOZBwXSKjGIYRsQNt6oZrxmzioVR9lNQDxgqinTD+S5lDERHN1ve0DaliP4AwKyITgCM
        A+UCHwHAEEHzqwPGKMUytNEjA1IxycEObBOFm2SKjW9QKxa4IhnfAgppSs+foYr4ZPx9gJsX9BStQ
        sBlgLXbY4Pr9Ohz+5g94z2E7eFXauAu5PKKbSLuqAPScIthGvavDjNylmSQvJQsT1cvRNkkMqFHVK
        cfKQWe6maqz0v82+VU2+yFeXHBL3SWB5DG6pWbwzELav8dUpHCYgZnkf3mU7rYJrOR8kw1h8KeQfb
        TUhbIbMqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gk2nc-0005l8-6v; Thu, 17 Jan 2019 08:13:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 403C2202647C2; Thu, 17 Jan 2019 09:13:14 +0100 (CET)
Date:   Thu, 17 Jan 2019 09:13:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, lizefan@huawei.com, axboe@kernel.dk,
        dennis@kernel.org, Dennis Zhou <dennisszhou@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Subject: Re: [PATCH v2 5/5] psi: introduce psi monitor
Message-ID: <20190117081314.GD10486@hirez.programming.kicks-ass.net>
References: <20190110220718.261134-1-surenb@google.com>
 <20190110220718.261134-6-surenb@google.com>
 <20190114102137.GB14054@worktop.programming.kicks-ass.net>
 <CAJuCfpGUWs0E9oPUjPTNm=WhPJcE_DBjZCtCiaVu5WXabKRW6A@mail.gmail.com>
 <20190116132446.GF10803@hirez.programming.kicks-ass.net>
 <CAJuCfpEJW6Uq4GSGEGLKOM4K7ySHUeTGrSUGM1+EJSQ16d8SJg@mail.gmail.com>
 <20190116191728.GA1380@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116191728.GA1380@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 02:17:28PM -0500, Johannes Weiner wrote:

> > > Also, you probably want to use atomic_t for g->polling, because we
> > > (sadly) have architectures where regular stores and atomic ops don't
> > > work 'right'.
> > 
> > Oh, I see. Will do. Thanks!
> 
> Yikes, that's news to me too. Good to know.

See Documentation/atomic_t.txt, specifically the atomic_set() part in
SEMANTICS.

Archs that suffer this include (but are not limited to): parisc,
sparc32-smp, something arc.

And yes, I would dearly love to kill all SMP support for architectures
like that..
