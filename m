Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A23C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803E721479
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbfBKKKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:10:24 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:61033 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725931AbfBKKKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:10:23 -0500
X-IronPort-AV: E=Sophos;i="5.58,358,1544457600"; 
   d="scan'208";a="54053644"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Feb 2019 18:10:21 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id A61BF4BAD9DB;
        Mon, 11 Feb 2019 18:10:20 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 11 Feb 2019 18:10:26 +0800
Date:   Mon, 11 Feb 2019 18:10:11 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     Borislav Petkov <bp@alien8.de>, Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        <caoj.fnst@cn.fujitsu.com>, Juergen Gross <jgross@suse.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        <linux-tip-commits@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [tip:x86/boot] x86/boot: Early parse RSDP and save it in
 boot_params
Message-ID: <20190211101011.GA5333@localhost.localdomain>
References: <20190123110850.12433-6-fanc.fnst@cn.fujitsu.com>
 <tip-3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce@git.kernel.org>
 <20190208190248.GA10854@roeck-us.net>
 <20190208191024.GL674@zn.tnic>
 <20190208204451.GA14024@roeck-us.net>
 <20190208215322.GO674@zn.tnic>
 <20190211002220.GD14948@zn.tnic>
 <CAKv+Gu-6bxRrn7Ft4cRYzB1Jgca=L_d1u5OU1nUzLe7SBEd=xQ@mail.gmail.com>
 <20190211095547.GB1651@localhost.localdomain>
 <CAKv+Gu_r4Vz2BRpRyJ=UsM1r-+CbyP6heggL+qsKKhJ_iTWhFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_r4Vz2BRpRyJ=UsM1r-+CbyP6heggL+qsKKhJ_iTWhFg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: A61BF4BAD9DB.A26AE
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 09:57:02AM +0000, Ard Biesheuvel wrote:
>On Mon, 11 Feb 2019 at 10:56, Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>>
>> On Mon, Feb 11, 2019 at 09:46:03AM +0000, Ard Biesheuvel wrote:
>> >On Mon, 11 Feb 2019 at 01:22, Borislav Petkov <bp@alien8.de> wrote:
>> >>
>> >> On Fri, Feb 08, 2019 at 10:53:22PM +0100, Borislav Petkov wrote:
>> >> > On Fri, Feb 08, 2019 at 12:44:51PM -0800, Guenter Roeck wrote:
>> >> > > Yes, the kernel boots if I comment out that function and have it return 0.
>> >> >
>> >> > Thanks, this localizes the issue significantly.
>> >>
>> >> Some observations:
>> >>
>> >>                 } else {
>> >>                         efi_config_table_32_t *tmp_table;
>> >>
>> >>                         tmp_table = config_tables;
>> >>                         guid = tmp_table->guid;                 <--- *
>> >>                         table = tmp_table->table;
>> >>                 }
>> >>
>> >> It blows up at that tmp_table->guid deref above. Singlestepping through
>> >> it with gdb shows:
>> >>
>> >> # arch/x86/boot/compressed/acpi.c:114:                  guid = tmp_table->guid;
>> >>         movq    (%rdi), %rax    # MEM[(struct efi_config_table_32_t *)config_tables_37].guid, guid
>> >>         movq    8(%rdi), %rsi   # MEM[(struct efi_config_table_32_t *)config_tables_37].guid, guid
>> >> # arch/x86/boot/compressed/acpi.c:115:                  table = tmp_table->table;
>> >>         movl    16(%rdi), %r10d # MEM[(struct efi_config_table_32_t *)config_tables_37].table, table
>> >>         jmp     .L30    #
>> >>
>> >> and %rdi has:
>> >>
>> >>         rdi            0x630646870
>> >>
>> >> which is an address above 4G but we're using a 32-bit EFI BIOS.
>> >>
>> >> Which begs the question whether EFI system tables can even be mapped at
>> >> something above 4G with a 32-bit EFI and whether that could work ok.
>> >> Hmm.
>> >>
>> >> Lemme add Ard and mfleming for insight here.
>> >>
>> >
>> >-ENOCONTEXT, but let me try in any case:
>> >
>> >linux/efi.h has
>> >
>> >typedef struct {
>> >  efi_guid_t guid;
>> >  u32 table;
>> >} efi_config_table_32_t;
>> >
>> >so if we end up with more than 32 bits set in table, there is
>> >something seriously wrong.
>> >
>> >The size of efi_config_table_32_t deviates from efi_config_table_64_t,
>> >so you will have to ensure that you are using the correct stride when
>> >iterating over config_tables.
>>
>> Here I use signature to judge it.
>> If the signature is EFI64_LOADER_SIGNATURE, I will use efi_config_table_64_t,
>> if the signature is EFI32_LOADER_SIGNATURE, I will use efi_config_table_32_t.
>> But the efi32 whose signature is EFI32_LOADER_SIGNATURE points to a
>> address above 4G, I am not sure whether this is normal and works well.
>>
>
>This is impossible. The 'table' member of efi_config_table_32_t is
>only 32 bits wide, so how can it contain an address over 4 GB ?

Maybe I mislead you. In my code, I need to find the eficonfig_table_*.
After that, I should type cast it to right
efi_config_table_32_t or efi_config_table_64_t.

Then my judgment is to compare its efi_info->efi_loader_signature.
If it's EFI64_LOADER_SIGNATURE, I will type cast it to efi_config_table_64_t.
If it's EFI32_LOADER_SIGNATURE, I will type cast it to efi_config_table_32_t.

But here is a issue, its signature matches EFI32_LOADER_SIGNATURE, but
it's table member is above 4G, but I use efi_config_table_32_t. That cause a problem.

Thanks,
Chao Fan

>
>


