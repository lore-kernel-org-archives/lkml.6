Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E13ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885D820880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885D820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbeISOk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:40:27 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37216 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbeISOk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:40:27 -0400
Received: by mail-ot1-f68.google.com with SMTP id o13-v6so5003943otl.4;
        Wed, 19 Sep 2018 02:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lPNSXbwYrhUMrS2KJUy679KqA5d6LSje+5sW4q9fhTY=;
        b=UrXy0Q2bqFEBWG1XJskAPOzWKizeaMy+Tl/ahploslTJYqoFmmzLQ9gxuNsBTDrNHE
         i50l3SKYAC9VK6/Gkn1vF02g7Oar5hnfsm1LnNAijun9xCGcFfyrfeaeggzTfqUsWHQp
         6jpxl0s1RnwmMJvImIVXA0lp7/hUfsxd9+wcmkm4WOzPNr2LTpv3z3b9LItIkHQzpUdb
         FKQNS9hdkYo9O4wSnmnHITGOb+jb2tgdZCEgcYOk/DWjpgztb22IAo0cky13v1i/JU+S
         9fgXH3X/oD0b54w5KZEeG/Ge+JZ/X/fucCE60PBGoScF2+JPuKPZVPxP55y4d2T/9B8O
         hdjg==
X-Gm-Message-State: APzg51AblQ2VFx+XHaZlDERdLJKd8+7vViTm9iYNFvlXdYRQ4g61plqm
        Od6+9I/+RBVB0lPHNPiF0K+s6GPj6SbPUVWSLWg=
X-Google-Smtp-Source: ANB0VdbTh2I7MD4Dmu69OwRbsmyzretJRpPjsPLkKETRaXDSxDzMJ7M2TGHJmhOBz2WvhGLuFVwfHTw3b6m/PdceWaU=
X-Received: by 2002:a9d:7317:: with SMTP id e23-v6mr17042277otk.162.1537347810606;
 Wed, 19 Sep 2018 02:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537275915.git.yu.c.chen@intel.com> <020db877db6a8d39808dfaef2a5162f541f0853b.1537275915.git.yu.c.chen@intel.com>
In-Reply-To: <020db877db6a8d39808dfaef2a5162f541f0853b.1537275915.git.yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Sep 2018 11:03:19 +0200
Message-ID: <CAJZ5v0jvB5zF-LqYsB1ughaZbRhZW1RjVSvY87q_W_pNkmqBeQ@mail.gmail.com>
Subject: Re: [PATCH 04/12][RFC v3] x86, hibernate: Extract the common code of
 64/32 bit system
To:     "Chen, Yu C" <yu.c.chen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        kookoo.gu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 9:32 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> From: Zhimin Gu <kookoo.gu@intel.com>
>
> Reduce the hibernation code duplication between x86-32 and x86-64
> by extracting the common code into hibernate.c.
>
> No functional change.
>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  arch/x86/include/asm/suspend.h |   8 ++
>  arch/x86/power/Makefile        |   2 +-
>  arch/x86/power/hibernate.c     | 249 +++++++++++++++++++++++++++++++++
>  arch/x86/power/hibernate_32.c  |  15 +-
>  arch/x86/power/hibernate_64.c  | 221 -----------------------------
>  5 files changed, 259 insertions(+), 236 deletions(-)
>  create mode 100644 arch/x86/power/hibernate.c
>
> diff --git a/arch/x86/include/asm/suspend.h b/arch/x86/include/asm/suspend.h
> index ecffe81ff65c..40b02558749f 100644
> --- a/arch/x86/include/asm/suspend.h
> +++ b/arch/x86/include/asm/suspend.h
> @@ -4,3 +4,11 @@
>  #else
>  # include <asm/suspend_64.h>
>  #endif
> +extern unsigned long restore_jump_address __visible;
> +extern unsigned long jump_address_phys;
> +extern unsigned long restore_cr3 __visible;
> +extern unsigned long temp_level4_pgt __visible;
> +extern unsigned long relocated_restore_code __visible;
> +extern int relocate_restore_code(void);
> +/* Defined in hibernate_asm_32/64.S */
> +extern asmlinkage __visible int restore_image(void);
> diff --git a/arch/x86/power/Makefile b/arch/x86/power/Makefile
> index a4701389562c..37923d715741 100644
> --- a/arch/x86/power/Makefile
> +++ b/arch/x86/power/Makefile
> @@ -7,4 +7,4 @@ nostackp := $(call cc-option, -fno-stack-protector)
>  CFLAGS_cpu.o   := $(nostackp)
>
>  obj-$(CONFIG_PM_SLEEP)         += cpu.o
> -obj-$(CONFIG_HIBERNATION)      += hibernate_$(BITS).o hibernate_asm_$(BITS).o
> +obj-$(CONFIG_HIBERNATION)      += hibernate_$(BITS).o hibernate_asm_$(BITS).o hibernate.o
> diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
> new file mode 100644
> index 000000000000..fbde8f0e8fe0
> --- /dev/null
> +++ b/arch/x86/power/hibernate.c
> @@ -0,0 +1,249 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Hibernation support for x86
> + *
> + * Copyright (c) 2007 Rafael J. Wysocki <rjw@sisk.pl>
> + * Copyright (c) 2002 Pavel Machek <pavel@ucw.cz>
> + * Copyright (c) 2001 Patrick Mochel <mochel@osdl.org>

I don't think this "copyright" information has any legal bearing any
more at this point.

I would just write it as

 * Authors:
 *  2007 Rafael J. Wysocki <rjw@sisk.pl>
 *  2002 Pavel Machek <pavel@ucw.cz>
 *  2001 Patrick Mochel <mochel@osdl.org>

as a matter of credits to the people who originally developed this code.

> + */
> +
> +#include <linux/gfp.h>
> +#include <linux/smp.h>
> +#include <linux/suspend.h>
> +#include <linux/scatterlist.h>
> +#include <linux/kdebug.h>
> +
> +#include <crypto/hash.h>
> +
> +#include <asm/e820/api.h>
> +#include <asm/init.h>
> +#include <asm/proto.h>
> +#include <asm/page.h>
> +#include <asm/pgtable.h>
> +#include <asm/mtrr.h>
> +#include <asm/sections.h>
> +#include <asm/suspend.h>
> +#include <asm/tlbflush.h>
> +
> +/*
> + * Address to jump to in the last phase of restore in order to get to the image
> + * kernel's text (this value is passed in the image header).
> + */
> +unsigned long restore_jump_address __visible;
> +unsigned long jump_address_phys;
> +
> +/*
> + * Value of the cr3 register from before the hibernation (this value is passed
> + * in the image header).
> + */
> +unsigned long restore_cr3 __visible;
> +unsigned long temp_level4_pgt __visible;
> +unsigned long relocated_restore_code __visible;
> +
> +#ifdef CONFIG_X86_64
> +#define RESTORE_MAGIC  0x23456789ABCDEF01UL
> +#else
> +#define RESTORE_MAGIC  0x12345678UL
> +#endif
> +
> +/**
> + *     pfn_is_nosave - check if given pfn is in the 'nosave' section
> + */
> +int pfn_is_nosave(unsigned long pfn)
> +{
> +       unsigned long nosave_begin_pfn;
> +       unsigned long nosave_end_pfn;
> +
> +       nosave_begin_pfn = __pa_symbol(&__nosave_begin) >> PAGE_SHIFT;
> +       nosave_end_pfn = PAGE_ALIGN(__pa_symbol(&__nosave_end)) >> PAGE_SHIFT;
> +
> +       return pfn >= nosave_begin_pfn && pfn < nosave_end_pfn;
> +}
> +

Since the majority of the code below in this new file is only going to
be used on 64-bit to start with, I will put it under #ifdef
CONFIG_X86_64 at this point and remove the #ifdef in one of the
subsequent patches when 32-bit actually starts to use it.

Thanks,
Rafael
