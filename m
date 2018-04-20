Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754881AbeDTNEp convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:04:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:53581 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754866AbeDTNEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:04:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,301,1520924400";
   d="scan'208";a="35135449"
From: "Liang, Kan" <kan.liang@intel.com>
To: "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "acme@kernel.org" <acme@kernel.org>,
        "eranian@google.com" <eranian@google.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>
Subject: RE: [PATCH V7 6/8] perf/x86/intel/uncore: Support IIO free running
 counters on SKX
Thread-Topic: [PATCH V7 6/8] perf/x86/intel/uncore: Support IIO free running
 counters on SKX
Thread-Index: AQHTwEesHZIBLoGfOkOHcNsI+JYRJqQJzugw
Date: Fri, 20 Apr 2018 13:04:38 +0000
Message-ID: <37D7C6CF3E00A74B8858931C1DB2F07753898B6F@SHSMSX103.ccr.corp.intel.com>
References: <1521549165-6216-1-git-send-email-kan.liang@intel.com>
 <1521549165-6216-6-git-send-email-kan.liang@intel.com>
In-Reply-To: <1521549165-6216-6-git-send-email-kan.liang@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOWFkMGI0MDItYzA5ZS00OWIyLTg4YzktN2U3YzQxNzU5OTI4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX0lDIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6InlDRm9XM01HeDhyUk40Q1k2RVJ2eXlQTTJyUVJOb2pxZkNpcUQ0RkJPOVU9In0=
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

> 
> From: Kan Liang <kan.liang@intel.com>
> 
> As of Skylake Server, there are a number of free-running counters in
> each IIO Box that collect counts for per box IO clocks and per Port
> Input/Output x BW/Utilization.
> Add a new PMU for these free-running counters. Don't let them share with
> the GP counters of IIO box. Otherwise, it will result in some (probably)
> unexpected scheduling artifacts.
> 
> The free running counter is read-only and always active. Counting will
> be suspended only when the IIO Box is powered down.
> 
> There are three types of IIO free running counters on Skylake server, IO
> CLOCKS counter, BANDWIDTH counters and UTILIZATION counters.
> IO CLOCKS counter is to count IO clocks.
> BANDWIDTH counters are to count inbound(PCIe->CPU)/outbound(CPU-
> >PCIe)
> bandwidth.
> UTILIZATION counters are to count input/output utilization.
> 
> The bit width of the free running counters is 36-bits.
> 
> Signed-off-by: Kan Liang <kan.liang@intel.com>
> ---
> 
> Changes since V6:
>  - Add a new PMU for IIO free-running counters.
> 

Hi Peter,

Could you please review the patch?
If it's OK for you, could you please merge the patch set?

Thanks,
Kan

>  arch/x86/events/intel/uncore_snbep.c | 82
> ++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/arch/x86/events/intel/uncore_snbep.c
> b/arch/x86/events/intel/uncore_snbep.c
> index 22ec65b..d6b302e 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -3484,6 +3484,87 @@ static struct intel_uncore_type skx_uncore_iio = {
>  	.format_group		= &skx_uncore_iio_format_group,
>  };
> 
> +enum perf_uncore_iio_freerunning_type_id {
> +	SKX_IIO_MSR_IOCLK			= 0,
> +	SKX_IIO_MSR_BW				= 1,
> +	SKX_IIO_MSR_UTIL			= 2,
> +
> +	SKX_IIO_FREERUNNING_TYPE_MAX,
> +};
> +
> +
> +static struct freerunning_counters skx_iio_freerunning[] = {
> +	[SKX_IIO_MSR_IOCLK]	= { 0xa45, 0x1, 0x20, 1, 36 },
> +	[SKX_IIO_MSR_BW]	= { 0xb00, 0x1, 0x10, 8, 36 },
> +	[SKX_IIO_MSR_UTIL]	= { 0xb08, 0x1, 0x10, 8, 36 },
> +};
> +
> +static struct uncore_event_desc skx_uncore_iio_freerunning_events[] = {
> +	/* Free-Running IO CLOCKS Counter */
> +	INTEL_UNCORE_EVENT_DESC(ioclk,
> 	"event=0xff,umask=0x10"),
> +	/* Free-Running IIO BANDWIDTH Counters */
> +	INTEL_UNCORE_EVENT_DESC(bw_in_port0,
> 	"event=0xff,umask=0x20"),
> +	INTEL_UNCORE_EVENT_DESC(bw_in_port0.scale,
> 	"3.814697266e-6"),
> +	INTEL_UNCORE_EVENT_DESC(bw_in_port0.unit,	"MiB"),
> +	INTEL_UNCORE_EVENT_DESC(bw_in_port1,
> 	"event=0xff,umask=0x21"),
> +	INTEL_UNCORE_EVENT_DESC(bw_in_port1.scale,
> 	"3.814697266e-6"),
> +	INTEL_UNCORE_EVENT_DESC(bw_in_port1.unit,	"MiB"),
> +	INTEL_UNCORE_EVENT_DESC(bw_in_port2,
> 	"event=0xff,umask=0x22"),
> +	INTEL_UNCORE_EVENT_DESC(bw_in_port2.scale,
> 	"3.814697266e-6"),
> +	INTEL_UNCORE_EVENT_DESC(bw_in_port2.unit,	"MiB"),
> +	INTEL_UNCORE_EVENT_DESC(bw_in_port3,
> 	"event=0xff,umask=0x23"),
> +	INTEL_UNCORE_EVENT_DESC(bw_in_port3.scale,
> 	"3.814697266e-6"),
> +	INTEL_UNCORE_EVENT_DESC(bw_in_port3.unit,	"MiB"),
> +	INTEL_UNCORE_EVENT_DESC(bw_out_port0,
> 	"event=0xff,umask=0x24"),
> +	INTEL_UNCORE_EVENT_DESC(bw_out_port0.scale,
> 	"3.814697266e-6"),
> +	INTEL_UNCORE_EVENT_DESC(bw_out_port0.unit,	"MiB"),
> +	INTEL_UNCORE_EVENT_DESC(bw_out_port1,
> 	"event=0xff,umask=0x25"),
> +	INTEL_UNCORE_EVENT_DESC(bw_out_port1.scale,
> 	"3.814697266e-6"),
> +	INTEL_UNCORE_EVENT_DESC(bw_out_port1.unit,	"MiB"),
> +	INTEL_UNCORE_EVENT_DESC(bw_out_port2,
> 	"event=0xff,umask=0x26"),
> +	INTEL_UNCORE_EVENT_DESC(bw_out_port2.scale,
> 	"3.814697266e-6"),
> +	INTEL_UNCORE_EVENT_DESC(bw_out_port2.unit,	"MiB"),
> +	INTEL_UNCORE_EVENT_DESC(bw_out_port3,
> 	"event=0xff,umask=0x27"),
> +	INTEL_UNCORE_EVENT_DESC(bw_out_port3.scale,
> 	"3.814697266e-6"),
> +	INTEL_UNCORE_EVENT_DESC(bw_out_port3.unit,	"MiB"),
> +	/* Free-running IIO UTILIZATION Counters */
> +	INTEL_UNCORE_EVENT_DESC(util_in_port0,
> 	"event=0xff,umask=0x30"),
> +	INTEL_UNCORE_EVENT_DESC(util_out_port0,
> 	"event=0xff,umask=0x31"),
> +	INTEL_UNCORE_EVENT_DESC(util_in_port1,
> 	"event=0xff,umask=0x32"),
> +	INTEL_UNCORE_EVENT_DESC(util_out_port1,
> 	"event=0xff,umask=0x33"),
> +	INTEL_UNCORE_EVENT_DESC(util_in_port2,
> 	"event=0xff,umask=0x34"),
> +	INTEL_UNCORE_EVENT_DESC(util_out_port2,
> 	"event=0xff,umask=0x35"),
> +	INTEL_UNCORE_EVENT_DESC(util_in_port3,
> 	"event=0xff,umask=0x36"),
> +	INTEL_UNCORE_EVENT_DESC(util_out_port3,
> 	"event=0xff,umask=0x37"),
> +	{ /* end: all zeroes */ },
> +};
> +
> +static struct intel_uncore_ops skx_uncore_iio_freerunning_ops = {
> +	.read_counter		= uncore_msr_read_counter,
> +};
> +
> +static struct attribute *skx_uncore_iio_freerunning_formats_attr[] = {
> +	&format_attr_event.attr,
> +	&format_attr_umask.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group
> skx_uncore_iio_freerunning_format_group = {
> +	.name = "format",
> +	.attrs = skx_uncore_iio_freerunning_formats_attr,
> +};
> +
> +static struct intel_uncore_type skx_uncore_iio_free_running = {
> +	.name			= "iio_free_running",
> +	.num_counters		= 17,
> +	.num_boxes		= 6,
> +	.num_freerunning_types	= SKX_IIO_FREERUNNING_TYPE_MAX,
> +	.freerunning		= skx_iio_freerunning,
> +	.ops			= &skx_uncore_iio_freerunning_ops,
> +	.event_descs		= skx_uncore_iio_freerunning_events,
> +	.format_group		=
> &skx_uncore_iio_freerunning_format_group,
> +};
> +
>  static struct attribute *skx_uncore_formats_attr[] = {
>  	&format_attr_event.attr,
>  	&format_attr_umask.attr,
> @@ -3557,6 +3638,7 @@ static struct intel_uncore_type *skx_msr_uncores[]
> = {
>  	&skx_uncore_ubox,
>  	&skx_uncore_chabox,
>  	&skx_uncore_iio,
> +	&skx_uncore_iio_free_running,
>  	&skx_uncore_irp,
>  	&skx_uncore_pcu,
>  	NULL,
> --
> 2.7.4
