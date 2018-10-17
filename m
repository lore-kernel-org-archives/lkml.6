Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B64DECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041BE214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HPMDze2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 041BE214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbeJQPdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:33:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41744 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeJQPdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=js9mWpExmwFkOZjKVC/ehWJNLHxvGgpbAznO3zQxpxk=; b=HPMDze2U9AI+SyFhNpEybi77z
        d9b39fBk13FdF4IyVxGNWTYzospS60QG/tRIGUHQmW4LrFs3txD+1TCeboESPfog4VMOhdKQu6Bdn
        GgXYo/r+P7xGzKdEmYqHcoYQxqvxd13vVgxbebdArK7qv7/Vj5WwecIVNoqmFw5W508UGQLQIbNNy
        AYCs0+Is92a2P3XzSvbygoeiwr0bMKQohJN43dG0HXusUnznZeZuXKdo3dK/xrWh09AyUuBVtN5py
        gySVRmq5bj7Khm1EsEzwIhKhOqSId2Xs4YwLUG6Qb4id2PUS4xp39KXHwUPpiZWw6+pW4AtcZ28Do
        r8tA5E52Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCgPc-0007Ph-2U; Wed, 17 Oct 2018 07:38:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 530942029856B; Wed, 17 Oct 2018 09:38:33 +0200 (CEST)
Date:   Wed, 17 Oct 2018 09:38:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] locking/qspinlock_stat: Count instances of nested
 lock slowpaths
Message-ID: <20181017073833.GE3121@hirez.programming.kicks-ass.net>
References: <1539697507-28084-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539697507-28084-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 09:45:06AM -0400, Waiman Long wrote:
> Queued spinlock supports up to 4 levels of lock slowpath nesting -
> user context, soft IRQ, hard IRQ and NMI. However, we are not sure how
> often the nesting happens. So 3 more per-cpu stat counters are added
> to track the number of instances where nesting index goes to 1, 2 and
> 3 respectively.
> 
> On a dual-socket 64-core 128-thread Zen server, the following were stat
> counter values under different circumstances.
> 
>          State                      slowpath   index1   index2   index3
>          -----                      --------   ------   ------   -------
>   After bootup                      1,012,150    82       0        0
>   After parallel build + perf-top 125,195,009    82       0        0

Would probably be good to check a network workload.
