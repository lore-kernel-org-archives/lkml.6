Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AA3C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E6B215F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="DV8bUA+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E6B215F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeI0VpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:45:25 -0400
Received: from a9-54.smtp-out.amazonses.com ([54.240.9.54]:39008 "EHLO
        a9-54.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727307AbeI0VpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1538061998;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=5liwlqbFl0SuwAKT/TtHqY6V25hgRoIO6r4E2yAYe1s=;
        b=DV8bUA+7uJkxPP2kBmdTykPUj7jq5k6CC8gSlsBMUz0HND+qcZiakKmDJbE5eKRh
        6ompb34xUsk3PJZohWo9H8H7hnfA7gRR9BamRRE6eQc2pB1RnRw77XttIBTR/JuDkHo
        D6ZarIpwU6TIvDZzAtK1odpDgMWEw3iydq2Z78+w=
Date:   Thu, 27 Sep 2018 15:26:38 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     zhong jiang <zhongjiang@huawei.com>
cc:     gregkh@linux-foundation.org, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [STABLE PATCH] slub: make ->cpu_partial unsigned int
In-Reply-To: <1538059420-14439-1-git-send-email-zhongjiang@huawei.com>
Message-ID: <010001661ba398a8-f7e5b6c8-b7ff-4f01-8b18-0ad582344ea7-000000@email.amazonses.com>
References: <1538059420-14439-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.09.27-54.240.9.54
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018, zhong jiang wrote:

> From: Alexey Dobriyan <adobriyan@gmail.com>
>
>         /*
>          * cpu_partial determined the maximum number of objects
>          * kept in the per cpu partial lists of a processor.
>          */
>
> Can't be negative.

True.

> I hit a real issue that it will result in a large number of memory leak.
> Because Freeing slabs are in interrupt context. So it can trigger this issue.
> put_cpu_partial can be interrupted more than once.
> due to a union struct of lru and pobjects in struct page, when other core handles
> page->lru list, for eaxmple, remove_partial in freeing slab code flow, It will
> result in pobjects being a negative value(0xdead0000). Therefore, a large number
> of slabs will be added to per_cpu partial list.

That sounds like it needs more investigation. Concurrent use of page
fields for other purposes can cause serious bugs.

>
> I had posted the issue to community before. The detailed issue description is as follows.

I did not see it. Please make sure to CC the maintainers.

