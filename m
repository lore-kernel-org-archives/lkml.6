Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C10C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181C820673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WrG0IRrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181C820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbeGSOgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:36:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38638 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730451AbeGSOgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9y3ZpgYtdHV1f5BZq6DQpPBciG7Ugn3PjPKzl3567fA=; b=WrG0IRrJDAoztD1ygNlKx0ZMy
        H4cajpz3fEjWshpAWul5YTB+vvRw2sl+8Wqp+j/CqSN8K8U9bQ9QnPWQ0AUAKi10+KrRmu2vRDbw7
        sO/4dh2KBbnwmWG3tWPINmKMNG9q9lLF/a2B4TUJXDU+2npeNJ7db91ABeBAioZqGB7kzldpesq9P
        NwT/N7vgtbzyD9cl9C9WuIpzaPvPdoCX2FuS6Hehq10QPf8dcwrfzB8uYauKoJlWfxBwU3op3h1j+
        3Qmgwp7L9cS3OCKzyrvmvWUBKPCN4tUVC064E3G2LOWV2p5tJ4hRSpA9Rb7z2kU//Dfv8l8XUILDi
        GZNucCFNA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg9M3-0003eS-BJ; Thu, 19 Jul 2018 13:52:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B410B20289330; Thu, 19 Jul 2018 15:52:24 +0200 (CEST)
Date:   Thu, 19 Jul 2018 15:52:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Waiman Long <longman@redhat.com>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v11 7/9] cpuset: Expose cpus.effective and mems.effective
 on cgroup v2 root
Message-ID: <20180719135224.GE2494@hirez.programming.kicks-ass.net>
References: <1529825440-9574-1-git-send-email-longman@redhat.com>
 <1529825440-9574-8-git-send-email-longman@redhat.com>
 <20180702165322.GI533219@devbig577.frc2.facebook.com>
 <bc59aa0a-70fd-583f-452d-9a947757cb69@redhat.com>
 <20180703155823.GS533219@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703155823.GS533219@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 08:58:23AM -0700, Tejun Heo wrote:
> Hello, Waiman.
> 
> On Tue, Jul 03, 2018 at 08:41:31AM +0800, Waiman Long wrote:
> > > So, effective changing when enabling partition on a child feels wrong
> > > to me.  It's supposed to contain what's actually allowed to the cgroup
> > > from its parent and that shouldn't change regardless of how those
> > > resources are used.  It's still given to the cgroup from its parent.
> > 
> > Another way to work around this issue is to expose the reserved_cpus in
> > the parent for holding CPUs that can taken by a chid partition. That
> > will require adding one more cpuset file for those cgroups that are
> > partition roots.
> 
> Yeah, that should work.
> 
> > I don't mind restricting that to the first level children for now. That
> > does restrict where we can put the container root if we want a separate
> > partition for a container. Let's hear if others have any objection about
> > that.
> 
> As currently implemented, partioning locks away the cpus which should
> be a system level decision, not container level, so it makes sense to
> me that it is only available to system root.

I'm terribly confused, what?!

Why would a container not be allowed to create partitions for its
various RT workloads?
