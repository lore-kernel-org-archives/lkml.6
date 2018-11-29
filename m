Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676D5C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CC420868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RmOAYmi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22CC420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbeK3Jzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:55:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45536 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbeK3Jzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ra98U7SXwseK33zjQjSsj2q0t7zcJPIR3CENVJkTmWQ=; b=RmOAYmi4+w5z/p1YTDUy3gAKU
        +YP2p7g19B3s4xOCHzgpvNJqoS6zQqy0wZKZqjw+qA1yoBWULhmkmWLR7MdwObkF8tztM/eYUO7tY
        85HKYxdGXVFfIt/E8ndDSq62cAF98l24w1TxLdkUTdKYNlShJYPTOfvxuYhEkXJp/COTrs6Vq8eYl
        +lexN7FleXzOiKsUIG/WSJtj+lQrfTPH5f5Qt8kV6qnMNcIam/XNOHvvIIn7xtmfmkOYlUZxj2ZPl
        HSGV679Gx+sQHpLk+rRq+g6HoFvXsB7jrjnJp3uk6BBpi10STCF2zKCX7vyoo2S4jMFAmUStfVQ5i
        +/i/keaxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSV6r-0007vb-QO; Thu, 29 Nov 2018 22:48:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 352D02029F87F; Thu, 29 Nov 2018 23:48:36 +0100 (CET)
Date:   Thu, 29 Nov 2018 23:48:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 0/2] locking/lockdep: Track number of zapped classes &
 report abuse
Message-ID: <20181129224836.GI11632@hirez.programming.kicks-ass.net>
References: <1543531297-18349-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543531297-18349-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 05:41:35PM -0500, Waiman Long wrote:
> When a kernel module is repeatedly load and unload, it will eventually
> exhaust the lockdep entries resulting in a bug message. This is a use
> case that the current lockdep code cannot support.
> 
> This patchset tracks the number of zapped classes and print a warning if
> too many lockdep entries are wasted because of too many module unloading.
> For example,
> 
> [ 2490.651531] BUG: MAX_LOCKDEP_KEYS too low!
> [ 2490.669925] turning off the locking correctness validator.
> [ 2490.669925] Please attach the output of /proc/lock_stat to the bug report
> [ 2490.669926] ========================================================
> [ 2490.669927] WARNING: 6499 out of 8191 locks have been destroyed
> [ 2490.669927] through kernel module unload operations.
> [ 2490.669928] The corresponding lockdep entries are not reusable.
> [ 2490.669928] The system might have run out of lockdep entries because
> [ 2490.669929] of repeated kernel module load and unload operations.
> [ 2490.669929] Lockdep cannot support this particular use case.
> [ 2490.669930] --------------------------------------------------------

Have a look here:

  https://lkml.kernel.org/r/20181128234325.110011-1-bvanassche@acm.org
