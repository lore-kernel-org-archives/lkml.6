Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtceD49b/AdRhuZgrcRS/K4Al9m1IKsI1FJJERCBYCsVVaFuAg7zU7Da7Q8YQV5I9KxINR0
ARC-Seal: i=1; a=rsa-sha256; t=1519410936; cv=none;
        d=google.com; s=arc-20160816;
        b=suMwLm3VlomE7cdpjfmexzlxlrD7AH7GJeA09rYspC+4xbE+hlSbdFag1s1QFFkZSD
         LsE4Y9xduGeXcW7mf08oyfqIgqIX6B6SqQ5nysGfq3ZWXIdSH8Po4tQuXdQKX8O45ULP
         JEgJCjWYFM1mHWqsBqvoCaX03IwSRMkrPPojB6mYz3aKxW6tBPQD4dqk5WhITJ0cncJQ
         /02K2f0enf2zLzb+ilfrqf9WDixfSaCC0RmXEd/zBXQ+t3zIQgdkUh6NKficrjg+yMlm
         lVZVzEiC4QQRxLXMYM9wSp2sC3UEraCMlrPzH7L3dpvU/MNz+RKovKQxNCAccrK7z2jQ
         cPDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zBJCaw1nUTM3uMhYLjo4iGphpSQ+v3yBpHca+Y0gwY8=;
        b=eA9FXjLMi+R+ZhtmVUFPSUvcNpM1Xv6+Wb9VGWwOPUAk07raaijM/lY9pZ0XURGrqP
         +vnRMQ/j4ngyLQG1lll9+NribCEUbCup6Duis2de8af0fLQ9+FmOVJvQjTOUT8AsDKYf
         /vu69mBGeCga9dUXj0qateTqhuKWYLvpm3N2xyNHvCqIZZme0iwb3OsseypVcp9IDTTP
         nkGD2/T+3jvO3P/relI8peOtITdzs7hfXDmco/YX5TzLYcZDn9iQw4mHO8+P07AD+WVe
         +eWfJ9ZURDe8WCR/1C7FVVLpnvF0x15nYlx8Q5awsMr3ckwxMAjd+7oTRurdfZq0PzlW
         eoLw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Balamuruhan S <bala24@linux.vnet.ibm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 036/193] perf bench numa: Fixup discontiguous/sparse numa nodes
Date: Fri, 23 Feb 2018 19:24:29 +0100
Message-Id: <20180223170331.756199134@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217587003347681?=
X-GMAIL-MSGID: =?utf-8?q?1593217842683299123?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>


[ Upstream commit 321a7c35c90cc834851ceda18a8ee18f1d032b92 ]

Certain systems are designed to have sparse/discontiguous nodes.  On
such systems, 'perf bench numa' hangs, shows wrong number of nodes and
shows values for non-existent nodes. Handle this by only taking nodes
that are exposed by kernel to userspace.

Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/1edbcd353c009e109e93d78f2f46381930c340fe.1511368645.git.sathnaga@linux.vnet.ibm.com
Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/bench/numa.c |   56 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 5 deletions(-)

--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -208,6 +208,47 @@ static const char * const numa_usage[] =
 	NULL
 };
 
+/*
+ * To get number of numa nodes present.
+ */
+static int nr_numa_nodes(void)
+{
+	int i, nr_nodes = 0;
+
+	for (i = 0; i < g->p.nr_nodes; i++) {
+		if (numa_bitmask_isbitset(numa_nodes_ptr, i))
+			nr_nodes++;
+	}
+
+	return nr_nodes;
+}
+
+/*
+ * To check if given numa node is present.
+ */
+static int is_node_present(int node)
+{
+	return numa_bitmask_isbitset(numa_nodes_ptr, node);
+}
+
+/*
+ * To check given numa node has cpus.
+ */
+static bool node_has_cpus(int node)
+{
+	struct bitmask *cpu = numa_allocate_cpumask();
+	unsigned int i;
+
+	if (cpu && !numa_node_to_cpus(node, cpu)) {
+		for (i = 0; i < cpu->size; i++) {
+			if (numa_bitmask_isbitset(cpu, i))
+				return true;
+		}
+	}
+
+	return false; /* lets fall back to nocpus safely */
+}
+
 static cpu_set_t bind_to_cpu(int target_cpu)
 {
 	cpu_set_t orig_mask, mask;
@@ -236,12 +277,12 @@ static cpu_set_t bind_to_cpu(int target_
 
 static cpu_set_t bind_to_node(int target_node)
 {
-	int cpus_per_node = g->p.nr_cpus/g->p.nr_nodes;
+	int cpus_per_node = g->p.nr_cpus / nr_numa_nodes();
 	cpu_set_t orig_mask, mask;
 	int cpu;
 	int ret;
 
-	BUG_ON(cpus_per_node*g->p.nr_nodes != g->p.nr_cpus);
+	BUG_ON(cpus_per_node * nr_numa_nodes() != g->p.nr_cpus);
 	BUG_ON(!cpus_per_node);
 
 	ret = sched_getaffinity(0, sizeof(orig_mask), &orig_mask);
@@ -641,7 +682,7 @@ static int parse_setup_node_list(void)
 			int i;
 
 			for (i = 0; i < mul; i++) {
-				if (t >= g->p.nr_tasks) {
+				if (t >= g->p.nr_tasks || !node_has_cpus(bind_node)) {
 					printf("\n# NOTE: ignoring bind NODEs starting at NODE#%d\n", bind_node);
 					goto out;
 				}
@@ -956,6 +997,8 @@ static void calc_convergence(double runt
 	sum = 0;
 
 	for (node = 0; node < g->p.nr_nodes; node++) {
+		if (!is_node_present(node))
+			continue;
 		nr = nodes[node];
 		nr_min = min(nr, nr_min);
 		nr_max = max(nr, nr_max);
@@ -976,8 +1019,11 @@ static void calc_convergence(double runt
 	process_groups = 0;
 
 	for (node = 0; node < g->p.nr_nodes; node++) {
-		int processes = count_node_processes(node);
+		int processes;
 
+		if (!is_node_present(node))
+			continue;
+		processes = count_node_processes(node);
 		nr = nodes[node];
 		tprintf(" %2d/%-2d", nr, processes);
 
@@ -1283,7 +1329,7 @@ static void print_summary(void)
 
 	printf("\n ###\n");
 	printf(" # %d %s will execute (on %d nodes, %d CPUs):\n",
-		g->p.nr_tasks, g->p.nr_tasks == 1 ? "task" : "tasks", g->p.nr_nodes, g->p.nr_cpus);
+		g->p.nr_tasks, g->p.nr_tasks == 1 ? "task" : "tasks", nr_numa_nodes(), g->p.nr_cpus);
 	printf(" #      %5dx %5ldMB global  shared mem operations\n",
 			g->p.nr_loops, g->p.bytes_global/1024/1024);
 	printf(" #      %5dx %5ldMB process shared mem operations\n",
