Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D377FC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 04:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E1625489
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 04:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E1625489
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbeGBEQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 00:16:44 -0400
Received: from ozlabs.org ([203.11.71.1]:45701 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751443AbeGBEQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 00:16:43 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Jv8N2J94z9s3q;
        Mon,  2 Jul 2018 14:16:36 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Update] Regression in 4.18 - 32-bit PowerPC crashes on boot - bisected to commit 1d40a5ea01d5
In-Reply-To: <CA+55aFzZ7PND2Xvz9wB1jaCmp0rBMTSmJtKiFwSeOWy9iLSd8Q@mail.gmail.com>
References: <99169786-61dd-b19c-ac81-84bcd0a67de4@lwfinger.net> <CA+55aFzZ7PND2Xvz9wB1jaCmp0rBMTSmJtKiFwSeOWy9iLSd8Q@mail.gmail.com>
Date:   Mon, 02 Jul 2018 14:16:33 +1000
Message-ID: <87d0w6mfvi.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Fri, Jun 29, 2018 at 1:42 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>
>> I have more information regarding this BUG. Line 700 of page-flags.h is the
>> macro PAGE_TYPE_OPS(Table, table). For further debugging, I manually expanded
>> the macro, and found that the bug line is VM_BUG_ON_PAGE(!PageTable(page), page)
>> in routine __ClearPageTable(), which is called from pgtable_page_dtor() in
>> include/linux/mm.h. I also added a printk call to PageTable() that logs
>> page->page_type. The routine was called twice. The first had page_type of
>> 0xfffffbff, which would have been expected for a . The second call had
>> 0xffffffff, which led to the BUG.
>
> So it looks to me like the tear-down of the page tables first found a
> page that is indeed a page table, and cleared the page table bit
> (well, it set it - the bits are reversed).
...
>
> That said, can some ppc person who knows the 32-bit ppc code and maybe
> knows what that "interrupt: 700" means talk about that oddity in the
> trace, please?

I think everyone else answered your questions here, and it should be
fixed now in your tree.

Larry let me know if you're still seeing a crash with 4.18-rc3.

cheers
