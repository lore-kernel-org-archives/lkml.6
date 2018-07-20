Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3DEECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A6420661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A6420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeGTUz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:55:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:53600 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727412AbeGTUzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:55:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4E340ADAB;
        Fri, 20 Jul 2018 20:06:06 +0000 (UTC)
Date:   Fri, 20 Jul 2018 13:05:59 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     jbaron@akamai.com, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH -next 0/2] fs/epoll: loosen irq safety when possible
Message-ID: <20180720200559.27nc7j2rrxpy5p3n@linux-r8p5>
References: <20180720172956.2883-1-dave@stgolabs.net>
 <20180720124212.7260d76d83e2b8e5e3349ea5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180720124212.7260d76d83e2b8e5e3349ea5@linux-foundation.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018, Andrew Morton wrote:

>On Fri, 20 Jul 2018 10:29:54 -0700 Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> Hi,
>>
>> Both patches replace saving+restoring interrupts when taking the
>> ep->lock (now the waitqueue lock), with just disabling local irqs.
>> This shows immediate performance benefits in patch 1 for an epoll
>> workload running on Xen.
>
>I'm surprised.  Is spin_lock_irqsave() significantly more expensive
>than spin_lock_irq()?  Relative to all the other stuff those functions
>are doing?  If so, how come?  Some architectural thing makes
>local_irq_save() much more costly than local_irq_disable()?

For example, if you compare x86 native_restore_fl() to xen_restore_fl(),
the cost of Xen is much higher.

And at least considering ep_scan_ready_list(), the lock is taken/released
twice, to deal with the ovflist when the ep->wq.lock is not held. To the
point that it yields measurable results (see patch 1) across incremental
thread counts.

>
>> The main concern we need to have with this
>> sort of changes in epoll is the ep_poll_callback() which is passed
>> to the wait queue wakeup and is done very often under irq context,
>> this patch does not touch this call.
>
>Yeah, these changes are scary.  For the code as it stands now, and for
>the code as it evolves.

Yes which is why I've been throwing lots of epoll workloads at it.

>
>I'd have more confidence if we had some warning mechanism if we run
>spin_lock_irq() when IRQs are disabled, which is probably-a-bug.  But
>afaict we don't have that.  Probably for good reasons - I wonder what
>they are?
>
>> Patches have been tested pretty heavily with the customer workload,
>> microbenchmarks, ltp testcases and two high level workloads that
>> use epoll under the hood: nginx and libevent benchmarks.
>>
>> Details are in the individual patches.
>>
>> Applies on top of mmotd.
>
>Please convince me about the performance benefits?

As for number I only have patch 1.

Thanks,
Davidlohr
