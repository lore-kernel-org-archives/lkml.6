Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E92C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8729620658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 11:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XoZ+C9Ti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8729620658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeHaPUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 11:20:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60562 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeHaPUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 11:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2Kulq2o6y6oW+ZbHRNjinXQHvy9HQQV5t1WcNklJmHA=; b=XoZ+C9Ti04LPBLr5AMdxTciPn
        7Wka1mSg7oTd/FDj79ryD1SB87yn8SDLHXF161rHqaeiD3y0KszRcI+PvJQkom862ym1/B+KPzVt2
        tLCZyhkL9COaeTUm+a5re3uHcN61KCCWm8VqvjwjQDSLrIybsVuLQLO7qbJGBsuoKM637XOQOtY8h
        w152jVg35i9gkcpIU+c2mOhMoOhbPeFsGY2dEgddO0VBE48UfwhnUWt5F1u2UKULLiBNldYz9aXVv
        8+yhU0bQlfTFbAN+V09fYV8//wlPFnlZ62pLhBcO9QIxfZ82EMxHchdhgHrx2H3Qt5KmquWkaoBTX
        oALaaA4bQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvhMF-0003Ew-81; Fri, 31 Aug 2018 11:12:55 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A8E02024D425; Fri, 31 Aug 2018 13:12:53 +0200 (CEST)
Date:   Fri, 31 Aug 2018 13:12:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH 2/2] sched/topology: Expose numa_mask set/clear functions
 to arch
Message-ID: <20180831111253.GJ24124@hirez.programming.kicks-ass.net>
References: <20180808081942.GA37418@linux.vnet.ibm.com>
 <1533920419-17410-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1533920419-17410-2-git-send-email-srikar@linux.vnet.ibm.com>
 <20180829080219.GN24124@hirez.programming.kicks-ass.net>
 <20180831102724.GB8437@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831102724.GB8437@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 03:27:24AM -0700, Srikar Dronamraju wrote:
> * Peter Zijlstra <peterz@infradead.org> [2018-08-29 10:02:19]:


> Powerpc lpars running on Phyp have 2 modes. Dedicated and shared.
> 
> Dedicated lpars are similar to kvm guest with vcpupin.

Like i know what that means... I'm not big on virt. I suppose you're
saying it has a fixed virt to phys mapping.

> Shared  lpars are similar to kvm guest without any pinning. When running
> shared lpar mode, Phyp allows overcommitting. Now if more lpars are
> created/destroyed, Phyp will internally move / consolidate the cores. The
> objective is similar to what autonuma tries achieves on the host but with a
> different approach (consolidating to optimal nodes to achieve the best
> possible output).  This would mean that the actual underlying cpus/node
> mapping has changed.

AFAIK Linux can _not_ handle cpu:node relations changing. And I'm pretty
sure I told you that before.

> Phyp will propogate upwards an event to the lpar.  The
> lpar / os can choose to ignore or act on the same.
> 
> We have found that acting on the event will provide upto 40% improvement
> over ignoring the event. Acting on the event would mean moving the cpu from
> one node to the other, and topology_work_fn exactly does that.

How? Last time I checked there was a ton of code that relies on
cpu_to_node() not changing during the runtime of the kernel.

Stuff like the per-cpu memory allocations are done using the boot time
cpu_to_node() map for instance. Similarly, kthread creation uses the
cpu_to_node() map at the time of creation.

A lot of stuff is not re-evaluated. If you're dynamically changing the
node map, you're in for a world of hurt.

> In the case where we didn't have the NUMA sched domain, we would build the
> independent (aka overlap) sched_groups. With NUMA  sched domain
> introduction, we try to reuse sched_groups (aka non-overlay). This results
> in the above, which I thought I tried to explain in
> https://lwn.net/ml/linux-kernel/20180810164533.GB42350@linux.vnet.ibm.com

That email was a ton of confusion; you show an error and you don't
explain how you get there.

> In the typical case above, lets take 2 node, 8 core each having SMT 8
> threads.  Initially all the 8 cores might come from node 0.  Hence
> sched_domains_numa_masks[NODE][node1] and
> sched_domains_numa_mask[NUMA][node1] is set at sched_init_numa will have
> blank cpumasks.
> 
> Let say Phyp decides to move some of the load to another node, node 1, which
> till now has 0 cpus.  Hence we will see
> 
> "BUG: arch topology borken \n the DIE domain not a subset of the NODE
> domain"   which is probably okay. This problem is even present even before
> NODE domain was created and systems still booted and ran.

No that is _NOT_ OKAY. The fact that it boots and runs just means we
cope with it, but it violates a base assumption when building domains.

> However with the introduction of NODE sched_domain,
> init_sched_groups_capacity() gets called for non-overlay sched_domains which
> gets us into even worse problems. Here we will end up in a situation where
> sgA->sgB->sgC-sgD->sgA gets converted into sgA->sgB->sgC->sgB which ends up
> creating cpu stalls.
> 
> So the request is to expose the sched_domains_numa_masks_set /
> sched_domains_numa_masks_clear to arch, so that on topology update i.e event
> from phyp, arch set the mask correctly. The scheduler seems to take care of
> everything else.

NAK, not until you've fixed every cpu_to_node() user in the kernel to
deal with that mask changing.

This is absolutely insane.
