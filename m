Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33B2C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 16:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EDD214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 16:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545929459;
	bh=+9JyKNbbd+CeS0XDJSZm8e7b7nfhwy/nrep8h23qBdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ubw1kToMrB/PCzIT+q+MtrlTAH7wf4lr9aq3P8Utp7PkYmYkmw0/oyZbW3WvHNETC
	 RbUq4fNmV7UV63N3jD/04gUMA/nwbn8eOKx1JevxeeDwHA0q+YLMkJw3LZ7mbjjFOO
	 mabHSYUly8Z+BKR3R6Qv3mowV64Kg9u+WUeK37x8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbeL0Qu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 11:50:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:39770 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727184AbeL0Qu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 11:50:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2C6F5AF3B;
        Thu, 27 Dec 2018 16:50:56 +0000 (UTC)
Date:   Thu, 27 Dec 2018 17:50:55 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khorenko <khorenko@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/1] mm/page_alloc: add a warning about high order
 allocations
Message-ID: <20181227165055.GN16738@dhcp22.suse.cz>
References: <20181225153927.2873-1-khorenko@virtuozzo.com>
 <20181225153927.2873-2-khorenko@virtuozzo.com>
 <20181226084051.GH16738@dhcp22.suse.cz>
 <12c71c7a-7896-df73-7ab4-eab5b6fc1fb0@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12c71c7a-7896-df73-7ab4-eab5b6fc1fb0@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27-12-18 16:05:18, Konstantin Khorenko wrote:
> On 12/26/2018 11:40 AM, Michal Hocko wrote:
> > Appart from general comments as a reply to the cover (btw. this all
> > should be in the changelog because this is the _why_ part of the
> > justification which should be _always_ part of the changelog).
> 
> Thank you, will add in the next version of the patch alltogether
> with other changes if any.
> 
> > On Tue 25-12-18 18:39:27, Konstantin Khorenko wrote:
> > [...]
> >> +config WARN_HIGH_ORDER
> >> +	bool "Enable complains about high order memory allocations"
> >> +	depends on !LOCKDEP
> >
> > Why?
> 
> LOCKDEP makes structures big, so if we see a high order allocation warning
> on a debug kernel with lockdep, it does not give us a lot - lockdep enabled
> kernel performance is not our target.
> i can remove !LOCKDEP dependence here, but then need to adjust default
> warning level i think, or logs will be spammed.

OK, I see but this just points to how this is not really a suitable
solution for the problem you are looking for.

> >> +static __always_inline void warn_high_order(int order, gfp_t gfp_mask)
> >> +{
> >> +	static atomic_t warn_count = ATOMIC_INIT(32);
> >> +
> >> +	if (order >= warn_order && !(gfp_mask & __GFP_NOWARN))
> >> +		WARN(atomic_dec_if_positive(&warn_count) >= 0,
> >> +		     "order %d >= %d, gfp 0x%x\n",
> >> +		     order, warn_order, gfp_mask);
> >> +}
> >
> > We do have ratelimit functionality, so why cannot you use it?
> 
> Well, my idea was to really shut up the warning after some number of messages
> (if a node is in production and its uptime, say, a year, i don't want to see
> many warnings in logs, first several is enough - let's fix them first).

OK, but it is quite likely that the system is perfectly healthy and
unfragmented after fresh boot when doing a large order allocations is
perfectly fine. Note that it is smaller order allocations that generate
fragmentation in general.
-- 
Michal Hocko
SUSE Labs
