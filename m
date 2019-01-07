Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556B4C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA692089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546858562;
	bh=vSFHQdd4WCI79de9JaQXYeh5S9KDwY4eZTj2ytPJKSA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fWkHLu1baZAoZ3dFt2qSZ+OnsjX2Y5KDJ+0djaebLRiUxDGO3MRsR1ox6lHqiRM/C
	 zQmrMf529y/IccHaTQNAGKLsgbZPbiUR+B9wvggrrwdUR8BFfoWTJadn57UusPhIu7
	 hH+guu05LxtBnqr3giMyhhjQ94Ir0RLV19x4APl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfAGK4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:56:01 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42162 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAGK4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:56:00 -0500
Received: by mail-ot1-f65.google.com with SMTP id v23so37391492otk.9;
        Mon, 07 Jan 2019 02:55:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9H6DAzzGZfyG3cdBhUSIpLNiSOpJ3yZ55TFNjkxHrQ=;
        b=NsHGX3b78Exr8f9oYCZMius+9nN/BbLURx8WjpnWA9L9qjo9lG37HAIDxt9ykeIdqG
         qFTr74qr+auE8tRZVT4phQY3r8H7A2caHgTcj0S1g6M6G/RfMrMRtl58IAnnDPKIITb3
         fvvM7SEt/IVjEGConcowFQYwxmpL+Q15w3qbitVRd2qlrlFMNwxS0+DkzKes+M1PBTCv
         0i1x9U1z1SxYAlnABZ+3e3aDSBwJ1Wvb8pcV6dgFJ2f/pIf8ylJmnsvnuAQlMw4Xo/Bw
         RvAPw+8fAnqmE8Qfr1vzWPSgk/C0EunVdxvf2rZgFYqEIlioZ2qUp6ECuQOnR9ndkF2T
         A1Dg==
X-Gm-Message-State: AJcUukeNSYxJpCSzeTHn2Q/6b/bq2iaUeN2Nj1CA/+FdYgk/fMHn7SGR
        lCiTbe/w2dO1WGXhh7IFttiGUrj+dvu+xS4CUtg=
X-Google-Smtp-Source: ALg8bN4yoocPMoutGPLo9UIM2pmU0J0qXsNs2b03T5RTt8XTEtizlumJJh67J7THEs3jMhz6oB4/Le0THxG61rB/+2g=
X-Received: by 2002:a9d:60b:: with SMTP id 11mr40441933otn.200.1546858559496;
 Mon, 07 Jan 2019 02:55:59 -0800 (PST)
MIME-Version: 1.0
References: <1546849485-27933-1-git-send-email-kernelfans@gmail.com> <1546849485-27933-2-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1546849485-27933-2-git-send-email-kernelfans@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jan 2019 11:55:48 +0100
Message-ID: <CAJZ5v0itzGsT-1BoBM+jiewmzhjuEVBJrDANBe+vtsAOiqpm1A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] acpi: change the topo of acpi_table_upgrade()
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 9:25 AM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> The current acpi_table_upgrade() relies on initrd_start, but this var is
> only valid after relocate_initrd(). There is requirement to extract the
> acpi info from initrd before memblock-allocator can work(see [2/4]), hence
> acpi_table_upgrade() need to accept the input param directly.
>
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-kernel@vger.kernel.org

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/arm64/kernel/setup.c | 2 +-
>  arch/x86/kernel/setup.c   | 2 +-
>  drivers/acpi/tables.c     | 4 +---
>  include/linux/acpi.h      | 4 ++--
>  4 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 4b0e123..48cb98c 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -315,7 +315,7 @@ void __init setup_arch(char **cmdline_p)
>         paging_init();
>         efi_apply_persistent_mem_reservations();
>
> -       acpi_table_upgrade();
> +       acpi_table_upgrade((void *)initrd_start, initrd_end - initrd_start);
>
>         /* Parse the ACPI tables for possible boot-time configuration */
>         acpi_boot_table_init();
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 3d872a5..acbcd62 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1175,8 +1175,8 @@ void __init setup_arch(char **cmdline_p)
>
>         reserve_initrd();
>
> -       acpi_table_upgrade();
>
> +       acpi_table_upgrade((void *)initrd_start, initrd_end - initrd_start);
>         vsmp_init();
>
>         io_delay_init();
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 48eabb6..d29b05c 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -471,10 +471,8 @@ static DECLARE_BITMAP(acpi_initrd_installed, NR_ACPI_INITRD_TABLES);
>
>  #define MAP_CHUNK_SIZE   (NR_FIX_BTMAPS << PAGE_SHIFT)
>
> -void __init acpi_table_upgrade(void)
> +void __init acpi_table_upgrade(void *data, size_t size)
>  {
> -       void *data = (void *)initrd_start;
> -       size_t size = initrd_end - initrd_start;
>         int sig, no, table_nr = 0, total_offset = 0;
>         long offset = 0;
>         struct acpi_table_header *table;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 87715f2..44dcbba 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1272,9 +1272,9 @@ acpi_graph_get_remote_endpoint(const struct fwnode_handle *fwnode,
>  #endif
>
>  #ifdef CONFIG_ACPI_TABLE_UPGRADE
> -void acpi_table_upgrade(void);
> +void acpi_table_upgrade(void *data, size_t size);
>  #else
> -static inline void acpi_table_upgrade(void) { }
> +static inline void acpi_table_upgrade(void *data, size_t size) { }
>  #endif
>
>  #if defined(CONFIG_ACPI) && defined(CONFIG_ACPI_WATCHDOG)
> --
> 2.7.4
>
