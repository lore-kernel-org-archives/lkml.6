Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CE4C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25B320651
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fRFc8ol+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E25B320651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbeJWB0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:26:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43280 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeJWB0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FLOYoI1bRK7fDiusil94FHLHwhbNvTUERdR8vXQql2A=; b=fRFc8ol+zNyfvFTsDXZ4bkfEV
        vGL+udtlogmJS1ZmScGuSQL1S9yA3HtSQP6vDeOclCRxOralc1jLX7no3i0nit/+BvDDvCMeHFsMv
        2uRo02f05ehmiuj1kPmHOoepirnlLGqIzTv9UnS3Za4ANl97lWiKYxyWwNRvJbdczpekOZUcj1Sr7
        AtAKXzuJz6mU2H8PK3tWShzfzLglOXav0hXSxy40AfNOVbOQMJHBqBm8P9VpC42Hs6Ai/e1arYvmw
        B2Hx1qvcbmY9MHQVtATfJ8ilL6IkFPjZglp4llKRnihu+WhYlQSC0P2VUspjViNAfZNQ19mo9+W3z
        FC1Mv4Vbg==;
Received: from [167.98.65.38] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEdfK-00014R-K9; Mon, 22 Oct 2018 17:06:54 +0000
Received: by worktop (Postfix, from userid 1000)
        id 55AE86E082E; Mon, 22 Oct 2018 18:56:31 +0200 (CEST)
Date:   Mon, 22 Oct 2018 18:56:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steve Sistare <steven.sistare@oracle.com>
Cc:     mingo@redhat.com, subhra.mazumdar@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 04/10] sched/fair: Dynamically update cfs_overload_cpus
Message-ID: <20181022165631.GE3117@worktop.programming.kicks-ass.net>
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
 <1540220381-424433-5-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540220381-424433-5-git-send-email-steven.sistare@oracle.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 07:59:35AM -0700, Steve Sistare wrote:
> An overloaded CPU has more than 1 runnable task.  When a CFS task wakes
> on a CPU, if h_nr_running transitions from 1 to more, then set the CPU in
> the cfs_overload_cpus bitmap.  When a CFS task sleeps, if h_nr_running
> transitions from 2 to less, then clear the CPU in cfs_overload_cpus.

> @@ -5111,8 +5147,12 @@ static inline void hrtick_update(struct rq *rq)
>  		update_cfs_group(se);
>  	}
>  
> -	if (!se)
> +	if (!se) {
>  		add_nr_running(rq, 1);
> +		if (prev_nr == 1)
> +			overload_set(rq);
> +
> +	}

This is very similar to what RT already has, except they also track if
the tasks in question is in fact migratable (p->nr_cpus_allowed > 1).

And similarly, it might make sense to use the sparse mask thing over
there.
