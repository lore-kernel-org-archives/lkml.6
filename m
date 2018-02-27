Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753168AbeB0MlR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 07:41:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753154AbeB0MlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 07:41:15 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC REBASED 5/5] powerpc/mm/slice: use the dynamic high slice size to limit bitmap operations
In-Reply-To: <20180227191125.659d5cbe@roar.ozlabs.ibm.com>
References: <02a62db83282b5ef3e0e8281fdc46fa91beffc86.1518382747.git.christophe.leroy@c-s.fr> <5badd882663833576c10b8aafe235fe1e443f119.1518382747.git.christophe.leroy@c-s.fr> <87bmga7qng.fsf@linux.vnet.ibm.com> <20180227191125.659d5cbe@roar.ozlabs.ibm.com>
Date: Tue, 27 Feb 2018 18:11:07 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18022712-0040-0000-0000-000004175457
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022712-0041-0000-0000-0000261A7AB3
Message-Id: <878tbe7ggs.fsf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802270159
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:

> On Tue, 27 Feb 2018 14:31:07 +0530
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> 
>> > The number of high slices a process might use now depends on its
>> > address space size, and what allocation address it has requested.
>> >
>> > This patch uses that limit throughout call chains where possible,
>> > rather than use the fixed SLICE_NUM_HIGH for bitmap operations.
>> > This saves some cost for processes that don't use very large address
>> > spaces.  
>> 
>> I haven't really looked at the final code. One of the issue we had was
>> with the below scenario.
>> 
>> mmap(addr, len) where addr < 128TB and addr+len > 128TB  We want to make
>> sure we build the mask such that we don't find the addr available.
>
> We should run it through the mmap regression tests. I *think* we moved
> all of that logic from the slice code to get_ummapped_area before going
> in to slices. I may have missed something though, it would be good to
> have more eyes on it.
>

mmap(-1,...) failed with the test. Something like below fix it

@@ -756,7 +770,7 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
        mm->context.low_slices_psize = lpsizes;
 
        hpsizes = mm->context.high_slices_psize;
-       high_slices = GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit);
+       high_slices = SLICE_NUM_HIGH;
        for (i = 0; i < high_slices; i++) {
                mask_index = i & 0x1;
                index = i >> 1;

I guess for everything in the mm_context_t, we should compute it till
SLICE_NUM_HIGH. The reason for failure was, even though we recompute the
slice mask cached in mm_context on slb_addr_limit, it was still derived
from the high_slices_psizes which was computed with lower value.

-aneesh
