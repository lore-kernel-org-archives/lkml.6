Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA62C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A12A222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387775AbfBMG5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 01:57:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387594AbfBMG5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 01:57:46 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1D6oor4020018
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 01:57:46 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qme3srsdd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 01:57:45 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 13 Feb 2019 06:57:43 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Feb 2019 06:57:38 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1D6vcdE2818540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Feb 2019 06:57:38 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9C5711C04A;
        Wed, 13 Feb 2019 06:57:37 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 182FC11C04C;
        Wed, 13 Feb 2019 06:57:37 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 13 Feb 2019 06:57:36 +0000 (GMT)
Date:   Wed, 13 Feb 2019 08:57:35 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Prateek Patel <prpatel@nvidia.com>,
        DT <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [RESEND PATCH v2] of: fix kmemleak crash caused by imbalance in
 early memory reservation
References: <3c886941-bf9d-f040-b568-ee7a8eba9a04@free.fr>
 <CGME20190123055509epcas3p18a6d66fa08412f2308cb2c1997328ea8@epcas3p1.samsung.com>
 <20190123055414.GA4747@rapoport-lnx>
 <78f4ea8a-996d-038e-9e33-5ff02fa2c43f@samsung.com>
 <20190123123143.GE4747@rapoport-lnx>
 <4b8f82c4-7f8f-b814-c1ec-9902e43963f6@free.fr>
 <617e0d57-342d-4162-bd21-ece18e481d87@free.fr>
 <CAL_JsqKbCg-rGmLoA3mPv54=LMuQBfevfzL8f2QPVyjN-sNk8w@mail.gmail.com>
 <20190213085028.6199594b@canb.auug.org.au>
 <CAL_JsqK-cC6oVZ9MkP+ExOGjCRhA0XxGSgqGKL3W9bFF3rKAgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqK-cC6oVZ9MkP+ExOGjCRhA0XxGSgqGKL3W9bFF3rKAgA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19021306-0008-0000-0000-000002BFD73C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021306-0009-0000-0000-0000222BF419
Message-Id: <20190213065734.GA14425@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902130050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 04:12:24PM -0600, Rob Herring wrote:
> On Tue, Feb 12, 2019 at 3:50 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > On Tue, 12 Feb 2019 10:03:09 -0600 Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Mon, Feb 11, 2019 at 10:47 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
> > > >
> > > > On 04/02/2019 15:37, Marc Gonzalez wrote:
> > > >
> > > > > Cc: stable@vger.kernel.org # 3.15+
> > > > > Fixes: 3f0c820664483 ("drivers: of: add initialization code for dynamic reserved memory")
> > > > > Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > > Acked-by: Prateek Patel <prpatel@nvidia.com>
> > > > > Tested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> > > > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > > > ---
> > > > > Resend with DT CCed to reach robh's patch queue
> > > > > I added CC: stable, Fixes, and Prateek's ack
> > > > > Trim recipients list to minimize inconvenience
> > > >
> > > > I'm confused over commit 3532b3b554a216f30edb841d29eef48521bdc592 in linux-next
> > > > "memblock: drop __memblock_alloc_base()"
> > > >
> > > > It's definitely going to conflict with the proposed patch
> > > > over drivers/of/of_reserved_mem.c
> > > >
> > > > Rob, what's the next step then?
> > >
> > > Rebase it on top of what's in linux-next and apply it to the tree
> > > which has the above dependency. I'm guessing that is Andrew Morton's
> > > tree.
> >
> > Yeah, that is in Andrew's "post linux-next" patch series, so if you
> > rebase it on top of linux-next and then send it to Andrew with some
> > explanation.
> >
> > ...
> >
> > Actually, if it is intended for the stable trees, then presumably it is
> > intended to go to Linus for the current release?  In which case, the
> > patch in Andrew's tree will have to be changed to cope after your patch
> > appears in Linus' tree (and therefore, linux-next).
> 
> At this point in the cycle, I wasn't planning to send this for 5.0.
> It's not fixing something introduced in 5.0 and it is a debug feature.
 
Below is the version vs. current mmotm.

From 9ea6dceb46067d4f1cbbdbec1189c8496aa0a4bc Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Mon, 4 Feb 2019 15:37:21 +0100
Subject: [PATCH] of: fix kmemleak crash caused by imbalance in early memory
 reservation

Marc Gonzalez reported the following kmemleak crash:

Unable to handle kernel paging request at virtual address ffffffc021e00000
Mem abort info:
  ESR = 0x96000006
  Exception class = DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
swapper pgtable: 4k pages, 39-bit VAs, pgdp = (____ptrval____)
[ffffffc021e00000] pgd=000000017e3ba803, pud=000000017e3ba803,
pmd=0000000000000000
Internal error: Oops: 96000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 6 PID: 523 Comm: kmemleak Tainted: G S      W         5.0.0-rc1 #13
Hardware name: Qualcomm Technologies, Inc. MSM8998 v1 MTP (DT)
pstate: 80000085 (Nzcv daIf -PAN -UAO)
pc : scan_block+0x70/0x190
lr : scan_block+0x6c/0x190
sp : ffffff8012e8bd20
x29: ffffff8012e8bd20 x28: ffffffc0fdbaf018
x27: ffffffc022000000 x26: 0000000000000080
x25: ffffff8011aadf70 x24: ffffffc0f8cc8000
x23: ffffff8010dc8000 x22: ffffff8010dc8830
x21: ffffffc021e00ff9 x20: ffffffc0f8cc8050
x19: ffffffc021e00000 x18: 0000000000002409
x17: 0000000000000200 x16: 0000000000000000
x15: ffffff8010e14dd8 x14: 0000000000002406
x13: 000000004c4dd0c6 x12: ffffffc0f77dad58
x11: 0000000000000001 x10: ffffff8010d9e688
x9 : ffffff8010d9f000 x8 : ffffff8010d9e688
x7 : 0000000000000002 x6 : 0000000000000000
x5 : ffffff8011511c20 x4 : 00000000000026d1
x3 : ffffff8010e14d88 x2 : 5b36396f4e7d4000
x1 : 0000000000208040 x0 : 0000000000000000
Process kmemleak (pid: 523, stack limit = 0x(____ptrval____))
Call trace:
 scan_block+0x70/0x190
 scan_gray_list+0x108/0x1c0
 kmemleak_scan+0x33c/0x7c0
 kmemleak_scan_thread+0x98/0xf0
 kthread+0x11c/0x120
 ret_from_fork+0x10/0x1c
Code: f9000fb4 d503201f 97ffffd2 35000580 (f9400260)
---[ end trace 176d6ed9d86a0c33 ]---
note: kmemleak[523] exited with preempt_count 2

The crash happens when a no-map area is allocated in
early_init_dt_alloc_reserved_memory_arch(). The allocated region is
registered with kmemleak, but it is then removed from memblock using
memblock_remove() that is not kmemleak-aware.

Replacing __memblock_alloc_base() with memblock_find_in_range() makes sure
that the allocated memory is not added to kmemleak and then
memblock_remove()'ing this memory is safe.

As a bonus, since memblock_find_in_range() ensures the allocation in the
specified range, the bounds check can be removed.

Cc: stable@vger.kernel.org # 3.15+
Fixes: 3f0c820664483 ("drivers: of: add initialization code for dynamic reserved memory")
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Prateek Patel <prpatel@nvidia.com>
Tested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 drivers/of/of_reserved_mem.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 78aa9eb..47971ab 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -34,21 +34,16 @@ int __init __weak early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 
 	end = !end ? MEMBLOCK_ALLOC_ANYWHERE : end;
 	align = !align ? SMP_CACHE_BYTES : align;
-	base = memblock_phys_alloc_range(size, align, 0, end);
+	base = memblock_find_in_range(size, align, start, end);
 	if (!base)
 		return -ENOMEM;
 
-	/*
-	 * Check if the allocated region fits in to start..end window
-	 */
-	if (base < start) {
-		memblock_free(base, size);
-		return -ENOMEM;
-	}
-
 	*res_base = base;
 	if (nomap)
 		return memblock_remove(base, size);
+	else
+		return memblock_reserve(base, size);
+
 	return 0;
 }
 
-- 
2.7.4

