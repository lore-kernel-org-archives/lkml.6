Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4225BECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E02782084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoTcvBb9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02782084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbeGTMwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 08:52:16 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:45250 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeGTMwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 08:52:16 -0400
Received: by mail-yb0-f193.google.com with SMTP id h127-v6so4517771ybg.12;
        Fri, 20 Jul 2018 05:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EE8DOX5ZIE3rtJp1zM5TJJep5oDH4cHuKZ9DE8KZmQI=;
        b=OoTcvBb9/Pxtz93qbOBRPREr0gTpQu+qg8l1NQieCQL7aoaa9AdGaResGWg/E8BD4+
         Ja8+/Q/uzzzh+hKvRb8C68OWXeYG6ymZjz+lx2IbcQqhgTrmJ7Nmo+f2QGYJbBrZTq5v
         0Cu6zJLbBbaz+/L+usDwGAqocoMS8UpEzp9MiZ6jzIYx4V9a1KvItwIwZh5HJwo2uQxg
         jysCdVepx29TMc8/03OrQDYKuG3RbiGfVumeZJ6MBrc21wZo39ajH+GUstd3mIn2CfV3
         PEx4wggSHlid2yxGhakfWrrbk6u9RpMUHWnp4xLlwcSpxhsAatsAC6Ll+Mom2KRCqTXr
         EJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EE8DOX5ZIE3rtJp1zM5TJJep5oDH4cHuKZ9DE8KZmQI=;
        b=Fi/cp1FhW/rGCG287wR576pPnV1ROwEUnu5JW/doPXxIbM2bk5+JqIcIpXZh0ksqFt
         ru5Mk3ooHTzh5aDPq5Dgs8UPjtiY/ZdCElg/B2fTchtmPkF4siFS9zZsgN8mVJawAqxu
         L9m5SYiVm1d7nRijok7TkA3vjLjFgSuWkE9gYDqBVC8bjYCEJ/Cqi9rgzsg6y7myDehu
         hEoyoj8Z3EENpQOd/xzfWH/oa3bnrxJZuRqsVAq693748D9Cg2dtQ4ZkiP8AnZppFl/B
         RcrYv+y00nEC8qCW55Z3tIm1oKeyxDenILdQ9bT9YUNlteP8aO8cyJ5zCsbSejaFZhbR
         ORfA==
X-Gm-Message-State: AOUpUlFZqU3P11iF+djLtjFVUoYOHCw3ftjS3MlHjHa6oiWS5c224qzA
        jYEVPGihwcqdPd98OkMpaeU=
X-Google-Smtp-Source: AAOMgpc3m2WvQa11oTasLwdButJ3/ZBtiqI9qN6lPnCYPGa2qd6/hAY9L2TmqYu3ttxHXI7lmZK6JQ==
X-Received: by 2002:a25:c641:: with SMTP id k62-v6mr829717ybf.384.1532088259189;
        Fri, 20 Jul 2018 05:04:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:5c80])
        by smtp.gmail.com with ESMTPSA id g203-v6sm811530ywb.69.2018.07.20.05.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 05:04:18 -0700 (PDT)
Date:   Fri, 20 Jul 2018 05:04:16 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v11 7/9] cpuset: Expose cpus.effective and mems.effective
 on cgroup v2 root
Message-ID: <20180720120416.GA1934745@devbig577.frc2.facebook.com>
References: <20180702165322.GI533219@devbig577.frc2.facebook.com>
 <bc59aa0a-70fd-583f-452d-9a947757cb69@redhat.com>
 <20180703155823.GS533219@devbig577.frc2.facebook.com>
 <20180719135224.GE2494@hirez.programming.kicks-ass.net>
 <1107494a-9667-df58-dcac-9366e969dc3a@redhat.com>
 <20180719153045.GT72677@devbig577.frc2.facebook.com>
 <de6f931d-613a-3e6a-2a4d-0e49b3bfe2e5@redhat.com>
 <20180719165201.GU72677@devbig577.frc2.facebook.com>
 <20180720113121.GJ2476@hirez.programming.kicks-ass.net>
 <20180720114549.GY72677@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720114549.GY72677@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jul 20, 2018 at 04:45:49AM -0700, Tejun Heo wrote:
> > > 2. take away any given cpu from ist subtree.
> > 
> > I really hate this obsession of yours and doubly so for partitions. But
> > why would this currently not be allowed?
> 
> Well, sorry that you hate it.  It's a fundamental architectural
> constraint.  If it can't satisfy that, it should't be in cgroup.

Just in case it wasn't clear from previous the exchanges, basic
architecture designs like this are what makes things like delegation
actually useful across all controllers.  If we allow a descendant in
the hierarchy to restrict waht its ancestors can do, it becomes really
painful operationally.

For now, I'd suggest just doing it at the first child level and move
on unless there are clear use cases where nested partitions are
useful, which I find unlikely given the nature of the operation -
partitions don't really have anything to do with one another.

Thanks.

-- 
tejun
