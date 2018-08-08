Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5C2C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2225721A09
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2225721A09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbeHHPgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 11:36:00 -0400
Received: from ozlabs.org ([203.11.71.1]:51221 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbeHHPgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 11:36:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41lsN34l38z9s0n;
        Wed,  8 Aug 2018 23:16:19 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "npiggin\@gmail.com" <npiggin@gmail.com>
Subject: Re: Build regressions/improvements in v4.17-rc1
In-Reply-To: <87lg9hb12y.fsf@concordia.ellerman.id.au>
References: <1523884165-17044-1-git-send-email-geert@linux-m68k.org> <CAMuHMdXxV1nWGWAAXSkBWm-9VWHVc57nhFLfQ4BijbKGh-vaUQ@mail.gmail.com> <20180806155440.9dcb271a3b075bd964aec60f@linux-foundation.org> <87lg9hb12y.fsf@concordia.ellerman.id.au>
Date:   Wed, 08 Aug 2018 23:16:16 +1000
Message-ID: <87d0utati7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:
> Andrew Morton <akpm@linux-foundation.org> writes:
>> On Mon, 6 Aug 2018 12:39:21 +0200 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>
>>> CC Dan, Michael, AKPM, powerpc
>>> 
>>> On Mon, Apr 16, 2018 at 3:10 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>> > Below is the list of build error/warning regressions/improvements in
>>> > v4.17-rc1[1] compared to v4.16[2].
>>> 
>>> I'd like to point your attention to:
>>> 
>>> >   + warning: vmlinux.o(.text+0x376518): Section mismatch in reference from the function .devm_memremap_pages() to the function .meminit.text:.arch_add_memory():  => N/A
>>> >   + warning: vmlinux.o(.text+0x376d64): Section mismatch in reference from the function .devm_memremap_pages_release() to the function .meminit.text:.arch_remove_memory():  => N/A
>>
>> hm.  Dan isn't around at present so we're on our own with this one.
>>
>> x86 doesn't put arch_add_memory and arch_remove_memory into __meminit. 
>> x86 does
>>
>> #ifdef CONFIG_MEMORY_HOTPLUG
>> int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
>> 		bool want_memblock)
>> {
>> 	...
>>
>>
>> So I guess powerpc should do that as well?
>
> But we only recently added it to fix a section mismatch warning:
>
>   WARNING: vmlinux.o(.text+0x6da88): Section mismatch in reference from the function .arch_add_memory() to the function .meminit.text:.create_section_mapping()
>   The function .arch_add_memory() references
>   the function __meminit .create_section_mapping().
>   This is often because .arch_add_memory lacks a __meminit 
>   annotation or the annotation of .create_section_mapping is wrong.
>
>
> I think the problem is that the section mismatch logic isn't able to
> cope with __meminit's changing semantics.
>
> When CONFIG_MEMORY_HOTPLUG=y references from .text to .meminit.text
> should be allowed, because they're just folded in together in the linker
> script.
>
> When CONFIG_MEMORY_HOTPLUG=n references from .text to .meminit.text
> should NOT be allowed, because .meminit.text becomes .init.text and will
> be freed.
>
> I don't see anything in the section mismatch logic to cope with that
> difference.
>
> It looks like __meminit is saving us about 1K on powerpc, so I'm
> strongly inclined to just remove it entirely from arch/powerpc.

Gah that doesn't work.

Our arch routines call things in mm/ that are __meminit, so we have to
mark our code __meminit too, otherwise we get a section mismatch
warning.

cheers
