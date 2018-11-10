Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439AEC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 22:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABAB20892
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 22:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z4yb6ASA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ABAB20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeKKIaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 03:30:01 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50606 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeKKIaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 03:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UUPeNX6yHyW9SMohaHmIgCWlfHbxVeP0/86qfa7HQCY=; b=z4yb6ASAYnfy1jmUkNo/631QC
        drqLnuQkUwwnpAHLqXtvSICSuZpJzB7QL5uUZzh08Jttqz/EldZq8KswJmfL+WaaG+3Z4DxQBvHHH
        7TfWQjc5pSGTlTyfsUOFuvrlJ/TSKM9o2q8Kr63ihr8+lk4jZP4yJF9IHVsW6DYxwtTONlH8TB8nb
        NEstAozwu2+vItFe88V56BYTBcoYjQDd5UQ9dAP6V4rubM1qC3w+bkLGIoPjb/90eLWBLluUX/oDB
        5kTNoG0Cv7lIEAAtZNh6k40ZwAdlHhgcP/OUTA1MWBdhwHszEspSvZgwGexdrbKsZ/lsBx+cGu5+S
        XhuJEHARQ==;
Received: from [64.114.255.114] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLbyE-0000gG-Ck; Sat, 10 Nov 2018 22:43:15 +0000
Received: by worktop (Postfix, from userid 1000)
        id CBB216E07F4; Sat, 10 Nov 2018 15:14:58 +0100 (CET)
Date:   Sat, 10 Nov 2018 15:14:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 01/12] locking/lockdep: Rework
 lockdep_set_novalidate_class()
Message-ID: <20181110141458.GE3339@worktop.programming.kicks-ass.net>
References: <1541709268-3766-1-git-send-email-longman@redhat.com>
 <1541709268-3766-2-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541709268-3766-2-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 03:34:17PM -0500, Waiman Long wrote:
> The current lockdep_set_novalidate_class() implementation is like
> a hack. It assigns a special class key for that lock and calls
> lockdep_init_map() twice.

Ideally it would go away.. it is not thing that should be used.

> This patch changes the implementation to make it more general so that
> it can be used by other special lock class types. A new "type" field
> is added to both the lockdep_map and lock_class structures.
> 
> The new field can now be used to designate a lock and a class object
> as novalidate. The lockdep_set_novalidate_class() call, however, should
> be called before lock initialization which calls lockdep_init_map().

I don't really feel like this is something that should be made easier or
better.

> @@ -102,6 +100,8 @@ struct lock_class {
>  	int				name_version;
>  	const char			*name;
>  
> +	unsigned int			flags;
> +
>  #ifdef CONFIG_LOCK_STAT
>  	unsigned long			contention_point[LOCKSTAT_POINTS];
>  	unsigned long			contending_point[LOCKSTAT_POINTS];

Esp. not at the cost of growing the data structures.


