Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B4DC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8760C240C2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 22:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tl34x+Nb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8760C240C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753592AbeGEW0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 18:26:19 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33473 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753432AbeGEW0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 18:26:17 -0400
Received: by mail-io0-f194.google.com with SMTP id z20-v6so9183668iol.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 15:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Itn3GGTAZrZ9LLqDELowKuzdSYibg/LVa3Nwm/YGp+g=;
        b=Tl34x+NbbxypL+9USkzjCJoPMevvQJEhDrBJZ9qpfs3Nz8Mvg16aIPeAwNFarxGCcW
         7jYt+A06oanqLWJjtsBd/ntAVHXUHezLWohTkK85HHJlV0MvwgMj7g7M517yQBosj/t+
         5zbtS+tLlIDBRzQundpX5qelbQC1mI+QZoH24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Itn3GGTAZrZ9LLqDELowKuzdSYibg/LVa3Nwm/YGp+g=;
        b=MMK2Xp3L6l07K+txYtp2uJLn/aL0tHKyuCVe/GZSozcBoENAe28Q4MgqvlzpTFBnCL
         M9DPUNpWiiC3A1Z1qFtRHPi/OtQicH0gfY35oYGZFYdosYxguCqyhsjXnJEie4uB8Vrk
         PBPd4BJ+5VocOTSZkATCrNaz3g5Bc+NpZNVYVqs1xajXviLZXVkEyKGMOG/TwZteEXr6
         Ewv4wqXxaAW8DtzCqpfd1kMn/X5PDZW1R2sLolA+OsevTukr085BKyfSMOxXeW6I7IJk
         Y5wmWJsdkoFVI1+vrTuGT4kHu3TmNDVcQNs8ntorr3gIW264aj3V4rxb4Bx5eTssjsRs
         dSDw==
X-Gm-Message-State: AOUpUlGJKp9TQm4YRtucgwhXV7NiBzdr2dFXDFCiyK3gtyCItg6S3HJg
        nKURSCa0cPf5kjFd8yxLC7c6GD/OdbjWVAGmD8VepA==
X-Google-Smtp-Source: AAOMgpd04kHJQerumdCo/i6/s3qnVjYwJgXTrHL5ETj5oZSCWxbcBGSEi+Stmc9lMiPCtpnxmkS29dmZo7ftXyYHGrk=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr6459667iof.173.1530829576901;
 Thu, 05 Jul 2018 15:26:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 15:26:16 -0700 (PDT)
In-Reply-To: <20180619064424.6642-3-takahiro.akashi@linaro.org>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org> <20180619064424.6642-3-takahiro.akashi@linaro.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 6 Jul 2018 00:26:16 +0200
Message-ID: <CAKv+Gu8m6DafSohjodBe324=UdubrPRLxGVGfTqOxhJ7FYK5Bg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] efi/arm: map UEFI memory map even w/o runtime
 services enabled
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Baicar, Tyler" <tbaicar@codeaurora.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Al Stone <al.stone@linaro.org>,
        Graeme Gregory <graeme.gregory@linaro.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 June 2018 at 08:44, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> Under the current implementation, UEFI memory map will be mapped and made
> available in virtual mappings only if runtime services are enabled.
> But in a later patch, we want to use UEFI memory map in acpi_os_ioremap()
> to create mappings of ACPI tables using memory attributes described in
> UEFI memory map.
>
> So, as a first step, arm_enter_runtime_services() will be modified
> so that UEFI memory map will be always accessible.
>
> See a relevant commit:
>     arm64: acpi: fix alignment fault in accessing ACPI tables
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

This may be taken via the arm64 tree.

> ---
>  drivers/firmware/efi/arm-runtime.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index 5889cbea60b8..30ac5c82051e 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -115,6 +115,13 @@ static int __init arm_enable_runtime_services(void)
>                 return 0;
>         }
>
> +       mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
> +
> +       if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
> +               pr_err("Failed to remap EFI memory map\n");
> +               return 0;
> +       }
> +
>         if (efi_runtime_disabled()) {
>                 pr_info("EFI runtime services will be disabled.\n");
>                 return 0;
> @@ -127,13 +134,6 @@ static int __init arm_enable_runtime_services(void)
>
>         pr_info("Remapping and enabling EFI services.\n");
>
> -       mapsize = efi.memmap.desc_size * efi.memmap.nr_map;
> -
> -       if (efi_memmap_init_late(efi.memmap.phys_map, mapsize)) {
> -               pr_err("Failed to remap EFI memory map\n");
> -               return -ENOMEM;
> -       }
> -
>         if (!efi_virtmap_init()) {
>                 pr_err("UEFI virtual mapping missing or invalid -- runtime services will not be available\n");
>                 return -ENOMEM;
> --
> 2.17.0
>
