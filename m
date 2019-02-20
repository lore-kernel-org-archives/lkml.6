Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26968C10F07
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7ADB20880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550700316;
	bh=y3CpP1kF1vQdnecm67d/Cm5WEPKbJ4dH6cLtWO2dUCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mWIR5/qyF3EYuU2jS1bvyLl3Mv39fpXsyxWut5BNNvH1WdmE5FNLqGuiIJ9SDEB1E
	 7laP1u91I2H2Mr43Pn+xUTpmsHfvGW2jGEqFDl8rMYVsEhNSap4zruPGz+qgOmdCgs
	 TmDo3O/SqNRtYbNFW8WBHpwmg9TbyO3IMJ9uLd2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfBTWFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:05:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:56468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbfBTWFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:05:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56E82B633;
        Wed, 20 Feb 2019 22:05:12 +0000 (UTC)
Date:   Wed, 20 Feb 2019 23:05:10 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jan Stancek <jstancek@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: Don't let userspace spam allocations warnings
Message-ID: <20190220220510.GE4525@dhcp22.suse.cz>
References: <20190220204058.11676-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220204058.11676-1-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-02-19 21:40:58, Daniel Vetter wrote:
> memdump_user usually gets fed unchecked userspace input. Blasting a
> full backtrace into dmesg every time is a bit excessive - I'm not sure
> on the kernel rule in general, but at least in drm we're trying not to
> let unpriviledge userspace spam the logs freely. Definitely not entire
> warning backtraces.

Yes, this makes sense to me. This API sounds like an example where
returning ENOMEM to the userspace right away is much better than
spamming the log for large allocation requests. Smaller allocations
simply do not fail and the OOM killer report will be printed regardless
of __GFP_NOWARN.

> It also means more filtering for our CI, because our testsuite
> exercises these corner cases and so hits these a lot.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jan Stancek <jstancek@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: linux-mm@kvack.org

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/util.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 1ea055138043..379319b1bcfd 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -150,7 +150,7 @@ void *memdup_user(const void __user *src, size_t len)
>  {
>  	void *p;
>  
> -	p = kmalloc_track_caller(len, GFP_USER);
> +	p = kmalloc_track_caller(len, GFP_USER | __GFP_NOWARN);
>  	if (!p)
>  		return ERR_PTR(-ENOMEM);
>  
> -- 
> 2.20.1
> 

-- 
Michal Hocko
SUSE Labs
