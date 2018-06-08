Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 79rdNeVaGltmZwAAmS7hNA
	; Fri, 08 Jun 2018 10:31:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CA19B607A4; Fri,  8 Jun 2018 10:31:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 55AAB601C3;
	Fri,  8 Jun 2018 10:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 55AAB601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751549AbeFHKa7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 06:30:59 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33777 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbeFHKa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 06:30:57 -0400
Received: by mail-wr0-f195.google.com with SMTP id k16-v6so12866803wro.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 03:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AAC7XJxDcMw344TkDXzdzw6BlR+jy9IyUApsGqbdmzg=;
        b=Qmsk7I5zH9A7gDikeHaKBD2BNJjRuiLG7SXf5kKMxA6ewK54fSKkbbrh26ujEPfRNm
         X7HevNUxNHxouw5GkNGpdOTX/zTyCPbY5oqqrF1m0WTI5kpwun0eLxPjHtlOxJr8T0Fg
         0UfzULLlknSKKyhfyLz5KSTpyuczeAYei+/tNB/80L57BJFMzKiPk+Hc3hVChSToKSFf
         PT2qTXqECHiW2BpJ/H+GbIxjzy5rB6YgDuNzdtBV3QazPfKUUtVYPHOrj0oj5Bl3x4wp
         EaJUGpSxhhBX6vI0U2kVLqJul9P2V+442Nwu4gdRsSFQE447E5SvUFTPxJ5NDJ+k/mqg
         a69w==
X-Gm-Message-State: APt69E0SkjG5HY0oM3jqb3IozirkZu03qlGGg9cUJ/xRUZK7asV1Vzjx
        gJi+wkUzN8pmt98VFq1gk4T6Dg==
X-Google-Smtp-Source: ADUXVKI5hgr3dqXIsTgGbZDkcjxjDmhI5Lia4tx0HTuGrsIzqbfFdPfgWI0Y8E03xY6bD8TldT7Z2Q==
X-Received: by 2002:adf:92c2:: with SMTP id 60-v6mr4501863wrn.70.1528453856071;
        Fri, 08 Jun 2018 03:30:56 -0700 (PDT)
Received: from localhost.localdomain ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id o16-v6sm26576332wrp.8.2018.06.08.03.30.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 03:30:55 -0700 (PDT)
Date: Fri, 8 Jun 2018 12:30:52 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joelaf@google.com, smuckle@google.com,
        adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [RFC PATCH v3 07/10] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20180608103052.GF658@localhost.localdomain>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-8-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521142505.6522-8-quentin.perret@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/18 15:25, Quentin Perret wrote:

[...]

> +static long compute_energy(struct task_struct *p, int dst_cpu)
> +{
> +	long util, max_util, sum_util, energy = 0;
> +	struct sched_energy_fd *sfd;
> +	int cpu;
> +
> +	for_each_freq_domain(sfd) {
> +		max_util = sum_util = 0;
> +		for_each_cpu_and(cpu, freq_domain_span(sfd), cpu_online_mask) {
> +			util = cpu_util_next(cpu, p, dst_cpu);
> +			util += cpu_util_dl(cpu_rq(cpu));
> +			/* XXX: add RT util_avg when available. */

em_fd_energy() below uses this to know which power to pick in the freq
table. So, if you have any RT task running on cpu freq will be at max
anyway. It seems to me that in this case max_util for the freq_domain
must be max_freq (w/o considering rt.util_avg as schedutil does). Then
you could probably still use rt.util_avg to get the percentage of busy
time with sum_util?

> +
> +			max_util = max(util, max_util);
> +			sum_util += util;
> +		}
> +
> +		energy += em_fd_energy(sfd->fd, max_util, sum_util);
> +	}
> +
> +	return energy;
> +}

Best,

- Juri
