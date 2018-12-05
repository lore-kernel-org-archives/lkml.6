Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF5AC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3812082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3812082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeLEBlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:41:10 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:50214 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725841AbeLEBlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:41:03 -0500
X-IronPort-AV: E=Sophos;i="5.56,316,1539619200"; 
   d="scan'208";a="49008367"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Dec 2018 09:41:01 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 275524B7349F;
        Wed,  5 Dec 2018 09:40:59 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 5 Dec 2018 09:41:03 +0800
Date:   Wed, 5 Dec 2018 09:40:44 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v12 1/5] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdline from KEXEC
Message-ID: <20181205014044.GF30941@localhost.localdomain>
References: <20181129081631.11139-1-fanc.fnst@cn.fujitsu.com>
 <20181129081631.11139-2-fanc.fnst@cn.fujitsu.com>
 <20181129211003.saxfvyboxpsn5mdr@gabell>
 <20181130024346.GB30941@localhost.localdomain>
 <20181130173515.6zx5wvs52s5aqnge@gabell>
 <20181201060539.GD30941@localhost.localdomain>
 <20181204184220.GC16705@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181204184220.GC16705@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 275524B7349F.AB249
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 07:42:20PM +0100, Borislav Petkov wrote:
>On Sat, Dec 01, 2018 at 02:05:39PM +0800, Chao Fan wrote:
>> >I built your whole patchset and got the error.
>> >The error depends on CONFIG_MODVERSIONS.
>> >If CONFIG_MODVERSIONS=y, you will get the build error.
>> 
>> Hi Masa,
>> 
>> Thanks, after that, I got the error.
>> About your solution, it can fix the error. But I am not sure whether
>> it's good.
>
>What does CONFIG_MODVERSIONS=y have to do with this? I don't see the
>connection.
>
>Also, your patch triggers another build error:
>
>ld -m elf_x86_64 -z noreloc-overflow -pie --no-dynamic-linker   -T arch/x86/boot/compressed/vmlinux.lds arch/x86/boot/compressed/head_64.o arch/x86/boot/compressed/misc.o arch/x86/boot/compressed/string.o arch/x86/boot/compressed/cmdline.o arch/x86/boot/compressed/error.o arch/x86/boot/compressed/piggy.o arch/x86/boot/compressed/cpuflags.o arch/x86/boot/compressed/early_serial_console.o arch/x86/boot/compressed/mem_encrypt.o arch/x86/boot/compressed/pgtable_64.o arch/x86/boot/compressed/eboot.o arch/x86/boot/compressed/efi_stub_64.o drivers/firmware/efi/libstub/lib.a arch/x86/boot/compressed/efi_thunk_64.o -o arch/x86/boot/compressed/vmlinux
>ld: arch/x86/boot/compressed/misc.o: in function `_parse_integer_fixup_radix':
>misc.c:(.text+0x3057): undefined reference to `_ctype'
>make[2]: *** [arch/x86/boot/compressed/Makefile:116: arch/x86/boot/compressed/vmlinux] Error 1
>make[1]: *** [arch/x86/boot/Makefile:112: arch/x86/boot/compressed/vmlinux] Error 2
>make: *** [arch/x86/Makefile:289: bzImage] Error 2
>make: *** Waiting for unfinished jobs....
>
>due to misc.o not seeing _ctype.
>
>Looks like this is going to become too hairy and perhaps it would
>be easier and cleaner if you copy all the functions needed into
>arch/x86/boot/cmdline.c and this way get rid of the crazy ifdeffery and
>the subtle build issues.
>
>I mean, we do this already in other places like perf tool is copying
>stuff selectively from kernel proper and since compressed/ is a
>completely separate stage, we probably should do that for the sake of
>keeping our sanity. :)

Thank you, I will do the copying job and consider more about putting
functions to arch/x86/boot/cmdline.c or arch/x86/boot/string.c.
Anyway, this method is simple.

Thanks,
Chao Fan

>
>Thx.
>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


