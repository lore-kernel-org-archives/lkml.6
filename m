Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2AEC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16AC42080D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="b9RqRHHg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfBKKYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:24:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51132 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfBKKYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:24:33 -0500
Received: from zn.tnic (p200300EC2BC7A100B5A7B0033B3D5267.dip0.t-ipconnect.de [IPv6:2003:ec:2bc7:a100:b5a7:b003:3b3d:5267])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E2F8E1EC0375;
        Mon, 11 Feb 2019 11:24:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549880672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=m9/LoAt94FMqZmVWZD6o6m5wRiZgEpd14L508jUz4QE=;
        b=b9RqRHHgJxwX6WNnSMHGbiFeD54+OwR7RgJEzFsogZ0dCpIKG3zzsFNHzMQrpLZ+ux3P1v
        xYuWN0x6SWgbYoYLzOda4k3PGEHkiN3LM/m+VgpkVOprt7XbQXZYh99qSK+eJmaFXzF0BF
        1tgE3olXUnYSv2zKceVaFznL2nwNtRk=
Date:   Mon, 11 Feb 2019 11:24:26 +0100
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
Message-ID: <20190211102426.GA19618@zn.tnic>
References: <20190208190248.GA10854@roeck-us.net>
 <20190208191024.GL674@zn.tnic>
 <20190208204451.GA14024@roeck-us.net>
 <20190208215322.GO674@zn.tnic>
 <20190211002220.GD14948@zn.tnic>
 <CAKv+Gu-6bxRrn7Ft4cRYzB1Jgca=L_d1u5OU1nUzLe7SBEd=xQ@mail.gmail.com>
 <20190211095547.GB1651@localhost.localdomain>
 <CAKv+Gu_r4Vz2BRpRyJ=UsM1r-+CbyP6heggL+qsKKhJ_iTWhFg@mail.gmail.com>
 <20190211101011.GA5333@localhost.localdomain>
 <CAKv+Gu-Tv=Wxhp9k_f4q+AZ+Wqc+joXrnpbz7aKD=75ZKp2Xcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-Tv=Wxhp9k_f4q+AZ+Wqc+joXrnpbz7aKD=75ZKp2Xcw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:17:36AM +0000, Ard Biesheuvel wrote:
> That still does not explain how 'table' can assume a value > 4 GB
> after assigning the contents of a u32 to it.

See efi_get_rsdp_addr() in tip/master and especially that systable address
computation:

#ifdef CONFIG_X86_64
        systab = (efi_system_table_t *)(ei->efi_systab | ((__u64)ei->efi_systab_hi<<32));
#else
        if (ei->efi_systab_hi || ei->efi_memmap_hi) {
                debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");
                return 0;
        }
        systab = (efi_system_table_t *)ei->efi_systab;
#endif

	...

	config_tables = (void *)(systab->tables + size * i);

It is hard to debug that early but I managed to singlestep it last night
to this deref:

              } else {
                        efi_config_table_32_t *tmp_table;

                        tmp_table = config_tables;
                        guid = tmp_table->guid;
				^^^^^^^^^^^^^^

                        table = tmp_table->table;

which in asm is:

# arch/x86/boot/compressed/acpi.c:114: 			guid = tmp_table->guid;
#NO_APP
	movq	(%rdi), %rax	# MEM[(struct efi_config_table_32_t *)config_tables_37].guid, guid
	movq	8(%rdi), %rsi	# MEM[(struct efi_config_table_32_t *)config_tables_37].guid, guid
# arch/x86/boot/compressed/acpi.c:115: 			table = tmp_table->table;
	movl	16(%rdi), %r10d	# MEM[(struct efi_config_table_32_t *)config_tables_37].table, table

and %rdi has 0x630646870 so either we got the wrong address or qemu
mapped it above 4G...

It is only an observation for now though...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
