Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4C0C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8776B2086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dONH3Hki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8776B2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeKGWrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:47:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbeKGWrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 17:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ghEFjup3LUn+tpj9gyuDotc1TfXh7DnCI2mdqd29zjs=; b=dONH3HkiCHxh5xA3aCBUS4tsv
        fkoLnudiP3rXlT9ziC/Ajdhgmf83Ozx5Q7twB3OV9LJYOsh0gIURbVbNbfjMRvB9m3t2kVSqIN2g+
        V0R1pnw33NplLbRUevdkrdG2+hsDDUPMOIdXJGer+iOtUHcBPd8KW4Q3jX/1bRZLM3B+gjbaUTLoG
        MLLrwy6TvmTd+ybeeL76VyUfdve8NKIabdyjtMj9eutc603P2Id6+ePemcQjz+xz4SxSxv0bAFadk
        9gDre/hM7vMfTiUyMsulkyyHMCxCqEiUxDjgamWnnV0OtMYAgmLVSha3PhoEdd/3w2KnvvVj6D3lA
        QM9+VYEHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKNhD-0001Pf-2N; Wed, 07 Nov 2018 13:16:35 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B73A20298C0C; Wed,  7 Nov 2018 14:16:32 +0100 (CET)
Date:   Wed, 7 Nov 2018 14:16:32 +0100
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
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v5 03/15] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Message-ID: <20181107131632.GP9781@hirez.programming.kicks-ass.net>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-4-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029183311.29175-4-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 06:32:57PM +0000, Patrick Bellasi wrote:

> +static void uclamp_group_put(unsigned int clamp_id, unsigned int group_id)
>  {
> +	union uclamp_map *uc_maps = &uclamp_maps[clamp_id][0];
> +	union uclamp_map uc_map_old, uc_map_new;
> +	long res;
> +
> +retry:
> +
> +	uc_map_old.data = atomic_long_read(&uc_maps[group_id].adata);
> +	uc_map_new = uc_map_old;
> +	uc_map_new.se_count -= 1;
> +	res = atomic_long_cmpxchg(&uc_maps[group_id].adata,
> +				  uc_map_old.data, uc_map_new.data);
> +	if (res != uc_map_old.data)
> +		goto retry;
> +}

Please write cmpxchg loops in the form:

	atomic_long_t *ptr = &uclamp_maps[clamp_id][group_id].adata;
	union uclamp_map old, new;

	old.data = atomic_long_read(ptr);
	do {
		new.data = old.data;
		new.se_cound--;
	} while (!atomic_long_try_cmpxchg(ptr, &old.data, new.data));


(same for all the others of course)
