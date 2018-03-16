Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753400AbeCPQs0 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 12:48:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:11000 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751623AbeCPQsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 12:48:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,316,1517904000";
   d="scan'208";a="35628619"
From: "Liang, Kan" <kan.liang@intel.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "acme@kernel.org" <acme@kernel.org>,
        "eranian@google.com" <eranian@google.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>
Subject: RE: [PATCH V6 1/8] perf/x86/intel/uncore: customized event_read for
 client IMC uncore
Thread-Topic: [PATCH V6 1/8] perf/x86/intel/uncore: customized event_read
 for client IMC uncore
Thread-Index: AQHTlhkaoCoTgM88UUO7Y8nj83N3G6PTYERw
Date: Fri, 16 Mar 2018 16:48:16 +0000
Message-ID: <37D7C6CF3E00A74B8858931C1DB2F07753854C10@SHSMSX103.ccr.corp.intel.com>
References: <1516911228-5293-1-git-send-email-kan.liang@intel.com>
In-Reply-To: <1516911228-5293-1-git-send-email-kan.liang@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTE3NWM1YzItM2Q1Ni00NzI2LTg1ODMtNjE3Mzc0ZDk0ZjE0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX0lDIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6InhWVDcwMDliOXlOZVlRXC9HRVFcL2d5SGd2bEZqRjlpNFdRYVVvcmpwWWFHaz0ifQ==
x-ctpclassification: CTP_IC
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Any comments for the patch set?

Thanks,
Kan
> 
> From: Kan Liang <Kan.liang@intel.com>
> 
> There are two free running counters for client IMC uncore. The custom
> event_init() function hardcode their index to 'UNCORE_PMC_IDX_FIXED' and
> 'UNCORE_PMC_IDX_FIXED + 1'. To support the 'UNCORE_PMC_IDX_FIXED +
> 1'
> case, the generic uncore_perf_event_update is obscurely hacked.
> The code quality issue will bring problem when new counter index is
> introduced into generic code. For example, free running counter index.
> 
> Introduce customized event_read function for client IMC uncore.
> The customized function is exactly copied from previous generic
> uncore_pmu_event_read.
> The 'UNCORE_PMC_IDX_FIXED + 1' case will be isolated for client IMC uncore
> only.
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Kan Liang <Kan.liang@intel.com>
> ---
> 
> Change since V5:
>  - Add reviewed-by
> 
>  arch/x86/events/intel/uncore_snb.c | 33
> +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/uncore_snb.c
> b/arch/x86/events/intel/uncore_snb.c
> index aee5e84..df53521 100644
> --- a/arch/x86/events/intel/uncore_snb.c
> +++ b/arch/x86/events/intel/uncore_snb.c
> @@ -450,6 +450,35 @@ static void snb_uncore_imc_event_start(struct
> perf_event *event, int flags)
>  		uncore_pmu_start_hrtimer(box);
>  }
> 
> +static void snb_uncore_imc_event_read(struct perf_event *event) {
> +	struct intel_uncore_box *box = uncore_event_to_box(event);
> +	u64 prev_count, new_count, delta;
> +	int shift;
> +
> +	/*
> +	 * There are two free running counters in IMC.
> +	 * The index for the second one is hardcoded to
> +	 * UNCORE_PMC_IDX_FIXED + 1.
> +	 */
> +	if (event->hw.idx >= UNCORE_PMC_IDX_FIXED)
> +		shift = 64 - uncore_fixed_ctr_bits(box);
> +	else
> +		shift = 64 - uncore_perf_ctr_bits(box);
> +
> +	/* the hrtimer might modify the previous event value */
> +again:
> +	prev_count = local64_read(&event->hw.prev_count);
> +	new_count = uncore_read_counter(box, event);
> +	if (local64_xchg(&event->hw.prev_count, new_count) != prev_count)
> +		goto again;
> +
> +	delta = (new_count << shift) - (prev_count << shift);
> +	delta >>= shift;
> +
> +	local64_add(delta, &event->count);
> +}
> +
>  static void snb_uncore_imc_event_stop(struct perf_event *event, int flags)  {
>  	struct intel_uncore_box *box = uncore_event_to_box(event); @@ -
> 472,7 +501,7 @@ static void snb_uncore_imc_event_stop(struct perf_event
> *event, int flags)
>  		 * Drain the remaining delta count out of a event
>  		 * that we are disabling:
>  		 */
> -		uncore_perf_event_update(box, event);
> +		snb_uncore_imc_event_read(event);
>  		hwc->state |= PERF_HES_UPTODATE;
>  	}
>  }
> @@ -534,7 +563,7 @@ static struct pmu snb_uncore_imc_pmu = {
>  	.del		= snb_uncore_imc_event_del,
>  	.start		= snb_uncore_imc_event_start,
>  	.stop		= snb_uncore_imc_event_stop,
> -	.read		= uncore_pmu_event_read,
> +	.read		= snb_uncore_imc_event_read,
>  };
> 
>  static struct intel_uncore_ops snb_uncore_imc_ops = {
> --
> 2.7.4
