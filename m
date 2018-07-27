Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2F2C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC1E208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC1E208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbeG0Oza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:55:30 -0400
Received: from foss.arm.com ([217.140.101.70]:43676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730318AbeG0Oz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:55:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EBF280D;
        Fri, 27 Jul 2018 06:33:32 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0FF393F2EA;
        Fri, 27 Jul 2018 06:33:32 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 92A131AE5252; Fri, 27 Jul 2018 14:33:32 +0100 (BST)
Date:   Fri, 27 Jul 2018 14:33:32 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joe Mario <jmario@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v3] locking/rwsem: Exit read lock slowpath if queue empty
 & no writer
Message-ID: <20180727133331.GC28549@arm.com>
References: <1532459425-19204-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532459425-19204-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 03:10:25PM -0400, Waiman Long wrote:
> It was discovered that a constant stream of readers with occassional
> writers pounding on a rwsem may cause many of the readers to enter the
> slowpath unnecessarily thus increasing latency and lowering performance.
> 
> In the current code, a reader entering the slowpath critical section
> will unconditionally set the WAITING_BIAS, if not set yet, and clear
> its active count even if no one is in the wait queue and no writer
> is present. This causes some incoming readers to observe the presence
> of waiters in the wait queue and hence have to go into the slowpath
> themselves.
> 
> With sufficient numbers of readers and a relatively short lock hold time,
> the WAITING_BIAS may be repeatedly turned on and off and a substantial
> portion of the readers will go into the slowpath sustaining a rather
> long queue in the wait queue spinlock and repeated WAITING_BIAS on/off
> cycle until the logjam is broken opportunistically.
> 
> To avoid this situation from happening, an additional check is added to
> detect the special case that the reader in the critical section is the
> only one in the wait queue and no writer is present. When that happens,
> it can just exit the slowpath and return immediately as its active count
> has already been set in the lock.  Other incoming readers won't observe
> the presence of waiters and so will not be forced into the slowpath.
> 
> The issue was found in a customer site where they had an application
> that pounded on the pread64 syscalls heavily on an XFS filesystem. The
> application was run in a recent 4-socket boxes with a lot of CPUs. They
> saw significant spinlock contention in the rwsem_down_read_failed() call.
> With this patch applied, the system CPU usage went down from 85% to 57%,
> and the spinlock contention in the pread64 syscalls was gone.
> 
> v3: Revise the commit log and comment again.
> v2: Add customer testing results and remove wording that may cause
>     confusion.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/rwsem-xadd.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

My nits with the commit message have been addressed, so:

Acked-by: Will Deacon <will.deacon@arm.com>

Thanks!

Will
