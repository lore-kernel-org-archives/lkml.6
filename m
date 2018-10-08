Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07168C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C729214C5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="CcUstuYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C729214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=globallogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeJIBJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:09:29 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41082 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJIBJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:09:29 -0400
Received: by mail-qt1-f196.google.com with SMTP id l41-v6so9318553qtl.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 10:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WLlcl054mHW8IfpNRHIlMdn/Q+MTcMIQHakbr7OJ9Uc=;
        b=CcUstuYHmKOYK1X3QxfF+t9Tu8SbdqKbU8bFcLdql3qpMfsfNwDcPQjLoTl7WCCNdK
         0faR6QYpGkMHysLGrsfMjZQKSbO71+qKzT20c/Eo8nuxWdvDBfksV3vFldyzdS26xEnZ
         RZgtuYfNZ38e04kKdc9FF1++Cn/5WTr7nKrh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLlcl054mHW8IfpNRHIlMdn/Q+MTcMIQHakbr7OJ9Uc=;
        b=oF0QT5sozMoPBq/4WZmlf/0IsFSY6WlI9ytDRE2nO9X9mbIoAvvBuSK5YdQU5mEW0u
         O5ZFIXWL1GGmVuwWFY1LnaK0uGi8nH6Z9zZfk9CvESRK30DDQ3/gOMtayrVPR4/xJrAJ
         VtnLL0gRxnVfnRB1rdlc2+F1ItfRwhipKz4TySbnBYc//qPdMoS5xEXZ4WXRPKdt8zRd
         mOhbxeh0YhdVkm0PwKUYbst7Pat8rwjcc5wcMfJ1HlmHZpr01dtoRBTY5sfhCBKXTtpG
         FURosoBMv60/dBjRfCF7Jz2sxLYftL0x+VdFH7Iti1XMDAlgtV9qsriRf4+jS22ojiGL
         4rDQ==
X-Gm-Message-State: ABuFfoj4gcTk8QL4HS+yFLPDgOfVxAUAbWg+ab7Sv8MbFMFFHfTkA0Q0
        B1C/GakbwkkSYvXVWYXwkp6DOgxhRR9dQZl5C90B6w==
X-Google-Smtp-Source: ACcGV63YVSZEiu5ebBchOq20H9Hjc8gSItA/GiKTV5tp65ck+uremN/0R4lCwI1QATfTgNCVn38IBkMdXyyNw6ptZEA=
X-Received: by 2002:aed:210e:: with SMTP id 14-v6mr20962204qtc.9.1539021396101;
 Mon, 08 Oct 2018 10:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <1538067417-6007-1-git-send-email-maksym.kokhan@globallogic.com> <20180927185626.gcvx5qjemxbff3zt@pburton-laptop>
In-Reply-To: <20180927185626.gcvx5qjemxbff3zt@pburton-laptop>
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
Date:   Mon, 8 Oct 2018 20:56:25 +0300
Message-ID: <CAMT6-xi+E1-ATYRXpkmcAprrwykLVHnUc2D+QBQLgPBv4hhwUg@mail.gmail.com>
Subject: Re: [PATCH 7/8] mips: convert to generic builtin command line
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Paul,

On Thu, Sep 27, 2018 at 9:56 PM Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Maksym,
>
> On Thu, Sep 27, 2018 at 07:56:57PM +0300, Maksym Kokhan wrote:
> > -choice
> > -     prompt "Kernel command line type" if !CMDLINE_OVERRIDE
> > -     default MIPS_CMDLINE_FROM_DTB if USE_OF && !ATH79 && !MACH_INGENIC && \
> > -                                      !MIPS_MALTA && \
> > -                                      !CAVIUM_OCTEON_SOC
> > -     default MIPS_CMDLINE_FROM_BOOTLOADER
> > -
> > -     config MIPS_CMDLINE_FROM_DTB
> > -             depends on USE_OF
> > -             bool "Dtb kernel arguments if available"
> > -
> > -     config MIPS_CMDLINE_DTB_EXTEND
> > -             depends on USE_OF
> > -             bool "Extend dtb kernel arguments with bootloader arguments"
> > -
> > -     config MIPS_CMDLINE_FROM_BOOTLOADER
> > -             bool "Bootloader kernel arguments if available"
> > -
> > -     config MIPS_CMDLINE_BUILTIN_EXTEND
> > -             depends on CMDLINE_BOOL
> > -             bool "Extend builtin kernel arguments with bootloader arguments"
> > -endchoice
> >%
> > -#define USE_PROM_CMDLINE     IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER)
> > -#define USE_DTB_CMDLINE              IS_ENABLED(CONFIG_MIPS_CMDLINE_FROM_DTB)
> > -#define EXTEND_WITH_PROM     IS_ENABLED(CONFIG_MIPS_CMDLINE_DTB_EXTEND)
> > -#define BUILTIN_EXTEND_WITH_PROM     \
> > -     IS_ENABLED(CONFIG_MIPS_CMDLINE_BUILTIN_EXTEND)
> > -
> >  static void __init arch_mem_init(char **cmdline_p)
> >  {
> >       struct memblock_region *reg;
> >       extern void plat_mem_setup(void);
> >
> > -#if defined(CONFIG_CMDLINE_BOOL) && defined(CONFIG_CMDLINE_OVERRIDE)
> > -     strlcpy(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
> > -#else
> > -     if ((USE_PROM_CMDLINE && arcs_cmdline[0]) ||
> > -         (USE_DTB_CMDLINE && !boot_command_line[0]))
> > -             strlcpy(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
> > -
> > -     if (EXTEND_WITH_PROM && arcs_cmdline[0]) {
> > -             if (boot_command_line[0])
> > -                     strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> > -             strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
> > -     }
> > -
> > -#if defined(CONFIG_CMDLINE_BOOL)
> > -     if (builtin_cmdline[0]) {
> > -             if (boot_command_line[0])
> > -                     strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> > -             strlcat(boot_command_line, builtin_cmdline, COMMAND_LINE_SIZE);
> > -     }
> > -
> > -     if (BUILTIN_EXTEND_WITH_PROM && arcs_cmdline[0]) {
> > -             if (boot_command_line[0])
> > -                     strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> > -             strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
> > -     }
> > -#endif
> > -#endif
> > -
> >       /* call board setup routine */
> >       plat_mem_setup();
> >
> > @@ -893,6 +856,8 @@ static void __init arch_mem_init(char **cmdline_p)
> >       pr_info("Determined physical RAM map:\n");
> >       print_memory_map();
> >
> > +     cmdline_add_builtin(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
> > +
> >       strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
> >
> >       *cmdline_p = command_line;
>
> I love the idea of simplifying this & sharing code with other
> architectures, but unfortunately I believe the above will be problematic
> for systems using arguments from device tree.
>
> At the point you call cmdline_add_builtin we should expect that:
>
>   - boot_command_line contains arguments from the DT, if any, and
>     otherwise may contain CONFIG_CMDLINE copied there by
>     early_init_dt_scan_chosen().
>
>   - arcs_cmdline contains arguments from the bootloader, if any.
>
> If I understand correctly you overwrite boot_command_line with the
> concatenation of CONFIG_CMDLINE_PREPEND, arcs_cmdline &
> CONFIG_CMDLINE_APPEND. This will clobber/lose the DT arguments.
>
> I'd expect this to be reproducible under QEMU using its boston emulation
> (ie. -M boston) and a kernel built for the generic platform that
> includes boston support (eg. 64r6el_defconfig).

You are right, there is a mistake in our implementation, thank you for
your observation. This bug can be easily fixed in 2 ways.
First - modify mips-specific code adding if statement with
processing bootloader cmdline:
------------------------------8<-----------------------------------

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 60638dd..7d11ef5 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -856,7 +856,11 @@ static void __init arch_mem_init(char **cmdline_p)
        pr_info("Determined physical RAM map:\n");
        print_memory_map();

-       cmdline_add_builtin(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
+       if (arcs_cmdline[0]) {
+               strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
+               strlcat(boot_command_line, arcs_cmdline, COMMAND_LINE_SIZE);
+       }
+       cmdline_add_builtin(boot_command_line, NULL, COMMAND_LINE_SIZE);

        strlcpy(command_line, boot_command_line, COMMAND_LINE_SIZE);

------------------------------8<-----------------------------------
This solution was tested under QEMU using malta emulation and it
works fine. Another way is to modify common code in
include/linux/cmdline.h, but I am not sure, which approach is better.

> It also doesn't allow for the various Kconfig options which allow us to
> ignore some of the sources of command line arguments, nor does it honor
> the ordering that those existing options allow. In practice perhaps we
> can cut down on some of this configurability anyway, but if we do that
> it needs to be thought through & the commit message should describe the
> changes in behaviour.

Yes, this generic command line implementation lacks some of the
features, existing in the current mips command line code, and we
are going to expand functionality of generic command line code to
correspond it, but it would be easier to initially merge this simple
implementation and then develop it step by step.

Thanks,
Maksym
