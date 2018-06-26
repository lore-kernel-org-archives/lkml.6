Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03ACC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8804926CEE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IfROJ30o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8804926CEE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbeFZQdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:33:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49202 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751980AbeFZQdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 12:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2Xb50pWIHlJUmEyRzTKzn6yle+BTxGxcFHo2PrulaDs=; b=IfROJ30oJg8EfpeOPxYX7lyQp
        iK2qiSXmvk8H6sh1JiNZlbRu2fkalpsKCM9CMz5E53vuYdsNm/gO0t+tanU1ta0jKl94/DDtpL0Wf
        4O23TzoTzYX1uj2CcoCtROC4H3bKRH2MFMXRAM2fJXf/QeXHDIBt06OffJikGFLB8cj3sBHGkVvEH
        s/3OiEFQFi1TqBOl3/iZ1i+1yMycL3vjVWvKZjsssUUAF8fFtgiUQ1IsHp9U5IehmuEB846A0lq1Y
        Mz+Jx+8FgUm93+kFh+z9EGXdiU2tc0pd7Lp5ad7heiwq7de270oP28X+PTyPugb7HW05wjbKgsTIW
        NG4It6nKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXqtl-0003Nm-5x; Tue, 26 Jun 2018 16:32:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9B2402029F1D9; Tue, 26 Jun 2018 18:32:55 +0200 (CEST)
Date:   Tue, 26 Jun 2018 18:32:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: sched/core warning triggers on rcu torture test
Message-ID: <20180626163255.GG2458@hirez.programming.kicks-ass.net>
References: <alpine.DEB.2.21.1806261709001.19188@somnus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806261709001.19188@somnus>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 06:16:04PM +0200, Anna-Maria Gleixner wrote:
> Hi,
> 
> during rcu torture tests (TREE04 and TREE07) I noticed, that a
> WARN_ON_ONCE() in sched core triggers on a recent 4.18-rc2 based
> kernel (6f0d349d922b ("Merge
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net")) as well as
> on a 4.17.3.
> 
> I'm running the tests on a machine with 144 cores:
> 
>   tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 144 --duration 120 --configs "9*TREE07"
>   tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 144 --duration 120 --configs "18*TREE04"
> 
> 
> The warning was introduced by commit d84b31313ef8 ("sched/isolation:
> Offload residual 1Hz scheduler tick").
> 
> 
> Output looks similar for all tests I did (this one is the output of
> the 4.18-rc2 based kernel):
> 
> WARNING: CPU: 11 PID: 906 at kernel/sched/core.c:3138 sched_tick_remote+0xb6/0xc0

That's nohz_full stuff, is that a normal part of rcutorture? In any
case, is the one housekeeping CPU getting seriously overloaded or
something?
