Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381B9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECC420657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfAQJ4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:56:43 -0500
Received: from ozlabs.org ([203.11.71.1]:48615 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbfAQJ4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:56:42 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43gKGp5Rwwz9sBn;
        Thu, 17 Jan 2019 20:56:34 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-riscv@lists.infradead.org,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, peterz@infradead.org,
        christoffer.dall@arm.com, marc.zyngier@arm.com,
        kirill@shutemov.name, rppt@linux.vnet.ibm.com,
        ard.biesheuvel@linaro.org, mark.rutland@arm.com,
        steve.capper@arm.com, james.morse@arm.com, robin.murphy@arm.com,
        aneesh.kumar@linux.ibm.com, vbabka@suse.cz, shakeelb@google.com,
        rientjes@google.com, palmer@sifive.com, greentime@andestech.com
Subject: Re: [PATCH V2] mm: Introduce GFP_PGTABLE
In-Reply-To: <20190116123018.GF6310@bombadil.infradead.org>
References: <1547619692-7946-1-git-send-email-anshuman.khandual@arm.com> <20190116065703.GE24149@dhcp22.suse.cz> <20190116123018.GF6310@bombadil.infradead.org>
Date:   Thu, 17 Jan 2019 20:56:34 +1100
Message-ID: <87tvi74nfx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Wed, Jan 16, 2019 at 07:57:03AM +0100, Michal Hocko wrote:
>> On Wed 16-01-19 11:51:32, Anshuman Khandual wrote:
>> > All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
>> > __GFP_ZERO) and using it for allocating page table pages. This causes some
>> > code duplication which can be easily avoided. GFP_KERNEL allocated and
>> > cleared out pages (__GFP_ZERO) are required for page tables on any given
>> > architecture. This creates a new generic GFP flag flag which can be used
>> > for any page table page allocation. Does not cause any functional change.
>> > 
>> > GFP_PGTABLE is being added into include/asm-generic/pgtable.h which is the
>> > generic page tabe header just to prevent it's potential misuse as a general
>> > allocation flag if included in include/linux/gfp.h.
>> 
>> I haven't reviewed the patch yet but I am wondering whether this is
>> really worth it without going all the way down to unify the common code
>> and remove much more code duplication. Or is this not possible for some
>> reason?
>
> Exactly what I suggested doing in response to v1.
>
> Also, the approach taken here is crazy.  x86 has a feature that no other
> architecture has bothered to implement yet -- accounting page tables
> to the process.

powerpc does __GFP_ACCOUNT for user page tables too. Shamelessly cribbed
from the x86 version of course :)

cheers
