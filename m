Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C659BC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8772085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CUAnfLXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8772085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbeKFVGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:06:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730525AbeKFVGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kFxUuHjpTxdn+Qfxz/i90rdrGYlXVZnA2uZTtMbZrV0=; b=CUAnfLXEDB7M65oP2yZiqICKv
        wt4SCNc9cR+YnL0IjaNZQrIl3uly8CxFCsTcRu5KP53AHW9BRvTmNFere2EPALbHKaCqTSdRppM69
        CZlALiKbuBW8//ugBMz5y73i9hQS1+MI28mJ25DlbW71KTPhlYGJKvHnDkW5L4HKWqgam5wW0F/m2
        QI/t0vJhtFHOcJ9s+qSQuXpgRMPiq09jul+FkUZPU/OipKZ8+bpP3txl4jlSZunf+5do631haSjXY
        yMUu4SBqpD1YsrSf2xwxOlsQTFtE+rS/35L8eM9ZTt6STMQbPxdPflXLno4IXhBY1qF+TF31OoPIN
        FtAyoKPTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJzjB-0001wL-48; Tue, 06 Nov 2018 11:41:01 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5CCC22029F9FF; Tue,  6 Nov 2018 12:40:55 +0100 (CET)
Date:   Tue, 6 Nov 2018 12:40:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@fb.com, pjt@google.com, luto@amacapital.net,
        Mike Galbraith <efault@gmx.de>, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>
Subject: Re: [PATCH v14 05/12] cpuset: Add an error state to
 cpuset.sched.partition
Message-ID: <20181106114055.GN22431@hirez.programming.kicks-ass.net>
References: <1539635377-22335-1-git-send-email-longman@redhat.com>
 <1539635377-22335-6-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539635377-22335-6-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 04:29:30PM -0400, Waiman Long wrote:
> +			case PRS_ENABLED:
> +				if (update_parent_subparts_cpumask(cp,
> +					partcmd_update, NULL, tmp))
> +					update_tasks_cpumask(parent);
> +				break;

That code indenting had me go WTF a few times.
