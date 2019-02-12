Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FB1C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1B3222BE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TeRkBdGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732055AbfBLUnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:43:52 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43566 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfBLUnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:43:52 -0500
Received: by mail-vs1-f66.google.com with SMTP id x1so17952vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DvXl/L8zWWtWgGpa36FAZ9aPwrRQIvK8abTSaWBzpe4=;
        b=TeRkBdGBSEhKzp+OhKFrEMYFPIrFjpRFUr2VdwX8S3sPAN0Rt9vmrKqw/0gX48qaRF
         bjilN04F0o38pokOnMDlBiF5bJSgVEPUPWzSwiET/8aU5PHbOd4IjHPnK3G7W2krLsh/
         6L/JcOw2JaJmE1D0tu1c2fYzZB1R13wSs82FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DvXl/L8zWWtWgGpa36FAZ9aPwrRQIvK8abTSaWBzpe4=;
        b=sZ76/usMQ6cZyKwm3oZaEHSvX8E0wo/xjOuAueFpMyVtcqp4qQ9mb7EQOCoiF86Dz2
         KMxYpu0Oa7FZUOJErW2p/P6cWJl+BKz+1+kLlULyWDmyVEnGrjdP/u5w1mB5DOxJ4nft
         vBiwhN+k5j1Lmw7denOCJloz96/1PynPpLM0WT228IT3Wm0E2tC0BqIJ4fbPP6+zdSLP
         JM5vOcdGUIcPI3aPVEwYoAfF01m63uxQYaKeJZb4HTauBtDdez1t3mgyS2xPcjzKYS5Z
         RyMCV019QirdCcQ6Bc015QInyW+WOqMRpVB0gfJp43NJwlyu32z0QGeQSNC8bzUo0FRB
         9FFA==
X-Gm-Message-State: AHQUAuZzlDxVfgu4tCP3O++FSYoLa85dg5Z/BGb7uGPVQ003dwhidKBx
        BE71EzQdEfKBE8LcDczdpUdq9gErEA0=
X-Google-Smtp-Source: AHgI3IbLtIG+yJt30kMPQbKkDigO4vPfSwJJy5vI139SjWJI8lgJOK9bdv+PUh9cuj+zlZqvVGaQ4Q==
X-Received: by 2002:a67:f851:: with SMTP id b17mr2510473vsp.23.1550004229938;
        Tue, 12 Feb 2019 12:43:49 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id l10sm15115190vkl.54.2019.02.12.12.43.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 12:43:49 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id k11so58966vsm.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:43:48 -0800 (PST)
X-Received: by 2002:a67:7d01:: with SMTP id y1mr2471312vsc.48.1550004228427;
 Tue, 12 Feb 2019 12:43:48 -0800 (PST)
MIME-Version: 1.0
References: <5c5403a5.1c69fb81.e34c0.9a13SMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <5c5403a5.1c69fb81.e34c0.9a13SMTPIN_ADDED_BROKEN@mx.google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 12 Feb 2019 12:43:36 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLO+evp0U8fR-bmgtmwDWBa_idN51cu9tQwQdGj998nsA@mail.gmail.com>
Message-ID: <CAGXu5jLO+evp0U8fR-bmgtmwDWBa_idN51cu9tQwQdGj998nsA@mail.gmail.com>
Subject: Re: [PATCH] pstore: Add boot loader log messages support
To:     Yue Hu <huyue2@yulong.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 12:30 AM Yue Hu <huyue2@yulong.com> wrote:
>
> From bac8bbcd6081b967422dc82074a41098a0cf5180 Mon Sep 17 00:00:00 2001
> From: Yue Hu <huyue2@yulong.com>
> Date: Tue, 29 Jan 2019 11:42:27 +0800
> Subject: [PATCH] pstore: Add boot loader log messages support
>
> Sometimes we hope to check boot loader log messages (e.g. Android
> Verified Boot status) when kernel is coming up. Generally it does
> depend on serial device, but it will be removed for the hardware
> shipping to market by most of manufacturers. In that case better
> solder and proper serial cable for different interface (e.g. Type-C
> or microUSB) are needed. That is inconvenient and even wasting much
> time on it.
>
> Therefore, let's add a logging support: PSTORE_TYPE_XBL.
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  fs/pstore/Kconfig      | 10 ++++++++
>  fs/pstore/platform.c   | 16 +++++++++++++
>  fs/pstore/ram.c        | 64 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  include/linux/pstore.h | 21 +++++++++++++----
>  4 files changed, 104 insertions(+), 7 deletions(-)
>
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index 0d19d19..ef4a2dc 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -137,6 +137,16 @@ config PSTORE_FTRACE
>
>           If unsure, say N.
>
> +config PSTORE_XBL
> +       bool "Log bootloader messages"
> +       depends on PSTORE
> +       help
> +         When the option is enabled, pstore will log boot loader
> +         messages to /sys/fs/pstore/xbl-ramoops-[ID] after reboot.
> +         Boot loader needs to support log buffer reserved.
> +
> +         If unsure, say N.
> +
>  config PSTORE_RAM
>         tristate "Log panic/oops to a RAM buffer"
>         depends on PSTORE
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index 0ca7657..7486e48 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -66,6 +66,7 @@
>         "mce",
>         "console",
>         "ftrace",
> +       "xbl",
>         "rtas",
>         "powerpc-ofw",
>         "powerpc-common",
> @@ -532,6 +533,19 @@ static void pstore_register_console(void) {}
>  static void pstore_unregister_console(void) {}
>  #endif
>
> +#ifdef CONFIG_PSTORE_XBL
> +static void pstore_register_xbl(void)
> +{
> +       struct pstore_record record;
> +
> +       pstore_record_init(&record, psinfo);
> +       record.type = PSTORE_TYPE_XBL;
> +       psinfo->write(&record);
> +}

This writes a zero-length record at registration time. Why?

> +#else
> +static void pstore_register_xbl(void) {}
> +#endif
> +
>  static int pstore_write_user_compat(struct pstore_record *record,
>                                     const char __user *buf)
>  {
> @@ -618,6 +632,8 @@ int pstore_register(struct pstore_info *psi)
>                 pstore_register_ftrace();
>         if (psi->flags & PSTORE_FLAGS_PMSG)
>                 pstore_register_pmsg();
> +       if (psi->flags & PSTORE_FLAGS_XBL)
> +               pstore_register_xbl();
>
>         /* Start watching for new records, if desired. */
>         if (pstore_update_ms >= 0) {
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index ca01778..0bb086b 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -56,6 +56,10 @@
>  module_param_named(pmsg_size, ramoops_pmsg_size, ulong, 0400);
>  MODULE_PARM_DESC(pmsg_size, "size of user space message log");
>
> +static ulong ramoops_xbl_size = MIN_MEM_SIZE;
> +module_param_named(xbl_size, ramoops_xbl_size, ulong, 0400);
> +MODULE_PARM_DESC(xbl_size, "size of boot loader log");
> +
>  static unsigned long long mem_address;
>  module_param_hw(mem_address, ullong, other, 0400);
>  MODULE_PARM_DESC(mem_address,
> @@ -88,6 +92,7 @@ struct ramoops_context {
>         struct persistent_ram_zone *cprz;       /* Console zone */
>         struct persistent_ram_zone **fprzs;     /* Ftrace zones */
>         struct persistent_ram_zone *mprz;       /* PMSG zone */
> +       struct persistent_ram_zone *bprz;       /* XBL zone */
>         phys_addr_t phys_addr;
>         unsigned long size;
>         unsigned int memtype;
> @@ -95,6 +100,7 @@ struct ramoops_context {
>         size_t console_size;
>         size_t ftrace_size;
>         size_t pmsg_size;
> +       size_t xbl_size;
>         int dump_oops;
>         u32 flags;
>         struct persistent_ram_ecc_info ecc_info;
> @@ -106,6 +112,7 @@ struct ramoops_context {
>         unsigned int max_ftrace_cnt;
>         unsigned int ftrace_read_cnt;
>         unsigned int pmsg_read_cnt;
> +       unsigned int xbl_read_cnt;
>         struct pstore_info pstore;
>  };
>
> @@ -119,6 +126,7 @@ static int ramoops_pstore_open(struct pstore_info *psi)
>         cxt->console_read_cnt = 0;
>         cxt->ftrace_read_cnt = 0;
>         cxt->pmsg_read_cnt = 0;
> +       cxt->xbl_read_cnt = 0;
>         return 0;
>  }
>
> @@ -272,6 +280,10 @@ static ssize_t ramoops_pstore_read(struct pstore_record *record)
>         if (!prz_ok(prz) && !cxt->pmsg_read_cnt++)
>                 prz = ramoops_get_next_prz(&cxt->mprz, 0 /* single */, record);
>
> +       if (!prz_ok(prz) && !cxt->xbl_read_cnt++) {
> +               prz = ramoops_get_next_prz(&cxt->bprz, 0 /* single */, record);
> +       }
> +
>         /* ftrace is last since it may want to dynamically allocate memory. */
>         if (!prz_ok(prz)) {
>                 if (!(cxt->flags & RAMOOPS_FLAG_FTRACE_PER_CPU) &&
> @@ -360,6 +372,26 @@ static size_t ramoops_write_kmsg_hdr(struct persistent_ram_zone *prz,
>         return len;
>  }
>
> +static void ramoops_get_xbl_record(struct persistent_ram_zone *prz,
> +                                 struct pstore_record *record,
> +                                 size_t xbl_size)
> +{
> +       struct pstore_xbl_header *hdr = NULL;
> +       size_t half = xbl_size / 2;
> +       size_t max = half - PSTORE_XBL_HDR_SIZE;
> +
> +       hdr = (struct pstore_xbl_header *)((size_t)prz->buffer + half);

Before reading this data, please verify the prz buffer sizes (since
prior boots may have had a different size, etc).

> +
> +       if (hdr->cookie == PSTORE_XBL_COOKIE) {
> +               record->buf = (char *)((size_t)hdr + PSTORE_XBL_HDR_SIZE);
> +               record->size = hdr->size_written;
> +               if (unlikely(record->size > max))
> +                       record->size = max;
> +               return;
> +       }
> +       pr_debug("no valid xbl record (cookie = 0x%08x)\n", hdr->cookie);
> +}
> +
>  static int notrace ramoops_pstore_write(struct pstore_record *record)
>  {
>         struct ramoops_context *cxt = record->psi->data;
> @@ -390,6 +422,16 @@ static int notrace ramoops_pstore_write(struct pstore_record *record)
>         } else if (record->type == PSTORE_TYPE_PMSG) {
>                 pr_warn_ratelimited("PMSG shouldn't call %s\n", __func__);
>                 return -EINVAL;
> +       } else if (record->type == PSTORE_TYPE_XBL) {
> +               if (!cxt->bprz)
> +                       return -ENOMEM;
> +
> +               ramoops_get_xbl_record(cxt->bprz, record, cxt->xbl_size);
> +               if (record->size == 0)
> +                       return -EINVAL;
> +
> +               persistent_ram_write(cxt->bprz, record->buf, record->size);
> +               return 0;
>         }
>
>         if (record->type != PSTORE_TYPE_DMESG)
> @@ -469,6 +511,9 @@ static int ramoops_pstore_erase(struct pstore_record *record)
>         case PSTORE_TYPE_PMSG:
>                 prz = cxt->mprz;
>                 break;
> +       case PSTORE_TYPE_XBL:
> +               prz = cxt->bprz;
> +               break;
>         default:
>                 return -EINVAL;
>         }
> @@ -697,6 +742,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>         parse_size("console-size", pdata->console_size);
>         parse_size("ftrace-size", pdata->ftrace_size);
>         parse_size("pmsg-size", pdata->pmsg_size);
> +       parse_size("xbl-size", pdata->xbl_size);
>         parse_size("ecc-size", pdata->ecc_info.ecc_size);
>         parse_size("flags", pdata->flags);
>
> @@ -740,7 +786,7 @@ static int ramoops_probe(struct platform_device *pdev)
>         }
>
>         if (!pdata->mem_size || (!pdata->record_size && !pdata->console_size &&
> -                       !pdata->ftrace_size && !pdata->pmsg_size)) {
> +               !pdata->ftrace_size && !pdata->pmsg_size && !pdata->xbl_size)) {
>                 pr_err("The memory size and the record/console size must be "
>                         "non-zero\n");
>                 goto fail_out;
> @@ -754,6 +800,8 @@ static int ramoops_probe(struct platform_device *pdev)
>                 pdata->ftrace_size = rounddown_pow_of_two(pdata->ftrace_size);
>         if (pdata->pmsg_size && !is_power_of_2(pdata->pmsg_size))
>                 pdata->pmsg_size = rounddown_pow_of_two(pdata->pmsg_size);
> +       if (pdata->xbl_size && !is_power_of_2(pdata->xbl_size))
> +               pdata->xbl_size = rounddown_pow_of_two(pdata->xbl_size);
>
>         cxt->size = pdata->mem_size;
>         cxt->phys_addr = pdata->mem_address;
> @@ -762,6 +810,7 @@ static int ramoops_probe(struct platform_device *pdev)
>         cxt->console_size = pdata->console_size;
>         cxt->ftrace_size = pdata->ftrace_size;
>         cxt->pmsg_size = pdata->pmsg_size;
> +       cxt->xbl_size = pdata->xbl_size;
>         cxt->dump_oops = pdata->dump_oops;
>         cxt->flags = pdata->flags;
>         cxt->ecc_info = pdata->ecc_info;
> @@ -769,7 +818,7 @@ static int ramoops_probe(struct platform_device *pdev)
>         paddr = cxt->phys_addr;
>
>         dump_mem_sz = cxt->size - cxt->console_size - cxt->ftrace_size
> -                       - cxt->pmsg_size;
> +                       - cxt->pmsg_size - cxt->xbl_size;
>         err = ramoops_init_przs("dmesg", dev, cxt, &cxt->dprzs, &paddr,
>                                 dump_mem_sz, cxt->record_size,
>                                 &cxt->max_dump_cnt, 0, 0);
> @@ -797,6 +846,11 @@ static int ramoops_probe(struct platform_device *pdev)
>         if (err)
>                 goto fail_init_mprz;
>
> +       err = ramoops_init_prz("xbl", dev, cxt, &cxt->bprz, &paddr,
> +                               cxt->xbl_size, 0);
> +       if (err)
> +               goto fail_init_bprz;
> +
>         cxt->pstore.data = cxt;
>         /*
>          * Since bufsize is only used for dmesg crash dumps, it
> @@ -818,6 +872,8 @@ static int ramoops_probe(struct platform_device *pdev)
>                 cxt->pstore.flags |= PSTORE_FLAGS_FTRACE;
>         if (cxt->pmsg_size)
>                 cxt->pstore.flags |= PSTORE_FLAGS_PMSG;
> +       if (cxt->xbl_size)
> +               cxt->pstore.flags |= PSTORE_FLAGS_XBL;
>
>         err = pstore_register(&cxt->pstore);
>         if (err) {
> @@ -835,6 +891,7 @@ static int ramoops_probe(struct platform_device *pdev)
>         dump_oops = pdata->dump_oops;
>         ramoops_console_size = pdata->console_size;
>         ramoops_pmsg_size = pdata->pmsg_size;
> +       ramoops_xbl_size = pdata->xbl_size;
>         ramoops_ftrace_size = pdata->ftrace_size;
>
>         pr_info("using 0x%lx@0x%llx, ecc: %d\n",
> @@ -847,6 +904,8 @@ static int ramoops_probe(struct platform_device *pdev)
>         kfree(cxt->pstore.buf);
>  fail_clear:
>         cxt->pstore.bufsize = 0;
> +       persistent_ram_free(cxt->bprz);
> +fail_init_bprz:
>         persistent_ram_free(cxt->mprz);
>  fail_init_mprz:
>  fail_init_fprz:
> @@ -915,6 +974,7 @@ static void __init ramoops_register_dummy(void)
>         pdata.console_size = ramoops_console_size;
>         pdata.ftrace_size = ramoops_ftrace_size;
>         pdata.pmsg_size = ramoops_pmsg_size;
> +       pdata.xbl_size = ramoops_xbl_size;
>         pdata.dump_oops = dump_oops;
>         pdata.flags = RAMOOPS_FLAG_FTRACE_PER_CPU;
>
> diff --git a/include/linux/pstore.h b/include/linux/pstore.h
> index b146181..e016bbf 100644
> --- a/include/linux/pstore.h
> +++ b/include/linux/pstore.h
> @@ -43,13 +43,14 @@ enum pstore_type_id {
>         PSTORE_TYPE_MCE         = 1,
>         PSTORE_TYPE_CONSOLE     = 2,
>         PSTORE_TYPE_FTRACE      = 3,
> +       PSTORE_TYPE_XBL         = 4,

Instead of reordering, please just append after PPC_OPAL.

>         /* PPC64-specific partition types */
> -       PSTORE_TYPE_PPC_RTAS    = 4,
> -       PSTORE_TYPE_PPC_OF      = 5,
> -       PSTORE_TYPE_PPC_COMMON  = 6,
> -       PSTORE_TYPE_PMSG        = 7,
> -       PSTORE_TYPE_PPC_OPAL    = 8,
> +       PSTORE_TYPE_PPC_RTAS    = 5,
> +       PSTORE_TYPE_PPC_OF      = 6,
> +       PSTORE_TYPE_PPC_COMMON  = 7,
> +       PSTORE_TYPE_PMSG        = 8,
> +       PSTORE_TYPE_PPC_OPAL    = 9,
>
>         /* End of the list */
>         PSTORE_TYPE_MAX
> @@ -207,10 +208,20 @@ struct pstore_info {
>  #define PSTORE_FLAGS_CONSOLE   BIT(1)
>  #define PSTORE_FLAGS_FTRACE    BIT(2)
>  #define PSTORE_FLAGS_PMSG      BIT(3)
> +#define PSTORE_FLAGS_XBL       BIT(4)
>
>  extern int pstore_register(struct pstore_info *);
>  extern void pstore_unregister(struct pstore_info *);
>
> +#define PSTORE_XBL_COOKIE      0x4c425850 /* "PXBL" in ASCII */
> +
> +struct pstore_xbl_header {
> +       uint32_t cookie;
> +       uint32_t size_written;
> +};
> +
> +#define PSTORE_XBL_HDR_SIZE    sizeof(struct pstore_xbl_header)
> +
>  struct pstore_ftrace_record {
>         unsigned long ip;
>         unsigned long parent_ip;

I don't see anything that actually _writes_ the PXBL? How does pstore
interact with the boot loader to get the logs?

-- 
Kees Cook
