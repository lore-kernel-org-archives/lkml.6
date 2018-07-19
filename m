Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36659ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E1420684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tBRQS7fK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E1420684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbeGSOBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:01:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730899AbeGSOBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cc72GVGe+gKbKerlxDkv31VhiqymTnnXhleURTpZrpM=; b=tBRQS7fKILX5iFNGRWVefIvYj
        OjHyoA0Gt2+xhfCm1oAvHgzPBozsDlVIMLblTXX3AVdnxhzJ1Fd70X1mQn+1pONgletaYfwq9zhGV
        ZxcodwZXwkbXLyQ8zlhwoI99bbOe0VN5+ucBNwzY1Yr8IlagXbVSsIzvtL7vGMDzf94edgykOqLgL
        fl/c7k2czebmE0KDBWpHZNUCSJTtNxUsXh01TtdrIbYMGbFy9g8LFLMtsZQznG3jpfjl73StwhFoV
        Oau2kEG5mmlvsl04cBr+KSc5EOIKTDyXbCdwG64FvGfihf+wXdEzjvtkPO9Auw7h8Dvc3HiobQqFz
        32l/WUiDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg8pJ-0005x4-UP; Thu, 19 Jul 2018 13:18:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 29DB820275F38; Thu, 19 Jul 2018 15:18:36 +0200 (CEST)
Date:   Thu, 19 Jul 2018 15:18:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 08/10] psi: pressure stall information for CPU, memory,
 and IO
Message-ID: <20180719131836.GG2476@hirez.programming.kicks-ass.net>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
 <20180718120318.GC2476@hirez.programming.kicks-ass.net>
 <20180719092614.GY2512@hirez.programming.kicks-ass.net>
 <20180719125038.GB13799@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719125038.GB13799@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 08:50:38AM -0400, Johannes Weiner wrote:
> On Thu, Jul 19, 2018 at 11:26:14AM +0200, Peter Zijlstra wrote:
> > On Wed, Jul 18, 2018 at 02:03:18PM +0200, Peter Zijlstra wrote:
> > 
> > > Leaving us just 5 bytes short of needing a single cacheline :/
> > > 
> > > struct ponies {
> > >         unsigned int               tasks[3];                                             /*     0    12 */
> > >         unsigned int               cpu_state:2;                                          /*    12:30  4 */
> > >         unsigned int               io_state:2;                                           /*    12:28  4 */
> > >         unsigned int               mem_state:2;                                          /*    12:26  4 */
> > > 
> > >         /* XXX 26 bits hole, try to pack */
> > > 
> > >         /* typedef u64 */ long long unsigned int     last_time;                          /*    16     8 */
> > >         /* typedef u64 */ long long unsigned int     some_time[3];                       /*    24    24 */
> > >         /* typedef u64 */ long long unsigned int     full_time[2];                       /*    48    16 */
> > >         /* --- cacheline 1 boundary (64 bytes) --- */
> > >         /* typedef u64 */ long long unsigned int     nonidle_time;                       /*    64     8 */
> > > 
> > >         /* size: 72, cachelines: 2, members: 8 */
> > >         /* bit holes: 1, sum bit holes: 26 bits */
> > >         /* last cacheline: 8 bytes */
> > > };
> > > 
> > > ARGGH!
> > 
> > It _might_ be possible to use curr->se.exec_start for last_time if you
> > very carefully audit and place the hooks. I've not gone through it in
> > detail, but it might just work.
> 
> Hnngg, and chop off an entire cacheline...

Yes.. a worthy goal :-)

> But don't we flush that delta out and update the timestamp on every
> tick?

Indeed.

> entity_tick() does update_curr(). That might be too expensive :(

Well, since you already do all this accounting on every enqueue/dequeue,
this can run many thousands of times per tick already, so once per tick
doesn't sound bad.

However, I just realized this might not in fact work, because
curr->se.exec_start is per task, and you really want something per-cpu
for this.

Bah, if only perf had a useful tool to report on data layout instead of
this c2c crap.. :-( The thinking being that we could maybe find a
usage-hole (a data member that is not in fact used) near something we
already touch for writing. 




