Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C53ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 00:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612E020647
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 00:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612E020647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeGUBNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 21:13:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:58982 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727224AbeGUBNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 21:13:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7D181AE7A;
        Sat, 21 Jul 2018 00:22:59 +0000 (UTC)
Date:   Fri, 20 Jul 2018 17:22:54 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH -next 0/2] fs/epoll: loosen irq safety when possible
Message-ID: <20180721002254.kwsdw7xhlogx7fr4@linux-r8p5>
References: <20180720172956.2883-1-dave@stgolabs.net>
 <20180720124212.7260d76d83e2b8e5e3349ea5@linux-foundation.org>
 <20180720200559.27nc7j2rrxpy5p3n@linux-r8p5>
 <20180720134429.1ba61018934b084bb2e17bdb@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180720134429.1ba61018934b084bb2e17bdb@linux-foundation.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018, Andrew Morton wrote:

>Did you try measuring it on bare hardware?

I did and wasn't expecting much difference.

For a 2-socket 40-core (ht) IvyBridge on a few workloads, unfortunately
I don't have a xen environment and the results for Xen I do have (which numbers
are in patch 1) I don't have the actual workload, so cannot compare them directly.

1) Different configurations were used for a epoll_wait (pipes io) microbench
(http://linux-scalability.org/epoll/epoll-test.c) and shows around a 7-10%
improvement in overall total number of times the epoll_wait() loops when using
both regular and nested epolls, so very raw numbers, but measurable nonetheless.

# threads	vanilla		dirty
     1		1677717		1805587
     2		1660510		1854064
     4		1610184		1805484
     8		1577696		1751222
     16		1568837		1725299
     32		1291532		1378463
     64		 752584		 787368

Note that stddev is pretty small.

2) Another pipe test, which shows no real measurable improvement.
(http://www.xmailserver.org/linux-patches/pipetest.c)

>> >
>> >I'd have more confidence if we had some warning mechanism if we run
>> >spin_lock_irq() when IRQs are disabled, which is probably-a-bug.  But
>> >afaict we don't have that.  Probably for good reasons - I wonder what
>> >they are?
>
>Well ignored ;)
>
>We could open-code it locally.  Add a couple of
>WARN_ON_ONCE(irqs_disabled())?  That might need re-benchmarking with
>Xen but surely just reading the thing isn't too expensive?

I agree, I'll see what I can come up with and also ask the customer to test
in his setup. Bare metal would also need some new numbers I guess.

Thanks,
Davidlohr
