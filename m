Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbeC2Pna (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 11:43:30 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55998 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751256AbeC2Pn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 11:43:28 -0400
Date: Thu, 29 Mar 2018 16:43:24 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] perf/core: store context switch out type into
 Perf trace
Message-ID: <20180329154323.mxi3iaaqimtozjoj@lakrids.cambridge.arm.com>
References: <6f4a5d0d-9e1f-d5a1-7719-7547bb688453@linux.intel.com>
 <f8d6833d-2ba3-e7cb-5422-adffb24dd33e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8d6833d-2ba3-e7cb-5422-adffb24dd33e@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 29, 2018 at 06:02:48PM +0300, Alexey Budankov wrote:
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 912b85b52344..cd6ad7e13824 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -655,6 +655,10 @@ struct perf_event_mmap_page {
>   * perf_event_attr::precise_ip.
>   */
>  #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
> +/*
> + * Indicates that thread was preempted in TASK_RUNNING state
> + */
> +#define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT	(1 << 14)
>  /*
>   * Reserve the last bit to indicate some extended misc field
>   */

Could you please add a description (in the header) describing why it's safe to
reuse this bit? i.e. describe which events these are valid for, so it's clear
they don't overlap.

For bit 13 we have:

/*
 * Following PERF_RECORD_MISC_* are used on different
 * events, so can reuse the same bit position:
 *
 *   PERF_RECORD_MISC_MMAP_DATA  - PERF_RECORD_MMAP* events
 *   PERF_RECORD_MISC_COMM_EXEC  - PERF_RECORD_COMM event
 *   PERF_RECORD_MISC_SWITCH_OUT - PERF_RECORD_SWITCH* events
 */
#define PERF_RECORD_MISC_MMAP_DATA              (1 << 13)
#define PERF_RECORD_MISC_COMM_EXEC              (1 << 13)
#define PERF_RECORD_MISC_SWITCH_OUT             (1 << 13)

Thanks,
Mark.
