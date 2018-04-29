Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753546AbeD2O4S (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 10:56:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34022 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753130AbeD2O4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 10:56:16 -0400
Date: Sun, 29 Apr 2018 16:56:13 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] perf updates for 4.17
Message-ID: <alpine.DEB.2.21.1804291653180.1595@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

The perf update contains the following bits:

    x86:
     - Prevent setting freeze_on_smi on PerfMon V1 CPUs to avoid #GP

    perf stat:
    
     - Keep the '/' event modifier separator in fallback, for example when
       fallbacking from 'cpu/cpu-cycles/' to user level only, where it should
       become 'cpu/cpu-cycles/u' and not 'cpu/cpu-cycles/:u' (Jiri Olsa)
    
     - Fix PMU events parsing rule, improving error reporting for
       invalid events (Jiri Olsa)
    
     - Disable write_backward and other event attributes for !group
       events in a group, fixing, for instance this group: '{cycles,msr/aperf/}:S'
       that has leader sampling (:S) and where just the 'cycles',
       the leader event, should have the write_backward attribute
       set, in this case it all fails because the PMU where 'msr/aperf/'
       lives doesn't accepts write_backward style sampling (Jiri Olsa)
    
     - Only fall back group read for leader (Kan Liang)
    
     - Fix core PMU alias list for x86 platform (Kan Liang)
    
     - Print out hint for mixed PMU group error (Kan Liang)
    
     - Fix duplicate PMU name for interval print (Kan Liang)
    
    Core:
    
     - Set main kernel end address properly when reading kernel and
       module maps (Namhyung Kim)
    
    perf mem:
    
     - Fix incorrect entries and add missing man options (Sangwon Hong)
    
    s/390:
    
     - Remove s390 specific strcmp_cpuid_cmp function (Thomas Richter)
    
     - Adapt 'perf test' case record+probe_libc_inet_pton.sh for s390
    
     - Fix s390 undefined record__auxtrace_init() return value in
       'perf record' (Thomas Richter)


Thanks,

	tglx

------------------>
Jiri Olsa (3):
      perf stat: Keep the / modifier separator in fallback
      perf pmu: Fix pmu events parsing rule
      perf evsel: Disable write_backward for leader sampling group events

Kan Liang (5):
      perf pmu: Fix core PMU alias list for X86 platform
      perf stat: Print out hint for mixed PMU group error
      perf evsel: Only fall back group read for leader
      perf stat: Fix duplicate PMU name for interval print
      perf/x86/intel: Don't enable freeze-on-smi for PerfMon V1

Namhyung Kim (1):
      perf machine: Set main kernel end address properly

Sangwon Hong (1):
      perf mem: Document incorrect and missing options

Thomas Richter (3):
      perf list: Remove s390 specific strcmp_cpuid_cmp function
      perf test: Adapt test case record+probe_libc_inet_pton.sh for s390
      perf record: Fix s390 undefined record__auxtrace_init() return value


 arch/x86/events/intel/core.c                       |  9 +++--
 tools/perf/Documentation/perf-mem.txt              | 41 +++++++++++++++-------
 tools/perf/arch/s390/util/auxtrace.c               |  1 +
 tools/perf/arch/s390/util/header.c                 | 18 ----------
 tools/perf/builtin-stat.c                          | 40 +++++++++++++++++++--
 tools/perf/pmu-events/arch/s390/mapfile.csv        | 10 +++---
 tools/perf/tests/attr/test-record-group-sampling   |  3 ++
 .../tests/shell/record+probe_libc_inet_pton.sh     |  6 ++--
 tools/perf/util/evsel.c                            | 18 +++++++---
 tools/perf/util/evsel.h                            |  1 +
 tools/perf/util/machine.c                          | 30 +++++++++-------
 tools/perf/util/parse-events.y                     |  8 ++---
 tools/perf/util/pmu.c                              | 22 +++++-------
 13 files changed, 129 insertions(+), 78 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 607bf565a90c..707b2a96e516 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3339,7 +3339,8 @@ static void intel_pmu_cpu_starting(int cpu)
 
 	cpuc->lbr_sel = NULL;
 
-	flip_smm_bit(&x86_pmu.attr_freeze_on_smi);
+	if (x86_pmu.version > 1)
+		flip_smm_bit(&x86_pmu.attr_freeze_on_smi);
 
 	if (!cpuc->shared_regs)
 		return;
@@ -3502,6 +3503,8 @@ static __initconst const struct x86_pmu core_pmu = {
 	.cpu_dying		= intel_pmu_cpu_dying,
 };
 
+static struct attribute *intel_pmu_attrs[];
+
 static __initconst const struct x86_pmu intel_pmu = {
 	.name			= "Intel",
 	.handle_irq		= intel_pmu_handle_irq,
@@ -3533,6 +3536,8 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.format_attrs		= intel_arch3_formats_attr,
 	.events_sysfs_show	= intel_event_sysfs_show,
 
+	.attrs			= intel_pmu_attrs,
+
 	.cpu_prepare		= intel_pmu_cpu_prepare,
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
@@ -3911,8 +3916,6 @@ __init int intel_pmu_init(void)
 
 	x86_pmu.max_pebs_events		= min_t(unsigned, MAX_PEBS_EVENTS, x86_pmu.num_counters);
 
-
-	x86_pmu.attrs			= intel_pmu_attrs;
 	/*
 	 * Quirk: v2 perfmon does not report fixed-purpose events, so
 	 * assume at least 3 events, when not running in a hypervisor:
diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index 8806ed5f3802..f8d2167cf3e7 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -28,29 +28,46 @@ OPTIONS
 <command>...::
 	Any command you can specify in a shell.
 
+-i::
+--input=<file>::
+	Input file name.
+
 -f::
 --force::
 	Don't do ownership validation
 
 -t::
---type=::
+--type=<type>::
 	Select the memory operation type: load or store (default: load,store)
 
 -D::
---dump-raw-samples=::
+--dump-raw-samples::
 	Dump the raw decoded samples on the screen in a format that is easy to parse with
 	one sample per line.
 
 -x::
---field-separator::
+--field-separator=<separator>::
 	Specify the field separator used when dump raw samples (-D option). By default,
 	The separator is the space character.
 
 -C::
---cpu-list::
-	Restrict dump of raw samples to those provided via this option. Note that the same
-	option can be passed in record mode. It will be interpreted the same way as perf
-	record.
+--cpu=<cpu>::
+	Monitor only on the list of CPUs provided. Multiple CPUs can be provided as a
+        comma-separated list with no space: 0,1. Ranges of CPUs are specified with -: 0-2. Default
+        is to monitor all CPUS.
+-U::
+--hide-unresolved::
+	Only display entries resolved to a symbol.
+
+-p::
+--phys-data::
+	Record/Report sample physical addresses
+
+RECORD OPTIONS
+--------------
+-e::
+--event <event>::
+	Event selector. Use 'perf mem record -e list' to list available events.
 
 -K::
 --all-kernel::
@@ -60,12 +77,12 @@ OPTIONS
 --all-user::
 	Configure all used events to run in user space.
 
---ldload::
-	Specify desired latency for loads event.
+-v::
+--verbose::
+	Be more verbose (show counter open errors, etc)
 
--p::
---phys-data::
-	Record/Report sample physical addresses
+--ldlat <n>::
+	Specify desired latency for loads event.
 
 In addition, for report all perf report options are valid, and for record
 all perf record options.
diff --git a/tools/perf/arch/s390/util/auxtrace.c b/tools/perf/arch/s390/util/auxtrace.c
index 6cb48e4cffd9..3afe8256eff2 100644
--- a/tools/perf/arch/s390/util/auxtrace.c
+++ b/tools/perf/arch/s390/util/auxtrace.c
@@ -87,6 +87,7 @@ struct auxtrace_record *auxtrace_record__init(struct perf_evlist *evlist,
 	struct perf_evsel *pos;
 	int diagnose = 0;
 
+	*err = 0;
 	if (evlist->nr_entries == 0)
 		return NULL;
 
diff --git a/tools/perf/arch/s390/util/header.c b/tools/perf/arch/s390/util/header.c
index a4c30f1c70be..163b92f33998 100644
--- a/tools/perf/arch/s390/util/header.c
+++ b/tools/perf/arch/s390/util/header.c
@@ -146,21 +146,3 @@ char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
 		zfree(&buf);
 	return buf;
 }
-
-/*
- * Compare the cpuid string returned by get_cpuid() function
- * with the name generated by the jevents file read from
- * pmu-events/arch/s390/mapfile.csv.
- *
- * Parameter mapcpuid is the cpuid as stored in the
- * pmu-events/arch/s390/mapfile.csv. This is just the type number.
- * Parameter cpuid is the cpuid returned by function get_cpuid().
- */
-int strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
-{
-	char *cp = strchr(cpuid, ',');
-
-	if (cp == NULL)
-		return -1;
-	return strncmp(cp + 1, mapcpuid, strlen(mapcpuid));
-}
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 147a27e8c937..f17dc601b0f3 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -172,6 +172,7 @@ static bool			interval_count;
 static const char		*output_name;
 static int			output_fd;
 static int			print_free_counters_hint;
+static int			print_mixed_hw_group_error;
 
 struct perf_stat {
 	bool			 record;
@@ -1126,6 +1127,30 @@ static void abs_printout(int id, int nr, struct perf_evsel *evsel, double avg)
 		fprintf(output, "%s%s", csv_sep, evsel->cgrp->name);
 }
 
+static bool is_mixed_hw_group(struct perf_evsel *counter)
+{
+	struct perf_evlist *evlist = counter->evlist;
+	u32 pmu_type = counter->attr.type;
+	struct perf_evsel *pos;
+
+	if (counter->nr_members < 2)
+		return false;
+
+	evlist__for_each_entry(evlist, pos) {
+		/* software events can be part of any hardware group */
+		if (pos->attr.type == PERF_TYPE_SOFTWARE)
+			continue;
+		if (pmu_type == PERF_TYPE_SOFTWARE) {
+			pmu_type = pos->attr.type;
+			continue;
+		}
+		if (pmu_type != pos->attr.type)
+			return true;
+	}
+
+	return false;
+}
+
 static void printout(int id, int nr, struct perf_evsel *counter, double uval,
 		     char *prefix, u64 run, u64 ena, double noise,
 		     struct runtime_stat *st)
@@ -1178,8 +1203,11 @@ static void printout(int id, int nr, struct perf_evsel *counter, double uval,
 			counter->supported ? CNTR_NOT_COUNTED : CNTR_NOT_SUPPORTED,
 			csv_sep);
 
-		if (counter->supported)
+		if (counter->supported) {
 			print_free_counters_hint = 1;
+			if (is_mixed_hw_group(counter))
+				print_mixed_hw_group_error = 1;
+		}
 
 		fprintf(stat_config.output, "%-*s%s",
 			csv_output ? 0 : unit_width,
@@ -1256,7 +1284,8 @@ static void uniquify_event_name(struct perf_evsel *counter)
 	char *new_name;
 	char *config;
 
-	if (!counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
+	if (counter->uniquified_name ||
+	    !counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
 					   strlen(counter->pmu_name)))
 		return;
 
@@ -1274,6 +1303,8 @@ static void uniquify_event_name(struct perf_evsel *counter)
 			counter->name = new_name;
 		}
 	}
+
+	counter->uniquified_name = true;
 }
 
 static void collect_all_aliases(struct perf_evsel *counter,
@@ -1757,6 +1788,11 @@ static void print_footer(void)
 "	echo 0 > /proc/sys/kernel/nmi_watchdog\n"
 "	perf stat ...\n"
 "	echo 1 > /proc/sys/kernel/nmi_watchdog\n");
+
+	if (print_mixed_hw_group_error)
+		fprintf(output,
+			"The events in group usually have to be from "
+			"the same PMU. Try reorganizing the group.\n");
 }
 
 static void print_counters(struct timespec *ts, int argc, const char **argv)
diff --git a/tools/perf/pmu-events/arch/s390/mapfile.csv b/tools/perf/pmu-events/arch/s390/mapfile.csv
index ca7682748a4b..78bcf7f8e206 100644
--- a/tools/perf/pmu-events/arch/s390/mapfile.csv
+++ b/tools/perf/pmu-events/arch/s390/mapfile.csv
@@ -1,6 +1,6 @@
 Family-model,Version,Filename,EventType
-209[78],1,cf_z10,core
-281[78],1,cf_z196,core
-282[78],1,cf_zec12,core
-296[45],1,cf_z13,core
-3906,3,cf_z14,core
+^IBM.209[78].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_z10,core
+^IBM.281[78].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_z196,core
+^IBM.282[78].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_zec12,core
+^IBM.296[45].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_z13,core
+^IBM.390[67].*[13]\.[1-5].[[:xdigit:]]+$,3,cf_z14,core
diff --git a/tools/perf/tests/attr/test-record-group-sampling b/tools/perf/tests/attr/test-record-group-sampling
index f906b793196f..8a33ca4f9e1f 100644
--- a/tools/perf/tests/attr/test-record-group-sampling
+++ b/tools/perf/tests/attr/test-record-group-sampling
@@ -35,3 +35,6 @@ inherit=0
 # sampling disabled
 sample_freq=0
 sample_period=0
+freq=0
+write_backward=0
+sample_id_all=0
diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 1ecc1f0ff84a..016882dbbc16 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -19,12 +19,10 @@ trace_libc_inet_pton_backtrace() {
 	expected[1]=".*inet_pton[[:space:]]\($libc\)$"
 	case "$(uname -m)" in
 	s390x)
-		eventattr='call-graph=dwarf'
+		eventattr='call-graph=dwarf,max-stack=4'
 		expected[2]="gaih_inet.*[[:space:]]\($libc|inlined\)$"
-		expected[3]="__GI_getaddrinfo[[:space:]]\($libc|inlined\)$"
+		expected[3]="(__GI_)?getaddrinfo[[:space:]]\($libc|inlined\)$"
 		expected[4]="main[[:space:]]\(.*/bin/ping.*\)$"
-		expected[5]="__libc_start_main[[:space:]]\($libc\)$"
-		expected[6]="_start[[:space:]]\(.*/bin/ping.*\)$"
 		;;
 	*)
 		eventattr='max-stack=3'
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3e87486c28fe..4cd2cf93f726 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -930,8 +930,11 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	 * than leader in case leader 'leads' the sampling.
 	 */
 	if ((leader != evsel) && leader->sample_read) {
-		attr->sample_freq   = 0;
-		attr->sample_period = 0;
+		attr->freq           = 0;
+		attr->sample_freq    = 0;
+		attr->sample_period  = 0;
+		attr->write_backward = 0;
+		attr->sample_id_all  = 0;
 	}
 
 	if (opts->no_samples)
@@ -1922,7 +1925,8 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 		goto fallback_missing_features;
 	} else if (!perf_missing_features.group_read &&
 		    evsel->attr.inherit &&
-		   (evsel->attr.read_format & PERF_FORMAT_GROUP)) {
+		   (evsel->attr.read_format & PERF_FORMAT_GROUP) &&
+		   perf_evsel__is_group_leader(evsel)) {
 		perf_missing_features.group_read = true;
 		pr_debug2("switching off group read\n");
 		goto fallback_missing_features;
@@ -2754,8 +2758,14 @@ bool perf_evsel__fallback(struct perf_evsel *evsel, int err,
 		   (paranoid = perf_event_paranoid()) > 1) {
 		const char *name = perf_evsel__name(evsel);
 		char *new_name;
+		const char *sep = ":";
 
-		if (asprintf(&new_name, "%s%su", name, strchr(name, ':') ? "" : ":") < 0)
+		/* Is there already the separator in the name. */
+		if (strchr(name, '/') ||
+		    strchr(name, ':'))
+			sep = "";
+
+		if (asprintf(&new_name, "%s%su", name, sep) < 0)
 			return false;
 
 		if (evsel->name)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index d3ee3af618ef..92ec009a292d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -115,6 +115,7 @@ struct perf_evsel {
 	unsigned int		sample_size;
 	int			id_pos;
 	int			is_pos;
+	bool			uniquified_name;
 	bool			snapshot;
 	bool 			supported;
 	bool 			needs_swap;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2eca8478e24f..32d50492505d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1019,13 +1019,6 @@ int machine__load_vmlinux_path(struct machine *machine, enum map_type type)
 	return ret;
 }
 
-static void map_groups__fixup_end(struct map_groups *mg)
-{
-	int i;
-	for (i = 0; i < MAP__NR_TYPES; ++i)
-		__map_groups__fixup_end(mg, i);
-}
-
 static char *get_kernel_version(const char *root_dir)
 {
 	char version[PATH_MAX];
@@ -1233,6 +1226,7 @@ int machine__create_kernel_maps(struct machine *machine)
 {
 	struct dso *kernel = machine__get_kernel(machine);
 	const char *name = NULL;
+	struct map *map;
 	u64 addr = 0;
 	int ret;
 
@@ -1259,13 +1253,25 @@ int machine__create_kernel_maps(struct machine *machine)
 			machine__destroy_kernel_maps(machine);
 			return -1;
 		}
-		machine__set_kernel_mmap(machine, addr, 0);
+
+		/* we have a real start address now, so re-order the kmaps */
+		map = machine__kernel_map(machine);
+
+		map__get(map);
+		map_groups__remove(&machine->kmaps, map);
+
+		/* assume it's the last in the kmaps */
+		machine__set_kernel_mmap(machine, addr, ~0ULL);
+
+		map_groups__insert(&machine->kmaps, map);
+		map__put(map);
 	}
 
-	/*
-	 * Now that we have all the maps created, just set the ->end of them:
-	 */
-	map_groups__fixup_end(&machine->kmaps);
+	/* update end address of the kernel map using adjacent module address */
+	map = map__next(machine__kernel_map(machine));
+	if (map)
+		machine__set_kernel_mmap(machine, addr, map->start);
+
 	return 0;
 }
 
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 7afeb80cc39e..d14464c42714 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -224,15 +224,15 @@ event_def: event_pmu |
 	   event_bpf_file
 
 event_pmu:
-PE_NAME opt_event_config
+PE_NAME '/' event_config '/'
 {
 	struct list_head *list, *orig_terms, *terms;
 
-	if (parse_events_copy_term_list($2, &orig_terms))
+	if (parse_events_copy_term_list($3, &orig_terms))
 		YYABORT;
 
 	ALLOC_LIST(list);
-	if (parse_events_add_pmu(_parse_state, list, $1, $2, false)) {
+	if (parse_events_add_pmu(_parse_state, list, $1, $3, false)) {
 		struct perf_pmu *pmu = NULL;
 		int ok = 0;
 		char *pattern;
@@ -262,7 +262,7 @@ PE_NAME opt_event_config
 		if (!ok)
 			YYABORT;
 	}
-	parse_events_terms__delete($2);
+	parse_events_terms__delete($3);
 	parse_events_terms__delete(orig_terms);
 	$$ = list;
 }
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 61a5e5027338..d2fb597c9a8c 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -539,9 +539,10 @@ static bool pmu_is_uncore(const char *name)
 
 /*
  *  PMU CORE devices have different name other than cpu in sysfs on some
- *  platforms. looking for possible sysfs files to identify as core device.
+ *  platforms.
+ *  Looking for possible sysfs files to identify the arm core device.
  */
-static int is_pmu_core(const char *name)
+static int is_arm_pmu_core(const char *name)
 {
 	struct stat st;
 	char path[PATH_MAX];
@@ -550,12 +551,6 @@ static int is_pmu_core(const char *name)
 	if (!sysfs)
 		return 0;
 
-	/* Look for cpu sysfs (x86 and others) */
-	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/cpu", sysfs);
-	if ((stat(path, &st) == 0) &&
-			(strncmp(name, "cpu", strlen("cpu")) == 0))
-		return 1;
-
 	/* Look for cpu sysfs (specific to arm) */
 	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/cpus",
 				sysfs, name);
@@ -586,7 +581,7 @@ char * __weak get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
  * cpuid string generated on this platform.
  * Otherwise return non-zero.
  */
-int __weak strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
+int strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
 {
 	regex_t re;
 	regmatch_t pmatch[1];
@@ -668,6 +663,7 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 	struct pmu_events_map *map;
 	struct pmu_event *pe;
 	const char *name = pmu->name;
+	const char *pname;
 
 	map = perf_pmu__find_map(pmu);
 	if (!map)
@@ -686,11 +682,9 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 			break;
 		}
 
-		if (!is_pmu_core(name)) {
-			/* check for uncore devices */
-			if (pe->pmu == NULL)
-				continue;
-			if (strncmp(pe->pmu, name, strlen(pe->pmu)))
+		if (!is_arm_pmu_core(name)) {
+			pname = pe->pmu ? pe->pmu : "cpu";
+			if (strncmp(pname, name, strlen(pname)))
 				continue;
 		}
 
