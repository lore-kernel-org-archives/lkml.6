Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61A7C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7439E20834
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7439E20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbeHHUqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:46:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727295AbeHHUqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:46:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 41DB440241C3;
        Wed,  8 Aug 2018 18:25:50 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C5B8E20290AB;
        Wed,  8 Aug 2018 18:25:49 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w78IPnqj025449;
        Wed, 8 Aug 2018 14:25:49 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w78IPms5025445;
        Wed, 8 Aug 2018 14:25:48 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 8 Aug 2018 14:25:48 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Richard.Earnshaw@arm.com,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        neko@bakuhatsu.net, linux-pci <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CAK8P3a2=rVvvW8bBcrPm3nXNNP56Ygxchu4ThD2ZgZ_cVcd8wQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.1808081347180.18198@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com> <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com> <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com> <20180803094129.GB17798@arm.com> <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com> <20180808113927.GA24736@iMac.local>
 <alpine.LRH.2.02.1808081011110.9997@file01.intranet.prod.int.rdu2.redhat.com> <b1a0dac5-3cf2-1a7f-ac7f-649126eb7873@arm.com> <20180808151444.GF24736@iMac.local> <CAK8P3a2=rVvvW8bBcrPm3nXNNP56Ygxchu4ThD2ZgZ_cVcd8wQ@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 08 Aug 2018 18:25:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 08 Aug 2018 18:25:50 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Aug 2018, Arnd Bergmann wrote:

> On Wed, Aug 8, 2018 at 5:15 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > On Wed, Aug 08, 2018 at 04:01:12PM +0100, Richard Earnshaw wrote:
> > > On 08/08/18 15:12, Mikulas Patocka wrote:
> > > > On Wed, 8 Aug 2018, Catalin Marinas wrote:
> > > >> On Fri, Aug 03, 2018 at 01:09:02PM -0400, Mikulas Patocka wrote:
> > - failing to write a few bytes
> > - writing a few bytes that were written 16 bytes before
> > - writing a few bytes that were written 16 bytes after
> >
> > > The overlapping writes in memcpy never write different values to the
> > > same location, so I still feel this must be some sort of HW issue, not a
> > > SW one.
> >
> > So do I (my interpretation is that it combines or rather skips some of
> > the writes to the same 16-byte address as it ignores the data strobes).
> 
> Maybe it just always writes to the wrong location, 16 bytes apart for one of
> the stp instructions. Since we are usually dealing with a pair of overlapping
> 'stp', both unaligned, that could explain both the missing bytes (we write
> data to the wrong place, but overwrite it with the correct data right away)
> and the extra copy (we write it to the wrong place, but then write the correct
> data to the correct place as well).
> 
> This sounds a bit like what the original ARM CPUs did on unaligned
> memory access, where a single aligned 4-byte location was accessed,
> but the bytes swapped around.
> 
> There may be a few more things worth trying out or analysing from
> the recorded past failures to understand more about how it goes
> wrong:
> 
> - For which data lengths does it fail? Having two overlapping
>   unaligned stp is something that only happens for 16..96 byte
>   memcpy.

If you want to research the corruptions in detail, I uploaded a file 
containing 7k corruptions here: 
http://people.redhat.com/~mpatocka/testcases/arm-pcie-corruption/

> - What if we use a pair of str instructions instead of an stp in
>   a modified memcpy? Does it now write to still write to the
>   wrong place 16 bytes away, just 8 bytes away, or correctly?

I replaced all stp instructions with str and it didn't have effect on 
corruptions. Either a few bytes is omitted, or a value that belongs 16 
bytes before or after is written.

> - Does it change in any way if we do the overlapping writes
>   in the reverse order? E.g. for the 16..64 byte case:
> 
> diff --git a/sysdeps/aarch64/memcpy.S b/sysdeps/aarch64/memcpy.S
> index 7e1163e6a0..09d0160bdf 100644
> --- a/sysdeps/aarch64/memcpy.S
> +++ b/sysdeps/aarch64/memcpy.S
> @@ -102,11 +102,11 @@ ENTRY (MEMCPY)
>         tbz     tmp1, 5, 1f
>         ldp     B_l, B_h, [src, 16]
>         ldp     C_l, C_h, [srcend, -32]
> -       stp     B_l, B_h, [dstin, 16]
>         stp     C_l, C_h, [dstend, -32]
> +       stp     B_l, B_h, [dstin, 16]
>  1:
> -       stp     A_l, A_h, [dstin]
>         stp     D_l, D_h, [dstend, -16]
> +       stp     A_l, A_h, [dstin]
>         ret
> 
>         .p2align 4
> 
>         Arnd

After reordering them, I observe only omitted writes, there are no longer 
misdirected writes:

http://people.redhat.com/~mpatocka/testcases/arm-pcie-corruption/reorder-test/

Mikulas
