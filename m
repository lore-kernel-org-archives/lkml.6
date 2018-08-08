Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CB4C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2DA21762
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2DA21762
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeHHQFR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:05:17 -0400
Received: from ozlabs.org ([203.11.71.1]:36935 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbeHHQFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:05:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41lt1l1GMMz9s0n;
        Wed,  8 Aug 2018 23:45:30 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     pmenzel@molgen.mpg.de, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Several suspected memory leaks
In-Reply-To: <CAHkRjk7aYtMJXmQ_zuV7B12JiCkLfg3-8x+ayTD2DU9gDwi8Hw@mail.gmail.com>
References: <468d3c5b-d71d-c95b-dab4-ea8c2cebe129@molgen.mpg.de> <69a6086d25c17b03ecf3ab7ed34fe941fd993410.camel@kernel.crashing.org> <CAHkRjk7aYtMJXmQ_zuV7B12JiCkLfg3-8x+ayTD2DU9gDwi8Hw@mail.gmail.com>
Date:   Wed, 08 Aug 2018 23:45:30 +1000
Message-ID: <87600las5h.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Catalin Marinas <catalin.marinas@arm.com> writes:
> On Wed, 11 Jul 2018 at 00:40, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>> On Tue, 2018-07-10 at 17:17 +0200, Paul Menzel wrote:
>> > On a the IBM S822LC (8335-GTA) with Ubuntu 18.04 I built Linux master
>> > – 4.18-rc4+, commit 092150a2 (Merge branch 'for-linus'
>> > of git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid) – with
>> > kmemleak. Several issues are found.
>>
>> Some of these are completely uninteresting though and look like
>> kmemleak bugs to me :-)
>>
>> >     [<00000000bc285bbf>] __pud_alloc+0x80/0x270
>> >     [<0000000007135d64>] hash__map_kernel_page+0x30c/0x4d0
>> >     [<0000000071677858>] __ioremap_at+0x108/0x140
>> >     [<000000000023e921>] __ioremap_caller+0x130/0x180
>> >     [<000000009dbc3923>] icp_native_init_one_node+0x5cc/0x760
>> >     [<0000000015f3168a>] icp_native_init+0x70/0x13c
>> >     [<00000000655550ed>] xics_init+0x38/0x1ac
>> >     [<0000000088dbf9d1>] pnv_init_IRQ+0x30/0x5c
>>
>> This is the interrupt controller mapping its registers, why on earth
>> would that be considered a leak ? kmemleak needs to learn to ignore
>> kernel page tables allocations.
>
> Indeed, that's just a false positive for powerpc. Kmemleak ignores
> page allocations and most architectures use __get_free_pages() for the
> page table. In this particular case, the powerpc code uses
> kmem_cache_alloc() and that's tracked by kmemleak. Since the pgd
> stores the __pa(pud), kmemleak doesn't detect this pointer and reports
> it as a leak. To work around this, you can pass SLAB_NOLEAKTRACE to
> kmem_cache_create() in pgtable_cache_add()

Ah thanks, I didn't know we could do it that way.

I did this instead which seems to work:

  https://git.kernel.org/torvalds/c/a984506c542e


cheers
