Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12DAC282D8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 04:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A3E21773
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 04:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfBDEFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 23:05:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726578AbfBDEFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 23:05:08 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1443jPj117161
        for <linux-kernel@vger.kernel.org>; Sun, 3 Feb 2019 23:05:07 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qe99g81x8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 23:05:06 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 4 Feb 2019 04:05:05 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Feb 2019 04:05:02 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x14450kB54067368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 04:05:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71B0611C052;
        Mon,  4 Feb 2019 04:05:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 420A211C04A;
        Mon,  4 Feb 2019 04:04:58 +0000 (GMT)
Received: from bangoria.in.ibm.com (unknown [9.124.31.104])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Feb 2019 04:04:58 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     oleg@redhat.com, srikar@linux.vnet.ibm.com
Cc:     songliubraving@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, aneesh.kumar@linux.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        syzbot+1068f09c44d151250c33@syzkaller.appspotmail.com
Subject: [PATCH] Uprobes: Fix deadlock between delayed_uprobe_lock and fs_reclaim
Date:   Mon,  4 Feb 2019 09:36:14 +0530
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19020404-0020-0000-0000-00000311269C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020404-0021-0000-0000-000021622FD2
Message-Id: <20190204040614.20450-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-04_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902040032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There can be a deadlock between delayed_uprobe_lock and
fs_reclaim like:

   CPU0                         CPU1
   ----                         ----
   lock(fs_reclaim);
                                lock(delayed_uprobe_lock);
                                lock(fs_reclaim);
   lock(delayed_uprobe_lock);

Here CPU0 is a file system code path which results in
mmput()->__mmput()->uprobe_clear_state() with fs_reclaim
locked. And, CPU1 is a uprobe event creation path.

This was reported by syzbot at [1]. Though, the reproducer
is nither available by syzbot nor I can reproduce it locally.

Callchains from syzbot report:

  -> #1 (fs_reclaim){+.+.}:
     __fs_reclaim_acquire mm/page_alloc.c:3730 [inline]
     fs_reclaim_acquire.part.97+0x24/0x30 mm/page_alloc.c:3741
     fs_reclaim_acquire+0x14/0x20 mm/page_alloc.c:3742
     slab_pre_alloc_hook mm/slab.h:418 [inline]
     slab_alloc mm/slab.c:3378 [inline]
     kmem_cache_alloc_trace+0x2d/0x750 mm/slab.c:3618
     kmalloc include/linux/slab.h:546 [inline]
     kzalloc include/linux/slab.h:741 [inline]
     delayed_uprobe_add kernel/events/uprobes.c:313 [inline]
     update_ref_ctr+0x36f/0x590 kernel/events/uprobes.c:447
     uprobe_write_opcode+0x94b/0xc50 kernel/events/uprobes.c:496
     set_swbp+0x2a/0x40
     install_breakpoint.isra.24+0x161/0x840 kernel/events/uprobes.c:885
     register_for_each_vma+0xa38/0xee0 kernel/events/uprobes.c:1041
     uprobe_apply+0xee/0x140 kernel/events/uprobes.c:1192
     uprobe_perf_open kernel/trace/trace_uprobe.c:1087 [inline]
     trace_uprobe_register+0x771/0xcf0 kernel/trace/trace_uprobe.c:1227
     perf_trace_event_open kernel/trace/trace_event_perf.c:181 [inline]
     perf_trace_event_init+0x1a5/0x990 kernel/trace/trace_event_perf.c:203
     perf_uprobe_init+0x1f1/0x280 kernel/trace/trace_event_perf.c:329
     perf_uprobe_event_init+0x106/0x1a0 kernel/events/core.c:8503
     perf_try_init_event+0x137/0x2f0 kernel/events/core.c:9770
     perf_init_event kernel/events/core.c:9801 [inline]
     perf_event_alloc.part.94+0x1d54/0x3740 kernel/events/core.c:10074
     perf_event_alloc kernel/events/core.c:10430 [inline]
     __do_sys_perf_event_open+0xada/0x3020 kernel/events/core.c:10531
     __se_sys_perf_event_open kernel/events/core.c:10420 [inline]
     __x64_sys_perf_event_open+0xbe/0x150 kernel/events/core.c:10420
     do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
     entry_SYSCALL_64_after_hwframe+0x49/0xbe

  -> #0 (delayed_uprobe_lock){+.+.}:
     lock_acquire+0x1ed/0x520 kernel/locking/lockdep.c:3844
     __mutex_lock_common kernel/locking/mutex.c:925 [inline]
     __mutex_lock+0x166/0x16f0 kernel/locking/mutex.c:1072
     mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
     uprobe_clear_state+0xb4/0x390 kernel/events/uprobes.c:1511
     __mmput kernel/fork.c:1041 [inline]
     mmput+0x1bc/0x610 kernel/fork.c:1066
     binder_alloc_free_page+0x5ab/0x1520 drivers/android/binder_alloc.c:983
     __list_lru_walk_one+0x29d/0x8c0 mm/list_lru.c:234
     list_lru_walk_one+0xa5/0xe0 mm/list_lru.c:278
     list_lru_walk_node+0x43/0x280 mm/list_lru.c:307
     list_lru_walk include/linux/list_lru.h:214 [inline]
     binder_shrink_scan+0x164/0x220 drivers/android/binder_alloc.c:1019
     do_shrink_slab+0x501/0xd30 mm/vmscan.c:557
     shrink_slab+0x389/0x8c0 mm/vmscan.c:706
     shrink_node+0x431/0x16b0 mm/vmscan.c:2758
     shrink_zones mm/vmscan.c:2987 [inline]
     do_try_to_free_pages+0x3e7/0x1290 mm/vmscan.c:3049
     try_to_free_pages+0x4d0/0xb90 mm/vmscan.c:3264
     __perform_reclaim mm/page_alloc.c:3773 [inline]
     __alloc_pages_direct_reclaim mm/page_alloc.c:3795 [inline]
     __alloc_pages_slowpath+0xa48/0x2de0 mm/page_alloc.c:4185
     __alloc_pages_nodemask+0xad8/0xea0 mm/page_alloc.c:4393
     __alloc_pages include/linux/gfp.h:473 [inline]
     __alloc_pages_node include/linux/gfp.h:486 [inline]
     khugepaged_alloc_page+0x95/0x190 mm/khugepaged.c:773
     collapse_huge_page mm/khugepaged.c:963 [inline]
     khugepaged_scan_pmd+0x1715/0x3d60 mm/khugepaged.c:1216
     khugepaged_scan_mm_slot mm/khugepaged.c:1725 [inline]
     khugepaged_do_scan mm/khugepaged.c:1806 [inline]
     khugepaged+0xf20/0x1750 mm/khugepaged.c:1851
     kthread+0x35a/0x440 kernel/kthread.c:246
     ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1876397.html

Reported-by: syzbot+1068f09c44d151250c33@syzkaller.appspotmail.com
Suggested-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 kernel/events/uprobes.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 8aef47ee7bfa..8be39a83d83a 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -95,6 +95,11 @@ struct delayed_uprobe {
 	struct mm_struct *mm;
 };
 
+/*
+ * Any memory allocation happening within lock(delayed_uprobe_lock)
+ * must use memalloc_nofs_save()/memalloc_nofs_restore() to avoid
+ * calling file system code from memory allocation code.
+ */
 static DEFINE_MUTEX(delayed_uprobe_lock);
 static LIST_HEAD(delayed_uprobe_list);
 
@@ -429,6 +434,7 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
 	struct vm_area_struct *rc_vma;
 	unsigned long rc_vaddr;
 	int ret = 0;
+	unsigned int nofs_flags;
 
 	rc_vma = find_ref_ctr_vma(uprobe, mm);
 
@@ -442,12 +448,30 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
 			return ret;
 	}
 
+	/*
+	 * There is a possibility of deadlock here:
+	 *
+	 *   CPU0                         CPU1
+	 *   ----                         ----
+	 *   lock(fs_reclaim);
+	 *                                lock(delayed_uprobe_lock);
+	 *                                lock(fs_reclaim);
+	 *   lock(delayed_uprobe_lock);
+	 *
+	 * Here CPU0 is a file system code path which results in
+	 * mmput()->__mmput()->uprobe_clear_state() with fs_reclaim locked.
+	 * And, CPU1 is a uprobe event creation path.
+	 *
+	 * Avoid calling into filesystem code inside lock(delayed_uprobe_lock).
+	 */
+	nofs_flags = memalloc_nofs_save();
 	mutex_lock(&delayed_uprobe_lock);
 	if (d > 0)
 		ret = delayed_uprobe_add(uprobe, mm);
 	else
 		delayed_uprobe_remove(uprobe, mm);
 	mutex_unlock(&delayed_uprobe_lock);
+	memalloc_nofs_restore(nofs_flags);
 
 	return ret;
 }
-- 
2.20.1

