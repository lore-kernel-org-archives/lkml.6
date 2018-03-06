Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELtCohGj0zKPjw23bjWDpASb1CuN+TucAgNIjMwc85skbLBvrPSZjg25Jd/LpMFKWcjL3vkX
ARC-Seal: i=1; a=rsa-sha256; t=1520295998; cv=none;
        d=google.com; s=arc-20160816;
        b=Du1Uy1oGc/9FUsQjNhDTLhgBo38FyKRIj8HieF+j0Bc1QUo1qR1LdxzuEhXU8BtXHR
         D+xurp9s9egLsoVhmxZax3dFlzpz+oBSg7VGTV6XJX9O+3/GUhOUKTnZ3DFJkaDmw52a
         /lBodJXRmzzxv+tyvg5XonBaDV+0R5ZBsyKVidse8s3KRBBVPHHUTI/5XKAUjYcXNDrK
         aQ98WmJEuGt80YRc9J9kN+a9kcdQcwx1qFhxadGBMpYiWDctuPL7hZS0nwkXdjO2uIpl
         mKKuLi0Sf0pRFvAt85DvtXcXu+3/ebQbGcyNJ90ESMhjZgyzN5W/mSGH51Sb8S8WNGq0
         Jsgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=h3rVuypm5GbF87smHo84TfJO/0okRDVlkb7hgxNOebo=;
        b=ElVxM68ffl0/puDSlGIjAuy/TTz8SLPHVNDqqd2Z5lCA4dgMc3cuejEAQK2pJaFumo
         YRpKAoWjMaA4kM063jKUo4nmk7lNH4dRvT42aniviDyYXaodC0m6f6PfCeGSns10v/51
         NyzL+RvAXjiHYAh7fWdz2E4odevbY1zLIL0W3P1DNT2VNv6Ahx/rqZKGvEiwXc4Cb9D3
         oXdKYLDrLU8+i2df7HdIwDAdopxmoBEi3AH5REOiw0KY2vaSSuXuf5mMVFtXloMGqq36
         jdJ8WYlbT2D5RXR01yXRQ7uNhF93f64+iimk2BOZhkHQfZ3naJ3EVidVfkNvwQSCIUrI
         QTTA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=sIE1nrDo;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=sIE1nrDo;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 41/65] kaiser: vmstat show NR_KAISERTABLE as nr_overhead
Date: Mon,  5 Mar 2018 19:25:14 -0500
Message-Id: <20180306002538.1761-42-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=881
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145896844550676?=
X-GMAIL-MSGID: =?utf-8?q?1594145896844550676?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

The kaiser update made an interesting choice, never to free any shadow
page tables.  Contention on global spinlock was worrying, particularly
with it held across page table scans when freeing.  Something had to be
done: I was going to add refcounting; but simply never to free them is
an appealing choice, minimizing contention without complicating the code
(the more a page table is found already, the less the spinlock is used).

But leaking pages in this way is also a worry: can we get away with it?
At the very least, we need a count to show how bad it actually gets:
in principle, one might end up wasting about 1/256 of memory that way
(1/512 for when direct-mapped pages have to be user-mapped, plus 1/512
for when they are user-mapped from the vmalloc area on another occasion
(but we don't have vmalloc'ed stacks, so only large ldts are vmalloc'ed).

Add per-cpu stat NR_KAISERTABLE: including 256 at startup for the
shared pgd entries, and 1 for each intermediate page table added
thereafter for user-mapping - but leave out the 1 per mm, for its
shadow pgd, because that distracts from the monotonic increase.
Shown in /proc/vmstat as nr_overhead (0 if kaiser not enabled).

In practice, it doesn't look so bad so far: more like 1/12000 after
nine hours of gtests below; and movable pageblock segregation should
tend to cluster the kaiser tables into a subset of the address space
(if not, they will be bad for compaction too).  But production may
tell a different story: keep an eye on this number, and bring back
lighter freeing if it gets out of control (maybe a shrinker).

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 3e3d38fd9832e82a8cb1a5b1154acfa43ac08d15)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/mm/kaiser.c   | 16 +++++++++++-----
 include/linux/mmzone.h |  3 ++-
 mm/vmstat.c            |  1 +
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/kaiser.c b/arch/x86/mm/kaiser.c
index 8996f3292596..50d650799f39 100644
--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -122,9 +122,11 @@ static pte_t *kaiser_pagetable_walk(unsigned long address, bool is_atomic)
 		if (!new_pmd_page)
 			return NULL;
 		spin_lock(&shadow_table_allocation_lock);
-		if (pud_none(*pud))
+		if (pud_none(*pud)) {
 			set_pud(pud, __pud(_KERNPG_TABLE | __pa(new_pmd_page)));
-		else
+			__inc_zone_page_state(virt_to_page((void *)
+						new_pmd_page), NR_KAISERTABLE);
+		} else
 			free_page(new_pmd_page);
 		spin_unlock(&shadow_table_allocation_lock);
 	}
@@ -140,9 +142,11 @@ static pte_t *kaiser_pagetable_walk(unsigned long address, bool is_atomic)
 		if (!new_pte_page)
 			return NULL;
 		spin_lock(&shadow_table_allocation_lock);
-		if (pmd_none(*pmd))
+		if (pmd_none(*pmd)) {
 			set_pmd(pmd, __pmd(_KERNPG_TABLE | __pa(new_pte_page)));
-		else
+			__inc_zone_page_state(virt_to_page((void *)
+						new_pte_page), NR_KAISERTABLE);
+		} else
 			free_page(new_pte_page);
 		spin_unlock(&shadow_table_allocation_lock);
 	}
@@ -206,11 +210,13 @@ static void __init kaiser_init_all_pgds(void)
 	pgd = native_get_shadow_pgd(pgd_offset_k((unsigned long )0));
 	for (i = PTRS_PER_PGD / 2; i < PTRS_PER_PGD; i++) {
 		pgd_t new_pgd;
-		pud_t *pud = pud_alloc_one(&init_mm, PAGE_OFFSET + i * PGDIR_SIZE);
+		pud_t *pud = pud_alloc_one(&init_mm,
+					   PAGE_OFFSET + i * PGDIR_SIZE);
 		if (!pud) {
 			WARN_ON(1);
 			break;
 		}
+		inc_zone_page_state(virt_to_page(pud), NR_KAISERTABLE);
 		new_pgd = __pgd(_KERNPG_TABLE |__pa(pud));
 		/*
 		 * Make sure not to stomp on some other pgd entry.
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 54d74f6eb233..42c56e0c947f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -131,8 +131,9 @@ enum zone_stat_item {
 	NR_SLAB_RECLAIMABLE,
 	NR_SLAB_UNRECLAIMABLE,
 	NR_PAGETABLE,		/* used for pagetables */
-	NR_KERNEL_STACK,
 	/* Second 128 byte cacheline */
+	NR_KERNEL_STACK,
+	NR_KAISERTABLE,
 	NR_UNSTABLE_NFS,	/* NFS unstable pages */
 	NR_BOUNCE,
 	NR_VMSCAN_WRITE,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4f5cd974e11a..8e0cbcd0fccc 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -714,6 +714,7 @@ const char * const vmstat_text[] = {
 	"nr_slab_unreclaimable",
 	"nr_page_table_pages",
 	"nr_kernel_stack",
+	"nr_overhead",
 	"nr_unstable",
 	"nr_bounce",
 	"nr_vmscan_write",
-- 
2.16.2
