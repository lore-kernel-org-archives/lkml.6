Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/fDcPxtAM6QYcmDfR2h8/pr3SswBqIRPbMwv0qhYGu477bj0awIc1YkSFpxSPBCchRjXfp
ARC-Seal: i=1; a=rsa-sha256; t=1524652869; cv=none;
        d=google.com; s=arc-20160816;
        b=eWjI14+3iD4AX3IvsbvK4h0x5Tc15OXpoF8qfTtg+yAL1Hh2T2+xpzX5Q89df9iNzu
         LLEhWZgAw4vA6fGU6XGHeyW/lE7qM29S1GUf4b9ny3PzbNuQ457HIUwJTCKjLt9H6Z4N
         EGO7XfuDmqie2ekqZI5rWTtbWaEx1lncJIH9H8TWyFVFyGBs4fN8SSPVMwrq5UqGA+qL
         nfl4Q3iPxkgTI+eWqMqKE/cWL4K9Bw7raOq2JLqc+MjNHzI9YA7WPA6hFiQ3KU2SEpk4
         DSU2wT3YOSx0SH5byTFRRWsFO0+FHPo0ZB49eGpQ/Tagj/qhtaGrqw4t9IxEB+y4q+DD
         UWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=j6NszllqN994Mb0cauIX2KLsXy6o9OJkgtNucAeeaRY=;
        b=D20TD+SYMY5NA/i8VotDpOmyQes2nMzhYoErrNsdJjI1AXBGtZVrT6jPN7t5DZVxTn
         fYQqw0A2sbqrlVo3se1n8+ebQkBa5dfUWpkaSy2/R8O+7KK8PUyQMSMedXwl8pOukB7q
         NFP1SfQaqj2s2rM18iw7DIGXHmCsmnUqCaI0pb6lyZGVQ2NKyAM70nM0+lsUJKTj+haS
         j0iFshBKZgQw1FfCs/BCjPV0foXdCqbd6bAdmWN6M9VSGAOm6FBXpG+GGQeyWxtNW+gl
         0vGLu3L7JFHIrlGIcWBbmm1HzS1eTnsLlO4BMUp/sDRf9qlmtQdf9XmpBRD9O81YIjKF
         gb7A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Bringmann <mwb@linux.vnet.ibm.com>,
	Nathan Fontenot <nfont@linux.vnet.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 098/183] powerpc/numa: Ensure nodes initialized for hotplug
Date: Wed, 25 Apr 2018 12:35:18 +0200
Message-Id: <20180425103246.408802173@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714407688543391?=
X-GMAIL-MSGID: =?utf-8?q?1598714407688543391?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bringmann <mwb@linux.vnet.ibm.com>


[ Upstream commit ea05ba7c559c8e5a5946c3a94a2a266e9a6680a6 ]

This patch fixes some problems encountered at runtime with
configurations that support memory-less nodes, or that hot-add CPUs
into nodes that are memoryless during system execution after boot. The
problems of interest include:

* Nodes known to powerpc to be memoryless at boot, but to have CPUs in
  them are allowed to be 'possible' and 'online'. Memory allocations
  for those nodes are taken from another node that does have memory
  until and if memory is hot-added to the node.

* Nodes which have no resources assigned at boot, but which may still
  be referenced subsequently by affinity or associativity attributes,
  are kept in the list of 'possible' nodes for powerpc. Hot-add of
  memory or CPUs to the system can reference these nodes and bring
  them online instead of redirecting the references to one of the set
  of nodes known to have memory at boot.

Note that this software operates under the context of CPU hotplug. We
are not doing memory hotplug in this code, but rather updating the
kernel's CPU topology (i.e. arch_update_cpu_topology /
numa_update_cpu_topology). We are initializing a node that may be used
by CPUs or memory before it can be referenced as invalid by a CPU
hotplug operation. CPU hotplug operations are protected by a range of
APIs including cpu_maps_update_begin/cpu_maps_update_done,
cpus_read/write_lock / cpus_read/write_unlock, device locks, and more.
Memory hotplug operations, including try_online_node, are protected by
mem_hotplug_begin/mem_hotplug_done, device locks, and more. In the
case of CPUs being hot-added to a previously memoryless node, the
try_online_node operation occurs wholly within the CPU locks with no
overlap. Using HMC hot-add/hot-remove operations, we have been able to
add and remove CPUs to any possible node without failures. HMC
operations involve a degree self-serialization, though.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/mm/numa.c |   47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -546,7 +546,7 @@ static int numa_setup_cpu(unsigned long
 	nid = of_node_to_nid_single(cpu);
 
 out_present:
-	if (nid < 0 || !node_online(nid))
+	if (nid < 0 || !node_possible(nid))
 		nid = first_online_node;
 
 	map_cpu_to_node(lcpu, nid);
@@ -905,10 +905,8 @@ static void __init find_possible_nodes(v
 		goto out;
 
 	for (i = 0; i < numnodes; i++) {
-		if (!node_possible(i)) {
-			setup_node_data(i, 0, 0);
+		if (!node_possible(i))
 			node_set(i, node_possible_map);
-		}
 	}
 
 out:
@@ -1277,6 +1275,40 @@ static long vphn_get_associativity(unsig
 	return rc;
 }
 
+static inline int find_and_online_cpu_nid(int cpu)
+{
+	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
+	int new_nid;
+
+	/* Use associativity from first thread for all siblings */
+	vphn_get_associativity(cpu, associativity);
+	new_nid = associativity_to_nid(associativity);
+	if (new_nid < 0 || !node_possible(new_nid))
+		new_nid = first_online_node;
+
+	if (NODE_DATA(new_nid) == NULL) {
+#ifdef CONFIG_MEMORY_HOTPLUG
+		/*
+		 * Need to ensure that NODE_DATA is initialized for a node from
+		 * available memory (see memblock_alloc_try_nid). If unable to
+		 * init the node, then default to nearest node that has memory
+		 * installed.
+		 */
+		if (try_online_node(new_nid))
+			new_nid = first_online_node;
+#else
+		/*
+		 * Default to using the nearest node that has memory installed.
+		 * Otherwise, it would be necessary to patch the kernel MM code
+		 * to deal with more memoryless-node error conditions.
+		 */
+		new_nid = first_online_node;
+#endif
+	}
+
+	return new_nid;
+}
+
 /*
  * Update the CPU maps and sysfs entries for a single CPU when its NUMA
  * characteristics change. This function doesn't perform any locking and is
@@ -1344,7 +1376,6 @@ int numa_update_cpu_topology(bool cpus_l
 {
 	unsigned int cpu, sibling, changed = 0;
 	struct topology_update_data *updates, *ud;
-	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
 	cpumask_t updated_cpus;
 	struct device *dev;
 	int weight, new_nid, i = 0;
@@ -1379,11 +1410,7 @@ int numa_update_cpu_topology(bool cpus_l
 			continue;
 		}
 
-		/* Use associativity from first thread for all siblings */
-		vphn_get_associativity(cpu, associativity);
-		new_nid = associativity_to_nid(associativity);
-		if (new_nid < 0 || !node_online(new_nid))
-			new_nid = first_online_node;
+		new_nid = find_and_online_cpu_nid(cpu);
 
 		if (new_nid == numa_cpu_lookup_table[cpu]) {
 			cpumask_andnot(&cpu_associativity_changes_mask,
