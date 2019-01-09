Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BADC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17F221738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbfAIKH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:07:56 -0500
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:57234 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729896AbfAIKHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:07:55 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id 8681E98B69
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 10:07:53 +0000 (UTC)
Received: (qmail 12814 invoked from network); 9 Jan 2019 10:07:53 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.96])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Jan 2019 10:07:53 -0000
Date:   Wed, 9 Jan 2019 10:07:51 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] RFC: sched/fair: skip select_idle_sibling() in
 presence of sync wakeups
Message-ID: <20190109100751.GQ31517@techsingularity.net>
References: <20190109034941.28759-1-aarcange@redhat.com>
 <1547007588.17100.17.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1547007588.17100.17.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 05:19:48AM +0100, Mike Galbraith wrote:
> > To test I used this trivial program.
> 
> Which highlights the problem.  That proggy really is synchronous, but
> the sync hint is applied to many MANY real world cases where this is
> not the case at all.  Sure, you can make things like pipe_test and
> nearly nonexistent payload TCP_RR numbers look gorgeous, but that
> demolishes concurrency for real applications.
> 

I agree with Mike here. Many previous attempts to strictly obey the strict
hint has led to regressions elsewhere -- specifically a task waking 2+
wakees that temporarily stack on one CPU when nearby CPUs sharing LLC
remain idle. It's why the select idle sibling logic tried to take into
account a recently used CPU to wake such tasks if the recent CPU was
still idle.

-- 
Mel Gorman
SUSE Labs
