Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDDEECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7F62147A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CVpUgEPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7F62147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbeGQOzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:55:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58350 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731733AbeGQOzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OUNk26li7VwVFPkQIQ4fOTX19qt2GWgKPm5YuwyF2nY=; b=CVpUgEPrLebGmj2iK9Fn8Bu7C
        RKjuMWD9R/pc5NaMPCEaTaGTEK7TxlCWmF2lHZmbfUkB9k+OXS/1b0/O6Oxrt4M7CtIbnAroPHfr5
        Ej1plu6xu5F0HsI10Eglr8DxCNVWutsTYTJP6dTiJSBSdAh8AwnvY1ECBOa4sf+Oc22Y0S+2mkP9y
        +WbtODQ2pQ3QsKlAlCCGj7Qs3C9xblzBs0tPUndR37/iGAub5G69ys5EiwPcLfpIF3C994B0wegxt
        nXHdEaIzWK1fUGxwNY6U8ZJ9BlnsznecDEyXDUfnQy/M/hJlWTbEW+5ZU5VHC6M7a+2CXjYgoM0sx
        sONwFC3CQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffQrX-0007tS-Eu; Tue, 17 Jul 2018 14:21:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E159620275F36; Tue, 17 Jul 2018 16:21:57 +0200 (CEST)
Date:   Tue, 17 Jul 2018 16:21:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 08/10] psi: pressure stall information for CPU, memory,
 and IO
Message-ID: <20180717142157.GF2494@hirez.programming.kicks-ass.net>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-9-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712172942.10094-9-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 01:29:40PM -0400, Johannes Weiner wrote:
> diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
> index 04f1321d14c4..ac39435d1521 100644
> --- a/include/linux/sched/stat.h
> +++ b/include/linux/sched/stat.h
> @@ -28,10 +28,14 @@ static inline int sched_info_on(void)
>  	return 1;
>  #elif defined(CONFIG_TASK_DELAY_ACCT)
>  	extern int delayacct_on;
> +	if (delayacct_on)
> +		return 1;
> +#elif defined(CONFIG_PSI)
> +	extern int psi_disabled;
> +	if (!psi_disabled)
> +		return 1;
>  #endif
> +	return 0;
>  }

Doesn't that want to be something like:

static inline bool sched_info_on(void)
{
#ifdef CONFIG_SCHEDSTAT
	return true;
#else /* !SCHEDSTAT */
#ifdef CONFIG_TASK_DELAY_ACCT
	extern int delayacct_on;
	if (delayacct_on)
		return true;
#endif /* DELAYACCT */
#ifdef CONFIG_PSI
	extern int psi_disabled;
	if (!psi_disabled)
		return true;
#endif
	return false;
#endif /* !SCHEDSTATE */
}

Such that if you build a TASK_DELAY_ACCT && PSI kernel, and boot with
nodelayacct, you still get sched_info_on().
