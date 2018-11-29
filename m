Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF9FC04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F882146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SsC7VIYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25F882146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388266AbeK3Bea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:34:30 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37054 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388226AbeK3Be3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:34:29 -0500
Received: by mail-it1-f196.google.com with SMTP id b5so3879545iti.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 06:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+MJvvToJ8ek5wJ8rT/HjfWH2ukSo4paI+8AVR+NKLok=;
        b=SsC7VIYGM6g7azcTEwzjOpE187KfRsy2k5bNyDnPwiZSMkjx57UFQ0Pr0F+FUvBBxl
         MNpLY3+UzMcacHOQwmGaDvnlIal+w0xpnHcO1rySpw6IQvCYRPPpnlqywu2VkqUoLoR2
         xDZ4GDkB5zjRJrq2cR2e/FpHdtYcw7OqE3obI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+MJvvToJ8ek5wJ8rT/HjfWH2ukSo4paI+8AVR+NKLok=;
        b=nGl8xBMkMbg7Pl9FGogUXroxuOIYOtjN1a95beEJBvLc5A578Zt3USVSgNa/PuMd8/
         Pwydk3+VLF6QoWJhR7bdnyYAS900BHmWBLKGSUlzXlUFqJF2iwE1DembKn93aOUFdBvk
         wN/uvxAw7kfQ2mZB2KDcz9AgxBxsjYYJWOJ5+1wcbiaQd0BpazEt1YdmMvDvDjv+DqoX
         IaHCcEwwP5nsucPR/i/O+tt+lF0bdOEpRGdkpz2amwO/EFFseQiafuHvUWPSR3/ertB6
         XIbex4f60u0KKh3d1arJyGjCbLzsy35qqdl/Exi9WcFCSYqMhVd9xsT0iRx/lWcVRzk8
         GVpg==
X-Gm-Message-State: AA+aEWaAVug98N6yCuKi6RCDi1jbHWesSbD+omwns3haa8FOgJrim/P4
        ld2CtYn1HLxITQBeUaj+Y5kDf4KAaveZNsmfPPTm6Q==
X-Google-Smtp-Source: AFSGD/WOyXNh1RNGIb4w4+xDqk2r0ffHN5CZ3R6qC0a4SqxchYJ4GaVe5Fjum51W7fMeZsPmBNLTHdtc4p9cbjDcCgc=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr1722403itk.71.1543501736299;
 Thu, 29 Nov 2018 06:28:56 -0800 (PST)
MIME-Version: 1.0
References: <20181129140106.520639693@linuxfoundation.org> <20181129140109.438834361@linuxfoundation.org>
In-Reply-To: <20181129140109.438834361@linuxfoundation.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 29 Nov 2018 15:28:44 +0100
Message-ID: <CAKv+Gu8cPOQaYY_KH3dq+2U517z7j67Od+Cxe+wB4gkEOqnQTA@mail.gmail.com>
Subject: Re: [PATCH 4.9 39/92] efi/arm: Revert deferred unmap of early memmap mapping
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018 at 15:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.9-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> [ Upstream commit 33412b8673135b18ea42beb7f5117ed0091798b6 ]
>
> Commit:
>
>   3ea86495aef2 ("efi/arm: preserve early mapping of UEFI memory map longer for BGRT")
>
> deferred the unmap of the early mapping of the UEFI memory map to
> accommodate the ACPI BGRT code, which looks up the memory type that
> backs the BGRT table to validate it against the requirements of the UEFI spec.
>
> Unfortunately, this causes problems on ARM, which does not permit
> early mappings to persist after paging_init() is called, resulting
> in a WARN() splat. Since we don't support the BGRT table on ARM anway,
> let's revert ARM to the old behaviour, which is to take down the
> early mapping at the end of efi_init().
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-efi@vger.kernel.org
> Fixes: 3ea86495aef2 ("efi/arm: preserve early mapping of UEFI memory ...")

This commit is only in v4.19 as far as I know. Does it even apply?


> Link: http://lkml.kernel.org/r/20181114175544.12860-3-ard.biesheuvel@linaro.org
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/firmware/efi/arm-init.c    | 4 ++++
>  drivers/firmware/efi/arm-runtime.c | 2 +-
>  drivers/firmware/efi/memmap.c      | 3 +++
>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
> index 1d1c9693ebfb..8ee91777abce 100644
> --- a/drivers/firmware/efi/arm-init.c
> +++ b/drivers/firmware/efi/arm-init.c
> @@ -256,6 +256,10 @@ void __init efi_init(void)
>                                     (params.mmap & ~PAGE_MASK)));
>
>         init_screen_info();
> +
> +       /* ARM does not permit early mappings to persist across paging_init() */
> +       if (IS_ENABLED(CONFIG_ARM))
> +               efi_memmap_unmap();
>  }
>
>  static int __init register_gop_device(void)
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index 4d788e0debfe..069c5a4479e6 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -118,7 +118,7 @@ static int __init arm_enable_runtime_services(void)
>  {
>         u64 mapsize;
>
> -       if (!efi_enabled(EFI_BOOT) || !efi_enabled(EFI_MEMMAP)) {
> +       if (!efi_enabled(EFI_BOOT)) {
>                 pr_info("EFI services will not be available.\n");
>                 return 0;
>         }
> diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
> index 78686443cb37..3fd2b450c649 100644
> --- a/drivers/firmware/efi/memmap.c
> +++ b/drivers/firmware/efi/memmap.c
> @@ -117,6 +117,9 @@ int __init efi_memmap_init_early(struct efi_memory_map_data *data)
>
>  void __init efi_memmap_unmap(void)
>  {
> +       if (!efi_enabled(EFI_MEMMAP))
> +               return;
> +
>         if (!efi.memmap.late) {
>                 unsigned long size;
>
> --
> 2.17.1
>
>
>
