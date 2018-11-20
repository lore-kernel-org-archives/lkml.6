Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762F2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 04:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312D220831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 04:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iNRhBfUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312D220831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbeKTPNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 10:13:15 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40276 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730276AbeKTPNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 10:13:14 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22-v6so357587pls.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 20:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qz7Fh62Lnq2ewkYC0LIkfwYa7eJa73OEqYgpRrOkDcU=;
        b=iNRhBfUGk7swVZ5U4LUt7QJvTTR9M5ZxzqkUUiqSWllcuLLnVBxjCyvqjRbjEjFxbd
         H8I1C1Aic6d6PXwNmdbpyl66viwUDlhH/kMixFs/+mQ3Qr6ARrSNPjRYiBHMTKx5J9y9
         /HDOGsRwNSd6QwrHnLZZ8zzw91dgPhk/zKPXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qz7Fh62Lnq2ewkYC0LIkfwYa7eJa73OEqYgpRrOkDcU=;
        b=iWuuJZjXS7mxH14cYIn1AUin1ED+ZdSTx3z/nZVOEpqxqT+p1Li9TBRsrvH/C2I59l
         hDP3Z7eTwZKVcrW/JmeqEdZ/NDBSN1ghM34ttGGvmwBpLmOL9BjDBUlWSiUjzSd9lwLT
         RDt+nQD6JjVvbInMpkoRFG+RGX3sQdzMZFwU7rdsJEBR+EKKcmDjIFIvj0aBq0rUWc/5
         9cnGzOslElkjsM75LQisaY+3dBR9+XkoNGn1Y4LaPttafvP1piHDz0aKemc2367UpDhl
         G1A2El9rwBo+KerNqXI+OOSOQWbtgZa6dm6q5Tz8WPicF7WjILjiQER8EzC2kmi9/xqi
         rJUw==
X-Gm-Message-State: AA+aEWbcWY+E82vRkPU9yir1eIcbsPUuIcrePcdu6tmJAufPmIsPLVGS
        SGBFis1alDrN0CqaUX0HyiTFVA==
X-Google-Smtp-Source: AFSGD/UGViXohg+/+cldaGMYGbg4lgX0gadqxDRoC8YtIplQQfeEFLyr8z5rYH6Nhz3BXY8bBPC3Qg==
X-Received: by 2002:a17:902:4025:: with SMTP id b34mr641406pld.181.1542689165552;
        Mon, 19 Nov 2018 20:46:05 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id f13sm22972274pfa.132.2018.11.19.20.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 20:46:04 -0800 (PST)
Date:   Tue, 20 Nov 2018 10:16:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, tkjos@google.com,
        joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org
Subject: Re: [PATCH v9 02/15] sched/cpufreq: Prepare schedutil for Energy
 Aware Scheduling
Message-ID: <20181120044602.bsfsp4alswbwoweu@vireshk-i7>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-3-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119141857.8625-3-quentin.perret@arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-11-18, 14:18, Quentin Perret wrote:
> @@ -223,20 +222,33 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)

> -	if ((util + cpu_util_dl(rq)) >= max)
> -		return max;
> +	if (type == FREQUENCY_UTIL) {
> +		/*
> +		 * For frequency selection we do not make cpu_util_dl() a
> +		 * permanent part of this sum because we want to use
> +		 * cpu_bw_dl() later on, but we need to check if the
> +		 * CFS+RT+DL sum is saturated (ie. no idle time) such
> +		 * that we select f_max when there is no idle time.
> +		 *
> +		 * NOTE: numerical errors or stop class might cause us
> +		 * to not quite hit saturation when we should --
> +		 * something for later.
> +		 */
> +
> +		if ((util + cpu_util_dl(rq)) >= max)
> +			return max;
> +	} else {
> +		/*
> +		 * OTOH, for energy computation we need the estimated
> +		 * running time, so include util_dl and ignore dl_bw.
> +		 */
> +		util += cpu_util_dl(rq);
> +		if (util >= max)
> +			return max;
> +	}

Maybe write above as:

        dl_util = cpu_util_dl(rq);

        if ((util + dl_util) >= max)
                return max;

	if (type != FREQUENCY_UTIL)
		util += dl_util;


as both the if/else parts were doing almost the same thing.

-- 
viresh
