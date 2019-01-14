Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D19C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3117120659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 19:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfANTAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:00:33 -0500
Received: from foss.arm.com ([217.140.101.70]:39054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfANTAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 14:00:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D07480D;
        Mon, 14 Jan 2019 11:00:32 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F0243F5BD;
        Mon, 14 Jan 2019 11:00:30 -0800 (PST)
Date:   Mon, 14 Jan 2019 19:00:25 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-mm@kvack.org, peterz@infradead.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] bitops.h: set_mask_bits() to return old value
Message-ID: <20190114190025.GA29167@fuggles.cambridge.arm.com>
References: <1547166387-19785-1-git-send-email-vgupta@synopsys.com>
 <1547166387-19785-4-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547166387-19785-4-git-send-email-vgupta@synopsys.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 04:26:27PM -0800, Vineet Gupta wrote:
> | > Also, set_mask_bits is used in fs quite a bit and we can possibly come up
> | > with a generic llsc based implementation (w/o the cmpxchg loop)
> |
> | May I also suggest changing the return value of set_mask_bits() to old.
> |
> | You can compute the new value given old, but you cannot compute the old
> | value given new, therefore old is the better return value. Also, no
> | current user seems to use the return value, so changing it is without
> | risk.
> 
> Link: http://lkml.kernel.org/g/20150807110955.GH16853@twins.programming.kicks-ass.net
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> ---
>  include/linux/bitops.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 705f7c442691..602af23b98c7 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -246,7 +246,7 @@ static __always_inline void __assign_bit(long nr, volatile unsigned long *addr,
>  		new__ = (old__ & ~mask__) | bits__;		\
>  	} while (cmpxchg(ptr, old__, new__) != old__);		\
>  								\
> -	new__;							\
> +	old__;							\
>  })
>  #endif

Acked-by: Will Deacon <will.deacon@arm.com>

May also explain why no in-tree users appear to use the return value!

Will
