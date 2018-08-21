Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD95C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787B0214C3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787B0214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeHUPo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 11:44:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:39307 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbeHUPo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 11:44:28 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2018 05:24:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,269,1531810800"; 
   d="scan'208";a="250679491"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 21 Aug 2018 05:24:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id EE206211; Tue, 21 Aug 2018 15:24:27 +0300 (EEST)
Date:   Tue, 21 Aug 2018 15:24:27 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/gup_benchmark: fix unsigned comparison with less than
 zero
Message-ID: <20180821122427.26thwexm2c7ihubc@black.fi.intel.com>
References: <20180821113634.3782-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821113634.3782-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 11:36:34AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the return from get_user_pages_fast is being checked
> to be less than zero for an error check, however, the variable being
> checked is unsigned so the check is always false. Fix this by using
> a signed long instead.
> 
> Detected by Coccinelle ("Unsigned expression compared with zero: nr <= 0")
> 
> Fixes: 64c349f4ae78 ("mm: add infrastructure for get_user_pages_fast() benchmarking")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

This is good catch, but the fix is wrong. See below.

> ---
>  mm/gup_benchmark.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/gup_benchmark.c b/mm/gup_benchmark.c
> index 6a473709e9b6..a9a15e7a1185 100644
> --- a/mm/gup_benchmark.c
> +++ b/mm/gup_benchmark.c
> @@ -31,6 +31,8 @@ static int __gup_benchmark_ioctl(unsigned int cmd,
>  	nr = gup->nr_pages_per_call;
>  	start_time = ktime_get();
>  	for (addr = gup->addr; addr < gup->addr + gup->size; addr = next) {
> +		long n;
> +
>  		if (nr != gup->nr_pages_per_call)
>  			break;

This check has to be done against 'n', not nr'. We stop as soon as
get_user_pages_fast() doesn't return the number of pages we expected.

I would rather change type of 'nr' to signed. It should also fix the
issue, right?

-- 
 Kirill A. Shutemov
