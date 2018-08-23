Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F6EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4DC7206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DC7206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732268AbeHWRvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 13:51:09 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:38873 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731404AbeHWRvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 13:51:08 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w7NEKwrJ000113;
        Thu, 23 Aug 2018 23:20:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Thu, 23 Aug 2018 23:20:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w7NEKvIB000109
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 23 Aug 2018 23:20:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] xen/gntdev: fix up blockable calls to mn_invl_range_start
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org,
        LKML <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
References: <20180823120707.10998-1-mhocko@kernel.org>
 <07c7ead4-334d-9b25-f588-25e9b46bbea0@i-love.sakura.ne.jp>
 <20180823135151.GM29735@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <470950f0-a579-6c74-c5f0-bea635259176@i-love.sakura.ne.jp>
Date:   Thu, 23 Aug 2018 23:20:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180823135151.GM29735@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/08/23 22:51, Michal Hocko wrote:
> You are right. I completely forgot I've removed in_range there. Does
> this look any better?
> 
> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
> index e7d8bb1bee2a..30f81004ea63 100644
> --- a/drivers/xen/gntdev.c
> +++ b/drivers/xen/gntdev.c
> @@ -525,14 +525,20 @@ static int mn_invl_range_start(struct mmu_notifier *mn,
>  		return -EAGAIN;
>  
>  	list_for_each_entry(map, &priv->maps, next) {
> -		if (!blockable && in_range(map, start, end)) {
> +		if (in_range(map, start, end)) {
> +			if (blockable)
> +				continue;
> +
>  			ret = -EAGAIN;
>  			goto out_unlock;
>  		}

This still looks strange. in_range() returns false if map->vma == NULL.
But unmap_if_in_range() unconditionally dereferences map->vma->vm_[start|end] .
Suggestion from Boris looks better.

>  		unmap_if_in_range(map, start, end);
>  	}
>  	list_for_each_entry(map, &priv->freeable_maps, next) {
> -		if (!blockable && in_range(map, start, end)) {
> +		if (in_range(map, start, end)) {
> +			if (blockable)
> +				continue;
> +			
>  			ret = -EAGAIN;
>  			goto out_unlock;
>  		}
> 

