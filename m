Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02D0C282C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D942146F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfBKBdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 20:33:36 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:26517 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726032AbfBKBdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 20:33:35 -0500
X-IronPort-AV: E=Sophos;i="5.58,357,1544457600"; 
   d="scan'208";a="54006975"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Feb 2019 09:33:34 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 9F5FC4BAD925;
        Mon, 11 Feb 2019 09:33:31 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 11 Feb 2019 09:33:34 +0800
Date:   Mon, 11 Feb 2019 09:33:23 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Guenter Roeck <linux@roeck-us.net>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <kirill.shutemov@linux.intel.com>,
        <mingo@redhat.com>, <thomas.lendacky@amd.com>,
        <yamada.masahiro@socionext.com>, <caoj.fnst@cn.fujitsu.com>,
        <jgross@suse.com>, <mingo@kernel.org>, <keescook@chromium.org>,
        <x86@kernel.org>, <hpa@zytor.com>,
        <linux-tip-commits@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [tip:x86/boot] x86/boot: Early parse RSDP and save it in
 boot_params
Message-ID: <20190211013323.GB1544@localhost.localdomain>
References: <20190123110850.12433-6-fanc.fnst@cn.fujitsu.com>
 <tip-3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce@git.kernel.org>
 <20190208190248.GA10854@roeck-us.net>
 <20190208191024.GL674@zn.tnic>
 <20190208204451.GA14024@roeck-us.net>
 <20190208215322.GO674@zn.tnic>
 <20190211002220.GD14948@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190211002220.GD14948@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 9F5FC4BAD925.AEE04
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 01:22:20AM +0100, Borislav Petkov wrote:
>On Fri, Feb 08, 2019 at 10:53:22PM +0100, Borislav Petkov wrote:
>> On Fri, Feb 08, 2019 at 12:44:51PM -0800, Guenter Roeck wrote:
>> > Yes, the kernel boots if I comment out that function and have it return 0.
>> 
>> Thanks, this localizes the issue significantly.
>
>Some observations:
>
>                } else {
>                        efi_config_table_32_t *tmp_table;
>
>                        tmp_table = config_tables;
>                        guid = tmp_table->guid;			<--- *
>                        table = tmp_table->table;
>                }
>
>It blows up at that tmp_table->guid deref above. Singlestepping through
>it with gdb shows:
>
># arch/x86/boot/compressed/acpi.c:114: 			guid = tmp_table->guid;
>	movq	(%rdi), %rax	# MEM[(struct efi_config_table_32_t *)config_tables_37].guid, guid
>	movq	8(%rdi), %rsi	# MEM[(struct efi_config_table_32_t *)config_tables_37].guid, guid
># arch/x86/boot/compressed/acpi.c:115: 			table = tmp_table->table;
>	movl	16(%rdi), %r10d	# MEM[(struct efi_config_table_32_t *)config_tables_37].table, table
>	jmp	.L30	#
>
>and %rdi has:
>
>	rdi            0x630646870
>
>which is an address above 4G but we're using a 32-bit EFI BIOS.
>
>Which begs the question whether EFI system tables can even be mapped at
>something above 4G with a 32-bit EFI and whether that could work ok.
>Hmm.

Thanks for your help. As you said, I am not wure whether 32-bit EFI can
map table address above 4G.
If the map method has problem, I think adding a check here can work.

Thanks,
Chao Fan

>
>Lemme add Ard and mfleming for insight here.
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


