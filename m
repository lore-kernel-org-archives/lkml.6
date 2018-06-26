Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A1FC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA2B257F8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PpCGpnW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA2B257F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752344AbeFZPtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:49:17 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47780 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbeFZPtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g7l/Wpr4y387DyKpP5NSfi6g0+0kJ3joaNa4U7Xqwio=; b=PpCGpnW1VVxMEw8w91U7V0Oga
        cyAEqcDv+jFnRuaTMaBimK9A+jK16uYp8aKJ0mnBsBlLqzWyPyOxEM5J0cbeaUvydRRRed0kcdTid
        KPODOycUr6ZBt29gn8pKsQnNKthoHjkUuHFOUROyrtfxgpfX1wmxmPEUEX8WqKNrcbrvcuSRVhXL/
        mvbPAMCK1ms4uRzKOG5b/a5f22E4LcrFcyXPRDK3j20udgETjQ6tCYmEnOvfVMnE6IE6LaEbXzXBr
        UoPzpM2PQL5F6Yn2lwNdmKAEqjK8nwiOz8PXA2zo7JDnyzZQQkw6su9Fdls0TBDDjl/iEZ5qqX6QW
        CpfSZlSWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXqDP-0002tH-7p; Tue, 26 Jun 2018 15:49:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 919502029F1DB; Tue, 26 Jun 2018 17:49:08 +0200 (CEST)
Date:   Tue, 26 Jun 2018 17:49:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/cputime: Ensure correct utime and stime proportion
Message-ID: <20180626154908.GE2458@hirez.programming.kicks-ass.net>
References: <20180622071542.61569-1-xlpang@linux.alibaba.com>
 <b9363fa9-826f-611f-3ab3-27e50c03422a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9363fa9-826f-611f-3ab3-27e50c03422a@linux.alibaba.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 08:19:49PM +0800, Xunlei Pang wrote:
> On 6/22/18 3:15 PM, Xunlei Pang wrote:
> > We use per-cgroup cpu usage statistics similar to "cgroup rstat",
> > and encountered a problem that user and sys usages are wrongly
> > split sometimes.
> > 
> > Run tasks with some random run-sleep pattern for a long time, and
> > when tick-based time and scheduler sum_exec_runtime hugely drifts
> > apart(scheduler sum_exec_runtime is less than tick-based time),
> > the current implementation of cputime_adjust() will produce less
> > sys usage than the actual use after changing to run a different
> > workload pattern with high sys. This is because total tick-based
> > utime and stime are used to split the total sum_exec_runtime.
> > 
> > Same problem exists on utime and stime from "/proc/<pid>/stat".
> > 
> > [Example]
> > Run some random run-sleep patterns for minutes, then change to run
> > high sys pattern, and watch.
> > 1) standard "top"(which is the correct one):
> >    4.6 us, 94.5 sy,  0.0 ni,  0.9 id, 0.0 wa, 0.0 hi, 0.0 si, 0.0 st
> > 2) our tool parsing utime and stime from "/proc/<pid>/stat":
> >    20.5 usr, 78.4 sys
> > We can see "20.5 usr" displayed in 2) was incorrect, it recovers
> > gradually with time: 9.7 usr, 89.5 sys
> > 
> High sys probably means there's something abnormal on the kernel
> path, it may hide issues, so we should make it fairly reliable.
> It can easily hit this problem with our per-cgroup statistics.
> 
> Hi Peter, any comment on this patch?

Well, no, because the Changelog is incomprehensible and the patch
doesn't really have useful comments, so I'll have to reverse engineer
the entire thing, and I've just not had time for that.
