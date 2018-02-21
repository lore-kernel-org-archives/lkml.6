Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227DOcXKT8ymXS+zqfCxwR5gReYk56OVm8XQ24uzmKDe6Fw30H/+tU4T1ei0lqscMZsieZZ0
ARC-Seal: i=1; a=rsa-sha256; t=1519217908; cv=none;
        d=google.com; s=arc-20160816;
        b=cizd0EYwEdrTb7xq/Osa3DXBGdvSOQLpm3rTvZMaLqIBLj8U43QRj+TabSH2aqxj0v
         yIRn7xzLolcCM+ZVW2tEije7k4X3QmN6uds0GBABnLdsPHQW5UWRaX7vYQ7OQHDGtO0q
         ZVb1sv2F4R40NOg0HS15NOoGmjZSlwkx0XxcD8RKVrHhEyXJRU7jPv2TDROT9CUSY9SE
         Ok3/6Wb1LTkW4AnCuGrW3mWXaJ7O58cCaLRv9SrLm5Kd90jNqeyN8zP6c2hhwr/Sprv0
         +CzNcShBnKqPnpou8gXOIfL+Ac09wI/ZheDYt0qYF1qhqBsfCJ6gYk3mygf8eMEpn3LO
         cMVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0lRoQ57F3IN2evr0VjxGYpEgWdc1wKd82UDzcm6cIPk=;
        b=TuPLyp1rCOYzOg0zFe/ARY0p6Clt0xpyZFtrqNFgTfB+BgkOQ6OqWhpfkZ78hZhte/
         PrEgi8ULJfLz1NXNTk3e3+ju5sLSJ333RZVzGIr/wlhYlFP6z/LcbgP9RRhsNZYTd7UH
         SWLChRTLOfV9D6af0rf89tlnqs2Suf7HUFJKN4dua3ydf0NWjUYnbEndDd0zmSfe2rKo
         tQ9KmpOtWEjEWpGMVeAvLrp0CFA4nqwdkSGj6Y4uspgjjYagvqZ4g6QIBhNDR1Lsnehu
         3/ZW8h9ielzUXK1J5I7ckmtMj4D6Qls34X1lFo6cBEmcPRboj3cG4N1iiMVKYNkhePSE
         zWmA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nathan Fontenot <nfont@linux.vnet.ibm.com>,
	Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 020/167] powerpc/numa: Invalidate numa_cpu_lookup_table on cpu remove
Date: Wed, 21 Feb 2018 13:47:11 +0100
Message-Id: <20180221124525.710499299@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015437529564475?=
X-GMAIL-MSGID: =?utf-8?q?1593015437529564475?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Fontenot <nfont@linux.vnet.ibm.com>

commit 1d9a090783bef19fe8cdec878620d22f05191316 upstream.

When DLPAR removing a CPU, the unmapping of the cpu from a node in
unmap_cpu_from_node() should also invalidate the CPUs entry in the
numa_cpu_lookup_table. There is not a guarantee that on a subsequent
DLPAR add of the CPU the associativity will be the same and thus
could be in a different node. Invalidating the entry in the
numa_cpu_lookup_table causes the associativity to be read from the
device tree at the time of the add.

The current behavior of not invalidating the CPUs entry in the
numa_cpu_lookup_table can result in scenarios where the the topology
layout of CPUs in the partition does not match the device tree
or the topology reported by the HMC.

This bug looks like it was introduced in 2004 in the commit titled
"ppc64: cpu hotplug notifier for numa", which is 6b15e4e87e32 in the
linux-fullhist tree. Hence tag it for all stable releases.

Cc: stable@vger.kernel.org
Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/include/asm/topology.h          |    5 +++++
 arch/powerpc/mm/numa.c                       |    5 -----
 arch/powerpc/platforms/pseries/hotplug-cpu.c |    2 ++
 3 files changed, 7 insertions(+), 5 deletions(-)

--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -44,6 +44,11 @@ extern int sysfs_add_device_to_node(stru
 extern void sysfs_remove_device_from_node(struct device *dev, int nid);
 extern int numa_update_cpu_topology(bool cpus_locked);
 
+static inline void update_numa_cpu_lookup_table(unsigned int cpu, int node)
+{
+	numa_cpu_lookup_table[cpu] = node;
+}
+
 static inline int early_cpu_to_node(int cpu)
 {
 	int nid;
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -142,11 +142,6 @@ static void reset_numa_cpu_lookup_table(
 		numa_cpu_lookup_table[cpu] = -1;
 }
 
-static void update_numa_cpu_lookup_table(unsigned int cpu, int node)
-{
-	numa_cpu_lookup_table[cpu] = node;
-}
-
 static void map_cpu_to_node(int cpu, int node)
 {
 	update_numa_cpu_lookup_table(cpu, node);
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -36,6 +36,7 @@
 #include <asm/xics.h>
 #include <asm/xive.h>
 #include <asm/plpar_wrappers.h>
+#include <asm/topology.h>
 
 #include "pseries.h"
 #include "offline_states.h"
@@ -331,6 +332,7 @@ static void pseries_remove_processor(str
 			BUG_ON(cpu_online(cpu));
 			set_cpu_present(cpu, false);
 			set_hard_smp_processor_id(cpu, -1);
+			update_numa_cpu_lookup_table(cpu, -1);
 			break;
 		}
 		if (cpu >= nr_cpu_ids)
