Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1520DC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14C420866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T8iqLWIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14C420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387765AbeKFCTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:19:35 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43556 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387603AbeKFCR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:17:27 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA5GsYIi052564;
        Mon, 5 Nov 2018 16:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=jxkC7rLLT5JE0Jtpp5a2UGIfbNY+hhiWsmmEye+YCsw=;
 b=T8iqLWIcT6mSMpnkQPq7gWEjNj1BYI7X7FJ73FI5DSg73jz2tZmbQk8hmJQpb4VJs0Yo
 C8HEbEo1PNSlzf6akxFswkhc7suHjR+pUMdR3ycD9+4ChKwCi+YMPAKzVtvYxzF6E54T
 ormXD6ufwf5U5YAV39XORznSYUVfH2hGcGdogyEGasAoqQAighyMFXGs//6idJzAYKdL
 3uHzOm6ntgeXU0zyzLGaFTyDbqpIduJp6qfRJT2eBhZcgAwH1ftyiF1b6GiBZ28m4LKh
 ITXmyL2q/0Xn6jRqYvByMIvI5LUzUeOeUelO5/YqiphEpWaGlua6ysZLjICtUcp0uG/O fw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2nh4aqg2ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Nov 2018 16:56:23 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA5GuMfm004956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Nov 2018 16:56:22 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA5GuLRt008448;
        Mon, 5 Nov 2018 16:56:21 GMT
Received: from localhost.localdomain (/73.60.114.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 08:56:21 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     linux-mm@kvack.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     aarcange@redhat.com, aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        daniel.m.jordan@oracle.com, darrick.wong@oracle.com,
        dave.hansen@linux.intel.com, jgg@mellanox.com, jwadams@google.com,
        jiangshanlai@gmail.com, mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        rdunlap@infradead.org, steven.sistare@oracle.com,
        tim.c.chen@intel.com, tj@kernel.org, vbabka@suse.cz
Subject: [RFC PATCH v4 09/13] vfio: relieve mmap_sem reader cacheline bouncing by holding it longer
Date:   Mon,  5 Nov 2018 11:55:54 -0500
Message-Id: <20181105165558.11698-10-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811050153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Profiling shows significant time being spent on atomic ops in mmap_sem
reader acquisition.  mmap_sem is taken and dropped for every single base
page during pinning, so this is not surprising.

Reduce the number of times mmap_sem is taken by holding for longer,
which relieves atomic cacheline bouncing.

Results for all VFIO page pinning patches
-----------------------------------------

The test measures the time from qemu invocation to the start of guest
boot.  The guest uses kvm with 320G memory backed with THP.  320G fits
in a node on the test machine used here, so there was no thrashing in
reclaim because of __GFP_THISNODE in THP allocations[1].

CPU:              2 nodes * 24 cores/node * 2 threads/core = 96 CPUs
                  Intel(R) Xeon(R) Platinum 8160 CPU @ 2.10GHz
memory:           754G split evenly between nodes
scaling_governor: performance

     patch 6                  patch 8                   patch 9 (this one)
     -----------------------  ------------------------  ------------------------
thr  speedup     average sec  speedup      average sec  speedup      average sec
  1            65.0 (± 0.6%)             65.2 (± 0.5%)             65.5 (± 0.4%)
  2     1.5x   42.8 (± 5.8%)     1.8x    36.0 (± 0.9%)     1.9x    34.4 (± 0.3%)
  3     1.9x   35.0 (±11.3%)     2.5x    26.4 (± 4.2%)     2.8x    23.7 (± 0.2%)
  4     2.3x   28.5 (± 1.3%)     3.1x    21.2 (± 2.8%)     3.6x    18.3 (± 0.3%)
  5     2.5x   26.2 (± 1.5%)     3.6x    17.9 (± 0.9%)     4.3x    15.1 (± 0.3%)
  6     2.7x   24.5 (± 1.8%)     4.0x    16.5 (± 3.0%)     5.1x    12.9 (± 0.1%)
  7     2.8x   23.5 (± 4.9%)     4.2x    15.4 (± 2.7%)     5.7x    11.5 (± 0.6%)
  8     2.8x   22.8 (± 1.8%)     4.2x    15.5 (± 4.7%)     6.4x    10.3 (± 0.8%)
 12     3.2x   20.2 (± 1.4%)     4.4x    14.7 (± 2.9%)     8.6x     7.6 (± 0.6%)
 16     3.3x   20.0 (± 0.7%)     4.3x    15.4 (± 1.3%)    10.2x     6.4 (± 0.6%)

At patch 6, lock_stat showed long reader wait time on mmap_sem writers,
leading to patch 8.

At patch 8, profiling revealed the issue with mmap_sem described above.

Across all three patches, performance consistently improves as the
thread count increases.  The one exception is the antiscaling with
nthr=16 in patch 8: those mmap_sem atomics are really bouncing around
the machine.

The performance with patch 9 looks pretty good overall.  I'm working on
finding the next bottleneck, and this is where it stopped:  When
nthr=16, the obvious issue profiling showed was contention on the split
PMD page table lock when pages are faulted in during the pinning (>2% of
the time).

A split PMD lock protects a PUD_SIZE-ed amount of page table mappings
(1G on x86), so if threads were operating on smaller chunks and
contending in the same PUD_SIZE range, this could be the source of
contention.  However, when nthr=16, threads operate on 5G chunks (320G /
16 threads / (1<<KTASK_LOAD_BAL_SHIFT)), so this wasn't the cause, and
aligning the chunks on PUD_SIZE boundaries didn't help either.

The time is short (6.4 seconds), so the next theory was threads
finishing at different times, but probes showed the threads all returned
within less than a millisecond of each other.

Kernel probes turned up a few smaller VFIO page pin calls besides the
heavy 320G call.  The chunk size given (PMD_SIZE) could affect thread
count and chunk size for these, so chunk size was increased from 2M to
1G.  This caused the split PMD contention to disappear, but with little
change in the runtime.  More digging required.

[1] lkml.kernel.org/r/20180925120326.24392-1-mhocko@kernel.org

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 drivers/vfio/vfio_iommu_type1.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 9e52a24eb45b..0d6ec0369de5 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -331,7 +331,7 @@ static int put_pfn(unsigned long pfn, int prot)
 }
 
 static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
-			 int prot, unsigned long *pfn)
+			 int prot, unsigned long *pfn, bool handle_mmap_sem)
 {
 	struct page *page[1];
 	struct vm_area_struct *vma;
@@ -342,7 +342,8 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
 	if (prot & IOMMU_WRITE)
 		flags |= FOLL_WRITE;
 
-	down_read(&mm->mmap_sem);
+	if (handle_mmap_sem)
+		down_read(&mm->mmap_sem);
 	if (mm == current->mm) {
 		ret = get_user_pages_longterm(vaddr, 1, flags, page, vmas);
 	} else {
@@ -360,14 +361,16 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
 			put_page(page[0]);
 		}
 	}
-	up_read(&mm->mmap_sem);
+	if (handle_mmap_sem)
+		up_read(&mm->mmap_sem);
 
 	if (ret == 1) {
 		*pfn = page_to_pfn(page[0]);
 		return 0;
 	}
 
-	down_read(&mm->mmap_sem);
+	if (handle_mmap_sem)
+		down_read(&mm->mmap_sem);
 
 	vma = find_vma_intersection(mm, vaddr, vaddr + 1);
 
@@ -377,7 +380,8 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
 			ret = 0;
 	}
 
-	up_read(&mm->mmap_sem);
+	if (handle_mmap_sem)
+		up_read(&mm->mmap_sem);
 	return ret;
 }
 
@@ -399,9 +403,12 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 	if (!mm)
 		return -ENODEV;
 
-	ret = vaddr_get_pfn(mm, vaddr, dma->prot, pfn_base);
-	if (ret)
+	down_read(&mm->mmap_sem);
+	ret = vaddr_get_pfn(mm, vaddr, dma->prot, pfn_base, false);
+	if (ret) {
+		up_read(&mm->mmap_sem);
 		return ret;
+	}
 
 	pinned++;
 	rsvd = is_invalid_reserved_pfn(*pfn_base);
@@ -416,6 +423,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 			put_pfn(*pfn_base, dma->prot);
 			pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n", __func__,
 					limit << PAGE_SHIFT);
+			up_read(&mm->mmap_sem);
 			return -ENOMEM;
 		}
 		lock_acct++;
@@ -427,7 +435,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 	/* Lock all the consecutive pages from pfn_base */
 	for (vaddr += PAGE_SIZE, iova += PAGE_SIZE; pinned < npage;
 	     pinned++, vaddr += PAGE_SIZE, iova += PAGE_SIZE) {
-		ret = vaddr_get_pfn(mm, vaddr, dma->prot, &pfn);
+		ret = vaddr_get_pfn(mm, vaddr, dma->prot, &pfn, false);
 		if (ret)
 			break;
 
@@ -444,6 +452,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 				pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n",
 					__func__, limit << PAGE_SHIFT);
 				ret = -ENOMEM;
+				up_read(&mm->mmap_sem);
 				goto unpin_out;
 			}
 			lock_acct++;
@@ -451,6 +460,7 @@ static long vfio_pin_pages_remote(struct vfio_dma *dma, unsigned long vaddr,
 	}
 
 out:
+	up_read(&mm->mmap_sem);
 	ret = vfio_lock_acct(dma, lock_acct, false);
 
 unpin_out:
@@ -497,7 +507,7 @@ static int vfio_pin_page_external(struct vfio_dma *dma, unsigned long vaddr,
 	if (!mm)
 		return -ENODEV;
 
-	ret = vaddr_get_pfn(mm, vaddr, dma->prot, pfn_base);
+	ret = vaddr_get_pfn(mm, vaddr, dma->prot, pfn_base, true);
 	if (!ret && do_accounting && !is_invalid_reserved_pfn(*pfn_base)) {
 		ret = vfio_lock_acct(dma, 1, true);
 		if (ret) {
-- 
2.19.1

