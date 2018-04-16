Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752916AbeDPObQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:31:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbeDPObO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:31:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1A621789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 16 Apr 2018 11:31:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] perf list: Add s390 support for detailed/verbose pmu
 event description
Message-ID: <20180416143111.GB18171@kernel.org>
References: <20180416132314.33249-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416132314.33249-1-tmricht@linux.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 16, 2018 at 03:23:14PM +0200, Thomas Richter escreveu:
> From: Thomas Richter <tmricht@linux.vnet.ibm.com>
> 
> Perf list with flags -d and -v print a description (-d) or
> a very verbose explanation (-v) of CPU specific counter events.
> These descriptions are provided with the json files in
> directory pmu-events/arch/s390/*.json.

Wasn't this a patch being reviewed by Mark?

- Arnaldo
 
> Display of these descriptions on s390 requires the
> corresponding json files.
> 
> On s390 this does not work because function is_pmu_core()
> does not detect the s390 directory name where the
> CPU specific events are listed. On x86 it is
>   /sys/bus/event_source/devices/cpu
> whereas on s390 it is
>   /sys/bus/event_source/devices/cpum_cf
>   /sys/bus/event_source/devices/cpum_sf
> 
> Fix this by adding s390 directory name testing to
> function is_pmu_core(). This is the same approach as taken for
> arm platform.
> 
> Output before:
> [root@s35lp76 perf]# ./perf list -d pmu
> List of pre-defined events (to be used in -e):
> 
>   cpum_cf/AES_BLOCKED_CYCLES/      [Kernel PMU event]
>   cpum_cf/AES_BLOCKED_FUNCTIONS/   [Kernel PMU event]
>   cpum_cf/AES_CYCLES/              [Kernel PMU event]
>   cpum_cf/AES_FUNCTIONS/           [Kernel PMU event]
>   ....
>   cpum_cf/TX_NC_TEND/              [Kernel PMU event]
>   cpum_cf/VX_BCD_EXECUTION_SLOTS/  [Kernel PMU event]
>   cpum_sf/SF_CYCLES_BASIC/         [Kernel PMU event]
> 
> Output after:
> [root@s35lp76 perf]# ./perf list -d pmu
> List of pre-defined events (to be used in -e):
> 
>   cpum_cf/AES_BLOCKED_CYCLES/      [Kernel PMU event]
>   cpum_cf/AES_BLOCKED_FUNCTIONS/   [Kernel PMU event]
>   cpum_cf/AES_CYCLES/              [Kernel PMU event]
>   cpum_cf/AES_FUNCTIONS/           [Kernel PMU event]
>   ....
>   cpum_cf/TX_NC_TEND/              [Kernel PMU event]
>   cpum_cf/VX_BCD_EXECUTION_SLOTS/  [Kernel PMU event]
>   cpum_sf/SF_CYCLES_BASIC/         [Kernel PMU event]
> 
> 3906:
>   bcd_dfp_execution_slots
>        [BCD DFP Execution Slots]
>   decimal_instructions
>        [Decimal Instructions]
>   dtlb2_gpage_writes
>        [DTLB2 GPAGE Writes]
>   dtlb2_hpage_writes
>        [DTLB2 HPAGE Writes]
>   dtlb2_misses
>        [DTLB2 Misses]
>   dtlb2_writes
>        [DTLB2 Writes]
>   itlb2_misses
>        [ITLB2 Misses]
>   itlb2_writes
>        [ITLB2 Writes]
>   l1c_tlb2_misses
>        [L1C TLB2 Misses]
>   .....
> 
> cfvn 3:
>   cpu_cycles
>        [CPU Cycles]
>   instructions
>        [Instructions]
>   l1d_dir_writes
>        [L1D Directory Writes]
>   l1d_penalty_cycles
>        [L1D Penalty Cycles]
>   l1i_dir_writes
>        [L1I Directory Writes]
>   l1i_penalty_cycles
>        [L1I Penalty Cycles]
>   problem_state_cpu_cycles
>        [Problem State CPU Cycles]
>   problem_state_instructions
>        [Problem State Instructions]
>   ....
> 
> csvn generic:
>   aes_blocked_cycles
>        [AES Blocked Cycles]
>   aes_blocked_functions
>        [AES Blocked Functions]
>   aes_cycles
>        [AES Cycles]
>   aes_functions
>        [AES Functions]
>   dea_blocked_cycles
>        [DEA Blocked Cycles]
>   dea_blocked_functions
>        [DEA Blocked Functions]
>   ....
> 
> Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> ---
>  tools/perf/util/pmu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 1111d5bf15ca..8675ddf558c6 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -562,6 +562,12 @@ static int is_pmu_core(const char *name)
>  	if (stat(path, &st) == 0)
>  		return 1;
>  
> +	/* Look for cpu sysfs (specific to s390) */
> +	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s",
> +		  sysfs, name);
> +	if (stat(path, &st) == 0 && !strncmp(name, "cpum_", 5))
> +		return 1;
> +
>  	return 0;
>  }
>  
> -- 
> 2.14.3
