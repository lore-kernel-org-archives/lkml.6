Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263A9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DCA2083D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6DCA2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeIFMvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:51:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40293 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeIFMvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:51:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id n2-v6so10358738wrw.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 01:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OcUD6zyFubkDVhsmPCCCASObW8UUhxp/Hh/diNtVEmg=;
        b=SHM8ipMLCvTPnk/+2FulyrAqa3173qRgsaUuWSo8QsYdJZ3VWVNcJS7BJosoCmEoow
         +bVSF420fDiDvfJKarXmZRhLClBf3RzqBgo4VLZPZtb6xPuAtRIggDsTFlg6VIPusCoC
         z/5Vc5O1m8RSr25mBI6bNFpwJBVUnJA511TeIULJJLlhyhNNyRbf4hge1sQCozmwCo2E
         QEstgek7PdSwvJ282tm1waUaF2C1irt03DrX9ks+vwIv3wQeSIwVl1mMaV1gdzTqCi+Z
         W+vyGK0+GARZaJKna/fVTumIR1TRJRGWiFP6FXTaQ8z5KhmNIFiqyeR+1Qr2jneA5jNU
         Rojg==
X-Gm-Message-State: APzg51D9GM4A7b71zVv+gVn+gUyZ24BI/3Y34zIvh+6uYnaTCSEejNLE
        9V6kkDcrB1e76XGazzbWQz7qLg==
X-Google-Smtp-Source: ANB0Vdbd8cF+3mEuY8S0hsIqRjrbnDZuWxSj+U83RJVL1pAa3XAhI/b/4C1nrW1goaCXuOn5PAV26A==
X-Received: by 2002:adf:ea92:: with SMTP id s18-v6mr1291427wrm.284.1536221851665;
        Thu, 06 Sep 2018 01:17:31 -0700 (PDT)
Received: from localhost.localdomain ([151.15.227.30])
        by smtp.gmail.com with ESMTPSA id 200-v6sm6790961wmv.6.2018.09.06.01.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 01:17:30 -0700 (PDT)
Date:   Thu, 6 Sep 2018 10:17:28 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 02/16] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Message-ID: <20180906081728.GB27626@localhost.localdomain>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-3-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828135324.21976-3-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/18 14:53, Patrick Bellasi wrote:

[...]

>  static inline int __setscheduler_uclamp(struct task_struct *p,
>  					const struct sched_attr *attr)
>  {
> -	if (attr->sched_util_min > attr->sched_util_max)
> -		return -EINVAL;
> -	if (attr->sched_util_max > SCHED_CAPACITY_SCALE)
> -		return -EINVAL;
> +	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
> +	int lower_bound, upper_bound;
> +	struct uclamp_se *uc_se;
> +	int result = 0;
>  
> -	p->uclamp[UCLAMP_MIN] = attr->sched_util_min;
> -	p->uclamp[UCLAMP_MAX] = attr->sched_util_max;
> +	mutex_lock(&uclamp_mutex);
>  
> -	return 0;
> +	/* Find a valid group_id for each required clamp value */
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> +		upper_bound = (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
> +			? attr->sched_util_max
> +			: p->uclamp[UCLAMP_MAX].value;
> +
> +		if (upper_bound == UCLAMP_NOT_VALID)
> +			upper_bound = SCHED_CAPACITY_SCALE;
> +		if (attr->sched_util_min > upper_bound) {
> +			result = -EINVAL;
> +			goto done;
> +		}
> +
> +		result = uclamp_group_find(UCLAMP_MIN, attr->sched_util_min);
> +		if (result == -ENOSPC) {
> +			pr_err(UCLAMP_ENOSPC_FMT, "MIN");
> +			goto done;
> +		}
> +		group_id[UCLAMP_MIN] = result;
> +	}
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> +		lower_bound = (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
> +			? attr->sched_util_min
> +			: p->uclamp[UCLAMP_MIN].value;
> +
> +		if (lower_bound == UCLAMP_NOT_VALID)
> +			lower_bound = 0;
> +		if (attr->sched_util_max < lower_bound ||
> +		    attr->sched_util_max > SCHED_CAPACITY_SCALE) {
> +			result = -EINVAL;
> +			goto done;
> +		}
> +
> +		result = uclamp_group_find(UCLAMP_MAX, attr->sched_util_max);
> +		if (result == -ENOSPC) {
> +			pr_err(UCLAMP_ENOSPC_FMT, "MAX");
> +			goto done;
> +		}
> +		group_id[UCLAMP_MAX] = result;
> +	}

Don't you have to reset result to 0 here (it seems what follows cannot
fail anymore)? Otherwise this function will return latest
uclamp_group_find return value, which will be interpreted as error if
not 0.

> +
> +	/* Update each required clamp group */
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> +		uc_se = &p->uclamp[UCLAMP_MIN];
> +		uclamp_group_get(UCLAMP_MIN, group_id[UCLAMP_MIN],
> +				 uc_se, attr->sched_util_min);
> +	}
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> +		uc_se = &p->uclamp[UCLAMP_MAX];
> +		uclamp_group_get(UCLAMP_MAX, group_id[UCLAMP_MAX],
> +				 uc_se, attr->sched_util_max);
> +	}
> +
> +done:
> +	mutex_unlock(&uclamp_mutex);
> +
> +	return result;
> +}

Best,

- Juri
