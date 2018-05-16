Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeEPSSM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:18:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:43119 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbeEPSSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:18:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,406,1520924400";
   d="scan'208";a="54950552"
Subject: Re: [PATCH V1 06/19] perf tools: Fix kernel_start for PTI on x86
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <1526388213-30696-1-git-send-email-adrian.hunter@intel.com>
 <1526388213-30696-7-git-send-email-adrian.hunter@intel.com>
 <20180516130029.GA18538@kernel.org>
 <56a4889f-6ea9-d7c6-3f1e-ea9738d314d0@intel.com>
 <20180516135539.GA1230@kernel.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <e20ff118-953e-d118-b5ff-cae52c6ff284@intel.com>
Date: Wed, 16 May 2018 21:16:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180516135539.GA1230@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/16/2018 04:55 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, May 16, 2018 at 04:45:41PM +0300, Adrian Hunter escreveu:
>> On 16/05/18 16:00, Arnaldo Carvalho de Melo wrote:
>>> 2303	bool machine__is(struct machine *machine, const char *arch)
>>> 2304	{
>>> 2305		return machine && machine->env && !strcmp(machine->env->arch, arch);
>>> 2306	}
>>> 2307	
>>> 2308	int machine__get_kernel_start(struct machine *machine)
>>> 2309	{
>>> (gdb) p machine
>>> $1 = (struct machine *) 0xc55548
>>> (gdb) p machine->env
>>> $2 = (struct perf_env *) 0xc06400 <perf_env>
>>> (gdb) p machine-env->arch
>>> No symbol "env" in current context.
>>> (gdb) p machine->env->arch
>>> $3 = 0x0
>>> (gdb)
>  
>> If there is no perf_data then perf_session__new() uses perf_env but it seems
>> perf_env.arch is not initialized.  Would it be OK to initialize
>> perf_env.arch and perf_env.nr_cpus_avail?
> 
> I guess so, to make that always available, i.e. no perf.data? Those
> should reflect the running machine environment.
> 
> So a preparatory patch that makes that the case would be good, I think.

How about this:

From: Adrian Hunter <adrian.hunter@intel.com>
Date: Wed, 16 May 2018 19:58:19 +0300
Subject: [PATCH] perf tools: Initialize perf_env.arch and
 perf_env.nr_cpus_avail

Initialize perf_env.arch and perf_env.nr_cpus_avail so that they are
available for tools to use, even for tools that are not processing a
perf.data file.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/perf.c     |  4 ++++
 tools/perf/util/env.c | 36 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/env.h |  2 ++
 3 files changed, 42 insertions(+)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 20a08cb32332..03ec7a3b996b 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -300,7 +300,11 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	commit_pager_choice();
 
 	perf_env__set_cmdline(&perf_env, argc, argv);
+	status = perf_env__read_common(&perf_env);
+	if (status < 0)
+		goto cleanup;
 	status = p->fn(argc, argv);
+cleanup:
 	perf_config__exit();
 	exit_browser(status);
 	perf_env__exit(&perf_env);
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 4c842762e3f2..0d34de3449a5 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -93,6 +93,42 @@ int perf_env__read_cpu_topology_map(struct perf_env *env)
 	return 0;
 }
 
+static int perf_env__read_arch(struct perf_env *env)
+{
+	struct utsname uts;
+
+	if (env->arch)
+		return 0;
+
+	if (!uname(&uts))
+		env->arch = strdup(uts.machine);
+
+	return env->arch ? 0 : -ENOMEM;
+}
+
+static void perf_env__read_nr_cpus_avail(struct perf_env *env)
+{
+	if (env->nr_cpus_avail == 0)
+		env->nr_cpus_avail = cpu__max_present_cpu();
+}
+
+int perf_env__read_common(struct perf_env *env)
+{
+	int ret;
+
+	ret = perf_env__read_arch(env);
+	if (ret < 0)
+		goto out_err;
+
+	perf_env__read_nr_cpus_avail(env);
+
+	return 0;
+
+out_err:
+	pr_err("Failed to determine machine environment\n");
+	return ret;
+}
+
 void cpu_cache_level__free(struct cpu_cache_level *cache)
 {
 	free(cache->type);
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index c4ef2e523367..a83ece08d6e4 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -73,6 +73,8 @@ struct perf_env {
 
 int perf_env__read_cpu_topology_map(struct perf_env *env);
 
+int perf_env__read_common(struct perf_env *env);
+
 void cpu_cache_level__free(struct cpu_cache_level *cache);
 
 const char *perf_env__arch(struct perf_env *env);
-- 
1.9.1
