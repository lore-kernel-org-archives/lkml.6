Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C26C282C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 00:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25B920863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 00:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="VaEWkJXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfBKAW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 19:22:29 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51434 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbfBKAW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 19:22:28 -0500
Received: from zn.tnic (p200300EC2BE58200B5A7B0033B3D5267.dip0.t-ipconnect.de [IPv6:2003:ec:2be5:8200:b5a7:b003:3b3d:5267])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB3661EC0586;
        Mon, 11 Feb 2019 01:22:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549844546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iqPcVkwpo0LqSXzvTcGk1Z+ISLJHnx+I+d44+z93YWs=;
        b=VaEWkJXdD3d18A8jmDIN49HXuhZ2H+kQdkPII0U/13UW+oRO+coS80zOqBqK1Lxm8MVoIh
        8sHFbm2jUh1cu9VPbHBCPSn2NSh3nuSz22rm99f5oZGJkYVQlhbvzINOz8FT/NiyL7dDo5
        IiYz18L96SoroB9Qb+3LH4YjGV8T/S8=
Date:   Mon, 11 Feb 2019 01:22:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     fanc.fnst@cn.fujitsu.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        mingo@redhat.com, thomas.lendacky@amd.com,
        yamada.masahiro@socionext.com, caoj.fnst@cn.fujitsu.com,
        jgross@suse.com, mingo@kernel.org, keescook@chromium.org,
        x86@kernel.org, hpa@zytor.com, linux-tip-commits@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [tip:x86/boot] x86/boot: Early parse RSDP and save it in
 boot_params
Message-ID: <20190211002220.GD14948@zn.tnic>
References: <20190123110850.12433-6-fanc.fnst@cn.fujitsu.com>
 <tip-3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce@git.kernel.org>
 <20190208190248.GA10854@roeck-us.net>
 <20190208191024.GL674@zn.tnic>
 <20190208204451.GA14024@roeck-us.net>
 <20190208215322.GO674@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190208215322.GO674@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 10:53:22PM +0100, Borislav Petkov wrote:
> On Fri, Feb 08, 2019 at 12:44:51PM -0800, Guenter Roeck wrote:
> > Yes, the kernel boots if I comment out that function and have it return 0.
> 
> Thanks, this localizes the issue significantly.

Some observations:

                } else {
                        efi_config_table_32_t *tmp_table;

                        tmp_table = config_tables;
                        guid = tmp_table->guid;			<--- *
                        table = tmp_table->table;
                }

It blows up at that tmp_table->guid deref above. Singlestepping through
it with gdb shows:

# arch/x86/boot/compressed/acpi.c:114: 			guid = tmp_table->guid;
	movq	(%rdi), %rax	# MEM[(struct efi_config_table_32_t *)config_tables_37].guid, guid
	movq	8(%rdi), %rsi	# MEM[(struct efi_config_table_32_t *)config_tables_37].guid, guid
# arch/x86/boot/compressed/acpi.c:115: 			table = tmp_table->table;
	movl	16(%rdi), %r10d	# MEM[(struct efi_config_table_32_t *)config_tables_37].table, table
	jmp	.L30	#

and %rdi has:

	rdi            0x630646870

which is an address above 4G but we're using a 32-bit EFI BIOS.

Which begs the question whether EFI system tables can even be mapped at
something above 4G with a 32-bit EFI and whether that could work ok.
Hmm.

Lemme add Ard and mfleming for insight here.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
