Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED62BC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C26F2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="M+iAuvG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C26F2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeIFCPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:15:11 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:44250 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIFCPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:15:11 -0400
Received: by mail-yb1-f196.google.com with SMTP id l16-v6so3299705ybk.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 14:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qXZubM8MF/Lw3QDANhwRZtFYSjHznjc5hICQlHp7cko=;
        b=M+iAuvG3nZuE+iAp8SieNDJtUSc+tUkG89ZfAYtfxK5ugvz93f4eDUzpQ7mO511D0G
         WCpqluaGB+8oMV+TYwpyJ2M5HYjOyXj+FUw4KIu4/sOoHF7UBxwRPBAv4gKuS/jloHts
         Z2BH6dIP18ZJkH6qVow1nkgDBjejunAgC07Usz0O6ifZ7ORxO1orGcM/0bsfD271p6O4
         4j9oW1PFKRQi1pNd/kHU7+I8NPaCGcqe/KcMulVod/1ktFig4wloJUY4d47nGmPrPTxf
         DoHaZsx0U8+8WJF2ZFMdY4ypmPH+ibIUZkhdCItDdSOLd1hSVrkb7R3o6xwTQanZEWbe
         K2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qXZubM8MF/Lw3QDANhwRZtFYSjHznjc5hICQlHp7cko=;
        b=A50tw3HUvCvaZAKcWf0mXsamgItXk+Z7xFgK1DUoidrgsP34J55hTtmtUpoFD0ZUE6
         nNP4Ys8wtQ+NoxhFwsnh5pE9kN9XMCgJWgS65BAwG9BCmvSOAF83T+E5tXzG0xz091vH
         hipAInZ8x7+JC5tNNSh2cFHRLg17XLi7KQaNX9BDkTUoeKlCMxb3Hp0YwfKdydsxBFTy
         RCG+kwdQHbm3IRmqw9qQglbKcfK9omBY3NTXTzXWyvpurPzVES6L/V692li3BSR61cQv
         qXIZdXxPU2mBw3O+/09ToiAU6E91Q99uwJnCJ/AxU3ynEnh11PM6N/b5cTszU8cqtXTR
         6QSQ==
X-Gm-Message-State: APzg51D9h3OibikwccbDM3oNUqqLxUpHL0eTR+oEdvk6QKgU9qpUVDfd
        9QFEs6JZIQ+JiQWjaM0dkcPt+A==
X-Google-Smtp-Source: ANB0VdZFPobuR+pATaCxUujxSwPnu+WW/S0aPZcMhkXcg2rIRce4Atq3CQMyxeqdnyU3h6mCvd+WpQ==
X-Received: by 2002:a25:bdcb:: with SMTP id g11-v6mr21206517ybk.494.1536183785217;
        Wed, 05 Sep 2018 14:43:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3622])
        by smtp.gmail.com with ESMTPSA id e124-v6sm1017519ywh.66.2018.09.05.14.43.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 14:43:03 -0700 (PDT)
Date:   Wed, 5 Sep 2018 17:43:03 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/9] psi: pressure stall information for CPU, memory, and
 IO v4
Message-ID: <20180905214303.GA30178@cmpxchg.org>
References: <20180828172258.3185-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828172258.3185-1-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 01:22:49PM -0400, Johannes Weiner wrote:
> This version 4 of the PSI series incorporates feedback from Peter and
> fixes two races in the lockless aggregator that Suren found in his
> testing and which caused the sample calculation to sometimes underflow
> and record bogusly large samples; details at the bottom of this email.

Peter, do the changes from v3 look sane to you?

If there aren't any further objections, I was hoping we could get this
lined up for 4.20.
