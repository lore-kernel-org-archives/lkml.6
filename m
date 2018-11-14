Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8031EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368F221780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPySrwYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368F221780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733277AbeKOBTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:19:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:47548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbeKOBTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:19:22 -0500
Received: from linux-8ccs (ip5f5adbda.dynamic.kabel-deutschland.de [95.90.219.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A10E2145D;
        Wed, 14 Nov 2018 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542208543;
        bh=hp3uylkoAMgyZlxB0Hc2iw4YMEXYFcY4KJzlFq6mGtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aPySrwYqkVyrW5dRAUeM1jjbDK1XBouxqxkydt6pTb3QaA0GH3oaKQGIgWROqeP30
         euyowGvktpv1wCzjy1IlUfINVCeG1jxqh+/mPsCmlqi7q0HPhEdNEnzGJKHuqieLVC
         LZdiX0nhW1eaqQpOSzrfPavo0kigVQm9gyjz2DGw=
Date:   Wed, 14 Nov 2018 16:15:37 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: Re: [PATCH v3] ARM: module: Fix function kallsyms on Thumb-2
Message-ID: <20181114151537.GA13928@linux-8ccs>
References: <20181113112745.15945-1-vincent.whitchurch@axis.com>
 <20181113135705.GI3505@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181113135705.GI3505@e103592.cambridge.arm.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.22-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Dave Martin [13/11/18 13:57 +0000]:
>On Tue, Nov 13, 2018 at 12:27:45PM +0100, Vincent Whitchurch wrote:
>> Thumb-2 functions have the lowest bit set in the symbol value in the
>> symtab.  When kallsyms are generated for the vmlinux, the kallsyms are
>> generated from the output of nm, and nm clears the lowest bit.
>>
>>  $ arm-linux-gnueabihf-readelf -a vmlinux | grep show_interrupts
>>   95947: 8015dc89   686 FUNC    GLOBAL DEFAULT    2 show_interrupts
>>  $ arm-linux-gnueabihf-nm vmlinux | grep show_interrupts
>>  8015dc88 T show_interrupts
>>  $ cat /proc/kallsyms | grep show_interrupts
>>  8015dc88 T show_interrupts
>>
>> However, for modules, the kallsyms uses the values in the symbol table
>> without modification, so for functions in modules, the lowest bit is set
>> in kallsyms.
>>
>>  $ arm-linux-gnueabihf-readelf -a drivers/net/tun.ko | grep tun_get_socket
>>     268: 000000e1    44 FUNC    GLOBAL DEFAULT    2 tun_get_socket
>>  $ arm-linux-gnueabihf-nm drivers/net/tun.ko | grep tun_get_socket
>>  000000e0 T tun_get_socket
>>  $ cat /proc/kallsyms | grep tun_get_socket
>>  7fcd30e1 t tun_get_socket  [tun]
>>
>> Because of this, the offset of the crashing instruction shown in oopses
>> is incorrect when the crash is in a module.  For example, given a
>> tun_get_socket which starts like this,
>>
>>  000000e0 <tun_get_socket>:
>>        e0:       b500            push    {lr}
>>        e2:       f7ff fffe       bl      0 <__gnu_mcount_nc>
>>        e6:       4b08            ldr     r3, [pc, #32]
>>        e8:       6942            ldr     r2, [r0, #20]
>>        ea:       429a            cmp     r2, r3
>>        ec:       d002            beq.n   f4 <tun_get_socket+0x14>
>>
>> a crash when tun_get_socket is called with NULL results in:
>>
>>  PC is at tun_get_socket+0x7/0x2c [tun]
>>  pc : [<7fcdb0e8>]
>>
>> which can result in the incorrect line being reported by gdb if this
>> symbol+offset is used there.  If the crash is on the first instruction
>> of a function, the "PC is at" line would also report the symbol name of
>> the preceding function.
>>
>> To solve this, introduce a weak module_kallsyms_symbol_value() function
>> which arches can override to fix up these symbol values, and implement
>
>(Jumping into this patch without having reviewed previous versions in
>detail, so I may have misunderstood some things...)
>
>
>Anyway:
>
>I prefer this to the previous approach of directly hacking the symbol
>values in the module kallsyms table.
>
>> this for Thumb-2.  We need to move elf_type() to st_other so that the
>> original value of st_info is preserved.
>
>Are you sure modifying st_other won't break anything?
>
>It's hard to imagine how ELF symbol visibility would be relevant in the
>kernel, but some arches put other stuff in st_other.  See alpha,
>powerpc, sh for example.  I haven't attempted to understand whether any
>of those uses matters here.

Yeah, the st_other field is used to apply relocations in those arches
you mention. Overwriting st_info/st_other only "works" here in the
sense that that field is no longer needed after applying relocations
(add_kallsyms() is called in post_relocation() in the module loader).
I agree it's hacky to reuse the field in that way, though.

>Ideally, we wouldn't abuse st_info to store elf_type() in the first
>place, but that may be messier to solve.  kallsyms could wrap the
>ElfXX_Sym in another struct to store extra metadata for example, but it
>would increase runtime memory consumption.

Yeah, I've always thought that was ugly. I think it was done as a
small optimization for kallsyms, so that we're not looking up what
char to print for every symbol, so the st_info field was repurposed
for this.

>Another option would be wedge STT_FUNC in bit 7 of st_info, say.
>Since elf_type() always yields an ASCII char, that bit shouldn't be
>used for anything today.  We would of course need to wrap further
>access to st_info to mask that bit off as appropriate.

Hm, actually on second thought, I don't think the st_size field is
used *anywhere* in the module loader, not in the arch-specific
relocation code nor in kallsyms. Perhaps that field could be used to
store the output of elf_type instead. Then we won't run into any
issues with delayed relocations with livepatch, as the st_size field
isn't used at all for applying relocs anyway. Since this field is not
used at runtime, I think we can use st_size instead of st_other or
st_info, which are two fields that some arches do use to apply relocs.
Would be great if someone could confirm/fact-check me on this.

Thanks!

Jessica


