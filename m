Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELugTekti3zL7cR93GXLR9hTjOIVicu0G+Jgfn5uictWIgr6Faqca+10zQ8KJb3waoMG/oEt
ARC-Seal: i=1; a=rsa-sha256; t=1519787017; cv=none;
        d=google.com; s=arc-20160816;
        b=SgT5bs5jgQlh9Q78jlOdblLKCQrd3Q4MT1ii2S8SV0jQaB7qnJoqEoMCYCFP7zAXhR
         GVkft2xz8pfN7Bit129wXkcRV/rf7Llw920EdlP6xXNTSavzGPox0y/v3Z08M7+mcrpV
         /DQcA8i4bYxhljHmX0ZqTG5ODAxGeYsz6HZ7cwPN4PzA9iqZ+bCLKNMkLnfuTNnGQlud
         brQfRq4QrTUoGnL2iAjz1q3E4y3ISLv3zUJ0Owkbd7Q8kZiDIhCZm7CY7LZZSwN5i2HB
         8pv/gZMTjrLmDsYn8qyfsNiVueXrecYqw9RxEzCtIaX/iAqnYDsbifFT7yxcg2MFKdgq
         K0Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=BARZaWAYmRBlfxTDfzInkRkkokoO+lReIGIJwO2Powg=;
        b=lvIcypswR3CG13zos9UL+XUqOBB0zByKzi0texMNNJvTm6o743+5orcDTE+FP8daXL
         jJ7jzunCjjAsdPB1W1Q9CP/XD0Y5rlkgVxlZXi/2WPeWAxmfEE5xbfVqTDxo3UCbJ7A4
         Oo7fQP7iNCk+ExxQJv7mYGd7D9w6zkDP/CN5xb1wkPdO0ejFjuJy+EqYmYqs273RZXnm
         hDVTlxskTR1mkuC4IRp+SkAee7SGOrVZveXleLb7LuTg0SaTjDf7YfwB3nbbSax3BCVA
         lCQX4FcZTfMDH/dz2RuUeu/DdiXjfAt+Bg0xP9sLREwRNH3ek5E4qkaz5SF2tFphZ7x0
         cwIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=rJTrSJPV;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=rJTrSJPV;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vbabka@suse.cz, bharata@linux.vnet.ibm.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        bhe@redhat.com
Subject: [v5 5/6] mm/memory_hotplug: don't read nid from struct page during hotplug
Date: Tue, 27 Feb 2018 22:03:07 -0500
Message-Id: <20180228030308.1116-6-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180228030308.1116-1-pasha.tatashin@oracle.com>
References: <20180228030308.1116-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8817 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=781
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280034
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593612191295299696?=
X-GMAIL-MSGID: =?utf-8?q?1593612191295299696?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

register_mem_sect_under_node is careful to check the node id of each
pfn in the memblock range to handle configurations with interleaving
nodes. This is not really needed for the memory hotplug because hotadded
ranges are bound to a single NUMA node. We simply cannot handle
interleaving NUMA nodes in the same memblock currently and there are no
signs that anybody would want anything like that in future. That would
require much more refactoring.

This is a preparatory patch for later patches.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/base/memory.c  |  4 ++--
 drivers/base/node.c    | 22 +++++++++++++++-------
 include/linux/memory.h |  2 +-
 include/linux/node.h   |  4 ++--
 mm/memory_hotplug.c    |  2 +-
 5 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index deb3f029b451..79fcd2bae96b 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -712,7 +712,7 @@ static int add_memory_block(int base_section_nr)
  * need an interface for the VM to add new memory regions,
  * but without onlining it.
  */
-int register_new_memory(int nid, struct mem_section *section)
+int hotplug_memory_register(int nid, struct mem_section *section)
 {
 	int ret = 0;
 	struct memory_block *mem;
@@ -731,7 +731,7 @@ int register_new_memory(int nid, struct mem_section *section)
 	}
 
 	if (mem->section_count == sections_per_block)
-		ret = register_mem_sect_under_node(mem, nid);
+		ret = register_mem_sect_under_node(mem, nid, false);
 out:
 	mutex_unlock(&mem_sysfs_mutex);
 	return ret;
diff --git a/drivers/base/node.c b/drivers/base/node.c
index ee090ab9171c..d7cfc8d8a5c5 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -397,7 +397,8 @@ static int __ref get_nid_for_pfn(unsigned long pfn)
 }
 
 /* register memory section under specified node if it spans that node */
-int register_mem_sect_under_node(struct memory_block *mem_blk, int nid)
+int register_mem_sect_under_node(struct memory_block *mem_blk, int nid,
+				 bool check_nid)
 {
 	int ret;
 	unsigned long pfn, sect_start_pfn, sect_end_pfn;
@@ -423,11 +424,18 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, int nid)
 			continue;
 		}
 
-		page_nid = get_nid_for_pfn(pfn);
-		if (page_nid < 0)
-			continue;
-		if (page_nid != nid)
-			continue;
+		/*
+		 * We need to check if page belongs to nid only for the boot
+		 * case, during hotplug we know that all pages in the memory
+		 * block belong to the same node.
+		 */
+		if (check_nid) {
+			page_nid = get_nid_for_pfn(pfn);
+			if (page_nid < 0)
+				continue;
+			if (page_nid != nid)
+				continue;
+		}
 		ret = sysfs_create_link_nowarn(&node_devices[nid]->dev.kobj,
 					&mem_blk->dev.kobj,
 					kobject_name(&mem_blk->dev.kobj));
@@ -502,7 +510,7 @@ int link_mem_sections(int nid, unsigned long start_pfn, unsigned long nr_pages)
 
 		mem_blk = find_memory_block_hinted(mem_sect, mem_blk);
 
-		ret = register_mem_sect_under_node(mem_blk, nid);
+		ret = register_mem_sect_under_node(mem_blk, nid, true);
 		if (!err)
 			err = ret;
 
diff --git a/include/linux/memory.h b/include/linux/memory.h
index f71e732c77b2..9f8cd856ca1e 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -109,7 +109,7 @@ extern int register_memory_notifier(struct notifier_block *nb);
 extern void unregister_memory_notifier(struct notifier_block *nb);
 extern int register_memory_isolate_notifier(struct notifier_block *nb);
 extern void unregister_memory_isolate_notifier(struct notifier_block *nb);
-extern int register_new_memory(int, struct mem_section *);
+int hotplug_memory_register(int nid, struct mem_section *section);
 #ifdef CONFIG_MEMORY_HOTREMOVE
 extern int unregister_memory_section(struct mem_section *);
 #endif
diff --git a/include/linux/node.h b/include/linux/node.h
index 4ece0fee0ffc..41f171861dcc 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -67,7 +67,7 @@ extern void unregister_one_node(int nid);
 extern int register_cpu_under_node(unsigned int cpu, unsigned int nid);
 extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid);
 extern int register_mem_sect_under_node(struct memory_block *mem_blk,
-						int nid);
+						int nid, bool check_nid);
 extern int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
 					   unsigned long phys_index);
 
@@ -97,7 +97,7 @@ static inline int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)
 	return 0;
 }
 static inline int register_mem_sect_under_node(struct memory_block *mem_blk,
-							int nid)
+							int nid, bool check_nid)
 {
 	return 0;
 }
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 565048f496f7..477e183a4ac7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -279,7 +279,7 @@ static int __meminit __add_section(int nid, unsigned long phys_start_pfn,
 	if (!want_memblock)
 		return 0;
 
-	return register_new_memory(nid, __pfn_to_section(phys_start_pfn));
+	return hotplug_memory_register(nid, __pfn_to_section(phys_start_pfn));
 }
 
 /*
-- 
2.16.2
