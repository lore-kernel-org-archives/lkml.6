Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C391AECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E43120C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 15:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hHAYmvK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E43120C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbeGQQF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:05:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44996 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729602AbeGQQF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sivGMNeEa4hjba3vK8UUdaWd0cu+fx+tu0F6HbvTrKA=; b=hHAYmvK5aBQZ/JPLolPltIS+R
        oIt6zn65AFHH8Xyv1WVfZmTOK4s1oPtWpTY/LE7traJl+mb5dIsiUqeEbmIBbAQ3V5hUR8qmtvnxj
        oUz2cwFyOCIRvX7k6+fCZ/dt6FElVDBlHXlu4LLju8lKu4szc2UzvDHNgPYM7nq7DFKZC6g2mUdGi
        NGyqbyI1IGm4DlCVsTKaFtDR9Hw7XqBkzJG+8h0uhc4XdCH6vqaZiw6bzR2eVPyvGG8kzG88vYZ59
        626IRZOrhLVKyAdGVYXryCuFys1yKUtNAc9qlpvb4Lu/ExBwd3rbHwAochgQFTYZ95DfB9MdWoVoh
        tc7UrhftQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffRxw-0001I0-NV; Tue, 17 Jul 2018 15:32:40 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EBA2A20275F36; Tue, 17 Jul 2018 17:32:38 +0200 (CEST)
Date:   Tue, 17 Jul 2018 17:32:38 +0200
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
Message-ID: <20180717153238.GA2476@hirez.programming.kicks-ass.net>
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
> +struct psi_group {
> +	struct psi_group_cpu *cpus;

That one wants a __percpu annotation on I think. Also, maybe a rename.

> +
> +	struct mutex stat_lock;
> +
> +	u64 some[NR_PSI_RESOURCES];
> +	u64 full[NR_PSI_RESOURCES];
> +
> +	unsigned long period_expires;
> +
> +	u64 last_some[NR_PSI_RESOURCES];
> +	u64 last_full[NR_PSI_RESOURCES];
> +
> +	unsigned long avg_some[NR_PSI_RESOURCES][3];
> +	unsigned long avg_full[NR_PSI_RESOURCES][3];
> +
> +	struct delayed_work clock_work;
> +};
