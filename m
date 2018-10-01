Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2888EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97DA205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97DA205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbeJARFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:05:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51000 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbeJARFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:05:10 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wfCXDLUAJMT7; Mon,  1 Oct 2018 12:28:02 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC64F00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:4f00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EBDED1EC01E9;
        Mon,  1 Oct 2018 12:28:01 +0200 (CEST)
Date:   Mon, 1 Oct 2018 12:28:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH resend] x86, asm: Use CC_SET()/CC_OUT() for
 __cmpxchg_double
Message-ID: <20181001102803.GA7269@zn.tnic>
References: <CAFULd4YdvwwhXWHqqPsGk5+TLG71ozgSscTZNsqmrm+Jzg941w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFULd4YdvwwhXWHqqPsGk5+TLG71ozgSscTZNsqmrm+Jzg941w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 10:33:05AM +0200, Uros Bizjak wrote:
> Remove open-coded uses of set instructions to use CC_SET()/CC_OUT()
> for __cmpxchg_double.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> ---
>  arch/x86/include/asm/cmpxchg.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
> index a55d79b233d3..bfb85e5844ab 100644
> --- a/arch/x86/include/asm/cmpxchg.h
> +++ b/arch/x86/include/asm/cmpxchg.h
> @@ -242,10 +242,12 @@ extern void __add_wrong_size(void)
>         BUILD_BUG_ON(sizeof(*(p2)) != sizeof(long));                    \
>         VM_BUG_ON((unsigned long)(p1) % (2 * sizeof(long)));            \
>         VM_BUG_ON((unsigned long)((p1) + 1) != (unsigned long)(p2));    \
> -       asm volatile(pfx "cmpxchg%c4b %2; sete %0"                      \
> -                    : "=a" (__ret), "+d" (__old2),                     \
> -                      "+m" (*(p1)), "+m" (*(p2))                       \
> -                    : "i" (2 * sizeof(long)), "a" (__old1),            \
> +       asm volatile(pfx "cmpxchg%c5b %1"                               \
> +                    CC_SET(e)                                          \
> +                    : CC_OUT(e) (__ret),                               \
> +                      "+m" (*(p1)), "+m" (*(p2)),                      \
> +                      "+a" (__old1), "+d" (__old2)                     \
> +                    : "i" (2 * sizeof(long)),                          \

To quote checkpatch:

WARNING: please, no spaces at the start of a line
#34: FILE: arch/x86/include/asm/cmpxchg.h:245:
+       asm volatile(pfx "cmpxchg%c5b %1"                               \$

ERROR: code indent should use tabs where possible
#35: FILE: arch/x86/include/asm/cmpxchg.h:246:
+                    CC_SET(e)                                          \$

WARNING: please, no spaces at the start of a line
#35: FILE: arch/x86/include/asm/cmpxchg.h:246:
+                    CC_SET(e)                                          \$

ERROR: code indent should use tabs where possible
#36: FILE: arch/x86/include/asm/cmpxchg.h:247:
+                    : CC_OUT(e) (__ret),                               \$


...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
