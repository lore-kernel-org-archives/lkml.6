Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D02C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D172175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZW7+SbnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfBGMRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:17:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59326 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfBGMRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:17:44 -0500
Received: from zn.tnic (p200300EC2BD1880034901D79874D129C.dip0.t-ipconnect.de [IPv6:2003:ec:2bd1:8800:3490:1d79:874d:129c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3F4831EC01AF;
        Thu,  7 Feb 2019 13:17:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549541861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=A8Cyi9FsctFQg1reS4e416nOpGL9/m9gfB3WKNmLr5w=;
        b=ZW7+SbnWyI4WaQasfoXxmPf+VBst3IdtOsw6FbILJm0FlLcRDIr1QSKsqQOYSY6Dsut1mX
        5XCOImqkeJ9/arIGz+1G/J5Tbek9dwsxVCeqCxM716K4k6RxJI5SMxyjkDOh/Jxo5PI1N1
        hRMjJEkp9bFNTvmk1f/svoF7FXpU2Uk=
Date:   Thu, 7 Feb 2019 13:17:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Garnier <thgarnie@google.com>,
        Nadav Amit <namit@vmware.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/27] x86: Use symbol name in jump table for PIE
 support
Message-ID: <20190207121729.GE2414@zn.tnic>
References: <20190131192533.34130-1-thgarnie@chromium.org>
 <20190131192533.34130-3-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190131192533.34130-3-thgarnie@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:24:09AM -0800, Thomas Garnier wrote:
> Replace the %c constraint with %P. The %c is incompatible with PIE
> because it implies an immediate value whereas %P reference a symbol.

How so?

AFAIK, %c requires a constant operand and if %P is used to print a
constant, it simply drops syntax-specific prefixes and does a bare
constant.

I guess that here

https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#x86Operandmodifiers

is not entirely correct as it should not say "If used for a constant"
for %P but say "symbol or constant".

But before/after asm doesn't show any difference. So what gives?

before:
# 39 "./arch/x86/include/asm/jump_label.h" 1
        1:
        .byte 0xe9
         .long .L241 - 2f       #
        2:
        .pushsection __jump_table,  "aw" 
         .balign 8 
        .long 1b - ., .L241 - .         #
         .quad __use_tsc + 1 - .        #,
        .popsection

after:
# 39 "./arch/x86/include/asm/jump_label.h" 1
        1:
        .byte 0xe9
         .long .L241 - 2f       #
        2:
        .pushsection __jump_table,  "aw" 
         .balign 8 
        .long 1b - ., .L241 - .         #
         .quad __use_tsc+1 - .  #
        .popsection 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
