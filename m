Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8F3C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 11:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECCB20818
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 11:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LaG8tQP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfBILZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 06:25:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39750 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfBILZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 06:25:58 -0500
Received: from zn.tnic (p200300EC2BDAE100BD748F741B983644.dip0.t-ipconnect.de [IPv6:2003:ec:2bda:e100:bd74:8f74:1b98:3644])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6721A1EC09F1;
        Sat,  9 Feb 2019 12:25:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549711556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IklpyE1nC9FGBOmiL4y73naMsvg7aZQjqZu6G0bUqlk=;
        b=LaG8tQP2xcGP33EdPnisnTsQ1Wxc/9gTzVb3upZdYTvnQGFEQzcsEpvoRSmBjeMOgdcnjk
        sRysOOvL9aLCWR5YD7kf1P/57O8usm0YJoaNHest6+djJ+kWu2iLX/wr1Q4ThojtLOd6L3
        /0nrABHDiXudcWkC+xghibBkf9kD3BE=
Date:   Sat, 9 Feb 2019 12:25:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     mingo@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v7 05/28] x86/asm/entry: annotate THUNKs
Message-ID: <20190209112551.GA5089@zn.tnic>
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-6-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130124711.12463-6-jslaby@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 01:46:48PM +0100, Jiri Slaby wrote:
> Place SYM_*_START_NOALIGN and SYM_*_END around the THUNK macro body.
> Preserve @function by FUNC (64bit) and CODE (32bit). Given it was not
> marked as aligned, use NOALIGN.
> 
> The common tail .L_restore is put inside SYM_CODE_START_LOCAL_NOALIGN
> and SYM_CODE_END too.
> 
> The result:
>  Value  Size Type    Bind   Vis      Ndx Name
>   0000    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_on_thunk
>   001c    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_off_thunk
>   0038    24 FUNC    GLOBAL DEFAULT    1 lockdep_sys_exit_thunk
>   0050    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule
>   0068    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule_notra
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> ---
>  arch/x86/entry/thunk_32.S | 4 ++--
>  arch/x86/entry/thunk_64.S | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)

...

> @@ -57,7 +56,7 @@
>  #if defined(CONFIG_TRACE_IRQFLAGS) \
>   || defined(CONFIG_DEBUG_LOCK_ALLOC) \
>   || defined(CONFIG_PREEMPT)
> -.L_restore:
> +SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
>  	popq %r11
>  	popq %r10
>  	popq %r9
> @@ -70,4 +69,5 @@
>  	popq %rbp
>  	ret
>  	_ASM_NOKPROBE(.L_restore)
> +SYM_CODE_END(.L_restore)

That local label doesn't even land in the symbol table:

$ readelf -a  arch/x86/entry/thunk_64.o | grep restore
$

so no need to touch it, AFAICT. And all local labels, for that matter.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
