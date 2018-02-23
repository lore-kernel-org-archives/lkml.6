Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519413817-2-13113114645963783967
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519413816; b=BY8S4RGMf6a6BOi0hpW84x/FFnvaNULFy9AzGEdatyNIsn3
    ulG2uUD8FLfvYptU3k69i/qkN++GyxeXM/4/D2o59ttPWDH6P4Y37506CGYZOOzT
    52zP+ChghNZ/CFltJakEFGO6kwWqhhDc/M3sLsbY1wTuBP9qfggr75jQGPKYWIP4
    DsJgyakZ5VOicdlf7dcYkVOu6Mw/urlRuvRKfHSjVsXC3L6W5TFbBVNlassGJ2gK
    Rl9UTVl7WhpUz9zUskGcAOut0ysbZaET5TCNFDHqahp+lTyQ6zyzgfJwr7Y+Qv9u
    0CcFpBZpt02+pMyIaQ8I6rTLjyupyZEycqMDmMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413816; bh=O3NJgNM/nJOJnxErQDSJtALblp
    eQdVKcLEAstKv9eNE=; b=aiAeNEO91mWqbvuZ5m4r07+LoA0d34d019ANabQ5YU
    rY+bVZ4W/sE0hA0+ljGopGGCtxTOsZH8gmVOjvF8s5lyRzvlpfqVMCxyru/nw/WB
    pIj5NagX52c5O3B4sYXMri2+96Vcc6wwN64Cnbo/Ue/AFVYWQxIrYbptRPwocfXi
    hqMs6S1okfH84RfPTrhtZmAR7D9EQn88UvfpRkh2Sk04tt//K/BwBYjfo5q0a9sK
    zF1UT0z/idRaw9dYjjCRx/KusSB8CmFXnq97y3W35YZnbWr8rQkOuFlL608a/kOS
    GDqtiAdfYX1ECpmwcvCc6FbofsHARJugTzB/QYTNNmbA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935392AbeBWSx0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:53:26 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47330 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935345AbeBWSxY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:53:24 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Balamuruhan S <bala24@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 074/159] perf bench numa: Fixup discontiguous/sparse numa nodes
Date: Fri, 23 Feb 2018 19:26:22 +0100
Message-Id: <20180223170752.562694504@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/bench/numa.c |   56 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 5 deletions(-)

--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -216,6 +216,47 @@ static const char * const numa_usage[] =
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
@@ -244,12 +285,12 @@ static cpu_set_t bind_to_cpu(int target_
 
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
@@ -649,7 +690,7 @@ static int parse_setup_node_list(void)
 			int i;
 
 			for (i = 0; i < mul; i++) {
-				if (t >= g->p.nr_tasks) {
+				if (t >= g->p.nr_tasks || !node_has_cpus(bind_node)) {
 					printf("\n# NOTE: ignoring bind NODEs starting at NODE#%d\n", bind_node);
 					goto out;
 				}
@@ -964,6 +1005,8 @@ static void calc_convergence(double runt
 	sum = 0;
 
 	for (node = 0; node < g->p.nr_nodes; node++) {
+		if (!is_node_present(node))
+			continue;
 		nr = nodes[node];
 		nr_min = min(nr, nr_min);
 		nr_max = max(nr, nr_max);
@@ -984,8 +1027,11 @@ static void calc_convergence(double runt
 	process_groups = 0;
 
 	for (node = 0; node < g->p.nr_nodes; node++) {
-		int processes = count_node_processes(node);
+		int processes;
 
+		if (!is_node_present(node))
+			continue;
+		processes = count_node_processes(node);
 		nr = nodes[node];
 		tprintf(" %2d/%-2d", nr, processes);
 
@@ -1291,7 +1337,7 @@ static void print_summary(void)
 
 	printf("\n ###\n");
 	printf(" # %d %s will execute (on %d nodes, %d CPUs):\n",
-		g->p.nr_tasks, g->p.nr_tasks == 1 ? "task" : "tasks", g->p.nr_nodes, g->p.nr_cpus);
+		g->p.nr_tasks, g->p.nr_tasks == 1 ? "task" : "tasks", nr_numa_nodes(), g->p.nr_cpus);
 	printf(" #      %5dx %5ldMB global  shared mem operations\n",
 			g->p.nr_loops, g->p.bytes_global/1024/1024);
 	printf(" #      %5dx %5ldMB process shared mem operations\n",
