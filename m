Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756CCC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F89220836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bptJ+1BM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F89220836
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932666AbeFTRCH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:02:07 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46720 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932153AbeFTRCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:02:06 -0400
Received: by mail-pf0-f193.google.com with SMTP id q1-v6so95642pff.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ahU7ALUz1vq36SiZ4NnO4BpdcSb3zBWgPmiXbVmkhVM=;
        b=bptJ+1BMTZ962eyIj/baQvdezCaP6atlNqtQW3pP3k7wfg6shezDrmk0ReRLv2lnf1
         r6JtkZMZDPoIWcGM2S0ZdpAfg7YfvOFmvj6W+uljMhXeCySQBONC5qG+vX5WhdzUc0Nu
         aG5IUeGXyoh/q2yLcXmFgMrpLfDTGZjbdWR4WHGixvyYjwNL1t1uSwkGVaZeZKLwj11t
         0ptbdhrQ09A96TUU5q5aOQzte0ijYoi9fz19ScllzMOQGr/I/FDGIs2zJC8DZnoSk7i1
         vAiLqQdF2JdQxh/uUja5qJIhj6lDqNfzgNjbDF9k18J5oXDzbYglxWH6f5fJAuSAfsYe
         XH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=ahU7ALUz1vq36SiZ4NnO4BpdcSb3zBWgPmiXbVmkhVM=;
        b=AkigrlPj97c+cQHylNeFWhodUSlbQinf81AB/NdDhIh2ivrs/KJUFtsnMtkbnXrnM7
         mjgjFE/j6qpB5CH2HsxFiNkAY6BZ1JFfaGOBLN6z504UOjqqShNltTtaod0nyRjZyC+m
         dLcsP39qWfsayJ17g2a8+VRX0rnYt6w2468ZnviSocIkSceGa6wcSdjT0g62SR2zrSys
         zE3TXSdJ/6V4HmneaR0SwJaPd2gPoaqBNtG18ViJm6pV45LsbZdS8KJr+9JrbX1ur5eF
         Ac/YQLFPRuY+1rXj+RrbFzVQiqVyotxU+aCSaHGXhh1R4JKmZ2XErCWaFXW3slLvr5Dg
         P4tg==
X-Gm-Message-State: APt69E3fycd9i7TEcOVkw4QXjZMyBUR2y21xytqWbrkIy62nzyjHm1WM
        C+ky8Rw0CUxbLkoJn3lPrUeURJG6LGU=
X-Google-Smtp-Source: ADUXVKKNfKckFsXIX5akmN3cTnM6U/dQtXgl3FJKons4AfrfFawzwkskzph3eAzBCPb1hnirdnq5zQ==
X-Received: by 2002:a62:499b:: with SMTP id r27-v6mr23889336pfi.74.1529514123667;
        Wed, 20 Jun 2018 10:02:03 -0700 (PDT)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cb:201:549c:c572:5008:d36f])
        by smtp.gmail.com with ESMTPSA id t3-v6sm4165599pgs.91.2018.06.20.10.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 10:02:02 -0700 (PDT)
From:   bsegall@google.com
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ben Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] sched/fair: Advance global expiration when period timer is restarted
References: <20180620101834.24455-1-xlpang@linux.alibaba.com>
        <20180620101834.24455-2-xlpang@linux.alibaba.com>
Date:   Wed, 20 Jun 2018 10:02:01 -0700
In-Reply-To: <20180620101834.24455-2-xlpang@linux.alibaba.com> (Xunlei Pang's
        message of "Wed, 20 Jun 2018 18:18:34 +0800")
Message-ID: <xm26bmc5pf1y.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xunlei Pang <xlpang@linux.alibaba.com> writes:

> When period gets restarted after some idle time, start_cfs_bandwidth()
> doesn't update the expiration information, expire_cfs_rq_runtime() will
> see cfs_rq->runtime_expires smaller than rq clock and go to the clock
> drift logic, wasting needless cpu cycles on the scheduler hot path.
>
> Update the global expiration in start_cfs_bandwidth() to avoid frequent
> expire_cfs_rq_runtime() calls once a new period begins.
>
> Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
Reviewed-By: Ben Segall <bsegall@google.com>


> ---
>  kernel/sched/fair.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e6bb68d52962..f167aca066cc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5204,13 +5204,18 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>  
>  void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>  {
> +	u64 overrun;
> +
>  	lockdep_assert_held(&cfs_b->lock);
>  
> -	if (!cfs_b->period_active) {
> -		cfs_b->period_active = 1;
> -		hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
> -		hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
> -	}
> +	if (cfs_b->period_active)
> +		return;
> +
> +	cfs_b->period_active = 1;
> +	overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
> +	cfs_b->runtime_expires += (overrun + 1) * ktime_to_ns(cfs_b->period);
> +	cfs_b->expires_seq++;
> +	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
>  }
>  
>  static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
