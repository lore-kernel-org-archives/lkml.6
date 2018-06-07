Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id K2lLNEwnGVtodQAAmS7hNA
	; Thu, 07 Jun 2018 12:39:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1D9F3608B8; Thu,  7 Jun 2018 12:39:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 86AF1608BA;
	Thu,  7 Jun 2018 12:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86AF1608BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753595AbeFGMjS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:39:18 -0400
Received: from outbound-smtp11.blacknight.com ([46.22.139.106]:43915 "EHLO
        outbound-smtp11.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753261AbeFGMjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:39:17 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp11.blacknight.com (Postfix) with ESMTPS id D124E1C2D7F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jun 2018 13:39:15 +0100 (IST)
Received: (qmail 30674 invoked from network); 7 Jun 2018 12:39:15 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.237.73])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 7 Jun 2018 12:39:15 -0000
Date: Thu, 7 Jun 2018 13:39:15 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Jakub Racek <jracek@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
Message-ID: <20180607123915.avrqbpp4adgj7ck4@techsingularity.net>
References: <20180606122731.GB27707@jra-laptop.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180606122731.GB27707@jra-laptop.brq.redhat.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 02:27:32PM +0200, Jakub Racek wrote:
> There is a huge performance regression on the 2 and 4 NUMA node systems on
> stream benchmark with 4.17 kernel compared to 4.16 kernel. Stream, Linpack
> and NAS parallel benchmarks show upto 50% performance drop.
> 

I have not observed this yet but NAS is the only one I'll see and that could
be a week or more away before I have data. I'll keep an eye out at least.

> When running for example 20 stream processes in parallel, we see the following behavior:
> 
> * all processes are started at NODE #1
> * memory is also allocated on NODE #1
> * roughly half of the processes are moved to the NODE #0 very quickly. *
> however, memory is not moved to NODE #0 and stays allocated on NODE #1
> 

Ok, 20 processes getting rescheduled to another node is not unreasonable
from a load-balancing perspective but memory locality is not always taken
into account. You also don't state what parallelisation method you used
for STREAM and it's relevant because of how tasks end up communicating
and what that means for placement.

The only automatic NUMA balancing patch I can think of that has a high
chance of being a factor is 7347fc87dfe6b7315e74310ee1243dc222c68086
but I cannot see how STREAM would be affected as I severely doubt
the processes are communicating heavily (unless openmp and then it's
a maybe). It might affect NAS because that does a lot of wakeups
via futex that has "interesting" characteristics (either openmp or
openmpi). 082f764a2f3f2968afa1a0b04a1ccb1b70633844 might also be a factor
but it's doubtful. I don't know about Linpack as I've never characterised
it so I don't know how it behaves.

There are a few patches that affect utilisation calculation which might
affect the load balancer but I can't pinpoint a single likely candidate.

Given that STREAM is usually short-lived, is bisection an option?

-- 
Mel Gorman
SUSE Labs
