Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA14ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF02321475
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qf5bl8Fz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF02321475
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731833AbeGQOtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:49:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42440 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeGQOtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZZ4KndFwA3KV+5BHpYSUDzvyMA6B/8tFlNACiFPkc7g=; b=Qf5bl8Fz6G4a0Y75MfuqgChYz
        gdlrC8C6MboDlATZLjH5AFTU9gZo9cGrVAmv6ZUubf8rvlF8MlnX7+vNtdKbV9CHjgs9HsfOwfYL3
        BltAZ6Yi8BOf5ZjDAOKXWhKLol7opLAo7orHOtGjrYa12uFdjoMAyFT5LJoryhNBK2F9QXxeblnUO
        XpbQeeBdv3drUPUC2sSWtkQqig+3siASQckpfU/gz673w5dcd6ckOtSIIOLoBEN+YJBVwEhd0X9H5
        wElNFOTB7rPo4le5KqWhsR3zcjcPhbfsGgF6+Ur80RoDbbwkLpkXqBP/+tk8fBE28omgiyhQISGIN
        7ekCoPpAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffQlz-0000no-RD; Tue, 17 Jul 2018 14:16:16 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 44BDE20275F36; Tue, 17 Jul 2018 16:16:14 +0200 (CEST)
Date:   Tue, 17 Jul 2018 16:16:14 +0200
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
Message-ID: <20180717141614.GE2494@hirez.programming.kicks-ass.net>
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
> +/* Tracked task states */
> +enum psi_task_count {
> +	NR_RUNNING,
> +	NR_IOWAIT,
> +	NR_MEMSTALL,
> +	NR_PSI_TASK_COUNTS,
> +};

> +/* Resources that workloads could be stalled on */
> +enum psi_res {
> +	PSI_CPU,
> +	PSI_MEM,
> +	PSI_IO,
> +	NR_PSI_RESOURCES,
> +};

These two have mem and iowait in different order. It really doesn't
matter, but my brain stumbled.
