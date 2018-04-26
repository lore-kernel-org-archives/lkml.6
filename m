Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756823AbeDZWG3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:06:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59254 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754841AbeDZWG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:06:28 -0400
Date: Thu, 26 Apr 2018 17:06:24 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <Will.Deacon@arm.com>,
        <mark.rutland@arm.com>, <jnair@caviumnetworks.com>,
        <Robert.Richter@cavium.com>, <Vadim.Lomovtsev@cavium.com>,
        <Jan.Glauber@cavium.com>, <gklkml16@gmail.com>
Subject: Re: [PATCH v4 2/2] ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU
 driver
Message-Id: <20180426170624.bfcba885431d57d0de2a3ddd@arm.com>
In-Reply-To: <20180425090047.6485-3-ganapatrao.kulkarni@cavium.com>
References: <20180425090047.6485-1-ganapatrao.kulkarni@cavium.com>
        <20180425090047.6485-3-ganapatrao.kulkarni@cavium.com>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018 14:30:47 +0530
Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com> wrote:

> +static int thunderx2_uncore_event_init(struct perf_event *event)
...
> +	/*
> +	 * SOC PMU counters are shared across all cores.
> +	 * Therefore, it does not support per-process mode.
> +	 * Also, it does not support event sampling mode.
> +	 */
> +	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
> +		return -EINVAL;
> +
> +	/* SOC counters do not have usr/os/guest/host bits */
> +	if (event->attr.exclude_user || event->attr.exclude_kernel ||
> +	    event->attr.exclude_host || event->attr.exclude_guest)
> +		return -EINVAL;
> +
> +	if (event->cpu < 0)
> +		return -EINVAL;
> +
> +	pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
> +
> +	if (!pmu_uncore)
> +		return -ENODEV;
> +
> +	/* Pick first online cpu from the node */
> +	event->cpu = cpumask_first(
> +			cpumask_of_node(pmu_uncore->uncore_dev->node));
> +
> +	if (event->cpu >= nr_cpu_ids)
> +		return -EINVAL;
> +
> +	if (event->attr.config >= pmu_uncore->uncore_dev->max_events)
> +		return -EINVAL;
> +
> +	/* store event id */
> +	hwc->config = event->attr.config;
> +
> +	/* Validate the group */
> +	if (!thunderx2_uncore_validate_event_group(event))
> +		return -EINVAL;

This PMU driver can be made more user-friendly by not just silently
returning an error code such as -EINVAL, but by emitting a useful
message describing the specific error via dmesg.

Thanks,

Kim
