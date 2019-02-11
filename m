Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B528C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6752084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="bTSU/E38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfBKKnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:43:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54586 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfBKKnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:43:01 -0500
Received: from zn.tnic (p200300EC2BC7A100B5A7B0033B3D5267.dip0.t-ipconnect.de [IPv6:2003:ec:2bc7:a100:b5a7:b003:3b3d:5267])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BC6E21EC0375;
        Mon, 11 Feb 2019 11:42:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549881779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Nr/Fd2YfVswTbKv5rabrY3ZCWtBZZLHkV3QVFJRS6tY=;
        b=bTSU/E38U29kvxvqqrsHIZJOwQb5gjSkl13IdQjGmrezAA7w8iQNAh9bfasTu9knHgrqOS
        3aXJkAKRlIr/ikDqpmkBaUvD6msgBg6I4sqQJghVz6RjbcwU6bDarYuwbK0rgpvw2/s5L0
        ifTgQ1ZbpKhNXeLJrn8Dux5kvkhnIqY=
Date:   Mon, 11 Feb 2019 11:42:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        caoj.fnst@cn.fujitsu.com, Juergen Gross <jgross@suse.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-tip-commits@vger.kernel.org,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [tip:x86/boot] x86/boot: Early parse RSDP and save it in
 boot_params
Message-ID: <20190211104254.GB19618@zn.tnic>
References: <20190208191024.GL674@zn.tnic>
 <20190208204451.GA14024@roeck-us.net>
 <20190208215322.GO674@zn.tnic>
 <20190211002220.GD14948@zn.tnic>
 <CAKv+Gu-6bxRrn7Ft4cRYzB1Jgca=L_d1u5OU1nUzLe7SBEd=xQ@mail.gmail.com>
 <20190211095547.GB1651@localhost.localdomain>
 <CAKv+Gu_r4Vz2BRpRyJ=UsM1r-+CbyP6heggL+qsKKhJ_iTWhFg@mail.gmail.com>
 <20190211101011.GA5333@localhost.localdomain>
 <CAKv+Gu-Tv=Wxhp9k_f4q+AZ+Wqc+joXrnpbz7aKD=75ZKp2Xcw@mail.gmail.com>
 <20190211102426.GA19618@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190211102426.GA19618@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 11:24:26AM +0100, Borislav Petkov wrote:
> It is only an observation for now though...

Ok, now I did this:

        for (i = 0; i < systab->nr_tables; i++) {
                acpi_physical_address table;
                void *config_tables;
                efi_guid_t guid;

                if ((unsigned long)systab->tables >> 32)			<---
                        asm volatile("1:\n jmp 1b");

                config_tables = (void *)(systab->tables + size * i);

It did stop at the endless loop there which would mean that
systab->tables is simply pointing somewhere into the weeds.

Asm is:

---
# arch/x86/boot/compressed/acpi.c:96: 			asm volatile("1:\n jmp 1b");
#APP
# 96 "arch/x86/boot/compressed/acpi.c" 1
	1:
 jmp 1b
# 0 "" 2
#NO_APP
	movq	112(%rcx), %rdi	# systab_147->tables, _31
.L29:
# arch/x86/boot/compressed/acpi.c:98: 		config_tables = (void *)(systab->tables + size * i);
	addq	%r9, %rdi	# ivtmp.64, config_tables
# arch/x86/boot/compressed/acpi.c:104: 			guid = tmp_table->guid;
---

and RDI is

rdi            0x630646870

in gdb.

systab itself gets computed to something low: 0x3fedb010.

Hmmm. Could it be that that EDK BIOS image is buggy?

[    0.000000] efi: EFI v2.70 by EDK II
[    0.000000] efi:  SMBIOS=0x3feb9000  ACPI=0x3fee7000  ACPI 2.0=0x3fee7014  MEMATTR=0x3f524110

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
