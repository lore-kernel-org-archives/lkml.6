Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBB6C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A211A2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A211A2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbeISShG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:37:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48962 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730876AbeISShF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:37:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA936C004A99;
        Wed, 19 Sep 2018 12:59:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-52.pek2.redhat.com [10.72.12.52])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 30ABD1073033;
        Wed, 19 Sep 2018 12:58:34 +0000 (UTC)
Subject: Re: [PATCH] resource: fix an error which walks through iomem
 resources
From:   lijiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dan.j.williams@intel.com, thomas.lendacky@amd.com,
        akpm@linux-foundation.org, tglx@linutronix.de, bhelgaas@google.com,
        baiyaowei@cmss.chinamobile.com, tiwai@suse.de, bp@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com
References: <20180917062029.511-1-lijiang@redhat.com>
Message-ID: <71104ee7-88e6-aa29-dbb6-a07b66c265c4@redhat.com>
Date:   Wed, 19 Sep 2018 20:58:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917062029.511-1-lijiang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 19 Sep 2018 12:59:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this patch, i have put this patch into another patches series, you can
refer to the link below:

https://lore.kernel.org/patchwork/patch/988431/
https://lore.kernel.org/patchwork/patch/988432/
https://lore.kernel.org/patchwork/patch/988433/

Thanks.

在 2018年09月17日 14:20, Lianbo Jiang 写道:
> When we walk through iomem resources by calling walk_iomem_res_desc(), the
> values of the function parameter may be modified in the while loop of __walk
> _iomem_res_desc(), which will cause us to not get the desired result in some
> cases.
> 
> At present, it only restores the original value of res->end, but it doesn't
> restore the original value of res->flags in the while loop of __walk_iomem
> _res_desc(). Whenever the find_next_iomem_res() finds a resource and returns
> the result, the original values of this resource will be modified, which might
> lead to an error in the next loop. For example:
> 
> The original value of resource flags is: res->flags=0x80000200(initial value)
> 
> p->flags   _ 0x81000200 _                _ 0x80000200 _
>           /              \              /              \
> |________|_______A________|____|_....._|______B_________|......___|
> 0                                                                 0xffffffff
>                 (memory address ranges)
> 
> Note: if ((p->flags & res->flags) != res->flags) continue;
> 
> When the resource A is found, the original value of this resource flags will
> be changed to 0x81000200(res->flags=0x81000200), and continue to look for the
> next resource, when the loop reaches resource B, it can not get the resource B
> any more(you can refer to the for loop of find_next_iomem_res()), because the
> value of conditional expression will become true and will also jump the resource
> B. In fact, we should get the resource A and B when we walk through the whole
> tree, but it only gets the resource A, the resource B is missed.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  kernel/resource.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 30e1bc68503b..f5d9fc70a04c 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -375,6 +375,7 @@ static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
>  				 int (*func)(struct resource *, void *))
>  {
>  	u64 orig_end = res->end;
> +	u64 orig_flags = res->flags;
>  	int ret = -1;
>  
>  	while ((res->start < res->end) &&
> @@ -385,6 +386,7 @@ static int __walk_iomem_res_desc(struct resource *res, unsigned long desc,
>  
>  		res->start = res->end + 1;
>  		res->end = orig_end;
> +		res->flags = orig_flags;
>  	}
>  
>  	return ret;
> 
