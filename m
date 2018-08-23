Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61834C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C6E208EB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C6E208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=au1.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbeHWIWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:22:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726204AbeHWIWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:22:22 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7N4nIgW037972
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 00:54:32 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m1krkd0p2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 00:54:32 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <benh@au1.ibm.com>;
        Thu, 23 Aug 2018 05:54:31 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Aug 2018 05:54:25 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7N4sOlx29360220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Aug 2018 04:54:24 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB2C952065;
        Thu, 23 Aug 2018 07:54:23 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 08EFB52057;
        Thu, 23 Aug 2018 07:54:23 +0100 (BST)
Received: from pasglop.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id E35E9A020A;
        Thu, 23 Aug 2018 14:54:19 +1000 (AEST)
Subject: Re: [PATCH 3/4] mm/tlb, x86/mm: Support invalidating TLB caches for
 RCU_TABLE_FREE
From:   Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Will Deacon <will.deacon@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        Adin Scannell <ascannell@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Date:   Thu, 23 Aug 2018 14:54:20 +1000
In-Reply-To: <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
References: <20180822153012.173508681@infradead.org>
         <20180822154046.823850812@infradead.org>
         <20180822155527.GF24124@hirez.programming.kicks-ass.net>
         <20180823134525.5f12b0d3@roar.ozlabs.ibm.com>
         <CA+55aFxneZTFxxxAjLZmj92VUJg6z7hERxJ2cHoth-GC0RuELw@mail.gmail.com>
Organization: IBM Australia
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18082304-4275-0000-0000-000002ADF27B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082304-4276-0000-0000-000037B6F984
Message-Id: <776104d4c8e4fc680004d69e3a4c2594b638b6d1.camel@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808230050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-22 at 20:59 -0700, Linus Torvalds wrote:
> On Wed, Aug 22, 2018 at 8:45 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> > 
> > powerpc/radix has no such issue, it already does this tracking.
> 
> Yeah, I now realize that this was why you wanted to add that hacky
> thing to the generic code, so that you can add the tlb_flush_pgtable()
> call.
> 
> I thought it was because powerpc had some special flush instruction
> for it, and the regular tlb flush didn't do it. But no. It was because
> the regular code had lost the tlb flush _entirely_, because powerpc
> didn't want it.

Heh :-) Well, back on hash we didn't (we do now with Radix) but I
wouldn't blame us for the generic code being broken ... the RCU table
freeing was in arch/powerpc at the time :-) I don't think it was us
making it generic :)

> > We were discussing this a couple of months ago, I wasn't aware of ARM's
> > issue but I suggested x86 could go the same way as powerpc.
> 
> The problem is that x86 _used_ to do this all correctly long long ago.
> 
> And then we switched over to the "generic" table flushing (which
> harkens back to the powerpc code).

Yes, we wrote it the RCU stuff to solve the races with SW walking,
which is completely orthogonal with HW walking & TLB content. We didn't
do the move to generic code though ;-)

> Which actually turned out to be not generic at all, and did not flush
> the internal pages like x86 used to (back when x86 just used
> tlb_remove_page for everything).

Well, having RCU do the flushing is rather generic, it makes sense
whenever there's somebody doing a SW walk *and* you don't have IPIs to
synchronize your flushes (ie, anybody with HW TLB invalidation
broadcast basically, so ARM and us).

> So as a result, x86 had unintentionally lost the TLB flush we used to
> have, because tlb_remove_table() had lost the tlb flushing because of
> a powerpc quirk.

This is a somewhat odd way of putting the "blame" :-) But yeah ok...

> You then added it back as a hacky per-architecture hook (apparently
> having realized that you never did it at all), which didn't fix the
> unintentional lack of flushing on x86.
> 
> So now we're going to do it right.  No more "oh, powerpc didn't need
> to flush because the hash tables weren't in the tlb at all" thing in
> the generic code that then others need to work around.

So we do need a different flush instruction for the page tables vs. the
normal TLB pages. 

Cheers,
Ben.


