Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeDIOSR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:18:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56818 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751367AbeDIOSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:18:16 -0400
Date: Mon, 9 Apr 2018 15:18:12 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf list: Add s390 support for detailed/verbose pmu
 event description
Message-ID: <20180409141811.eaynqn53nxavcjo2@lakrids.cambridge.arm.com>
References: <20180409110015.20793-1-tmricht@linux.ibm.com>
 <20180409113732.6k3plpp6pqdcbzrh@lakrids.cambridge.arm.com>
 <975962f2-3d85-2325-da31-b74951863cbe@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <975962f2-3d85-2325-da31-b74951863cbe@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 03:03:32PM +0200, Thomas-Mich Richter wrote:
> On 04/09/2018 01:37 PM, Mark Rutland wrote:
> > On Mon, Apr 09, 2018 at 01:00:15PM +0200, Thomas Richter wrote:
> >> @@ -562,6 +562,12 @@ static int is_pmu_core(const char *name)
> >>  	if (stat(path, &st) == 0)
> >>  		return 1;
> >>  
> >> +	/* Look for cpu sysfs (specific to s390) */
> >> +	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s",
> >> +		  sysfs, name);
> >> +	if (stat(path, &st) == 0)
> >> +		return 1;
> > 
> > IIUC here we return true if the PMU has a sysfs directory, but all PMUs
> > (including uncore PMUs) should have such a directory, so this will make
> > is_pmu_core() always return true.
> > 
> > Can you match the "cpum_" prefix specifically, instead?
> > 
> > Thanks,
> > Mark.
> 
> I am sorry, I don't follow you.
>
> When I look at the code function sequence
> 
> perf_pmu__scan()
> +---> pmu_read_sysfs()
>       This functions scans directory /sys/bus/event_source/devices/
>       and calls for each entry in this directory. For s390 these entries exist:
>       cpum_sf cpum_cf tracepoint and software

... and we want is:

	is_pmu_core("cpum_sf") == true
	is_pmu_core("cpum_cf") == true
	is_pmu_core("tracepoint") == false
	is_pmu_core("software") == false

>       +---> perf_pmu__find();
>             +---> pmu_lookup()

>                   +---> pmu_add_cpu_aliases() adds the list of aliases such as cpum_sf/SF_CYCLES_BASIC/
>                         to the global list of aliases. But ths happens only when
>                         +---> is_pmu_core()
>                               function returns true.
>                               And for s390 it needs to test for /sys/bus/event_source/devices/cpum_sf/ and
>                               /sys/bus/event_source/devices/cpum_cf/
>                               directories.
>                               These directories are used to read the alias names in function
>                               pmu_aliases() above.

However, your code also returns true for "tracepoint" and "software".

You check if there's a directory under event_source/devices/ for the PMU
name, and every PMU should have such a directory.

For example, on my x86 box I have

[mark@lakrids:~]% ls /sys/bus/event_source/devices 
breakpoint   power           uncore_cbox_13  uncore_cbox_9  uncore_qpi_0
cpu          software        uncore_cbox_2   uncore_ha_0    uncore_qpi_1
cstate_core  tracepoint      uncore_cbox_3   uncore_ha_1    uncore_r2pcie
cstate_pkg   uncore_cbox_0   uncore_cbox_4   uncore_imc_0   uncore_r3qpi_0
intel_bts    uncore_cbox_1   uncore_cbox_5   uncore_imc_1   uncore_r3qpi_1
intel_cqm    uncore_cbox_10  uncore_cbox_6   uncore_imc_4   uncore_ubox
intel_pt     uncore_cbox_11  uncore_cbox_7   uncore_imc_5
msr          uncore_cbox_12  uncore_cbox_8   uncore_pcu


... and with your patch and the below hack applied:

----
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index bd0a32b03523..cec6bf551fe3 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -675,6 +675,12 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
                        break;
                }
 
+               if (is_pmu_core(name)) {
+                       printf ("is_pmu_core(\"%s\") is true\n", name);
+               } else {
+                       printf ("is_pmu_core(\"%s\") is false\n", name);
+               }
+
                if (!is_pmu_core(name)) {
                        /* check for uncore devices */
                        if (pe->pmu == NULL)
----

... is_pmu_core() returns true for every PMU:

[mark@lakrids:~/src/linux/tools/perf]% ./perf list | grep 'is true' | uniq
is_pmu_core("uncore_imc_4") is true
is_pmu_core("uncore_cbox_5") is true
is_pmu_core("uncore_ha_0") is true
is_pmu_core("uncore_cbox_3") is true
is_pmu_core("uncore_qpi_0") is true
is_pmu_core("cstate_pkg") is true
is_pmu_core("breakpoint") is true
is_pmu_core("uncore_imc_0") is true
is_pmu_core("uncore_ubox") is true
is_pmu_core("uncore_pcu") is true
is_pmu_core("uncore_cbox_1") is true
is_pmu_core("uncore_r3qpi_0") is true
is_pmu_core("uncore_cbox_13") is true
is_pmu_core("intel_cqm") is true
is_pmu_core("power") is true
is_pmu_core("cpu") is true
is_pmu_core("intel_pt") is true
is_pmu_core("uncore_cbox_11") is true
is_pmu_core("uncore_cbox_8") is true
is_pmu_core("uncore_imc_5") is true
is_pmu_core("software") is true
is_pmu_core("uncore_cbox_6") is true
is_pmu_core("uncore_ha_1") is true
is_pmu_core("uncore_r2pcie") is true
is_pmu_core("uncore_cbox_4") is true
is_pmu_core("intel_bts") is true
is_pmu_core("uncore_qpi_1") is true
is_pmu_core("uncore_imc_1") is true
is_pmu_core("uncore_cbox_2") is true
is_pmu_core("uncore_r3qpi_1") is true
is_pmu_core("uncore_cbox_0") is true
is_pmu_core("cstate_core") is true
is_pmu_core("uncore_cbox_12") is true
is_pmu_core("tracepoint") is true
is_pmu_core("uncore_cbox_9") is true
is_pmu_core("msr") is true
is_pmu_core("uncore_cbox_10") is true
is_pmu_core("uncore_cbox_7") is true

[mark@lakrids:~/src/linux/tools/perf]% ./perf list | grep 'is false' | wc -l
0


... whereas previously this was only the case for the CPU PMU:

[mark@lakrids:~/src/linux/tools/perf]% ./perf list | grep 'is true' | uniq
is_pmu_core("cpu") is true

[mark@lakrids:~/src/linux/tools/perf]% ./perf list | grep 'is false' | uniq
is_pmu_core("uncore_imc_4") is false
is_pmu_core("uncore_cbox_5") is false
is_pmu_core("uncore_ha_0") is false
is_pmu_core("uncore_cbox_3") is false
is_pmu_core("uncore_qpi_0") is false
is_pmu_core("cstate_pkg") is false
is_pmu_core("breakpoint") is false
is_pmu_core("uncore_imc_0") is false
is_pmu_core("uncore_ubox") is false
is_pmu_core("uncore_pcu") is false
is_pmu_core("uncore_cbox_1") is false
is_pmu_core("uncore_r3qpi_0") is false
is_pmu_core("uncore_cbox_13") is false
is_pmu_core("intel_cqm") is false
is_pmu_core("power") is false
is_pmu_core("intel_pt") is false
is_pmu_core("uncore_cbox_11") is false
is_pmu_core("uncore_cbox_8") is false
is_pmu_core("uncore_imc_5") is false
is_pmu_core("software") is false
is_pmu_core("uncore_cbox_6") is false
is_pmu_core("uncore_ha_1") is false
is_pmu_core("uncore_r2pcie") is false
is_pmu_core("uncore_cbox_4") is false
is_pmu_core("intel_bts") is false
is_pmu_core("uncore_qpi_1") is false
is_pmu_core("uncore_imc_1") is false
is_pmu_core("uncore_cbox_2") is false
is_pmu_core("uncore_r3qpi_1") is false
is_pmu_core("uncore_cbox_0") is false
is_pmu_core("cstate_core") is false
is_pmu_core("uncore_cbox_12") is false
is_pmu_core("tracepoint") is false
is_pmu_core("uncore_cbox_9") is false
is_pmu_core("msr") is false
is_pmu_core("uncore_cbox_10") is false
is_pmu_core("uncore_cbox_7") is false

If it's fine to have a tautological is_pmu_core(), then we can remove it
entirely.

My understanding was that we have the is_pmu_core() check to ensure that
we don't associate aliases with other PMUs in the system.

For example, on some arm platforms the CPU PMU isn't available, and we
shouldn't add the CPU PMU aliases just because we have a software PMU.

> Maybe I misunderstand this whole scheme, but with this patch the perf
> list commands works...

It looks like it works on my x86 box, at least, but I do think this is
wrong in some cases.

Thanks,
Mark.
