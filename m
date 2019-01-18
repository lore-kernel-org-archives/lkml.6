Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30957C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020F620823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="TbShEl9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfARRY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:24:26 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:46429 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbfARRYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:24:24 -0500
Received: by mail-qt1-f177.google.com with SMTP id y20so15965207qtm.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 09:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=lZ87AmTI1oQJ5sXff1dsD162tkB2dFUbVTnQFxv3BtQ=;
        b=TbShEl9BC80tqkxWYSFwCY2ufjK+Civ0MP5jcClAH9JxgogYSBAsulNqmrKq7qLuRf
         Qok+y+ma78lXAXtdorJHvqHZrgTnucXXX49E6gwY/cNC2+u/lmGD8jhTeWF/kvYSppUc
         c5ClMr7OGS5el1eeKJQd2tEDwVy2qpJoIzUmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=lZ87AmTI1oQJ5sXff1dsD162tkB2dFUbVTnQFxv3BtQ=;
        b=Iut2mEOt+l7Z4mLnYdJAZ0jui1vSJt5eLZBwxUMF/zryl5ZWmVCKeUoTdGq+v4E6hB
         Av256o/SguqFYoz80TPKOXuCGuwFf2hRyy1zngh/VepEWH4mSIa1OGgagGQ8187bVIF5
         j8s2gWxVEApdmio4da3wSq/WW9tkXaBrDiEk0eLybEpu7YvMOnKzGpD3o5wMa9+qKe8O
         ZcM6VgK4fjAAZ7oqhQzZT5d+naf1W/BObEvWHh/UJ3/euQfYj8mgmoDMATg3B78Az7/X
         m7HJ8g8yc0aURWQn0EygSya+l17oOx11jjolo6rVcgonUfi0zwSHvWx3B5v9/zG7gIEd
         89Yw==
X-Gm-Message-State: AJcUukdJRIqOp/jfkW2l4LGhrIaHWKuByRvNJFiJK8eAX/fxB2T0Qgz1
        FmpPHq+F18ptBatntyXSOy9AyA==
X-Google-Smtp-Source: ALg8bN7QGmw8V4AGkCqQf6xPcnIaiE0tYYzZxK3PAgvj3Q8JR42WWY0rpJ++XtI5ngKMKgISWwtTZg==
X-Received: by 2002:aed:3781:: with SMTP id j1mr16912136qtb.315.1547832262988;
        Fri, 18 Jan 2019 09:24:22 -0800 (PST)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id w184sm68657577qkw.90.2019.01.18.09.24.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 09:24:21 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Fri, 18 Jan 2019 12:24:20 -0500 (EST)
X-X-Sender: vince@macbook-air
To:     Peter Zijlstra <peterz@infradead.org>
cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf: rdpmc bug when viewing all procs on remote cpu
In-Reply-To: <20190118155814.GC14054@worktop.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1901181217180.5762@macbook-air>
References: <alpine.DEB.2.21.1901101229010.3358@macbook-air> <alpine.DEB.2.21.1901101246340.3358@macbook-air> <alpine.DEB.2.21.1901101500030.3717@macbook-air> <alpine.DEB.2.21.1901111649580.6487@macbook-air> <20190118120149.GC27931@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901180905090.5762@macbook-air> <20190118155814.GC14054@worktop.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019, Peter Zijlstra wrote:
> 
> You can actually use rdpmc when you attach to a CPU, but you have to
> ensure that the userspace component is guaranteed to run on that very
> CPU (sched_setaffinity(2) comes to mind).

unfortunately the HPC people using PAPI would probably be annoyed if we 
started binding their threads to cores out from under them.

> The best we could possibly do is put the (target, not current) cpu
> number in the mmap page; but userspace should already know this, for it
> created the event and therefore knows this already.

one other thing the kernel would do is just disable rdpmc (setting index 
to 0) in the case where the original perf_event_open() cpu paramater!=0

though that would stop the case where we were on the same CPU from 
working.

The issue is currently if you're not careful the rdpmc() interface will 
sometimes return plausible (but wrong) results for a cross-CPU rdpmc() 
call, even if you are properly falling back to read() on ->index being 0.
It's a bit surprising and it looks like it will take a decent amount of 
userspace code to work around the issue, which cuts into the low-overhead 
nature of rdpmc.

If the answer is simply this is the way the kernel is going to do it, 
that's fine, I just have to add workarounds to PAPI and then get the 
perf_even_open() manpage updated to make sure people are aware of the 
issue.

Vince


