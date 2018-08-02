Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FFDC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B507D2154B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 12:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYBPj+MD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B507D2154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbeHBOkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 10:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732267AbeHBOkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 10:40:16 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7899D21531;
        Thu,  2 Aug 2018 12:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533214152;
        bh=C4lgpSMMTl4O8EZfVAKzvmU8YfZ7tA1mEGSlA683HDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dYBPj+MDzL+BSkRdknkApl59+vbnsSphZAvWkUknEIrLDAJdWJIS4+3/i9FF3YQl1
         rQPMLm/W2e43OoKphyNKguzAgqOYksQbqDUG+0pJzjNEfF/w4K65bG/WcVcS7HiSPT
         OPM9vJv5lXeIGlScUPKDP0E+m7d5GltCqPtSjtKU=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id E80AF140A1C; Thu,  2 Aug 2018 09:49:09 -0300 (-03)
Date:   Thu, 2 Aug 2018 09:49:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH 1/3] perf auxtrace: Support for perf report -D for s390
Message-ID: <20180802124909.GB7996@kernel.org>
References: <20180802074622.13641-1-tmricht@linux.ibm.com>
 <20180802074622.13641-2-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802074622.13641-2-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 02, 2018 at 09:46:20AM +0200, Thomas Richter escreveu:
> Add initial support for s390 auxiliary traces using the
> CPU-Measurement Sampling Facility.

Could you please provide one or two paragraphs explaining what is this
"CPU-Measurement Sampling Facility", in which hardware this is available
(all s/390 hardware has it? Just the 64-bit model(s)?) and provide a
public URL for people interested in further reading?

- Arnaldo
 
> Support and ignore PERF_REPORT_AUXTRACE_INFO records
> in the perf data file. Later patches will show the contents
> of the auxiliary traces.
> 
> Setup the auxtrace queues and data structures for s390.
> A raw dump of the perf.data file now does not show
> an error when an auxtrace event is encountered.
> 
> Output before:
> [root@s35lp76 perf]# ./perf report -D -i perf.data.auxtrace
> 0x128 [0x10]: failed to process type: 70
> Error:
> failed to process sample
> 
> 0x128 [0x10]: event: 70
> .
> . ... raw event: size 16 bytes
> .  0000:  00 00 00 46 00 00 00 10 00 00 00 00 00 00 00 00  ...F............
> 
> 0x128 [0x10]: PERF_RECORD_AUXTRACE_INFO type: 0
> [root@s35lp76 perf]#
> 
> Output after:
>  # ./perf report -D -i perf.data.auxtrace |fgrep PERF_RECORD_AUXTRACE
> 0 0 0x128 [0x10]: PERF_RECORD_AUXTRACE_INFO type: 5
> 0 0 0x25a66 [0x30]: PERF_RECORD_AUXTRACE size: 0x40000
> 	 offset: 0  ref: 0  idx: 4  tid: -1  cpu: 4
> ....
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
> ---
>  tools/perf/arch/s390/util/auxtrace.c |   1 +
>  tools/perf/util/Build                |   1 +
>  tools/perf/util/auxtrace.c           |   3 +
>  tools/perf/util/auxtrace.h           |   1 +
>  tools/perf/util/s390-cpumsf.c        | 123 +++++++++++++++++++++++++++
>  tools/perf/util/s390-cpumsf.h        |  21 +++++
>  6 files changed, 150 insertions(+)
>  create mode 100644 tools/perf/util/s390-cpumsf.c
>  create mode 100644 tools/perf/util/s390-cpumsf.h
> 
> diff --git a/tools/perf/arch/s390/util/auxtrace.c b/tools/perf/arch/s390/util/auxtrace.c
> index 3afe8256eff2..44c857388897 100644
> --- a/tools/perf/arch/s390/util/auxtrace.c
> +++ b/tools/perf/arch/s390/util/auxtrace.c
> @@ -30,6 +30,7 @@ cpumsf_info_fill(struct auxtrace_record *itr __maybe_unused,
>  		 struct auxtrace_info_event *auxtrace_info __maybe_unused,
>  		 size_t priv_size __maybe_unused)
>  {
> +	auxtrace_info->type = PERF_AUXTRACE_S390_CPUMSF;
>  	return 0;
>  }
>  
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index b604ef334dc9..7efe15b9618d 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -87,6 +87,7 @@ libperf-$(CONFIG_AUXTRACE) += intel-pt.o
>  libperf-$(CONFIG_AUXTRACE) += intel-bts.o
>  libperf-$(CONFIG_AUXTRACE) += arm-spe.o
>  libperf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o
> +libperf-$(CONFIG_AUXTRACE) += s390-cpumsf.o
>  
>  ifdef CONFIG_LIBOPENCSD
>  libperf-$(CONFIG_AUXTRACE) += cs-etm.o
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index d056447520a2..ae8c37b219c9 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -56,6 +56,7 @@
>  #include "intel-pt.h"
>  #include "intel-bts.h"
>  #include "arm-spe.h"
> +#include "s390-cpumsf.h"
>  
>  #include "sane_ctype.h"
>  #include "symbol/kallsyms.h"
> @@ -920,6 +921,8 @@ int perf_event__process_auxtrace_info(struct perf_tool *tool __maybe_unused,
>  		return arm_spe_process_auxtrace_info(event, session);
>  	case PERF_AUXTRACE_CS_ETM:
>  		return cs_etm__process_auxtrace_info(event, session);
> +	case PERF_AUXTRACE_S390_CPUMSF:
> +		return s390_cpumsf_process_auxtrace_info(event, session);
>  	case PERF_AUXTRACE_UNKNOWN:
>  	default:
>  		return -EINVAL;
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index e731f55da072..71fc3bd74299 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -44,6 +44,7 @@ enum auxtrace_type {
>  	PERF_AUXTRACE_INTEL_BTS,
>  	PERF_AUXTRACE_CS_ETM,
>  	PERF_AUXTRACE_ARM_SPE,
> +	PERF_AUXTRACE_S390_CPUMSF,
>  };
>  
>  enum itrace_period_type {
> diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
> new file mode 100644
> index 000000000000..e9a5ea21dbbf
> --- /dev/null
> +++ b/tools/perf/util/s390-cpumsf.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright IBM Corp. 2018
> + * Auxtrace support for s390 CPU-Measurement Sampling Facility
> + *
> + * Author(s):  Thomas Richter <tmricht@linux.ibm.com>
> + */
> +
> +#include <endian.h>
> +#include <errno.h>
> +#include <byteswap.h>
> +#include <inttypes.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/bitops.h>
> +#include <linux/log2.h>
> +
> +#include "cpumap.h"
> +#include "color.h"
> +#include "evsel.h"
> +#include "evlist.h"
> +#include "machine.h"
> +#include "session.h"
> +#include "util.h"
> +#include "thread.h"
> +#include "debug.h"
> +#include "auxtrace.h"
> +#include "s390-cpumsf.h"
> +
> +struct s390_cpumsf {
> +	struct auxtrace		auxtrace;
> +	struct auxtrace_queues	queues;
> +	struct auxtrace_heap	heap;
> +	struct perf_session	*session;
> +	struct machine		*machine;
> +	u32			auxtrace_type;
> +	u32			pmu_type;
> +};
> +
> +static int
> +s390_cpumsf_process_event(struct perf_session *session __maybe_unused,
> +			  union perf_event *event __maybe_unused,
> +			  struct perf_sample *sample __maybe_unused,
> +			  struct perf_tool *tool __maybe_unused)
> +{
> +	return 0;
> +}
> +
> +static int
> +s390_cpumsf_process_auxtrace_event(struct perf_session *session __maybe_unused,
> +				   union perf_event *event __maybe_unused,
> +				   struct perf_tool *tool __maybe_unused)
> +{
> +	return 0;
> +}
> +
> +static int s390_cpumsf_flush(struct perf_session *session __maybe_unused,
> +			     struct perf_tool *tool __maybe_unused)
> +{
> +	return 0;
> +}
> +
> +static void s390_cpumsf_free_events(struct perf_session *session)
> +{
> +	struct s390_cpumsf *sf = container_of(session->auxtrace,
> +					      struct s390_cpumsf,
> +					       auxtrace);
> +	struct auxtrace_queues *queues = &sf->queues;
> +	unsigned int i;
> +
> +	for (i = 0; i < queues->nr_queues; i++)
> +		zfree(&queues->queue_array[i].priv);
> +	auxtrace_queues__free(queues);
> +}
> +
> +static void s390_cpumsf_free(struct perf_session *session)
> +{
> +	struct s390_cpumsf *sf = container_of(session->auxtrace,
> +					      struct s390_cpumsf,
> +					      auxtrace);
> +
> +	auxtrace_heap__free(&sf->heap);
> +	s390_cpumsf_free_events(session);
> +	session->auxtrace = NULL;
> +	free(sf);
> +}
> +
> +int s390_cpumsf_process_auxtrace_info(union perf_event *event,
> +				      struct perf_session *session)
> +{
> +	struct auxtrace_info_event *auxtrace_info = &event->auxtrace_info;
> +	struct s390_cpumsf *sf;
> +	int err;
> +
> +	if (auxtrace_info->header.size < sizeof(struct auxtrace_info_event))
> +		return -EINVAL;
> +
> +	sf = zalloc(sizeof(struct s390_cpumsf));
> +	if (sf == NULL)
> +		return -ENOMEM;
> +
> +	err = auxtrace_queues__init(&sf->queues);
> +	if (err)
> +		goto err_free;
> +
> +	sf->session = session;
> +	sf->machine = &session->machines.host; /* No kvm support */
> +	sf->auxtrace_type = auxtrace_info->type;
> +	sf->pmu_type = PERF_TYPE_RAW;
> +
> +	sf->auxtrace.process_event = s390_cpumsf_process_event;
> +	sf->auxtrace.process_auxtrace_event = s390_cpumsf_process_auxtrace_event;
> +	sf->auxtrace.flush_events = s390_cpumsf_flush;
> +	sf->auxtrace.free_events = s390_cpumsf_free_events;
> +	sf->auxtrace.free = s390_cpumsf_free;
> +	session->auxtrace = &sf->auxtrace;
> +
> +	return 0;
> +
> +err_free:
> +	free(sf);
> +	return err;
> +}
> diff --git a/tools/perf/util/s390-cpumsf.h b/tools/perf/util/s390-cpumsf.h
> new file mode 100644
> index 000000000000..fb64d100555c
> --- /dev/null
> +++ b/tools/perf/util/s390-cpumsf.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright IBM Corp. 2018
> + * Auxtrace support for s390 CPU-Measurement Sampling Facility
> + *
> + * Author(s):  Thomas Richter <tmricht@linux.ibm.com>
> + */
> +
> +#ifndef INCLUDE__PERF_S390_CPUMSF_H
> +#define INCLUDE__PERF_S390_CPUMSF_H
> +
> +union perf_event;
> +struct perf_session;
> +struct perf_pmu;
> +
> +struct auxtrace_record *
> +s390_cpumsf_recording_init(int *err, struct perf_pmu *s390_cpumsf_pmu);
> +
> +int s390_cpumsf_process_auxtrace_info(union perf_event *event,
> +				      struct perf_session *session);
> +#endif
> -- 
> 2.17.0
