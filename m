Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABD4C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E3E20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="TH3jD+yH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E3E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967014AbeFSQJe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:09:34 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:48420 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966733AbeFSQJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cmpxchg.org
        ; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=+IqX0uvqzAWjSDuvjz2ayMip+Gsi1TKGyqUNwCy3Wgk=; b=TH3jD+yHYEgEQsWkWsf9xNCyDy
        iH2seAn+hK6YDoD1ezwik4ADymd9SAaBXf+pvSjCCMLc166wBLk+4qbTG8OGxSt/A/MNrTvotc0zJ
        RXnNPjSWUbXSEluxLTcL4wcLqQ1ZQjBRUTD49J8SDMSJHb+zGzwCjTFIYFg+eksO29bM=;
Date:   Tue, 19 Jun 2018 12:11:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.com>, Greg Thelen <gthelen@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 0/3] Directed kmem charging
Message-ID: <20180619161149.GA27423@cmpxchg.org>
References: <20180619051327.149716-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619051327.149716-1-shakeelb@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shakeel,

this looks generally reasonable to me.

However, patch 1 introduces API that isn't used until patch 2 and 3,
which makes reviewing harder since you have to jump back and forth
between emails. Please fold patch 1 and introduce API along with the
users.

On Mon, Jun 18, 2018 at 10:13:24PM -0700, Shakeel Butt wrote:
> This patchset introduces memcg variant memory allocation functions.  The
> caller can explicitly pass the memcg to charge for kmem allocations.
> Currently the kernel, for __GFP_ACCOUNT memory allocation requests,
> extract the memcg of the current task to charge for the kmem allocation.
> This patch series introduces kmem allocation functions where the caller
> can pass the pointer to the remote memcg.  The remote memcg will be
> charged for the allocation instead of the memcg of the caller.  However
> the caller must have a reference to the remote memcg.  This patch series
> also introduces scope API for targeted memcg charging. So, all the
> __GFP_ACCOUNT alloctions within the specified scope will be charged to
> the given target memcg.

Can you open with the rationale for the series, i.e. the problem
statement (fsnotify and bh memory footprint), *then* follow with the
proposed solution?

Thanks!
