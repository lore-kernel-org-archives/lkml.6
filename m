Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356ABC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB09207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB09207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeJXTtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:49:40 -0400
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:39951 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727000AbeJXTtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:49:40 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id DD33A98A44
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 11:21:54 +0000 (UTC)
Received: (qmail 6832 invoked from network); 24 Oct 2018 11:21:54 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.142])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 Oct 2018 11:21:54 -0000
Date:   Wed, 24 Oct 2018 12:21:53 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Yi Wang <wang.yi59@zte.com.cn>, zhong.weidong@zte.com.cn,
        Yi Liu <liu.yi24@zte.com.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] sched/core: Don't mix isolcpus and housekeeping CPUs
Message-ID: <20181024112153.GD23537@techsingularity.net>
References: <1540350169-18581-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20181024085636.GB23537@techsingularity.net>
 <20181024094646.GA18466@linux.vnet.ibm.com>
 <20181024101508.GP3109@worktop.c.hoisthospitality.com>
 <20181024104124.GC18466@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20181024104124.GC18466@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 04:11:24PM +0530, Srikar Dronamraju wrote:
> * Peter Zijlstra <peterz@infradead.org> [2018-10-24 12:15:08]:
> 
> > On Wed, Oct 24, 2018 at 03:16:46PM +0530, Srikar Dronamraju wrote:
> > > * Mel Gorman <mgorman@techsingularity.net> [2018-10-24 09:56:36]:
> > > 
> > > > On Wed, Oct 24, 2018 at 08:32:49AM +0530, Srikar Dronamraju wrote:
> > > > It would certainly be a bit odd because the
> > > > application is asking for some protection but no guarantees are given
> > > > and the application is not made aware via an error code that there is a
> > > > problem. Asking the application to parse dmesg hoping to find the right
> > > > error message is going to be fragile.
> > > 
> > > Its a actually a good question.
> > > What should we be doing if a mix of isolcpus and housekeeping (aka
> > > non-isolcpus) is given in the mask.
> > > 
> > > Right now as you pointed, there is no easy way for the application to know
> > > which are the non-isolcpus to set its affinity. cpusets effective_cpus and
> > > cpus_allowed both will contain isolcpus too.
> > 
> > The easy option is to not use isolcpus :-) It is a horrifically bad
> > interface.
> 
> Agree, but thats something thats been exposed long time back.
> Do we have an option to remove that?  Hopefully nobody is using it.
> 

I occasionally see bugs asking questions about interference from the kernel
when isolcpus are in use. The last one was related to a timer interrupt
every HZ (not a mainline kernel) but still, it's some evidence that it
has users :(

-- 
Mel Gorman
SUSE Labs
