Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A4AE160877
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753620AbeFFQrl (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:47:41 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35174 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbeFFQrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:47:40 -0400
X-Google-Smtp-Source: ADUXVKKCzdW5FaNasumhDhiXVIrYhDut2vcde1oVIdR/NgSlN9l6hHvYuJt7re/1CZyyY1yGZkObZw==
Date: Wed, 6 Jun 2018 18:47:34 +0200
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
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Message-ID: <20180606164734.GC15894@localhost.localdomain>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521142505.6522-4-quentin.perret@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On 21/05/18 15:24, Quentin Perret wrote:

[...]

> +#ifdef CONFIG_ENERGY_MODEL

[...]

> +struct em_data_callback {
> +	/**
> +	 * active_power() - Provide power at the next capacity state of a CPU
> +	 * @power	: Active power at the capacity state (modified)
> +	 * @freq	: Frequency at the capacity state (modified)
> +	 * @cpu		: CPU for which we do this operation
> +	 *
> +	 * active_power() must find the lowest capacity state of 'cpu' above
> +	 * 'freq' and update 'power' and 'freq' to the matching active power
> +	 * and frequency.
> +	 *
> +	 * Return 0 on success.
> +	 */
> +	int (*active_power) (unsigned long *power, unsigned long *freq, int cpu);
> +};

[...]

> +#else
> +struct em_freq_domain;
> +struct em_data_callback;

This doesn't compile for CONFIG_ENERGY_MODEL=n:

drivers/cpufreq/cpufreq-dt.c:164:9: error: variable 'em_cb' has initializer but incomplete type                                                          
  struct em_data_callback em_cb = { &dev_pm_opp_of_estimate_power };                       
           ^~~~~~~~~~~~~~~~

Guess you need some sort of macro to init the struct (w/o introducing
ifdeffery into drivers code)?

Best,

- Juri
