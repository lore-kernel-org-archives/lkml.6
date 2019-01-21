Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA88FC2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9518B20870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DL9I95He"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbfAUPnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:43:01 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34673 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729612AbfAUPnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:43:00 -0500
Received: by mail-io1-f66.google.com with SMTP id b16so16758862ior.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhXNhVthK2ADzkNXHxGjOO9GA4GV19AqWl+e6KsOOhg=;
        b=DL9I95He0QGH9IK22WIEmrQxuPDUp/mjHLqqMMWGYkKVVaQt+Wf2ophnhVWRa5rIJm
         X40hYJUacKmclFtP6/yFmArpNo6kNvqEvz5zVlZcHXBlrfYDHWaFmjF5RS/50tRyaVvk
         PwpdECd8tQHlvIbxp9WMMgbBH8bAMDTLIt1no=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhXNhVthK2ADzkNXHxGjOO9GA4GV19AqWl+e6KsOOhg=;
        b=OCHZrXDm6W5V/bIywpZfZ/Lf1T6bFAneIbP5Bhym6Jj44FSDvIb3Io4Xe7M2bP87/W
         50ju6QAPC3TQbwgNqczvvHwq9GPiL3Mv3nlSLb4ePVzbuuFSDLl86mBLTgaQ3DUJuxhN
         L8NZfoX4SyTzGTI7YKX54tOwddccHwxDjjUAObl6O0++DGzOtCxWVaUEZl5dTACKy561
         BPKvLEhSwfFwofZVq6Lm+nSGVFD0BtVmsjyg66zMoCYkGqkJ/t4isingKI6WvHsvX3Oc
         BBYmNRxSQHx4YBRTOEHdfj7eoItjVne/RgL+hEzv8pWTphQILgWIUkLmECOE81r5e8f4
         DaMQ==
X-Gm-Message-State: AJcUukd9NKLzemCAdI0X6xONwah9qw25L9ysIlu4pmTleL8ooDQ8LjII
        PlSwqztiVKwrDLQYyJFqG75NTznIi/nSN6ObFwNSPw==
X-Google-Smtp-Source: ALg8bN7oA+eNciAo7OAY1Trq/TCQHSPNwLNgcgIMUor0zOlWetbhkxMGl14dJFm5IhZLFq9psBXNHdhDPirSC/jrin8=
X-Received: by 2002:a5d:8410:: with SMTP id i16mr16954755ion.173.1548085379377;
 Mon, 21 Jan 2019 07:42:59 -0800 (PST)
MIME-Version: 1.0
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com> <1548084825-8803-12-git-send-email-julien.thierry@arm.com>
In-Reply-To: <1548084825-8803-12-git-send-email-julien.thierry@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 21 Jan 2019 16:42:48 +0100
Message-ID: <CAKv+Gu8w1cgrqpoL2n2Q=Jbjt_ZruF=oH0-cDyy-LuJUo8YBEA@mail.gmail.com>
Subject: Re: [PATCH v9 11/26] efi: Let architectures decide the flags that
 should be saved/restored
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019 at 16:34, Julien Thierry <julien.thierry@arm.com> wrote:
>
> Currently, irqflags are saved before calling runtime services and
> checked for mismatch on return.
>
> Provide a pair of overridable macros to save and restore (if needed) the
> state that need to be preserved on return from a runtime service.
> This allows to check for flags that are not necesarly related to
> irqflags.
>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: linux-efi@vger.kernel.org
> ---
>  drivers/firmware/efi/runtime-wrappers.c | 17 +++++++++++++++--
>  include/linux/efi.h                     |  5 +++--
>  2 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
> index 8903b9c..2f4b68b 100644
> --- a/drivers/firmware/efi/runtime-wrappers.c
> +++ b/drivers/firmware/efi/runtime-wrappers.c
> @@ -89,11 +89,24 @@
>         efi_rts_work.status;                                            \
>  })
>
> +#ifndef arch_efi_save_flags
> +#define arch_efi_save_flags(state_flags)       local_save_flags(state_flags)
> +#define arch_efi_restore_flags(state_flags)    local_irq_restore(state_flags)
> +#endif
> +
> +inline unsigned long efi_call_virt_save_flags(void)

If you drop the 'inline' here,

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> +{
> +       unsigned long flags;
> +
> +       arch_efi_save_flags(flags);
> +       return flags;
> +}
> +
>  void efi_call_virt_check_flags(unsigned long flags, const char *call)
>  {
>         unsigned long cur_flags, mismatch;
>
> -       local_save_flags(cur_flags);
> +       cur_flags = efi_call_virt_save_flags();
>
>         mismatch = flags ^ cur_flags;
>         if (!WARN_ON_ONCE(mismatch & ARCH_EFI_IRQ_FLAGS_MASK))
> @@ -102,7 +115,7 @@ void efi_call_virt_check_flags(unsigned long flags, const char *call)
>         add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_NOW_UNRELIABLE);
>         pr_err_ratelimited(FW_BUG "IRQ flags corrupted (0x%08lx=>0x%08lx) by EFI %s\n",
>                            flags, cur_flags, call);
> -       local_irq_restore(flags);
> +       arch_efi_restore_flags(flags);
>  }
>
>  /*
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 45ff763..bd80b7e 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1607,6 +1607,7 @@ efi_status_t efi_setup_gop(efi_system_table_t *sys_table_arg,
>
>  bool efi_runtime_disabled(void);
>  extern void efi_call_virt_check_flags(unsigned long flags, const char *call);
> +extern unsigned long efi_call_virt_save_flags(void);
>
>  enum efi_secureboot_mode {
>         efi_secureboot_mode_unset,
> @@ -1652,7 +1653,7 @@ enum efi_secureboot_mode {
>                                                                         \
>         arch_efi_call_virt_setup();                                     \
>                                                                         \
> -       local_save_flags(__flags);                                      \
> +       __flags = efi_call_virt_save_flags();                           \
>         __s = arch_efi_call_virt(p, f, args);                           \
>         efi_call_virt_check_flags(__flags, __stringify(f));             \
>                                                                         \
> @@ -1667,7 +1668,7 @@ enum efi_secureboot_mode {
>                                                                         \
>         arch_efi_call_virt_setup();                                     \
>                                                                         \
> -       local_save_flags(__flags);                                      \
> +       __flags = efi_call_virt_save_flags();                           \
>         arch_efi_call_virt(p, f, args);                                 \
>         efi_call_virt_check_flags(__flags, __stringify(f));             \
>                                                                         \
> --
> 1.9.1
>
