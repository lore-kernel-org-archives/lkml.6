Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791A4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA4F2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA4F2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732895AbeKNUXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:23:04 -0500
Received: from ozlabs.org ([203.11.71.1]:51509 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbeKNUXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 15:23:04 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42w0qr3yQXz9s7W;
        Wed, 14 Nov 2018 21:20:24 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Joel Stanley <joel@jms.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alan Modra <amodra@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warnings from Linus' tree
In-Reply-To: <CACPK8XeDHt46rUJWQ1n=4fRWioogs9K0Z8dkxUa=E2ShfQ1Vdg@mail.gmail.com>
References: <20180612081413.323d85b8@canb.auug.org.au> <CACPK8XeDHt46rUJWQ1n=4fRWioogs9K0Z8dkxUa=E2ShfQ1Vdg@mail.gmail.com>
Date:   Wed, 14 Nov 2018 21:20:23 +1100
Message-ID: <87k1lgufiw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Stanley <joel@jms.id.au> writes:
> Hello Alan,
>
> On Tue, 12 Jun 2018 at 07:44, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
>> Building Linus' tree, today's linux-next build (powerpc ppc64_defconfig)
>> produced these warning:
>>
>> ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
>> ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
>> ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
>>
>> This may just be because I have started building using the native Debian
>> gcc for the powerpc builds ...
>
> Do you know why we started creating these?

It's controlled by the ld option --hash-style, which AFAICS still
defaults to sysv (generating .hash).

But it seems gcc can be configured to have a different default, and at
least my native ppc64le toolchains are passing gnu, eg:

 /usr/lib/gcc/powerpc64le-linux-gnu/6/collect2 -plugin
 /usr/lib/gcc/powerpc64le-linux-gnu/6/liblto_plugin.so
 -plugin-opt=/usr/lib/gcc/powerpc64le-linux-gnu/6/lto-wrapper
 -plugin-opt=-fresolution=/tmp/ccw1U2fF.res
 -plugin-opt=-pass-through=-lgcc -plugin-opt=-pass-through=-lgcc_s
 -plugin-opt=-pass-through=-lc -plugin-opt=-pass-through=-lgcc
 -plugin-opt=-pass-through=-lgcc_s --sysroot=/ --build-id --eh-frame-hdr
 -V -shared -m elf64lppc
 --hash-style=gnu
 ^^^^^^^^^^^^^^^^

So that's presumably why we're seeing it, some GCCs are configured to
use it.

> If it's intentional, should we be putting including them in the same
> way as .hash sections?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/kernel/vmlinux.lds.S#n282
>
>   .hash : AT(ADDR(.hash) - LOAD_OFFSET) { *(.hash) }

That would presumably work.

My question though is do we even need it?

From what I can see for it to be useful you need the section as well as
an entry in the dynamic section pointing at it, and we don't have a
dynamic section at all:

  $ readelf -S vmlinux | grep gnu.hash
    [ 4] .gnu.hash         GNU_HASH         c000000000dbbdb0  00dcbdb0
  $ readelf -d vmlinux
  
  There is no dynamic section in this file.

Compare to the vdso:

$ readelf -d arch/powerpc/kernel/vdso64/vdso64.so

Dynamic section at offset 0x868 contains 12 entries:
  Tag        Type                         Name/Value
 0x000000000000000e (SONAME)             Library soname: [linux-vdso64.so.1]
 0x0000000000000004 (HASH)               0x120
 0x000000006ffffef5 (GNU_HASH)           0x170
 0x0000000000000005 (STRTAB)             0x320
 0x0000000000000006 (SYMTAB)             0x1d0
 0x000000000000000a (STRSZ)              269 (bytes)
 0x000000000000000b (SYMENT)             24 (bytes)
 0x0000000070000003 (PPC64_OPT)          0x0
 0x000000006ffffffc (VERDEF)             0x450
 0x000000006ffffffd (VERDEFNUM)          2
 0x000000006ffffff0 (VERSYM)             0x42e
 0x0000000000000000 (NULL)               0x0


So can't we just discard .gnu.hash? And in fact do we need .hash either?

Actually arm64 discards the latter, and parisc discards both.

Would still be good to hear from Alan or someone else who knows anything
about toolchain stuff, ie. not me :)

cheers
