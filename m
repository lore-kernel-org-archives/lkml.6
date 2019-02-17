Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447E3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056C02177B
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfBQXu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 18:50:28 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42898 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfBQXu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 18:50:28 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4359E1234135D;
        Sun, 17 Feb 2019 15:50:27 -0800 (PST)
Date:   Sun, 17 Feb 2019 15:50:26 -0800 (PST)
Message-Id: <20190217.155026.2230689002634375366.davem@davemloft.net>
To:     alexander.duyck@gmail.com
Cc:     netdev@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jannh@google.com
Subject: Re: [net PATCH 0/2] Address recent issues found in netdev
 page_frag_alloc usage
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190215223741.16881.84864.stgit@localhost.localdomain>
References: <20190215223741.16881.84864.stgit@localhost.localdomain>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 17 Feb 2019 15:50:27 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 15 Feb 2019 14:44:05 -0800

> This patch set addresses a couple of issues that I had pointed out to Jann
> Horn in response to a recent patch submission.
> 
> The first issue is that I wanted to avoid the need to read/modify/write the
> size value in order to generate the value for pagecnt_bias. Instead we can
> just use a fixed constant which reduces the need for memory read operations
> and the overall number of instructions to update the pagecnt bias values.
> 
> The other, and more important issue is, that apparently we were letting tun
> access the napi_alloc_cache indirectly through netdev_alloc_frag and as a
> result letting it create unaligned accesses via unaligned allocations. In
> order to prevent this I have added a call to SKB_DATA_ALIGN for the fragsz
> field so that we will keep the offset in the napi_alloc_cache
> SMP_CACHE_BYTES aligned.

Series applied, thanks Alexander.
