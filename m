Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1760CC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A31F20663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 22:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dyUmlH95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A31F20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbeJWGiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 02:38:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33212 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbeJWGiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 02:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uqZjL42rA+d/Yp/3YjWgxa9nIHn4R35ZtLi1LJrro1M=; b=dyUmlH95lP9Yeh6bGrKvrVHvb
        5glXKKCKSNMa4z7MyBOAnFU300xSq1vT/4OqNpq9LBQymaMhC/wOFh4P84jP/IOHZJ5jqBmE/UiTx
        7kRzysGY1A+lun7+uRAQc5wkUVVLIBGsJmbj8mzjzu5snkczORvurz6eti3ypqCsZgbBFQo1ps0pp
        XSRO6DmJsyoKYOuUjiPBcoQ40eF0fgdCRcv/hqp4XgFwByE4ZmFEjVYQS8UnzAq0U4XRxonv3zlt7
        8SmBs96Ils0Rhb1GwQmWsd/xD2Z6Kqpkbhv81KpcCBbKHyW4ZTYYdOV7YFRErN2JETYA2ISjG32vD
        KBQbpHK6g==;
Received: from [167.98.65.38] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEiWC-0007IG-BZ; Mon, 22 Oct 2018 22:17:48 +0000
Received: by worktop (Postfix, from userid 1000)
        id 39A296E08B7; Tue, 23 Oct 2018 00:09:35 +0200 (CEST)
Date:   Tue, 23 Oct 2018 00:09:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Sistare <steven.sistare@oracle.com>
Cc:     mingo@redhat.com, subhra.mazumdar@oracle.com,
        dhaval.giani@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] steal tasks to improve CPU utilization
Message-ID: <20181022220935.GD3109@worktop.c.hoisthospitality.com>
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
 <20181022170421.GF3117@worktop.programming.kicks-ass.net>
 <8e38ce84-ec1a-aef7-4784-462ef754f62a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e38ce84-ec1a-aef7-4784-462ef754f62a@oracle.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 03:07:10PM -0400, Steven Sistare wrote:
> On 10/22/2018 1:04 PM, Peter Zijlstra wrote:
> > On Mon, Oct 22, 2018 at 07:59:31AM -0700, Steve Sistare wrote:
> >> When a CPU has no more CFS tasks to run, and idle_balance() fails to
> >> find a task, then attempt to steal a task from an overloaded CPU in the
> >> same LLC. Maintain and use a bitmap of overloaded CPUs to efficiently
> >> identify candidates.  To minimize search time, steal the first migratable
> >> task that is found when the bitmap is traversed.  For fairness, search
> >> for migratable tasks on an overloaded CPU in order of next to run.
> >>
> >> This simple stealing yields a higher CPU utilization than idle_balance()
> >> alone, because the search is cheap, so it may be called every time the CPU
> >> is about to go idle.  idle_balance() does more work because it searches
> >> widely for the busiest queue, so to limit its CPU consumption, it declines
> >> to search if the system is too busy.  Simple stealing does not offload the
> >> globally busiest queue, but it is much better than running nothing at all.
> > 
> > Why I don't dislike the idea; I feel it is unfortunate to have two
> > different mechanisms to do effectively the same thing.
> > 
> > Can't we improve idle_balance() instead of building this parallel
> > functionality?
> 
> We could delete idle_balance() and use stealing exclusively for handling
> new idle.  For each sd level, stealing would look for an overloaded CPU
> in the overloaded bitmap(s) that overlap that level.  I played with that
> a little but it is not ready for prime time, and I did not want to hold
> the patch series for it.  Also, I would like folks to get some production
> experience with stealing on a variety of architectures before considering
> a radical step like replacing idle_balance().

Fair enough. And yes, it might make sense to fully replace the current
newidle balance with something along these lines.

> We could remove the core and socket levels from idle_balance() and let
> stealing handle those levels.  I think that makes sense after stealing
> performance is validated on more architectures, but we would still have
> two different mechanisms.

Yes, this would be a fairly simple change and make sense until we have a
full replacement.

> We could merge the stealing code into the idle_balance() code to get a
> union of the two, but IMO that would be less readable.

Agreed; I don't think that'll be pretty.
