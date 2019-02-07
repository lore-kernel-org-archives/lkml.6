Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF393C282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5E42175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bP26+sXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfBGThQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:37:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35378 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfBGThP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XyuH3s5btQ7mHAGeF3ZoeE02Akb0cMxexPWpqxP67uA=; b=bP26+sXr54fuUiR9IiKuknojR
        05eeVLzShuE8V2JQQq+lfq9ZtSMoU0jIpnXpvfH4ZhsSvLea4l2sSH5NKBTpsbQLAV7Al75giSjt4
        8D/9lUqRmMfG9pqGPFyQe/+x1Wm5DqeO1ii498wxhKnVW3wXrlqtwMhwxrSd74jTQ7PfXWkiAJd2s
        WZXsHWFftOJha3iNy6AqDdu4EriyGPQIuAx1ekfM1n367vAWmnMagMW/lyFtWJcMQKZFSwevsBhJA
        MnCmBTgT3RNgZ/zdgpD5R/Ww9xF1HBKd1/4p5r2Bs4+dBP5QTBcUXQNetp4Lp4dJEaqxfwTLblQ+a
        XoUnvxP+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1grpTn-0007db-3V; Thu, 07 Feb 2019 19:36:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E1222029E062; Thu,  7 Feb 2019 20:36:56 +0100 (CET)
Date:   Thu, 7 Feb 2019 20:36:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH-tip 04/22] locking/rwsem: Remove arch specific rwsem files
Message-ID: <20190207193656.GF32511@hirez.programming.kicks-ass.net>
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <1549566446-27967-5-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549566446-27967-5-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 02:07:08PM -0500, Waiman Long wrote:

> +static inline int __down_read_trylock(struct rw_semaphore *sem)
> +{
> +	long tmp;
> +
> +	while ((tmp = atomic_long_read(&sem->count)) >= 0) {
> +		if (tmp == atomic_long_cmpxchg_acquire(&sem->count, tmp,
> +				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
> +			return 1;
> +		}
> +	}

Nah, you're supposed to write that like:

	for (;;) {
		val = atomic_long_cond_read_relaxed(&sem->count, VAL < 0);
		if (atomic_long_try_cmpxchg_acquire(&sem->count, &val,
						    val + RWSEM_ACTIVE_READ_BIAS))
			break;
	}

> +	return 0;
> +}


Anyway, yuck, you're keeping all that BIAS nonsense :/ I was so hoping
for a rwsem implementation without that impenetrable crap.
