Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CABDC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042B420850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="bwu65YBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 042B420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbeLDSmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:42:22 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45976 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbeLDSmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:42:22 -0500
Received: from zn.tnic (p200300EC2BC7BF005D01DF6409406D0C.dip0.t-ipconnect.de [IPv6:2003:ec:2bc7:bf00:5d01:df64:940:6d0c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B72861EC0229;
        Tue,  4 Dec 2018 19:42:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1543948940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KRmQEtasXuhZ60ezXPZRXhVP7Pef7diVugS2FTeUVZE=;
        b=bwu65YBDYhEB72lq8VxNNnHpcOs31v31gZLLHvaqR1qvwAEtFnEsQCoxX084a2pxX6cwhH
        o2Wojvr6qkbJxyuRXIIyj2V32cqGoPby3/FB+ku13Q4XFMff+nE6+uQzPAft0ZUZMQGav5
        KjcXEmkVXFWN4eon1FnXMtaNj0Yk7rE=
Date:   Tue, 4 Dec 2018 19:42:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, keescook@chromium.org,
        bhe@redhat.com, indou.takao@jp.fujitsu.com,
        caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v12 1/5] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdline from KEXEC
Message-ID: <20181204184220.GC16705@zn.tnic>
References: <20181129081631.11139-1-fanc.fnst@cn.fujitsu.com>
 <20181129081631.11139-2-fanc.fnst@cn.fujitsu.com>
 <20181129211003.saxfvyboxpsn5mdr@gabell>
 <20181130024346.GB30941@localhost.localdomain>
 <20181130173515.6zx5wvs52s5aqnge@gabell>
 <20181201060539.GD30941@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181201060539.GD30941@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 01, 2018 at 02:05:39PM +0800, Chao Fan wrote:
> >I built your whole patchset and got the error.
> >The error depends on CONFIG_MODVERSIONS.
> >If CONFIG_MODVERSIONS=y, you will get the build error.
> 
> Hi Masa,
> 
> Thanks, after that, I got the error.
> About your solution, it can fix the error. But I am not sure whether
> it's good.

What does CONFIG_MODVERSIONS=y have to do with this? I don't see the
connection.

Also, your patch triggers another build error:

ld -m elf_x86_64 -z noreloc-overflow -pie --no-dynamic-linker   -T arch/x86/boot/compressed/vmlinux.lds arch/x86/boot/compressed/head_64.o arch/x86/boot/compressed/misc.o arch/x86/boot/compressed/string.o arch/x86/boot/compressed/cmdline.o arch/x86/boot/compressed/error.o arch/x86/boot/compressed/piggy.o arch/x86/boot/compressed/cpuflags.o arch/x86/boot/compressed/early_serial_console.o arch/x86/boot/compressed/mem_encrypt.o arch/x86/boot/compressed/pgtable_64.o arch/x86/boot/compressed/eboot.o arch/x86/boot/compressed/efi_stub_64.o drivers/firmware/efi/libstub/lib.a arch/x86/boot/compressed/efi_thunk_64.o -o arch/x86/boot/compressed/vmlinux
ld: arch/x86/boot/compressed/misc.o: in function `_parse_integer_fixup_radix':
misc.c:(.text+0x3057): undefined reference to `_ctype'
make[2]: *** [arch/x86/boot/compressed/Makefile:116: arch/x86/boot/compressed/vmlinux] Error 1
make[1]: *** [arch/x86/boot/Makefile:112: arch/x86/boot/compressed/vmlinux] Error 2
make: *** [arch/x86/Makefile:289: bzImage] Error 2
make: *** Waiting for unfinished jobs....

due to misc.o not seeing _ctype.

Looks like this is going to become too hairy and perhaps it would
be easier and cleaner if you copy all the functions needed into
arch/x86/boot/cmdline.c and this way get rid of the crazy ifdeffery and
the subtle build issues.

I mean, we do this already in other places like perf tool is copying
stuff selectively from kernel proper and since compressed/ is a
completely separate stage, we probably should do that for the sake of
keeping our sanity. :)

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
