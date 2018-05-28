Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939413AbeE1OvG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937219AbeE1K2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:28:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 058/329] powerpc/numa: Use ibm,max-associativity-domains to discover possible nodes
Date: Mon, 28 May 2018 11:59:47 +0200
Message-Id: <20180528100247.506080168@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bringmann <mwb@linux.vnet.ibm.com>

[ Upstream commit a346137e9142b039fd13af2e59696e3d40c487ef ]

On powerpc systems which allow 'hot-add' of CPU or memory resources,
it may occur that the new resources are to be inserted into nodes that
were not used for these resources at bootup. In the kernel, any node
that is used must be defined and initialized. These empty nodes may
occur when,

* Dedicated vs. shared resources. Shared resources require information
  such as the VPHN hcall for CPU assignment to nodes. Associativity
  decisions made based on dedicated resource rules, such as
  associativity properties in the device tree, may vary from decisions
  made using the values returned by the VPHN hcall.

* memoryless nodes at boot. Nodes need to be defined as 'possible' at
  boot for operation with other code modules. Previously, the powerpc
  code would limit the set of possible nodes to those which have
  memory assigned at boot, and were thus online. Subsequent add/remove
  of CPUs or memory would only work with this subset of possible
  nodes.

* memoryless nodes with CPUs at boot. Due to the previous restriction
  on nodes, nodes that had CPUs but no memory were being collapsed
  into other nodes that did have memory at boot. In practice this
  meant that the node assignment presented by the runtime kernel
  differed from the affinity and associativity attributes presented by
  the device tree or VPHN hcalls. Nodes that might be known to the
  pHyp were not 'possible' in the runtime kernel because they did not
  have memory at boot.

This patch ensures that sufficient nodes are defined to support
configuration requirements after boot, as well as at boot. This patch
set fixes a couple of problems.

* Nodes known to powerpc to be memoryless at boot, but to have CPUs in
  them are allowed to be 'possible' and 'online'. Memory allocations
  for those nodes are taken from another node that does have memory
  until and if memory is hot-added to the node. * Nodes which have no
  resources assigned at boot, but which may still be referenced
  subsequently by affinity or associativity attributes, are kept in
  the list of 'possible' nodes for powerpc. Hot-add of memory or CPUs
  to the system can reference these nodes and bring them online
  instead of redirecting to one of the set of nodes that were known to
  have memory at boot.

This patch extracts the value of the lowest domain level (number of
allocable resources) from the device tree property
"ibm,max-associativity-domains" to use as the maximum number of nodes
to setup as possibly available in the system. This new setting will
override the instruction:

    nodes_and(node_possible_map, node_possible_map, node_online_map);

presently seen in the function arch/powerpc/mm/numa.c:initmem_init().

If the "ibm,max-associativity-domains" property is not present at
boot, no operation will be performed to define or enable additional
nodes, or enable the above 'nodes_and()'.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/mm/numa.c |   37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -904,6 +904,34 @@ static void __init setup_node_data(int n
 	NODE_DATA(nid)->node_spanned_pages = spanned_pages;
 }
 
+static void __init find_possible_nodes(void)
+{
+	struct device_node *rtas;
+	u32 numnodes, i;
+
+	if (min_common_depth <= 0)
+		return;
+
+	rtas = of_find_node_by_path("/rtas");
+	if (!rtas)
+		return;
+
+	if (of_property_read_u32_index(rtas,
+				"ibm,max-associativity-domains",
+				min_common_depth, &numnodes))
+		goto out;
+
+	for (i = 0; i < numnodes; i++) {
+		if (!node_possible(i)) {
+			setup_node_data(i, 0, 0);
+			node_set(i, node_possible_map);
+		}
+	}
+
+out:
+	of_node_put(rtas);
+}
+
 void __init initmem_init(void)
 {
 	int nid, cpu;
@@ -917,12 +945,15 @@ void __init initmem_init(void)
 	memblock_dump_all();
 
 	/*
-	 * Reduce the possible NUMA nodes to the online NUMA nodes,
-	 * since we do not support node hotplug. This ensures that  we
-	 * lower the maximum NUMA node ID to what is actually present.
+	 * Modify the set of possible NUMA nodes to reflect information
+	 * available about the set of online nodes, and the set of nodes
+	 * that we expect to make use of for this platform's affinity
+	 * calculations.
 	 */
 	nodes_and(node_possible_map, node_possible_map, node_online_map);
 
+	find_possible_nodes();
+
 	for_each_online_node(nid) {
 		unsigned long start_pfn, end_pfn;
 
