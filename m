Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbeFCJNp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 05:13:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36089 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeFCJNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 05:13:43 -0400
Date: Sun, 3 Jun 2018 11:13:40 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] perf fixes for 4.17
Message-ID: <alpine.DEB.2.21.1806030856190.1603@nanos.tec.linutronix.de>
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

A set of fixes for perf tooling:

    - Fix 'perf test Session topology' segfault on s390 (Thomas Richter)
    
    - Fix NULL return handling in bpf__prepare_load() (YueHaibing)
    
    - Fix indexing on Coresight ETM packet queue decoder (Mathieu Poirier)
    
    - Fix perf.data format description of NRCPUS header (Arnaldo Carvalho de Melo)
    
    - Update perf.data documentation section on cpu topology
    
    - Handle uncore event aliases in small groups properly (Kan Liang)
    
    - Add missing perf_sample.addr into python sample dictionary (Leo Yan)

Thanks,

	tglx

------------------>
Arnaldo Carvalho de Melo (1):
      perf tools: Fix perf.data format description of NRCPUS header

Kan Liang (1):
      perf parse-events: Handle uncore event aliases in small groups properly

Leo Yan (1):
      perf script python: Add addr into perf sample dict

Mathieu Poirier (1):
      perf cs-etm: Fix indexing for decoder packet queue

Thomas Richter (2):
      perf test: "Session topology" dumps core on s390
      perf data: Update documentation section on cpu topology

YueHaibing (1):
      perf bpf: Fix NULL return handling in bpf__prepare_load()


 tools/perf/Documentation/perf.data-file-format.txt |  10 +-
 tools/perf/tests/topology.c                        |  30 ++++-
 tools/perf/util/bpf-loader.c                       |   6 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  12 +-
 tools/perf/util/evsel.h                            |   1 +
 tools/perf/util/parse-events.c                     | 130 ++++++++++++++++++++-
 tools/perf/util/parse-events.h                     |   7 +-
 tools/perf/util/parse-events.y                     |   8 +-
 .../util/scripting-engines/trace-event-python.c    |   2 +
 9 files changed, 185 insertions(+), 21 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index d00f0d51cab8..dfb218feaad9 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -111,8 +111,8 @@ A perf_header_string with the CPU architecture (uname -m)
 A structure defining the number of CPUs.
 
 struct nr_cpus {
-       uint32_t nr_cpus_online;
        uint32_t nr_cpus_available; /* CPUs not yet onlined */
+       uint32_t nr_cpus_online;
 };
 
 	HEADER_CPUDESC = 8,
@@ -153,10 +153,18 @@ struct {
 	HEADER_CPU_TOPOLOGY = 13,
 
 String lists defining the core and CPU threads topology.
+The string lists are followed by a variable length array
+which contains core_id and socket_id of each cpu.
+The number of entries can be determined by the size of the
+section minus the sizes of both string lists.
 
 struct {
        struct perf_header_string_list cores; /* Variable length */
        struct perf_header_string_list threads; /* Variable length */
+       struct {
+	      uint32_t core_id;
+	      uint32_t socket_id;
+       } cpus[nr]; /* Variable length records */
 };
 
 Example:
diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
index 17cb1bb3448c..40e30a26b23c 100644
--- a/tools/perf/tests/topology.c
+++ b/tools/perf/tests/topology.c
@@ -70,6 +70,27 @@ static int check_cpu_topology(char *path, struct cpu_map *map)
 	session = perf_session__new(&data, false, NULL);
 	TEST_ASSERT_VAL("can't get session", session);
 
+	/* On platforms with large numbers of CPUs process_cpu_topology()
+	 * might issue an error while reading the perf.data file section
+	 * HEADER_CPU_TOPOLOGY and the cpu_topology_map pointed to by member
+	 * cpu is a NULL pointer.
+	 * Example: On s390
+	 *   CPU 0 is on core_id 0 and physical_package_id 6
+	 *   CPU 1 is on core_id 1 and physical_package_id 3
+	 *
+	 *   Core_id and physical_package_id are platform and architecture
+	 *   dependend and might have higher numbers than the CPU id.
+	 *   This actually depends on the configuration.
+	 *
+	 *  In this case process_cpu_topology() prints error message:
+	 *  "socket_id number is too big. You may need to upgrade the
+	 *  perf tool."
+	 *
+	 *  This is the reason why this test might be skipped.
+	 */
+	if (!session->header.env.cpu)
+		return TEST_SKIP;
+
 	for (i = 0; i < session->header.env.nr_cpus_avail; i++) {
 		if (!cpu_map__has(map, i))
 			continue;
@@ -95,7 +116,7 @@ int test__session_topology(struct test *test __maybe_unused, int subtest __maybe
 {
 	char path[PATH_MAX];
 	struct cpu_map *map;
-	int ret = -1;
+	int ret = TEST_FAIL;
 
 	TEST_ASSERT_VAL("can't get templ file", !get_temp(path));
 
@@ -110,12 +131,9 @@ int test__session_topology(struct test *test __maybe_unused, int subtest __maybe
 		goto free_path;
 	}
 
-	if (check_cpu_topology(path, map))
-		goto free_map;
-	ret = 0;
-
-free_map:
+	ret = check_cpu_topology(path, map);
 	cpu_map__put(map);
+
 free_path:
 	unlink(path);
 	return ret;
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index af7ad814b2c3..cee658733e2c 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -66,7 +66,7 @@ bpf__prepare_load_buffer(void *obj_buf, size_t obj_buf_sz, const char *name)
 	}
 
 	obj = bpf_object__open_buffer(obj_buf, obj_buf_sz, name);
-	if (IS_ERR(obj)) {
+	if (IS_ERR_OR_NULL(obj)) {
 		pr_debug("bpf: failed to load buffer\n");
 		return ERR_PTR(-EINVAL);
 	}
@@ -102,14 +102,14 @@ struct bpf_object *bpf__prepare_load(const char *filename, bool source)
 			pr_debug("bpf: successfull builtin compilation\n");
 		obj = bpf_object__open_buffer(obj_buf, obj_buf_sz, filename);
 
-		if (!IS_ERR(obj) && llvm_param.dump_obj)
+		if (!IS_ERR_OR_NULL(obj) && llvm_param.dump_obj)
 			llvm__dump_obj(filename, obj_buf, obj_buf_sz);
 
 		free(obj_buf);
 	} else
 		obj = bpf_object__open(filename);
 
-	if (IS_ERR(obj)) {
+	if (IS_ERR_OR_NULL(obj)) {
 		pr_debug("bpf: failed to load %s\n", filename);
 		return obj;
 	}
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index c8b98fa22997..4d5fc374e730 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -96,11 +96,19 @@ int cs_etm_decoder__get_packet(struct cs_etm_decoder *decoder,
 	/* Nothing to do, might as well just return */
 	if (decoder->packet_count == 0)
 		return 0;
+	/*
+	 * The queueing process in function cs_etm_decoder__buffer_packet()
+	 * increments the tail *before* using it.  This is somewhat counter
+	 * intuitive but it has the advantage of centralizing tail management
+	 * at a single location.  Because of that we need to follow the same
+	 * heuristic with the head, i.e we increment it before using its
+	 * value.  Otherwise the first element of the packet queue is not
+	 * used.
+	 */
+	decoder->head = (decoder->head + 1) & (MAX_BUFFER - 1);
 
 	*packet = decoder->packet_buffer[decoder->head];
 
-	decoder->head = (decoder->head + 1) & (MAX_BUFFER - 1);
-
 	decoder->packet_count--;
 
 	return 1;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 92ec009a292d..b13f5f234c8f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -127,6 +127,7 @@ struct perf_evsel {
 	bool			precise_max;
 	bool			ignore_missing_thread;
 	bool			forced_leader;
+	bool			use_uncore_alias;
 	/* parse modifier helper */
 	int			exclude_GH;
 	int			nr_members;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index b8b8a9558d32..2fc4ee8b86c1 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1219,13 +1219,16 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 
 int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, char *name,
-			 struct list_head *head_config, bool auto_merge_stats)
+			 struct list_head *head_config,
+			 bool auto_merge_stats,
+			 bool use_alias)
 {
 	struct perf_event_attr attr;
 	struct perf_pmu_info info;
 	struct perf_pmu *pmu;
 	struct perf_evsel *evsel;
 	struct parse_events_error *err = parse_state->error;
+	bool use_uncore_alias;
 	LIST_HEAD(config_terms);
 
 	pmu = perf_pmu__find(name);
@@ -1244,11 +1247,14 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		memset(&attr, 0, sizeof(attr));
 	}
 
+	use_uncore_alias = (pmu->is_uncore && use_alias);
+
 	if (!head_config) {
 		attr.type = pmu->type;
 		evsel = __add_event(list, &parse_state->idx, &attr, NULL, pmu, NULL, auto_merge_stats);
 		if (evsel) {
 			evsel->pmu_name = name;
+			evsel->use_uncore_alias = use_uncore_alias;
 			return 0;
 		} else {
 			return -ENOMEM;
@@ -1282,6 +1288,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		evsel->metric_expr = info.metric_expr;
 		evsel->metric_name = info.metric_name;
 		evsel->pmu_name = name;
+		evsel->use_uncore_alias = use_uncore_alias;
 	}
 
 	return evsel ? 0 : -ENOMEM;
@@ -1317,7 +1324,8 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 				list_add_tail(&term->list, head);
 
 				if (!parse_events_add_pmu(parse_state, list,
-							  pmu->name, head, true)) {
+							  pmu->name, head,
+							  true, true)) {
 					pr_debug("%s -> %s/%s/\n", str,
 						 pmu->name, alias->str);
 					ok++;
@@ -1339,7 +1347,120 @@ int parse_events__modifier_group(struct list_head *list,
 	return parse_events__modifier_event(list, event_mod, true);
 }
 
-void parse_events__set_leader(char *name, struct list_head *list)
+/*
+ * Check if the two uncore PMUs are from the same uncore block
+ * The format of the uncore PMU name is uncore_#blockname_#pmuidx
+ */
+static bool is_same_uncore_block(const char *pmu_name_a, const char *pmu_name_b)
+{
+	char *end_a, *end_b;
+
+	end_a = strrchr(pmu_name_a, '_');
+	end_b = strrchr(pmu_name_b, '_');
+
+	if (!end_a || !end_b)
+		return false;
+
+	if ((end_a - pmu_name_a) != (end_b - pmu_name_b))
+		return false;
+
+	return (strncmp(pmu_name_a, pmu_name_b, end_a - pmu_name_a) == 0);
+}
+
+static int
+parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
+					   struct parse_events_state *parse_state)
+{
+	struct perf_evsel *evsel, *leader;
+	uintptr_t *leaders;
+	bool is_leader = true;
+	int i, nr_pmu = 0, total_members, ret = 0;
+
+	leader = list_first_entry(list, struct perf_evsel, node);
+	evsel = list_last_entry(list, struct perf_evsel, node);
+	total_members = evsel->idx - leader->idx + 1;
+
+	leaders = calloc(total_members, sizeof(uintptr_t));
+	if (WARN_ON(!leaders))
+		return 0;
+
+	/*
+	 * Going through the whole group and doing sanity check.
+	 * All members must use alias, and be from the same uncore block.
+	 * Also, storing the leader events in an array.
+	 */
+	__evlist__for_each_entry(list, evsel) {
+
+		/* Only split the uncore group which members use alias */
+		if (!evsel->use_uncore_alias)
+			goto out;
+
+		/* The events must be from the same uncore block */
+		if (!is_same_uncore_block(leader->pmu_name, evsel->pmu_name))
+			goto out;
+
+		if (!is_leader)
+			continue;
+		/*
+		 * If the event's PMU name starts to repeat, it must be a new
+		 * event. That can be used to distinguish the leader from
+		 * other members, even they have the same event name.
+		 */
+		if ((leader != evsel) && (leader->pmu_name == evsel->pmu_name)) {
+			is_leader = false;
+			continue;
+		}
+		/* The name is always alias name */
+		WARN_ON(strcmp(leader->name, evsel->name));
+
+		/* Store the leader event for each PMU */
+		leaders[nr_pmu++] = (uintptr_t) evsel;
+	}
+
+	/* only one event alias */
+	if (nr_pmu == total_members) {
+		parse_state->nr_groups--;
+		goto handled;
+	}
+
+	/*
+	 * An uncore event alias is a joint name which means the same event
+	 * runs on all PMUs of a block.
+	 * Perf doesn't support mixed events from different PMUs in the same
+	 * group. The big group has to be split into multiple small groups
+	 * which only include the events from the same PMU.
+	 *
+	 * Here the uncore event aliases must be from the same uncore block.
+	 * The number of PMUs must be same for each alias. The number of new
+	 * small groups equals to the number of PMUs.
+	 * Setting the leader event for corresponding members in each group.
+	 */
+	i = 0;
+	__evlist__for_each_entry(list, evsel) {
+		if (i >= nr_pmu)
+			i = 0;
+		evsel->leader = (struct perf_evsel *) leaders[i++];
+	}
+
+	/* The number of members and group name are same for each group */
+	for (i = 0; i < nr_pmu; i++) {
+		evsel = (struct perf_evsel *) leaders[i];
+		evsel->nr_members = total_members / nr_pmu;
+		evsel->group_name = name ? strdup(name) : NULL;
+	}
+
+	/* Take the new small groups into account */
+	parse_state->nr_groups += nr_pmu - 1;
+
+handled:
+	ret = 1;
+out:
+	free(leaders);
+	return ret;
+}
+
+void parse_events__set_leader(char *name, struct list_head *list,
+			      struct parse_events_state *parse_state)
 {
 	struct perf_evsel *leader;
 
@@ -1348,6 +1469,9 @@ void parse_events__set_leader(char *name, struct list_head *list)
 		return;
 	}
 
+	if (parse_events__set_leader_for_uncore_aliase(name, list, parse_state))
+		return;
+
 	__perf_evlist__set_leader(list);
 	leader = list_entry(list->next, struct perf_evsel, node);
 	leader->group_name = name ? strdup(name) : NULL;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 5015cfd58277..4473dac27aee 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -167,7 +167,9 @@ int parse_events_add_breakpoint(struct list_head *list, int *idx,
 				void *ptr, char *type, u64 len);
 int parse_events_add_pmu(struct parse_events_state *parse_state,
 			 struct list_head *list, char *name,
-			 struct list_head *head_config, bool auto_merge_stats);
+			 struct list_head *head_config,
+			 bool auto_merge_stats,
+			 bool use_alias);
 
 int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
 			       char *str,
@@ -178,7 +180,8 @@ int parse_events_copy_term_list(struct list_head *old,
 
 enum perf_pmu_event_symbol_type
 perf_pmu__parse_check(const char *name);
-void parse_events__set_leader(char *name, struct list_head *list);
+void parse_events__set_leader(char *name, struct list_head *list,
+			      struct parse_events_state *parse_state);
 void parse_events_update_lists(struct list_head *list_event,
 			       struct list_head *list_all);
 void parse_events_evlist_error(struct parse_events_state *parse_state,
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 7afeb80cc39e..e37608a87dba 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -161,7 +161,7 @@ PE_NAME '{' events '}'
 	struct list_head *list = $3;
 
 	inc_group_count(list, _parse_state);
-	parse_events__set_leader($1, list);
+	parse_events__set_leader($1, list, _parse_state);
 	$$ = list;
 }
 |
@@ -170,7 +170,7 @@ PE_NAME '{' events '}'
 	struct list_head *list = $2;
 
 	inc_group_count(list, _parse_state);
-	parse_events__set_leader(NULL, list);
+	parse_events__set_leader(NULL, list, _parse_state);
 	$$ = list;
 }
 
@@ -232,7 +232,7 @@ PE_NAME opt_event_config
 		YYABORT;
 
 	ALLOC_LIST(list);
-	if (parse_events_add_pmu(_parse_state, list, $1, $2, false)) {
+	if (parse_events_add_pmu(_parse_state, list, $1, $2, false, false)) {
 		struct perf_pmu *pmu = NULL;
 		int ok = 0;
 		char *pattern;
@@ -251,7 +251,7 @@ PE_NAME opt_event_config
 					free(pattern);
 					YYABORT;
 				}
-				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true))
+				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
 					ok++;
 				parse_events_terms__delete(terms);
 			}
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 10dd5fce082b..7f8afacd08ee 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -531,6 +531,8 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 			PyLong_FromUnsignedLongLong(sample->period));
 	pydict_set_item_string_decref(dict_sample, "phys_addr",
 			PyLong_FromUnsignedLongLong(sample->phys_addr));
+	pydict_set_item_string_decref(dict_sample, "addr",
+			PyLong_FromUnsignedLongLong(sample->addr));
 	set_sample_read_in_dict(dict_sample, sample, evsel);
 	pydict_set_item_string_decref(dict, "sample", dict_sample);
 
