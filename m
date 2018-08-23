Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B926C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 06:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81E1208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 06:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81E1208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbeHWKQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 06:16:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726301AbeHWKQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 06:16:50 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7N6i7Gb042448
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 02:48:41 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m1p1cv65q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 02:48:41 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Thu, 23 Aug 2018 07:48:37 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Aug 2018 07:48:32 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7N6mVcb37814298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Aug 2018 06:48:31 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1EEBAE051;
        Thu, 23 Aug 2018 09:48:08 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3059BAE057;
        Thu, 23 Aug 2018 09:48:08 +0100 (BST)
Received: from mschwideX1 (unknown [9.145.145.151])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Aug 2018 09:48:08 +0100 (BST)
Date:   Thu, 23 Aug 2018 08:48:28 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Will Deacon <will.deacon@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Miller <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for
 RCU_TABLE_FREE
In-Reply-To: <CA+55aFw3edpf6JBn-pbqYhtvMPZJ7VmJTkGfO_9=uQMO=dV32g@mail.gmail.com>
References: <20180822153012.173508681@infradead.org>
        <20180822154046.823850812@infradead.org>
        <20180822155527.GF24124@hirez.programming.kicks-ass.net>
        <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
        <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
        <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
        <CA+55aFzM77G9-Q6LboPLJ=5gHma66ZQKiMGCMqXoKABirdF98w@mail.gmail.com>
        <CA+55aFw3edpf6JBn-pbqYhtvMPZJ7VmJTkGfO_9=uQMO=dV32g@mail.gmail.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18082306-0012-0000-0000-0000029D863D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082306-0013-0000-0000-000020D0CC5F
Message-Id: <20180823084828.3d4d0527@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-23_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=613 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808230071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2018 22:20:32 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Aug 22, 2018 at 10:11 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So instead, when you get to the actual "tlb_flush(tlb)", you do
> > exactly that - flush the tlb. And the mmu_gather structure shows you
> > how much you need to flush. If you see that "freed_tables" is set,
> > then you know that you need to also do the special instruction to
> > flush the inner level caches. The range continues to show the page
> > range.  
> 
> Note that this obviously works fine for a hashed table model too - you
> just ignore the "freed_tables" bit entirely and continue to do
> whatever you always did.
> 
> And we can ignore it on x86 too, because we just see the range, and we
> invalidate the range, and that will always invalidate the mid-level
> caching too.
> 
> So the new bit is literally for arm and powerpc-radix (and maybe
> s390), but we want to make the actual VM interface truly generic and
> not have one set of code with five different behaviors (which we
> _currently_ kind of have with the whole in addition to all the
> HAVE_RCU_TABLE_FREE etc config options that modify how the code works.
> 
> It would be good to also cut down on the millions of functions that
> each architecture can override, because Christ, it got very confusing
> at times to follow just how the code flowed from generic code to
> architecture-specific macros back to generic code and then
> arch-specific inline helper functions.
> 
> It's a maze of underscores and "page" vs "table", and "flush" vs "remove" etc.
> 
> But that "it would be good to really make everybody to use as much of
> the generic code as possible" and everybody have the same pattern,
> that's a future thing. But the whole "let's just add that
> "freed_tables" thing would be part of trying to get people to use the
> same overall pattern, even if some architectures might not care about
> that detail.

For s390 the new freed_tables bit looks to be step into the right
direction. Right now there is the flush_mm bit in the mm->context
that I use to keep track of the need for a global flush of the mm.
The flush_mm bit is currently used for both lazy PTE flushing and
TLB flushes for freed page table pages.

I'll look into it once the generic patch is merged. The switch to
the generic mmu_gather is certainly not a change that can be done
in a hurry, we had too many subtle TLB flush issues in the past.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

