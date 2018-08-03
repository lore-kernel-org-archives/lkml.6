Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29597C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAD621777
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XDNWTjb4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAD621777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbeHCTM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:12:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60544 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbeHCTM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9SKvL5mBhDInQR64JgTNiYmIMyZrEVQ4JX0o0ob6sKE=; b=XDNWTjb4kDHOqjchaHeMHOCKz
        qLAyFj4tmpJ7kg1kMWohfqFhhR2e2aJFWvpV+CGvJaT57jKrNJ69/TESjYIQZjuwwepQ1PYC4gbKI
        DzkVzL2hoGZD/lW3LQJA3fPYqlbXYTydSrePlgsUAkEqrsGM6zxZbQ/KuqD6r8zUQRdU2ud0hevoN
        VdkmplTJ89s+FnpSH3zBlBjOhvXc2BxNUCjfVD2bYkCTioShyK/nB6edw0lguq263zsCCCyQ2Hzby
        kbkgLiqQapzGXa3ClBs9X5btgdH/pCbPDrY1hD6zwbAq0B0cqv8eXQQRhDMaUieZBFhdE/w8e5Mdf
        NQCcBnXMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fldfw-0005ZL-Em; Fri, 03 Aug 2018 17:15:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4216620267E51; Fri,  3 Aug 2018 19:15:38 +0200 (CEST)
Date:   Fri, 3 Aug 2018 19:15:38 +0200
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
Message-ID: <20180803171538.GD2494@hirez.programming.kicks-ass.net>
References: <20180801151958.32590-1-hannes@cmpxchg.org>
 <20180801151958.32590-9-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801151958.32590-9-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 11:19:57AM -0400, Johannes Weiner wrote:
> +	/* total= */
> +	for (s = 0; s < NR_PSI_STATES - 1; s++)
> +		group->total[s] += div_u64(deltas[s], max(nonidle_total, 1UL));

Just a nit; probably not worth fixing.

This looses the remainder of that division. But since the divisor is
variable it becomes really hard to not loose something at some point.


