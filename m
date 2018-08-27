Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35440C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D134E208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D134E208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeH1CdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 22:33:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60116 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbeH1CdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 22:33:17 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8660F25A;
        Mon, 27 Aug 2018 22:44:38 +0000 (UTC)
Date:   Mon, 27 Aug 2018 15:44:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shaohua Li <shli@kernel.org>, Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 1/3] swap: Use __try_to_reclaim_swap() in
 free_swap_and_cache()
Message-Id: <20180827154437.f48115fb23cc214b76bee97d@linux-foundation.org>
In-Reply-To: <20180827075535.17406-2-ying.huang@intel.com>
References: <20180827075535.17406-1-ying.huang@intel.com>
        <20180827075535.17406-2-ying.huang@intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018 15:55:33 +0800 Huang Ying <ying.huang@intel.com> wrote:

> The code path to reclaim the swap entry in free_swap_and_cache() is
> almost same as that of __try_to_reclaim_swap().  The largest
> difference is just coding style.  So the support to the additional
> requirement of free_swap_and_cache() is added into
> __try_to_reclaim_swap().  free_swap_and_cache() is changed to call
> __try_to_reclaim_swap(), and delete the duplicated code.  This will
> improve code readability and reduce the potential bugs.
> 
> There are 2 functionality differences between __try_to_reclaim_swap()
> and swap entry reclaim code of free_swap_and_cache().
> 
> - free_swap_and_cache() only reclaims the swap entry if the page is
>   unmapped or swap is getting full.  The support has been added into
>   __try_to_reclaim_swap().
> 
> - try_to_free_swap() (called by __try_to_reclaim_swap()) checks
>   pm_suspended_storage(), while free_swap_and_cache() not.  I think
>   this is OK.  Because the page and the swap entry can be reclaimed
>   later eventually.

hm.  Having functions take `mode' arguments which specify their actions
in this manner isn't popular (Linus ;)) but I guess the end result is
somewhat better.

