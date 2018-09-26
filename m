Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EE0C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A652620676
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A652620676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeIZUfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:35:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:52532 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726768AbeIZUfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:35:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A60E1ACE1;
        Wed, 26 Sep 2018 14:22:35 +0000 (UTC)
Date:   Wed, 26 Sep 2018 16:22:32 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     <paulus@samba.org>, <benh@kernel.crashing.org>,
        <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Move a dereference below a NULL test
Message-ID: <20180926162232.250c0090@naga>
In-Reply-To: <1537962368-14019-1-git-send-email-zhongjiang@huawei.com>
References: <1537962368-14019-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 19:46:08 +0800
zhong jiang <zhongjiang@huawei.com> wrote:

> It is safe to move dereference below a NULL test.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  arch/powerpc/kernel/cacheinfo.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/cacheinfo.c
> b/arch/powerpc/kernel/cacheinfo.c index a8f20e5..7f19714 100644
> --- a/arch/powerpc/kernel/cacheinfo.c
> +++ b/arch/powerpc/kernel/cacheinfo.c
> @@ -401,14 +401,13 @@ static struct cache
> *cache_lookup_or_instantiate(struct device_node *node, struct cache
> *cache; 
>  	cache = cache_lookup_by_node(node);
> +	if (!cache)
> +		cache = cache_do_one_devnode(node, level);
>  
>  	WARN_ONCE(cache && cache->level != level,

This has also null test so cache should be dereferenced only when
non-null here.

Thanks

Michal
