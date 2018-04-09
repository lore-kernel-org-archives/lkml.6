Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeDILhj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:37:39 -0400
Received: from foss.arm.com ([217.140.101.70]:55102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750759AbeDILhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:37:37 -0400
Date: Mon, 9 Apr 2018 12:37:33 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf list: Add s390 support for detailed/verbose pmu
 event description
Message-ID: <20180409113732.6k3plpp6pqdcbzrh@lakrids.cambridge.arm.com>
References: <20180409110015.20793-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409110015.20793-1-tmricht@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 09, 2018 at 01:00:15PM +0200, Thomas Richter wrote:
> From: Thomas Richter <tmricht@linux.vnet.ibm.com>
> 
> Perf list with flags -d and -v print a description (-d) or
> a very verbose explanation (-v) of CPU specific counter events.
> These descriptions are provided with the json files in
> directory pmu-events/arch/s390/*.json.
> 
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

I don't think this is quite right.

On arm, we specifically look for PMU directories which have a
file called CPUs. e.g.

  /sys/bus/event_source/devices/arm_pmuv3/cpus

... where "arm_pmuv3" is the PMU name.

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
> +	if (stat(path, &st) == 0)
> +		return 1;

IIUC here we return true if the PMU has a sysfs directory, but all PMUs
(including uncore PMUs) should have such a directory, so this will make
is_pmu_core() always return true.

Can you match the "cpum_" prefix specifically, instead?

Thanks,
Mark.
