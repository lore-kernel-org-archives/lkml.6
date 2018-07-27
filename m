Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DBBC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E6F20883
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 00:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E6F20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbeG0BVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 21:21:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:49862 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731412AbeG0BVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 21:21:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 445C9AE75;
        Fri, 27 Jul 2018 00:02:20 +0000 (UTC)
Date:   Thu, 26 Jul 2018 17:02:15 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH v3] locking/rwsem: Exit read lock slowpath if queue empty
 & no writer
Message-ID: <20180727000215.ez3el2tbbasxa5fk@linux-r8p5>
References: <1532459425-19204-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1532459425-19204-1-git-send-email-longman@redhat.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018, Waiman Long wrote:

>It was discovered that a constant stream of readers with occassional
>writers pounding on a rwsem may cause many of the readers to enter the
>slowpath unnecessarily thus increasing latency and lowering performance.
>
>In the current code, a reader entering the slowpath critical section
>will unconditionally set the WAITING_BIAS, if not set yet, and clear
>its active count even if no one is in the wait queue and no writer
>is present. This causes some incoming readers to observe the presence
>of waiters in the wait queue and hence have to go into the slowpath
>themselves.
>
>With sufficient numbers of readers and a relatively short lock hold time,
>the WAITING_BIAS may be repeatedly turned on and off and a substantial
>portion of the readers will go into the slowpath sustaining a rather
>long queue in the wait queue spinlock and repeated WAITING_BIAS on/off
>cycle until the logjam is broken opportunistically.
>
>To avoid this situation from happening, an additional check is added to
>detect the special case that the reader in the critical section is the
>only one in the wait queue and no writer is present. When that happens,
>it can just exit the slowpath and return immediately as its active count
>has already been set in the lock.  Other incoming readers won't observe
>the presence of waiters and so will not be forced into the slowpath.
>
>The issue was found in a customer site where they had an application
>that pounded on the pread64 syscalls heavily on an XFS filesystem. The
>application was run in a recent 4-socket boxes with a lot of CPUs. They
>saw significant spinlock contention in the rwsem_down_read_failed() call.
>With this patch applied, the system CPU usage went down from 85% to 57%,
>and the spinlock contention in the pread64 syscalls was gone.
>
>v3: Revise the commit log and comment again.
>v2: Add customer testing results and remove wording that may cause
>    confusion.
>
>Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
