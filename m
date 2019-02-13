Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D643BC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B028B222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391879AbfBML1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:27:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:44960 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727977AbfBML1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:27:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2EF02ABAC;
        Wed, 13 Feb 2019 11:27:31 +0000 (UTC)
Subject: Re: [PATCH] hugetlb: allow to free gigantic pages regardless of the
 configuration
To:     Alexandre Ghiti <aghiti@upmem.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     linux-riscv@lists.infradead.org, hch@infradead.org,
        Alexandre Ghiti <alex@ghiti.fr>
References: <20190117183953.5990-1-aghiti@upmem.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <16a6209c-868b-8fd5-a70a-6e0e1ecb62d4@suse.cz>
Date:   Wed, 13 Feb 2019 12:27:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117183953.5990-1-aghiti@upmem.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/19 7:39 PM, Alexandre Ghiti wrote:
> From: Alexandre Ghiti <alex@ghiti.fr>
> 
> On systems without CMA or (MEMORY_ISOLATION && COMPACTION) activated but
> that support gigantic pages, boottime reserved gigantic pages can not be
> freed at all. This patchs simply enables the possibility to hand back
> those pages to memory allocator.
> 
> This commit then renames gigantic_page_supported and
> ARCH_HAS_GIGANTIC_PAGE to make them more accurate. Indeed, those values
> being false does not mean that the system cannot use gigantic pages: it
> just means that runtime allocation of gigantic pages is not supported,
> one can still allocate boottime gigantic pages if the architecture supports
> it.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

I'm fine with the change, but wonder if this can be structured better in a way
which would remove the duplicated "if (MEMORY_ISOLATION && COMPACTION) || CMA"
from all arches, as well as the duplicated
gigantic_page_runtime_allocation_supported()

something like:

- "select ARCH_HAS_GIGANTIC_PAGE" has no conditions, it just says the arch can
support them either at boottime or runtime (but runtime is usable only if other
conditions are met)
- gigantic_page_runtime_allocation_supported() is a function that returns true
if ARCH_HAS_GIGANTIC_PAGE && ((MEMORY_ISOLATION && COMPACTION) || CMA) and
there's a single instance, not per-arch.
- code for freeing gigantic pages can probably still be conditional on
ARCH_HAS_GIGANTIC_PAGE

BTW I wanted also to do something about the "(MEMORY_ISOLATION && COMPACTION) ||
CMA" ugliness itself, i.e. put the common parts behind some new kconfig
(COMPACTION_CORE ?) and expose it better to users, but I can take a stab on that
once the above part is settled.

Vlastimil
