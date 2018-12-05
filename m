Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C47BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07B120851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07B120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeLEIck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:32:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbeLEIck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:32:40 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 622433082B23;
        Wed,  5 Dec 2018 08:32:40 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC8BF6012C;
        Wed,  5 Dec 2018 08:32:38 +0000 (UTC)
Date:   Wed, 5 Dec 2018 09:32:36 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     christoffer.dall@arm.com, marc.zyngier@arm.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm/arm: return 0 when the number of objects is not less
 than min
Message-ID: <20181205083236.5tzhnxfhi4h4nknn@kamzik.brq.redhat.com>
References: <1543972551-60951-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543972551-60951-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 05 Dec 2018 08:32:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 09:15:51AM +0800, Peng Hao wrote:
> Return 0 when there is enough kvm_mmu_memory_cache object.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  virt/kvm/arm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index ed162a6..fcda0ce 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -127,7 +127,7 @@ static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
>  	while (cache->nobjs < max) {
>  		page = (void *)__get_free_page(PGALLOC_GFP);
>  		if (!page)
> -			return -ENOMEM;
> +			return cache->nobjs >= min ? 0 : -ENOMEM;

This condition will never be true here, as the exact same condition is
already checked above, and if it had been true, then we wouldn't be here.

What problem are you attempting to solve?

>  		cache->objects[cache->nobjs++] = page;
>  	}
>  	return 0;
> -- 
> 1.8.3.1
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
