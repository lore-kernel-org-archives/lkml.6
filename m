Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AH8x226fRib4urdCsNMBi06FDIZDaupW54+I535M3suRmHbJBJocJQD1L8JObB4pYIZMFQJAy8sW
ARC-Seal: i=1; a=rsa-sha256; t=1518714049; cv=none;
        d=google.com; s=arc-20160816;
        b=ieMOj0slYM2gHLcLQ7NDSMs3aofxhkRTBL5cDwKeZtxpwn9J583plzZO6R5GGVZThf
         e3FgsFOtD67t6LHS6krrikSc1fWFOmSE5Ursa1zeDwlB+PnA27xQMpH0pOKujUsDLC/N
         HJoPE5rJemR3Q3Gn2Y+jMl/HqJ5hi0Su+uOpXnP+RpfVXH2ehzFGoWyshiBOCQxsfNSj
         TvYzIeXODfARS0xk328LIey/JyJpIYp7hbFiL+wQ203Rb3mMfmpKZYs335A9ES+PspFT
         NgEtlJ22zQXqL1dF+T3hXBk8eSWjw2qkidb/cVgKv+MhpFpw54+UFcThgDZ2USQpe62O
         5Rgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=pURwZi1uEwvE1x8RDR5wM4of+423yULw1TtJn6LFJ3w=;
        b=jZEBfAK95PKIQ4Bbk6edJ7VIORUGdbdPkquWOlwt6PNw8Tw4B+JlUvB4RyutsDu/YS
         Abq36sKJnTeyqhltgygnZ8QvpUArm+Irsy4ebS240gByVMEXMUsVcHLrWnR9sge2bmoH
         XmbIYAKt3nxYVn4VAwO7U9O98pgjh/eiTGKc4qDrYmDMSCurqmFw4ZGlX2qaiLESGm/N
         LH7PAL9RuZet2SpaECIPi6GD4DSZTgyA5z0Ht4/8y1J7zL5SIe+gViysDfeR++M7DUSv
         GFDEjJqCPjCZ7b4hDYvtj95LNAzKYpGePhwJfTCOrIhdUv7/nlyDxR/cgFkwNuc18a1A
         5yxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=QzJQWlGK;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=QzJQWlGK;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vbabka@suse.cz, bharata@linux.vnet.ibm.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        bhe@redhat.com
Subject: [v4 5/6] mm/memory_hotplug: don't read nid from struct page during hotplug
Date: Thu, 15 Feb 2018 11:59:19 -0500
Message-Id: <20180215165920.8570-6-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215165920.8570-1-pasha.tatashin@oracle.com>
References: <20180215165920.8570-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8806 signatures=668672
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=902
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802150205
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592487103505854531?=
X-GMAIL-MSGID: =?utf-8?q?1592487103505854531?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

During memory hotplugging the probe routine will leave struct pages
uninitialized, the same as it is currently done during boot. Therefore, we
do not want to access the inside of struct pages before
__init_single_page() is called during onlining.

Because during hotplug we know that pages in one memory block belong to
the same numa node, we can skip the checking. We should keep checking for
the boot case.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 drivers/base/memory.c |  2 +-
 drivers/base/node.c   | 22 +++++++++++++++-------
 include/linux/node.h  |  4 ++--
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index deb3f029b451..a14fb0cd424a 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
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
-- 
2.16.1
