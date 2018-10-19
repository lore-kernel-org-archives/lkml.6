Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F292ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E947F21470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dojz3/cJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E947F21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeJSW6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbeJSW6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:58:55 -0400
Received: from localhost (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39B9D2064A;
        Fri, 19 Oct 2018 14:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539960747;
        bh=rhbTZYZ3tUsux5xF4bPnH1rkACZPodNKgZ1QCyF2ZSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dojz3/cJWS3y9Oumcr1MPH4LeJTBe8Ktb8kk93BgEM66AluqpwimHE+AzPbdnVSRP
         rgCghQpAvcZklrur+FefSB+Sh+hHEzviZ85xvfL0ldoz7o4uRkHZ8zhpDR3Y9kfQ8k
         4QA6ABZGbwHk5yTTX8UpFyK9Z/QZoPSok+6DHHbY=
Date:   Fri, 19 Oct 2018 16:52:24 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>
Subject: Re: [RFC 00/60] Coscheduling for Linux
Message-ID: <20181019145223.GA15416@lerouge>
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <20181017020933.GC24723@lerouge>
 <a177875f-2072-ab55-b079-f2142d9b776e@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a177875f-2072-ab55-b079-f2142d9b776e@amazon.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 01:40:03PM +0200, Jan H. Schönherr wrote:
> On 17/10/2018 04.09, Frederic Weisbecker wrote:
> > On Fri, Sep 07, 2018 at 11:39:47PM +0200, Jan H. Schönherr wrote:
> >> C) How does it work?
> >> --------------------
> [...]
> >> For each task-group, the user can select at which level it should be
> >> scheduled. If you set "cpu.scheduled" to "1", coscheduling will typically
> >> happen at core-level on systems with SMT. That is, if one SMT sibling
> >> executes a task from this task group, the other sibling will do so, too. If
> >> no task is available, the SMT sibling will be idle. With "cpu.scheduled"
> >> set to "2" this is extended to the next level, which is typically a whole
> >> socket on many systems. And so on.  If you feel, that this does not provide
> >> enough flexibility, you can specify "cosched_split_domains" on the kernel
> >> command line to create more fine-grained scheduling domains for your
> >> system.
> > 
> > Have you considered using cpuset to specify the set of CPUs inside which
> > you want to coschedule task groups in? Perhaps that would be more flexible
> > and intuitive to control than this cpu.scheduled value.
> 
> Yes, I did consider cpusets. Though, there are two dimensions to it:
> a) at what fraction of the system tasks shall be coscheduled, and
> b) where these tasks shall execute within the system.
> 
> cpusets would be the obvious answer to the "where". However, in the current
> form they are too inflexible with too much overhead. Suppose, you want to
> coschedule two tasks on SMT siblings of a core. You would be able to
> restrict the tasks to a specific core with a cpuset. But then, it is bound
> to that core, and the load balancer cannot move the group of two tasks to a
> different core.
> 
> Now, it would be possible to "invent" relocatable cpusets to address that
> issue ("I want affinity restricted to a core, I don't care which"), but
> then, the current way how cpuset affinity is enforced doesn't scale for
> making use of it from within the balancer. (The upcoming load balancing
> portion of the coscheduler currently uses a file similar to cpu.scheduled
> to restrict affinity to a load-balancer-controlled subset of the system.)

Oh ok, I understand now. Affinity and node-scope mutual exclusion are
entirely decoupled, I see.

> 
> 
> Using cpusets as the mean to describe which parts of the system are to be
> coscheduled *may* be possible. But if so, it's a long way out. The current
> implementation uses scheduling domains for this, because (a) most
> coscheduling use cases require an alignment to the topology, and (b) it
> integrates really nicely with the load balancer.

So what is the need for cosched_split_domains? What kind of corner case won't
fit into scheduler domains? Can you perhaps spare that part in this patchset
to simplify it somehow? If it happens to be necessary, it can still be added
iteratively.

Thanks.

