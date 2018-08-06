Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C545C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FED217B9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bSkuTjxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FED217B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733132AbeHFSN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:13:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48820 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730724AbeHFSNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8IaTbGiI2kBzPlXkTibDxExERHMd3REdT8BW2Nz2qnY=; b=bSkuTjxYN4NMHmlhw2dJhmPpJ
        P/0O5ZWufJug37n30eMX6zn9IQ0QpAMnZAkNcmK7ou43dU+XTgCRkMmrSLxP6K8g2QeSdU49zFQUk
        UKVCQQkrwn65ney/0EdNe2Jnp9GQB66ViYynnHVgRlOeS4wcg/b791Co6Qn7TbL5q8sJcAQTAGpKP
        qK6iCvfApWakeMjob3w18AAJ53W+BD+pkUu590MFo5HHgYEY4zeE3PDYCg9VX6qeP2R/r5aVuarbv
        nPOtSdbtiXpN80LRv/aCX3eAYocf/L9kvVddGLD3aVruUatVCx0nrIh8Rcf/LEUn+5bFekxQ4rWVI
        17xROMavw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmhyl-0006hP-05; Mon, 06 Aug 2018 16:03:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7547920589AA1; Mon,  6 Aug 2018 18:03:29 +0200 (CEST)
Date:   Mon, 6 Aug 2018 18:03:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 8/9] psi: pressure stall information for CPU, memory, and
 IO
Message-ID: <20180806160329.GP2494@hirez.programming.kicks-ass.net>
References: <20180801151958.32590-1-hannes@cmpxchg.org>
 <20180801151958.32590-9-hannes@cmpxchg.org>
 <20180803165641.GA2476@hirez.programming.kicks-ass.net>
 <20180806151928.GB9888@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806151928.GB9888@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 11:19:28AM -0400, Johannes Weiner wrote:
> On Fri, Aug 03, 2018 at 06:56:41PM +0200, Peter Zijlstra wrote:
> > On Wed, Aug 01, 2018 at 11:19:57AM -0400, Johannes Weiner wrote:

> > > +		u32 uninitialized_var(nonidle);
> > 
> > urgh.. I can see why the compiler got confused. Dodgy :-)
> 
> :-) I think we can make this cleaner. Something like this (modulo the
> READ_ONCE/WRITE_ONCE you pointed out in the other email)?
> 

> @@ -244,60 +287,17 @@ static bool psi_update_stats(struct psi_group *group)
>  	 */
>  	for_each_online_cpu(cpu) {
>  		struct psi_group_cpu *groupc = per_cpu_ptr(group->pcpu, cpu);
> +		u32 nonidle;
> +
> +		nonidle = read_update_delta(groupc, PSI_NONIDLE, cpu);
> +		nonidle = nsecs_to_jiffies(nonidle);
> +		nonidle_total += nonidle;
> +
> +		for (s = 0; s < PSI_NONIDLE; s++) {
> +			u32 delta;
> +
> +			delta = read_update_delta(groupc, s, cpu);
> +			deltas[s] += (u64)delta * nonidle;
>  		}
>  	}

Yes, much clearer, thanks!
