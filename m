Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F57C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664E320647
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ei1300xP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664E320647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbeG0JJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:09:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46014 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729442AbeG0JJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uqwPEn1GMINOJ8+Zw1ofTtI8q0YhWIQUUUhEr32Y/UA=; b=Ei1300xPC+dq5EyfR932a9fof
        3bkK42GjQRxttvhjsyJTUgYTr8v8vXWXgwwTL1NUqVYQZepd3TEWQDKlAui9JUSImC6jDIO+OsyMs
        NiHKeEwr5z+TLIJqVSX8Jv78y8fOZOh+FYxPw4xt9is3qdjvqf5hp/PC6ByZvsQdDK/j4HLKP7mm5
        8Jsgirw0Uaj36pNLu4Uj2rvRYoV3OkRQRxm6yuQ0mITSJpKD6EYa44+AGjpXRiVl1jIM1YUbxNEcR
        ObRioWwzvKH4DoAopaP2wE9C48/2y7bokr0VEwu+txfewbKQutuMNW+0ITz5jR8BctjqzW4coYPkS
        rYLKJgeYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fixUb-0004PS-Jy; Fri, 27 Jul 2018 07:48:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 442A42040AE9C; Fri, 27 Jul 2018 09:48:51 +0200 (CEST)
Date:   Fri, 27 Jul 2018 09:48:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Cheng Lin <cheng.lin130@zte.com.cn>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn,
        tan.hu@zte.com.cn.cn
Subject: Re: [PATCH v2] sched/numa: do not balance tasks onto isolated cpus
Message-ID: <20180727074851.GY2494@hirez.programming.kicks-ass.net>
References: <1532593148-106266-1-git-send-email-cheng.lin130@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532593148-106266-1-git-send-email-cheng.lin130@zte.com.cn>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 04:19:08PM +0800, Cheng Lin wrote:
> -	if (!cpumask_test_cpu(arg.dst_cpu, &arg.src_task->cpus_allowed))
> +	if ((!cpumask_test_cpu(arg.dst_cpu, &arg.src_task->cpus_allowed))
> +		|| !housekeeping_test_cpu(arg.dst_cpu, HK_FLAG_DOMAIN))
>  		goto out;

You did not read the comment I provided last time. Using isolcpus (and
thus it's renamed houskeeping thing) is the wrong thing to do. Load
balancing should be limited to it's root domain.
