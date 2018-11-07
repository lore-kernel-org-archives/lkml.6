Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9B2C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A128C2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tRoTKjVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A128C2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbeKGT56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:57:58 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56636 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbeKGT55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:57:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VpEBND7swepGr1z6Igg4GFVtuhlwJCQ5TwgnQaDROF8=; b=tRoTKjVf09BwSH7lk+7J/urcM
        9Id3uWZo11rxEK5lxvxji+nJsp2SYg6KVs6SblUNlO/IpIW+sKRDN+QKA5ivnlk9XcXHafGrVUn8d
        /0k7QRuoxuWP+8pyetKe+lpiO1CJvZsi9q5XBJPi4V1rfES0chJFIQw/PNwkMEYGS+xvm/ZuyW6Cu
        ewQkbgTQiOdnM3b7vVuEjmRHxmsl+ezJeR/e3p2/Ba1CmLPduMJzx+hkmpXJTCWlrGc914igN6hmd
        7p13ekJLwaiC1GkCz3CxjNAn39ZPC0kJWhwMpNpx37YDZ9fCFzowWVD/djN3P6IbYjQoyfpz/dYU5
        G3K6Aaqpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKL3x-0004FJ-MM; Wed, 07 Nov 2018 10:27:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20BA62029F881; Wed,  7 Nov 2018 11:27:52 +0100 (CET)
Date:   Wed, 7 Nov 2018 11:27:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "aaron.lu@intel.com" <aaron.lu@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "bsd@redhat.com" <bsd@redhat.com>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jwadams@google.com" <jwadams@google.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "Pavel.Tatashin@microsoft.com" <Pavel.Tatashin@microsoft.com>,
        "prasad.singamsetty@oracle.com" <prasad.singamsetty@oracle.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "steven.sistare@oracle.com" <steven.sistare@oracle.com>,
        "tim.c.chen@intel.com" <tim.c.chen@intel.com>,
        "tj@kernel.org" <tj@kernel.org>, "vbabka@suse.cz" <vbabka@suse.cz>
Subject: Re: [RFC PATCH v4 01/13] ktask: add documentation
Message-ID: <20181107102752.GK9781@hirez.programming.kicks-ass.net>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-2-daniel.m.jordan@oracle.com>
 <20181106084911.GA22504@hirez.programming.kicks-ass.net>
 <20181106203411.pdce6tgs7dncwflh@ca-dmjordan1.us.oracle.com>
 <20181106205146.GB30490@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106205146.GB30490@mellanox.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 08:51:54PM +0000, Jason Gunthorpe wrote:
> On Tue, Nov 06, 2018 at 12:34:11PM -0800, Daniel Jordan wrote:
> 
> > > What isn't clear is if this calling thread is waiting or not. Only do
> > > this inheritance trick if it is actually waiting on the work. If it is
> > > not, nobody cares.
> > 
> > The calling thread waits.  Even if it didn't though, the inheritance trick
> > would still be desirable for timely completion of the job.
> 
> Can you make lockdep aware that this is synchronous?
> 
> ie if I do
> 
>   mutex_lock()
>   ktask_run()
>   mutex_lock()
> 
> Can lockdep know that all the workers are running under that lock?
> 
> I'm thinking particularly about rtnl_lock as a possible case, but
> there could also make some sense to hold the read side of the mm_sem
> or similar like the above.

Yes, the normal trick is adding a fake lock to ktask_run and holding
that over the actual job. See lock_map* in flush_workqueue() vs
process_one_work().


