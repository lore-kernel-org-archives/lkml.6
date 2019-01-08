Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4D5C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F9F20883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546964229;
	bh=4txs0LmEDzED4CFW/IfVto/QK/5lF57/AgR2XIXJl4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ljGq94GU2l/HZc3LiRXrPbs+Sc705zGnDpjMXQqu3BFWuQ4DwxgRvocvJSLKhJnmY
	 HIRRZ7Cfb2SRxNb2lwrFtq6gHUPAlH88z0JLbyYPU0h88JBUVgRyADbZMHBCNdtbA1
	 nw8vbj9HkA6UwmQR7atO6IZxVh6KZdCxdhtZjX2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfAHQRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:17:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728211AbfAHQRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:17:08 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 855CD2087F;
        Tue,  8 Jan 2019 16:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546964227;
        bh=4txs0LmEDzED4CFW/IfVto/QK/5lF57/AgR2XIXJl4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NAqeNX/w/izK37wq2tpTRu70WaKJgaLZMXbqE0O9inizE+xbgIibK4D+ETBfSagLb
         WdM6VDC5kvI+GIBZ3JvrCJXNRmxWHropkK++V1isuzZVupO14QaBQmMGd2r71PXhXj
         d5m8tM5v9JzMBclKFfJelcXrDkAErmoUg/zLJX5E=
Date:   Wed, 9 Jan 2019 00:16:59 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.0-rc1 (test results)
Message-ID: <20190108161659.GA26358@guoren-Inspiron-7460>
References: <CAHk-=wgKYnrL3LjhVkH2Fp+ecmWhLqezT9zmR6CzfcpwcJX0qA@mail.gmail.com>
 <20190107192648.GA10789@roeck-us.net>
 <CAHk-=wjt6oKtYuJ-EOGSO1m8vBdPa+g2_6WZ6MKCwfu4afoSrw@mail.gmail.com>
 <20190108095107.GA25409@guoren-Inspiron-7460>
 <20190108154031.GB343@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108154031.GB343@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Michal,

On Tue, Jan 08, 2019 at 04:40:31PM +0100, Michal Hocko wrote:
> On Tue 08-01-19 17:51:07, Guo Ren wrote:
> [...]
> > static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
> > {
> > 	pte_t *pte;
> > 	unsigned long i;
> > 
> > 	pte = (pte_t *) __get_free_page(GFP_KERNEL | __GFP_RETRY_MAYFAIL);
> > 						     ^^^^^^^^^^^^^^^^^^^
> > 						     It's necessary ?
> > 						     x86 & arm don't use
> > 						     it.
> > 	if (!pte)
> > 		return NULL;
> 
> That depends on whether you want OOM killer to be triggered for these
> allocations. If you add the flag then the allocation bails out with a
> failure rather than kill an oom victim.

Yes, in page_alloc.c: 
	if (gfp_mask & __GFP_RETRY_MAYFAIL)
		goto out;
	...
	if (out_of_memory(&oc) || WARN_ON_ONCE(gfp_mask & __GFP_NOFAIL)) {
            ^^^^^^^^^^^^^ OOM kill victim
	...
		if (gfp_mask & __GFP_NOFAIL)
			page = __alloc_pages_cpuset_fallback(gfp_mask, order,
					ALLOC_NO_WATERMARKS, ac);
	}

Seems it could affect the behavior of the system which is out of memory.
OOM killer could help to get_page for current. So keep the same as x86 &
arm here. I'll remove __GFP_RETRY_MAYFAIL in patch.

Best Regards
 Guo Ren
