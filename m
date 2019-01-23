Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6C3C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 05:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCB521019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 05:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfAWFy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 00:54:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725945AbfAWFy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 00:54:28 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0N5s9LA054528
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 00:54:27 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q6e8pygnp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 00:54:26 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 23 Jan 2019 05:54:24 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Jan 2019 05:54:18 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0N5sHix24313864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Jan 2019 05:54:18 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEB72A4054;
        Wed, 23 Jan 2019 05:54:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70EA7A405B;
        Wed, 23 Jan 2019 05:54:16 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.208])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 23 Jan 2019 05:54:16 +0000 (GMT)
Date:   Wed, 23 Jan 2019 07:54:14 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Prateek Patel <prpatel@nvidia.com>,
        Sachin Nikam <snikam@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: kmemleak panic
References: <b7629ecf-757c-f8b5-df83-ba83d7036b2f@free.fr>
 <20190119132832.GA29881@MBP.local>
 <6579db26-10ac-3fbf-1998-5b937a38f202@free.fr>
 <d4facdc2-0581-929f-caa2-b9efa9bd8f97@arm.com>
 <CAL_JsqKFT8J6g02gxeBiTfBb_XHhp2-ZNB6DgaLPK85kNZGRig@mail.gmail.com>
 <20190121143704.GE29504@arrakis.emea.arm.com>
 <CAL_JsqKQb34zVNTzo9DLNiDwmWGxkrKezSOjwCUPAvgzUoLYjg@mail.gmail.com>
 <20190121174234.GC26461@rapoport-lnx>
 <2bb30550-435a-046c-4f45-21dd594aa695@free.fr>
 <3c886941-bf9d-f040-b568-ee7a8eba9a04@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c886941-bf9d-f040-b568-ee7a8eba9a04@free.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19012305-4275-0000-0000-00000302E0CA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012305-4276-0000-0000-0000381113E9
Message-Id: <20190123055414.GA4747@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901230047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 03:12:54PM +0100, Marc Gonzalez wrote:
> On 22/01/2019 15:02, Marc Gonzalez wrote:
> 
> > On 21/01/2019 18:42, Mike Rapoport wrote:
> > 
> >> If I understood correctly, the trouble comes from no-map range allocated in 
> >> early_init_dt_alloc_reserved_memory_arch().
> >>
> >> There's indeed imbalance, because memblock_alloc() does kmemleak_alloc(), but
> >> memblock_remove() does not do kmemleak_free().
> >>
> >> I think the best way is to replace __memblock_alloc_base() with
> >> memblock_find_in_range(), e.g something like:
> >>
> >>
> >> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> >> index 1977ee0adcb1..6807a1cffe55 100644
> >> --- a/drivers/of/of_reserved_mem.c
> >> +++ b/drivers/of/of_reserved_mem.c
> >> @@ -37,21 +37,16 @@ int __init __weak early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
> >>  	 */
> >>  	end = !end ? MEMBLOCK_ALLOC_ANYWHERE : end;
> >>  	align = !align ? SMP_CACHE_BYTES : align;
> >> -	base = __memblock_alloc_base(size, align, end);
> >> +	base = memblock_find_in_range(size, align, start, end);
> >>  	if (!base)
> >>  		return -ENOMEM;
> >>  
> >> -	/*
> >> -	 * Check if the allocated region fits in to start..end window
> >> -	 */
> >> -	if (base < start) {
> >> -		memblock_free(base, size);
> >> -		return -ENOMEM;
> >> -	}
> >> -
> >>  	*res_base = base;
> >>  	if (nomap)
> >>  		return memblock_remove(base, size);
> >> +	else
> >> +		return memblock_reserve(base, size);
> >> +
> >>  	return 0;
> >>  }
> >>  
> > 
> > Your patch solves the issue. \o/

Great :)
 
> [ Add nvidia devs, but drop schowdary@nvidia.com ]
> 

Resending it as a formal patch now, I took a liberty to add your Tested-by.

From a847ca684db29a3c09e4dd2a8a008b35cf36e52f Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Wed, 23 Jan 2019 07:38:50 +0200
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

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Tested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 drivers/of/of_reserved_mem.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 1977ee0adcb1..6807a1cffe55 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -37,21 +37,16 @@ int __init __weak early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 	 */
 	end = !end ? MEMBLOCK_ALLOC_ANYWHERE : end;
 	align = !align ? SMP_CACHE_BYTES : align;
-	base = __memblock_alloc_base(size, align, end);
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

