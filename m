Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695B2C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E00F20821
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BpQ3FF1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfBDUSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:18:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60152 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727645AbfBDUSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:18:45 -0500
Received: from zn.tnic (p200300EC2BC6E200742B98B19C68EA29.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:e200:742b:98b1:9c68:ea29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B72E21EC02AE;
        Mon,  4 Feb 2019 21:18:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1549311522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JRIafTr++bxruDwRAdS3vWkSas/9WDJFMNDZf45Fhvk=;
        b=BpQ3FF1bfQfSHLeFislzl8ajBm60mFSrViJvk5gahgIY9raPcE+7praZOwdAIFO7PKONf9
        I2DhDjQ8UuAtI7ttEYGiRsJ3LhjCxthJBb3mF3CRk6JjCN2TMQTPgqDTao810FWoDtgxAI
        3Sy5WncNr4YUqokRGeo0XjhhTBov2Vc=
Date:   Mon, 4 Feb 2019 21:18:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     mingo@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 03/28] x86/asm/suspend: use SYM_DATA for data
Message-ID: <20190204201831.GK29639@zn.tnic>
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-4-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130124711.12463-4-jslaby@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 01:46:46PM +0100, Jiri Slaby wrote:
> Some global data in the suspend code were marked as `ENTRY'. ENTRY was
> intended for functions and shall be paired with ENDPROC. ENTRY also
> aligns symbols which creates unnecessary holes here between data. Since
> we are dropping historical markings, make proper use of newly added
> SYM_DATA in this code.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
>  arch/x86/kernel/acpi/wakeup_32.S | 2 +-
>  arch/x86/kernel/acpi/wakeup_64.S | 2 +-
>  arch/x86/kernel/head_32.S        | 6 ++----
>  arch/x86/kernel/head_64.S        | 5 ++---
>  4 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
> index 4203d4f0c68d..feac1e5ecba0 100644
> --- a/arch/x86/kernel/acpi/wakeup_32.S
> +++ b/arch/x86/kernel/acpi/wakeup_32.S
> @@ -89,7 +89,7 @@ ret_point:
>  
>  .data
>  ALIGN
> -ENTRY(saved_magic)	.long	0
> +SYM_DATA(saved_magic,	.long 0)
>  saved_eip:		.long 0
>  
>  # saved registers
> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> index 510fa12aab73..551758f48eb7 100644
> --- a/arch/x86/kernel/acpi/wakeup_64.S
> +++ b/arch/x86/kernel/acpi/wakeup_64.S
> @@ -133,4 +133,4 @@ saved_rbx:		.quad	0
>  saved_rip:		.quad	0
>  saved_rsp:		.quad	0
>  
> -ENTRY(saved_magic)	.quad	0
> +SYM_DATA(saved_magic,	.quad	0)

Ok, I like the proper ELF symbol typing with this: NOTYPE goes away.

 74408: ffffffff82021920     0 NOTYPE  GLOBAL DEFAULT   11 saved_magic

->

 74366: ffffffff820218f0     8 OBJECT  GLOBAL DEFAULT   11 saved_magic

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
