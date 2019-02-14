Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9A2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068C7222DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388787AbfBNRNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:13:30 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56730 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730929AbfBNRNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:13:30 -0500
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net [96.89.128.221])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CD96614D5ECC8;
        Thu, 14 Feb 2019 09:13:28 -0800 (PST)
Date:   Thu, 14 Feb 2019 09:13:28 -0800 (PST)
Message-Id: <20190214.091328.1687361207100252890.davem@davemloft.net>
To:     jannh@google.com
Cc:     netdev@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, vbabka@suse.cz,
        pavel.tatashin@microsoft.com, osalvador@suse.de,
        mgorman@techsingularity.net, aaron.lu@intel.com,
        alexander.h.duyck@redhat.com
Subject: Re: [RESEND PATCH net] mm: page_alloc: fix ref bias in
 page_frag_alloc() for 1-byte allocs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190213214559.125666-1-jannh@google.com>
References: <20190213214559.125666-1-jannh@google.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 14 Feb 2019 09:13:29 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>
Date: Wed, 13 Feb 2019 22:45:59 +0100

> The basic idea behind ->pagecnt_bias is: If we pre-allocate the maximum
> number of references that we might need to create in the fastpath later,
> the bump-allocation fastpath only has to modify the non-atomic bias value
> that tracks the number of extra references we hold instead of the atomic
> refcount. The maximum number of allocations we can serve (under the
> assumption that no allocation is made with size 0) is nc->size, so that's
> the bias used.
> 
> However, even when all memory in the allocation has been given away, a
> reference to the page is still held; and in the `offset < 0` slowpath, the
> page may be reused if everyone else has dropped their references.
> This means that the necessary number of references is actually
> `nc->size+1`.
> 
> Luckily, from a quick grep, it looks like the only path that can call
> page_frag_alloc(fragsz=1) is TAP with the IFF_NAPI_FRAGS flag, which
> requires CAP_NET_ADMIN in the init namespace and is only intended to be
> used for kernel testing and fuzzing.
> 
> To test for this issue, put a `WARN_ON(page_ref_count(page) == 0)` in the
> `offset < 0` path, below the virt_to_page() call, and then repeatedly call
> writev() on a TAP device with IFF_TAP|IFF_NO_PI|IFF_NAPI_FRAGS|IFF_NAPI,
> with a vector consisting of 15 elements containing 1 byte each.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Applied and queued up for -stable.
