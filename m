Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D739C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C698320652
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HuhiMKTw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C698320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932764AbeFUJ1o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 05:27:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54596 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932534AbeFUJ1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 05:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JSOZVtQOypHIPrxa8fKJl9JPZDlOm7if4F1KKmt8WwI=; b=HuhiMKTwtH2WKvve7v73eWhCu
        c3hRhtjagvoQlXzwr7WIIY6/ZwFoj9ulGutKtuQ/uLQ+cjuWlxtvEmETS8eakjotcpcnio/S/pp4e
        G2NRjB6jh2DhkhqAutO6RMndfH8sDjBbdGM3AekW7HS7S08WcwIkrWHE8C3mdDtokYvdX+8f2tVbg
        Cy8o9M9gUk9GdxMKRWhbgiuSkZ8yrpB4ubxsk9ay0OR0LwCpbKoUpAIHtE9j7+qNIaDLATUSdva8U
        5/QyufwXlgftgwDkWWoFKrTzAatdkSCabLAPQAq/akL1IFgblbOiLF0Da1XwKYfazdMwjjaiMyer5
        KpUSr69FQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVvsH-0002e6-Rr; Thu, 21 Jun 2018 09:27:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2C90C2029F1DB; Thu, 21 Jun 2018 11:27:28 +0200 (CEST)
Date:   Thu, 21 Jun 2018 11:27:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v10 2/9] cpuset: Add new v2 cpuset.sched.domain_root flag
Message-ID: <20180621092728.GV2494@hirez.programming.kicks-ass.net>
References: <1529295249-5207-1-git-send-email-longman@redhat.com>
 <1529295249-5207-3-git-send-email-longman@redhat.com>
 <20180620142735.GM2494@hirez.programming.kicks-ass.net>
 <b44b0748-9fec-6bb0-7665-435487e5d8b3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b44b0748-9fec-6bb0-7665-435487e5d8b3@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 03:58:06PM +0800, Waiman Long wrote:
> On 06/20/2018 10:27 PM, Peter Zijlstra wrote:
> > On Mon, Jun 18, 2018 at 12:14:01PM +0800, Waiman Long wrote:
> >> +  cpuset.sched.domain_root
> > Why are we calling this a domain_root and not a partition?
> 
> A partition can consist of several cgroups in a tree structure. That
> flag should only be set at the root of a partition. I will change the
> name to partition_root if you think this name is acceptable.

The flag indicates the 'effective_cpus' things of the current group is a
partition. The fact that it can have sub-partitions doesn't really
matter does it.

Just call it 'partition', leave out the whole root stuff, all of cgroup
is hierarchical and you can have sub-groups we don't go around calling
everything a root.
