Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C37C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F093214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 08:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F093214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbeISOLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 10:11:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43649 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbeISOLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 10:11:13 -0400
Received: by mail-ot1-f65.google.com with SMTP id u20-v6so4901483otk.10;
        Wed, 19 Sep 2018 01:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7swXxDpRPSbf8zimfKQiQP2ZT7ZmlvOnVlSgf2TgCL0=;
        b=l9mdBvPkKeg4eDw62MhuBRAr8pj0K1gr7fkCPgOdcvv03q9POXQUPsaSXQxOyFkvQl
         oWziUVRi+fmL2pqYw4U94IBCnZManIFbn4DAA+MhfW9JSZJI/KyrogarTSLcxIkgUaAg
         vFcUPr1GdNIVL5mk8WHT7FPcfgSKYXyarbA2DFwoxE4TvXQ2fhdm+SpFJVMXQL52lHQ+
         kajS6hnKPcAyqKftdj+uaiD4AAEblXTja3sMiFZzxKHsWY+EvDTLPQIwq8dUyFIN70h5
         K7QrZXVNiaatwfCYGxRmi1/xxVKFuTw2L/mPJqrdtsPVuiKvCFyXizRVvqoaWrVos7Ug
         FX9A==
X-Gm-Message-State: APzg51CVaMCuGUY3nc+XCzRxfZGB9zUDwLULQcidGDphT6kt/o0NRjFt
        x54htGs4cNY17yhJvxrd9G4CSRDtwJCcMxJVfas=
X-Google-Smtp-Source: ANB0VdZHSsMCJ+7If62toNT6B6VVQwKFXySRNfOLZg8Kztif153bUnmvPAsGfAjivj+QObO/MXuDlqRQQ+H247PXXTI=
X-Received: by 2002:a9d:648f:: with SMTP id g15-v6mr17347386otl.191.1537346062302;
 Wed, 19 Sep 2018 01:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1537275915.git.yu.c.chen@intel.com> <9df6959bc2f3776eb512b7964a94bd02639e65eb.1537275915.git.yu.c.chen@intel.com>
In-Reply-To: <9df6959bc2f3776eb512b7964a94bd02639e65eb.1537275915.git.yu.c.chen@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Sep 2018 10:34:11 +0200
Message-ID: <CAJZ5v0gu8O+VkgQ3R8RYVbpnuomVxZtnq00SQzEV1+9h_02j_Q@mail.gmail.com>
Subject: Re: [PATCH 01/12][RFC v3] x86, hibernate: Fix nosave_regions setup
 for hibernation
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

On Wed, Sep 19, 2018 at 9:30 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> From: Zhimin Gu <kookoo.gu@intel.com>
>
> On 32bit systems, nosave_regions(non RAM areas) located between
> max_low_pfn and max_pfn are not excluded from hibernation snapshot
> currently, which may result in a machine check exception when
> trying to access these unsafe regions during hibernation:
>
> [  612.800453] Disabling lock debugging due to kernel taint
> [  612.805786] mce: [Hardware Error]: CPU 0: Machine Check Exception: 5 Bank 6: fe00000000801136
> [  612.814344] mce: [Hardware Error]: RIP !INEXACT! 60:<00000000d90be566> {swsusp_save+0x436/0x560}
> [  612.823167] mce: [Hardware Error]: TSC 1f5939fe276 ADDR dd000000 MISC 30e0000086
> [  612.830677] mce: [Hardware Error]: PROCESSOR 0:306c3 TIME 1529487426 SOCKET 0 APIC 0 microcode 24
> [  612.839581] mce: [Hardware Error]: Run the above through 'mcelog --ascii'
> [  612.846394] mce: [Hardware Error]: Machine check: Processor context corrupt
> [  612.853380] Kernel panic - not syncing: Fatal machine check
> [  612.858978] Kernel Offset: 0x18000000 from 0xc1000000 (relocation range: 0xc0000000-0xf7ffdfff)
>
> This is because on 32bit systems, pages above max_low_pfn are regarded
> as high memeory, and accessing unsafe pages might cause expected MCE.
> On the problematic 32bit system, there are reserved memory above low
> memory, which triggered the MCE:
>
> e820 memory mapping:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d7ff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009d800-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000d160cfff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000d160d000-0x00000000d1613fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000d1614000-0x00000000d1a44fff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000d1a45000-0x00000000d1ecffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000d1ed0000-0x00000000d7eeafff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000d7eeb000-0x00000000d7ffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000d8000000-0x00000000d875ffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000d8760000-0x00000000d87fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000d8800000-0x00000000d8fadfff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000d8fae000-0x00000000d8ffffff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x00000000d9000000-0x00000000da71bfff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000da71c000-0x00000000da7fffff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000da800000-0x00000000dbb8bfff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000dbb8c000-0x00000000dbffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000dd000000-0x00000000df1fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000041edfffff] usable
>
> Fix this problem by changing pfn limit from max_low_pfn to max_pfn.
> This fix does not impact 64bit system because on 64bit max_low_pfn
> is the same as max_pfn.
>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  arch/x86/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index b4866badb235..90ecc108bc8a 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1251,7 +1251,7 @@ void __init setup_arch(char **cmdline_p)
>         x86_init.hyper.guest_late_init();
>
>         e820__reserve_resources();
> -       e820__register_nosave_regions(max_low_pfn);
> +       e820__register_nosave_regions(max_pfn);
>
>         x86_init.resources.reserve_resources();
>
> --

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
