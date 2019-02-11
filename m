Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F5EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A1D20838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="d0WOfzbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfBKLE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 06:04:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58106 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfBKLE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 06:04:58 -0500
Received: from zn.tnic (p200300EC2BC7A100B5A7B0033B3D5267.dip0.t-ipconnect.de [IPv6:2003:ec:2bc7:a100:b5a7:b003:3b3d:5267])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 245C11EC0375;
        Mon, 11 Feb 2019 12:04:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549883096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4FY4e3BcXb4F+LDstC9JcCKC1VQbKeu3f5eLlIoEVJs=;
        b=d0WOfzbHtBo87iggkP0BLZLBwS9EJo8kGRFku/IXFYKHRDlEfcxN3tIzteUakxg/Dtdd84
        iS+QilIgO+pDEWXjfULOi46/KhqYgf+cv0X9ENmuePfV0dVgVetZb7ghAjLeeG7lwdnVD3
        NGCFBRSL7sco9jbzCr4RgWP9/qlQnqc=
Date:   Mon, 11 Feb 2019 12:04:51 +0100
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
Message-ID: <20190211110451.GD19618@zn.tnic>
References: <20190208215322.GO674@zn.tnic>
 <20190211002220.GD14948@zn.tnic>
 <CAKv+Gu-6bxRrn7Ft4cRYzB1Jgca=L_d1u5OU1nUzLe7SBEd=xQ@mail.gmail.com>
 <20190211095547.GB1651@localhost.localdomain>
 <CAKv+Gu_r4Vz2BRpRyJ=UsM1r-+CbyP6heggL+qsKKhJ_iTWhFg@mail.gmail.com>
 <20190211101011.GA5333@localhost.localdomain>
 <CAKv+Gu-Tv=Wxhp9k_f4q+AZ+Wqc+joXrnpbz7aKD=75ZKp2Xcw@mail.gmail.com>
 <20190211102426.GA19618@zn.tnic>
 <20190211104254.GB19618@zn.tnic>
 <CAKv+Gu9mm-w66ZZrd7WhuD3_iELS5vUJ0-1DtRq1GDjSsDNEVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9mm-w66ZZrd7WhuD3_iELS5vUJ0-1DtRq1GDjSsDNEVg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:46:18AM +0000, Ard Biesheuvel wrote:
> As I pointed out in my previous reply, systab will be the wrong type
> on 32-bit firmware, it needs to be efi_system_table_32_t

Yeah, that seems to work. It boots now and it says:

[    0.000000] efi: No EFI runtime due to 32/64-bit mismatch with kernel

Do you think we should mirror that behavoir early too, so that people
don't get any ideas?

Or should we limit that only to the RDSP address computation and
anything else where kernel and EFI bitness mismatch should be disabled?

Thanks Ard!

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
