Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752876AbeBTQRZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:17:25 -0500
Received: from mout.gmx.net ([212.227.15.15]:41899 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752854AbeBTQRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:17:24 -0500
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        linux-mm@kvack.org, Joel Stanley <joel@jms.id.au>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: [PATCH 3/6] powerpc: numa: Use the right #ifdef guards around functions
Date: Tue, 20 Feb 2018 17:14:21 +0100
Message-Id: <20180220161424.5421-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180220161424.5421-1-j.neuschaefer@gmx.net>
References: <20180220161424.5421-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:z+V7hx/ma+GqgunhROgGfc3ifHsd532RFZIN4Ul6yW2KNxMTQMx
 DsvseSnJNEHCQD9jLRc6Z1xi7eSTaJMXmDWjthBN/eUzra6w8Ri4BOwDekqnWqMa8N36Umr
 7Zmn0vrmIPFC2HSnhK/r9gwhwJ3lRUpm72NaWXtCw2KHQ3vdUpnH2nPTdsI/n/AltaoLLVP
 wn+QvUG0lOkLztWL/BlXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RhcgyLUoKYk=:SbX6NyHRYQfS8J3lB0CBIR
 kMDOZxiJ9zsrqDcjP5iFwbeP3qbDUUVksSAebkl3xEwOEZf3ybdmWjQNfciYA6tPSsfuWoj6T
 XijZ/z/3X6DrwMtw8ry7OU4EWtWGsQA4xG3FKUC0ygnDMCMjS5Ckql2n+mZNUq2iNznI3M5tz
 vmG1n3msQ+YE/bn1xXK8SzY2S7CAFosr65Bjo2aRgokEJtx7oOGkd9J7US+vlfqh4O5GiGRME
 O8amiOLuR6NbGSRKTKMLO5Ux0A/tg1jJ4t10I++wRt6eRF44/A93xQlLXwO/BwhsaXEgUH58u
 QAVG9yxZkLe1HRIWBU8XmONRkH15SNDVQ3bauWORfaGLt8tXtLb+4Fard2vVzrflQOkgjq7qA
 OAoY3222fpIGK2SCLT0wClMIEvjNDian3schxDdI5z1oRz026CpM/aIfUbzXsL63yx+/rxKkQ
 WMKOg+hSmWGwk5TxI8SWyxC9cEA2XlHa5tK/46nra/xSO4qCtBtuM2bVLc2KPj+T3QlKnAxHC
 4Fbj6BZBwUeCtwWAsg4uAC2N0kFc8bv4A/4oApXPyZ6gNUmaMzjLOGKLooF4cyS7Ox5ISMCxh
 8jpq9IW3SU8H7UT3p3W/XNBmlmh1ncl7DvVkkkQWW8d1sSPz2cCe1xZXc7KvScWkYHB2230Ow
 D7yelBoWeomEDdI5NIWUijIC6moD0VZW0QAyMw2wj+r+9kln55eQtB6ncY7ltW1zIYO+QQDlD
 PwyPPCdsCm6MQTOlE3V1Ocjm/geWNt1K5zCpojTEaMjyUcmV7u2w1OxRuOizkJeKDX8YpmirL
 VqUUQXyWoII/UXM7+11hFOSiPOtfMfXWI9s9DrTFcHQxkdhbBU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_node_to_nid and dump_numa_cpu_topology are declared inline in their
respective header files, if CONFIG_NUMA is not set. Thus it is only
valid to define these functions in numa.c if CONFIG_NUMA is set.
(numa.c, despite the name, isn't conditionalized on CONFIG_NUMA, but
CONFIG_NEED_MULTIPLE_NODES.)

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/powerpc/mm/numa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 0570bc2a0b13..df03a65b658f 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -254,6 +254,7 @@ static int of_node_to_nid_single(struct device_node *device)
 	return nid;
 }
 
+#ifdef CONFIG_NUMA
 /* Walk the device tree upwards, looking for an associativity id */
 int of_node_to_nid(struct device_node *device)
 {
@@ -272,6 +273,7 @@ int of_node_to_nid(struct device_node *device)
 	return nid;
 }
 EXPORT_SYMBOL(of_node_to_nid);
+#endif
 
 static int __init find_min_common_depth(void)
 {
@@ -744,6 +746,7 @@ static void __init setup_nonnuma(void)
 	}
 }
 
+#ifdef CONFIG_NUMA
 void __init dump_numa_cpu_topology(void)
 {
 	unsigned int node;
@@ -778,6 +781,7 @@ void __init dump_numa_cpu_topology(void)
 		pr_cont("\n");
 	}
 }
+#endif
 
 /* Initialize NODE_DATA for a node on the local memory */
 static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
-- 
2.16.1
