Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4F1C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9E7240C2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kfIPJNrk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9E7240C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753846AbeGEW2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 18:28:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51586 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753521AbeGEW2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 18:28:20 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so13076123wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 15:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sz/E/5Vi8EWs9Y8JR8aevvawtocAftgETp4BcNHPDMQ=;
        b=kfIPJNrkkpcHgDS8hfbx7RmBTTR585mdzTQyFP+uzMhTy7J7lGw6ClAI4psbXjI9Q6
         QGe9lSvQbMEt8KeeQIKBLsedt8jyAJ3SCYJdVJaHeYrQCKuI17OA0eyajGJ/KVLk33YZ
         ISM2Mp0emxnQQy3o6mclQMi9enCpp7bUXOPVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sz/E/5Vi8EWs9Y8JR8aevvawtocAftgETp4BcNHPDMQ=;
        b=gQYTdCnzmI+03Al7oXG8Jpmz/uGE9G8YKA5M3hZ6k4we6uHFaFNSkSs/QzYmTnu0qc
         v0gHoMc7xVDt98CUarzoSRSxFDXRjziYr0NsvcWnvD0eNO7/JvOMmUWYr59ZUSV5bxqW
         S28zFN3Nof6r8TRTnYj9i071TruE8wqWHc+XRNElUUxj58lSJ3fY9M2p5m0HUSsOUqDX
         mJEcGYjYOkpM2xRwrmdeLlyVe+H8wPoteeOYO5IeHtHIXeTMhDyPQ1A9Q4+fNAt7rPZx
         ttUPbmnbj9qSFcEXQZLJmPGSh7vTHYvImQm3A69UHL2zUJ9yyqdata9DBGtx2MPfrane
         pdjg==
X-Gm-Message-State: APt69E2p3wvBNXboBTnCL9XEDey7dnay4MItF4IarojtsLmF0skoDPrM
        k8PCFHrDF13losunlCM9LBRI6O8c
X-Google-Smtp-Source: AAOMgpexfDNaoIzwaw1mg9VQ4vau7yJvA3Ag++NirrMtM5mk/JbLgaNp/DK/R+GFmJ3eH9Zax6pBOg==
X-Received: by 2002:a1c:7506:: with SMTP id o6-v6mr5215581wmc.60.1530829698767;
        Thu, 05 Jul 2018 15:28:18 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id a203-v6sm9444427wme.46.2018.07.05.15.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 15:28:18 -0700 (PDT)
Date:   Fri, 6 Jul 2018 00:28:12 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 0/3] sched/locking/doc: Miscellaneous fixes
Message-ID: <20180705222812.GA4582@andrea>
References: <1530182480-13205-1-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530182480-13205-1-git-send-email-andrea.parri@amarulasolutions.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 12:41:17PM +0200, Andrea Parri wrote:
> Hi,
> 
> This is a follow-up on the discussion started in [1].
> 
> Applies on -rcu/dev.
> 
> Cheers,
>   Andrea
> 
> [1] http://lkml.kernel.org/r/1529918258-7295-1-git-send-email-andrea.parri@amarulasolutions.com
> 
> Andrea Parri (3):
>   sched: Use smp_mb() in wake_woken_function()
>   locking: Clarify requirements for smp_mb__after_spinlock()
>   doc: Update wake_up() & co. memory-barrier guarantees

What is the plan for this series?

We are currently discussing locking changes that might affect 2/3, but
I'd still consider this patch and the overall series as an improvement
over the current status (1/3 is a fix to the code) and I'd really like
future changes to be based on this series...

I expected this series to go via "-rcu -> tip -> ..."; 2/3 had Peter's
Ack, but 1/3 and 3/3 are missing any comments (or tags): please let me
know if any action on the series is required from me (the series still
applies on the latest "dev" branch of -rcu).

  Andrea


> 
>  Documentation/memory-barriers.txt | 43 ++++++++++++++++++------------
>  include/linux/sched.h             |  4 +--
>  include/linux/spinlock.h          | 25 ++----------------
>  kernel/sched/completion.c         |  8 +++---
>  kernel/sched/core.c               | 30 +++++++++------------
>  kernel/sched/wait.c               | 55 ++++++++++++++++++---------------------
>  6 files changed, 72 insertions(+), 93 deletions(-)
> 
> -- 
> 2.7.4
> 
