Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696BEC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBB4217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550064991;
	bh=T71FDtFZoBA1eCh9qUuHolpuH0DcG5LdOn3nqWumweo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I+jfBkJf4k1Es76jw8KwW2fb8Skd4RNhhzS1Ota9tmqHBNqh04pd1ZmB7EBPwhAM+
	 +ZgEetSIAJNYAZskHuDe3taVprBBsuCCOxfEr8O307pqVFJ7euG0/oQZGZlgQWS9Rp
	 gPdQA4ZGUtQVq7MPVN5chIZEgdyPGpJKocPp1K6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfBMNga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:36:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfBMNg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:36:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F2512075D;
        Wed, 13 Feb 2019 13:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550064987;
        bh=T71FDtFZoBA1eCh9qUuHolpuH0DcG5LdOn3nqWumweo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BpSrj02y9BKNILk+2f3ko7JVpnvWFSgs4gqM/4fmCLpUR27/0tEwMF6aLnjs9Tj4n
         uplvVy+x9WuB/K00lKPQrEZoObhujELgbagbPiswtculZc4uZZYQkaKn6AvenlMqvo
         WxWHS0TNYVdBWuJHOHJ1DgEIoHDrXOfITpi+HHE8=
Date:   Wed, 13 Feb 2019 14:36:24 +0100
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
Message-ID: <20190213133624.GB9460@kroah.com>
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

This is really commit 63f3655f9501 ("mm, memcg: fix reclaim deadlock
with writeback") which was in 4.9.152, 4.14.94, 4.19.16, and 4.20.3 as
well as 5.0-rc2.

> [2] b0b9b3df27d10, mm: stop leaking PageTables

This commit was in 4.10, so I am guessing that this really is just a
backport of that commit?

If so, it's not the full backport, why not take the whole thing?  Why
only cherry-pick one chunk of it?  Why do we not need the other parts?

thanks,

greg k-h
