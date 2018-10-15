Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B3BC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C25208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C25208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeJOWyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:54:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56431 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeJOWyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:54:47 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gC4UR-0000vY-7k; Mon, 15 Oct 2018 17:09:03 +0200
Date:   Mon, 15 Oct 2018 17:09:03 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: Use cpus_read_lock() while looking at
 cpu_online_mask
Message-ID: <20181015150902.asifwhikqkz53ai4@linutronix.de>
References: <20180910135615.tr3cvipwbhq6xug4@linutronix.de>
 <20180911160532.GJ4225@linux.vnet.ibm.com>
 <20180911162142.cc3vgook2gctus4c@linutronix.de>
 <20180911170222.GO4225@linux.vnet.ibm.com>
 <20180919205521.GE902964@devbig004.ftw2.facebook.com>
 <20180919221140.GH4222@linux.ibm.com>
 <20181012184114.w332lnkc34evd4sm@linutronix.de>
 <20181013134813.GD2674@linux.ibm.com>
 <20181015144217.nu5cp5mxlboyjbre@linutronix.de>
 <20181015150715.GA2422@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181015150715.GA2422@tardis>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-15 23:07:15 [+0800], Boqun Feng wrote:
> Hi, Sebastian
Hi Boqun,

> On Mon, Oct 15, 2018 at 04:42:17PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2018-10-13 06:48:13 [-0700], Paul E. McKenney wrote:
> > > 
> > > My concern would be that it would queue it by default for the current
> > > CPU, which would serialize the processing, losing the concurrency of
> > > grace-period initialization.  But that was a long time ago, and perhaps
> > > workqueues have changed. 
> > 
> > but the code here is always using the first CPU of a NUMA node or did I
> > miss something?
> > 
> 
> The thing is the original way is to pick one CPU for a *RCU* node to
> run the grace-period work, but with your proposal, if a RCU node is
> smaller than a NUMA node (having fewer CPUs), we could end up having two
> grace-period works running on one CPU. I think that's Paul's concern.

Ah. Okay. From what I observed, the RCU nodes and NUMA nodes were 1:1
here. Noted.
Given that I can enqueue a work item on an offlined CPU I don't see why
commit fcc6354365015 ("rcu: Make expedited GPs handle CPU 0 being
offline") should make a difference. Any objections to just revert it?

> Regards,
> Boqun

Sebastian
