Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFDCC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B2320883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pbzZO34k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B2320883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbeKGVlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:41:40 -0500
Received: from merlin.infradead.org ([205.233.59.134]:58946 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeKGVlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FsAUNDwhbnLrJJRn1c3CpMgWLoumr1Q/EjqsG1h7o2A=; b=pbzZO34k4T1rQz3XiCdyPu39N
        IWC7rDmIcIvZyaLTU97ocefO6hzf+UbJ3UF/FOMGdYxCzPp0T/K2vqotQlmn5eBC/1ClNqwqnj9eW
        KBLcKZjWdcBERlUq5mNw0TTRJVZgFP/f+R0Xih7hkQ43DpfH98itZYB+pNeevNc36+8DPsrUJf0cw
        aQqCOV9RI4KkrTSg99zyEXMwBHlHWR4iZM2y8N29fB6Cut3vgqgmOHgiVk7Tobb8wLtJDmKWrkQDT
        K+ohBT9uRaN17Ny2VUKlR9HxhBMWgu41zKK1cl/bSKZAn65Jj9uqU/GCzjbMSS5gZ8izlaQKW3zDH
        1cID3+u0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKMgC-0005UR-17; Wed, 07 Nov 2018 12:11:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2ABEA20284F94; Wed,  7 Nov 2018 13:11:26 +0100 (CET)
Date:   Wed, 7 Nov 2018 13:11:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v5 02/15] sched/core: make sched_setattr able to tune the
 current policy
Message-ID: <20181107121126.GN9781@hirez.programming.kicks-ass.net>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-3-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029183311.29175-3-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 06:32:56PM +0000, Patrick Bellasi wrote:

> @@ -50,11 +52,13 @@
>  #define SCHED_FLAG_RESET_ON_FORK	0x01
>  #define SCHED_FLAG_RECLAIM		0x02
>  #define SCHED_FLAG_DL_OVERRUN		0x04
> -#define SCHED_FLAG_UTIL_CLAMP		0x08
> +#define SCHED_FLAG_TUNE_POLICY		0x08
> +#define SCHED_FLAG_UTIL_CLAMP		0x10

That seems to suggest you want to do this patch first, but you didn't..
