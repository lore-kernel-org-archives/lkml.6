Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DD6C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D4B207E0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OQgrpQSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfBDL4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:56:15 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35628 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbfBDL4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 06:56:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wdWg3Gk782dVCrvocq6FDMvJKD4tJ23otHwOGefFoWo=; b=OQgrpQSwPVg3KOSPz4326KVAo
        anBqsBOnYk1VUlqXIrsadW9QryJ6UwTv/UUdAEhTrOsTXTDAjY7Vuc1b1Bl6i3aLcP0+rHjPB5OPF
        qIVe9rlW9+B4dbkI2y8IpSFsVpnw9QJkdXSi1wV26J3x5hh/hmDdXr7p+1Lt7U0LeGh91luUgsO8B
        ISZ9vdoRdx5sVadWRVcsrIUtghoUu3TtGbw476wdAw3Yc2OUF5YDdSGEJ2RfMtpa9AVHRDNGx2+KU
        7R51B1qW5dhOtBoHl8ciGJD2PgwH1S2uvmrIRe2lyu9LapHthKaAu79f6mSpdYDbKUydruUpjG6UH
        WsroIZRGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqcqv-000282-C4; Mon, 04 Feb 2019 11:55:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F4462029FA06; Mon,  4 Feb 2019 12:55:50 +0100 (CET)
Date:   Mon, 4 Feb 2019 12:55:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v6 3/5] cgroup/cpuset: make callback_lock raw
Message-ID: <20190204115550.GB17550@hirez.programming.kicks-ass.net>
References: <20190117084739.17078-1-juri.lelli@redhat.com>
 <20190117084739.17078-4-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117084739.17078-4-juri.lelli@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 09:47:37AM +0100, Juri Lelli wrote:
> @@ -2366,7 +2366,7 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
>  	cpuset_filetype_t type = seq_cft(sf)->private;
>  	int ret = 0;
>  
> -	spin_lock_irq(&callback_lock);
> +	raw_spin_lock_irq(&callback_lock);
>  
>  	switch (type) {
>  	case FILE_CPULIST:
> @@ -2388,7 +2388,7 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
>  		ret = -EINVAL;
>  	}
>  
> -	spin_unlock_irq(&callback_lock);
> +	raw_spin_unlock_irq(&callback_lock);
>  	return ret;
>  }
>  
could we not convert this to use cpuset_mutex ?
