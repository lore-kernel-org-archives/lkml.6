Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD86DC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA9520825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA9520825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeKITWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 14:22:24 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:29985 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbeKITWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 14:22:24 -0500
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wA99fulv005070;
        Fri, 9 Nov 2018 18:41:56 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Fri, 09 Nov 2018 18:41:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157065137.bbtec.net [60.157.65.137])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wA99fqCP005009
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 9 Nov 2018 18:41:56 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: UBSAN: Undefined behaviour in mm/page_alloc.c
To:     Michal Hocko <mhocko@kernel.org>, Kyungtae Kim <kt0755@gmail.com>
Cc:     akpm@linux-foundation.org, pavel.tatashin@microsoft.com,
        vbabka@suse.cz, osalvador@suse.de, rppt@linux.vnet.ibm.com,
        aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        alexander.h.duyck@linux.intel.com, mgorman@techsingularity.net,
        lifeasageek@gmail.com, threeearcat@gmail.com,
        syzkaller@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
References: <CAEAjamseRRHu+TaTkd1TwpLNm8mtDGP=2K0WKLF0wH-3iLcW_w@mail.gmail.com>
 <20181109084353.GA5321@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <b51aae15-eb5d-47f0-1222-bfc1ef21e06c@I-love.SAKURA.ne.jp>
Date:   Fri, 9 Nov 2018 18:41:53 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181109084353.GA5321@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/09 17:43, Michal Hocko wrote:
> @@ -4364,6 +4353,17 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
>  	gfp_t alloc_mask; /* The gfp_t that was actually used for allocation */
>  	struct alloc_context ac = { };
>  
> +	/*
> +	 * In the slowpath, we sanity check order to avoid ever trying to

Please keep the comment up to dated.
I don't like that comments in OOM code is outdated.

> +	 * reclaim >= MAX_ORDER areas which will never succeed. Callers may
> +	 * be using allocators in order of preference for an area that is
> +	 * too large.
> +	 */
> +	if (order >= MAX_ORDER) {

Also, why not to add BUG_ON(gfp_mask & __GFP_NOFAIL); here?

> +		WARN_ON_ONCE(!(gfp_mask & __GFP_NOWARN));
> +		return NULL;
> +	}
> +
>  	gfp_mask &= gfp_allowed_mask;
>  	alloc_mask = gfp_mask;
>  	if (!prepare_alloc_pages(gfp_mask, order, preferred_nid, nodemask, &ac, &alloc_mask, &alloc_flags))
> 
