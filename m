Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0839C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 06:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931E820870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 06:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dlzG7UHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931E820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732005AbeKTQqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 11:46:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33481 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731499AbeKTQqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 11:46:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so491029plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 22:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8tTu90lz7d1RXsDHTFCmwgIPgGmA7/ELT7ZzFdY+mrA=;
        b=dlzG7UHlEmaVHwnDXWktec0VjIgYl+PFDKLFEw/yKQfdp9EjPys2BUXmtZS+yimXqy
         +VG2/x8jkt1HLjDSuHTB69sX93ee0ZoZaWSDMAWLVdVD0mSU3SVwBgSowgsbFZBGEnsq
         MDyXbNBdMK4VrRl+TC/RxCzwacHB1bS0UKv3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8tTu90lz7d1RXsDHTFCmwgIPgGmA7/ELT7ZzFdY+mrA=;
        b=B2J66pP6ghZli4Z3F8WERBEWDFU6d74HGYO+uEwLZI06hZeiKThz/ruZRh1XvAlHNI
         xIF1LI4p5R0iUIBgGsNstbB8C+jRdcEWo42ELt/kIJn0NoDMeG8lJIzfVVsvAJXwP7ih
         WmukqgHVvKSM5vIBPJuGZiKBlgdif8C4A4Vvum0Gu2mYPAaXLRYTfRbtXnfXwbzjN10G
         7yVq38nV3eXpZK+z7SaF/9c5to2NvTbStjE1Mp5Ww3mTXcSJhwhdVAMmSkMakeQAqatM
         HB9ks16z4bZNoAlG9My3FvB+x8O4oPEgcElzYJ/5lQmhybU4Ge/Bj9BkabeSY824VCbV
         JJYQ==
X-Gm-Message-State: AA+aEWYIAeKn3Y+oXeaXnezBJkEvUesKx/TSwf3BSqQKKyCh0r+DlpP6
        Pk9hSKMvOd4z4DvnaXFMATOqLg==
X-Google-Smtp-Source: AFSGD/UbGXgwgZF08N/6enFLwjZA+acQG4sQYNb3p2qKJTGwXMc38AIY3ZHX7iF/uRbLfg0vCv0EIg==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63-v6mr882510plb.241.1542694768993;
        Mon, 19 Nov 2018 22:19:28 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id g2sm718142pfi.95.2018.11.19.22.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 22:19:27 -0800 (PST)
Date:   Tue, 20 Nov 2018 11:49:25 +0530
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
Subject: Re: [PATCH v9 15/15] OPTIONAL: cpufreq: dt: Register an Energy Model
Message-ID: <20181120061925.t6j5jjepziq2gcsh@vireshk-i7>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-16-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119141857.8625-16-quentin.perret@arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-11-18, 14:18, Quentin Perret wrote:
>  static int cpufreq_init(struct cpufreq_policy *policy)
>  {
> +	struct em_data_callback em_cb = EM_DATA_CB(of_est_power);
>  	struct cpufreq_frequency_table *freq_table;
>  	struct opp_table *opp_table = NULL;
>  	struct private_data *priv;
> @@ -160,7 +203,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	unsigned int transition_latency;
>  	bool fallback = false;
>  	const char *name;
> -	int ret;
> +	int ret, nr_opp;
>  
>  	cpu_dev = get_cpu_device(policy->cpu);
>  	if (!cpu_dev) {
> @@ -237,6 +280,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  		ret = -EPROBE_DEFER;
>  		goto out_free_opp;
>  	}
> +	nr_opp = ret;
>  
>  	if (fallback) {
>  		cpumask_setall(policy->cpus);
> @@ -280,6 +324,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>  	policy->cpuinfo.transition_latency = transition_latency;
>  	policy->dvfs_possible_from_any_cpu = true;
>  
> +	em_register_perf_domain(policy->cpus, nr_opp, &em_cb);
> +
>  	return 0;
>  
>  out_free_cpufreq_table:

I haven't gone deep into the series, but why don't we need something
like em_unregister_perf_domain()? That can be used if the cpufreq
driver goes away. Else loading/unloading/loading the cpufreq driver
may register the perf-domain callback again.

-- 
viresh
