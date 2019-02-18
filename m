Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ADAC10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B8C21848
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550496821;
	bh=xVTxS5W0tuWQ5kJJ1jNbiEp7I+LCmqfv6UhLLql9NBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wj0JmXNKa91bAfCwik9RczJwnBVSc3b7NUwvxdSqDUYFlDN822VE3GfqmgzYjDEu1
	 G3C4c9TnXRTU1Oa7GGRGiSirlxqZvw8LyFhheogIwPzZyFVv2Xb8RtsvxriKWQpBmo
	 Dupzes8A3JXMMJ3l2TLDQ0gULJBEtLtLkJt8KdmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbfBRNdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:33:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:43914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728394AbfBRNdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:33:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ECB72147A;
        Mon, 18 Feb 2019 13:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550496820;
        bh=xVTxS5W0tuWQ5kJJ1jNbiEp7I+LCmqfv6UhLLql9NBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i+vNEoXIxe5Hp1OvQ3NurLSZEfbbTCugflAEiqrk1O0eIUhxAFb5bOL4tSSXw0HYW
         9TIgap/24VjKTuROt9nlqGLWGolZBGEod/0zgEzcwouV55+7bYQukHYSzotXbKmJrB
         KRxlv3QugaQUeWU/qrRQ0vP6jEtObUY3fvs8LWoY=
Date:   Mon, 18 Feb 2019 14:33:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Liu Bo <bo.liu@linux.alibaba.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: Fix the pgtable leak
Message-ID: <20190218133337.GB30139@kroah.com>
References: <20190213112900.33963-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213112900.33963-1-minchan@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 08:29:00PM +0900, Minchan Kim wrote:
> [1] was backported to v4.9 stable tree but it introduces pgtable
> memory leak because with fault retrial, preallocated pagetable
> could be leaked in second iteration.
> To fix the problem, this patch backport [2].
> 
> [1] 5cf3e5ff95876, mm, memcg: fix reclaim deadlock with writeback
> [2] b0b9b3df27d10, mm: stop leaking PageTables
> 
> Fixes: 5cf3e5ff95876 ("mm, memcg: fix reclaim deadlock with writeback")
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Liu Bo <bo.liu@linux.alibaba.com>
> Cc: <stable@vger.kernel.org> [4.9]
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  mm/memory.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)

I fixed up the changelog text to be correct, and now queued this up,
thanks.

greg k-h
