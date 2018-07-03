Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D47C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C0523E80
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mvrq9/Uh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C0523E80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934035AbeGCPhW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:37:22 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52329 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933933AbeGCPhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:37:20 -0400
Received: by mail-it0-f68.google.com with SMTP id p4-v6so3728730itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=30w5FcS4aSaL45ySKftVASszSujMzzBVXluFiBfMawo=;
        b=Mvrq9/Uh0F04wGHdQIgapKadKrjWEaxZ41KiJZgYOhdpL956ovvxASslqRkpG7OgVc
         ryN5U6a1bzGN7xRdU14XMay+OsBZb/YCgTDIpdMepgzDddZ5Ls/8PRlk6fZmJpiqkfSM
         HL8GzH0ImvX/Pz/A1ioxKgp1/tRwIPPFJhbTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=30w5FcS4aSaL45ySKftVASszSujMzzBVXluFiBfMawo=;
        b=AfEuiy8RShtxdnbaM3KTe181JsAIJFmOs1ELDEH0MS0lrBoCC3w8FULzvBv+Iq80tv
         OIiaa+Ye+Rs6OufqPdUjsMxX/Gg0Q3VpCIOHyDgyeaDDOIGtgcJunhMQIRyldMtJuzFk
         AQ88GGBmriXcVrxstf+GlvGdKwCXsfXXr+IXTUegbWoNJugUKnwOlDL9n5IyCu84zG8D
         p4y8pNENlanbm+BGu+gtevs2x0xYE5isUt9kuMMYmXqIlqZCejH3air6tJuZr+ySP4Rj
         /4kV/lXIfnLEtjDYxJMkiMTQwIaq8dHW4MKk2KLWzUFVJu+5CqMADIvTRWCF6ix3KEs2
         HRjw==
X-Gm-Message-State: APt69E2k099U/VuWBKYPw+yubMzUyZDYeQT5EsO1T0tCgjlxF2f75HJ3
        5nlP4RsNG4ODeu5PYMLyCViokVBW0W5maYVaE2ynog==
X-Google-Smtp-Source: AAOMgpfRTLbwVzaMO9SpWvzaEmBVdV/XUtZvoUa8LSEyZArGyWqV/IlJzLEqUgR9w8iu53NJIVwe2DsEhwNF7JYnRos=
X-Received: by 2002:a02:4187:: with SMTP id n7-v6mr24904392jad.86.1530632238681;
 Tue, 03 Jul 2018 08:37:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 08:37:18 -0700 (PDT)
In-Reply-To: <1530624720-32004-1-git-send-email-brijesh.singh@amd.com>
References: <1530624720-32004-1-git-send-email-brijesh.singh@amd.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 3 Jul 2018 17:37:18 +0200
Message-ID: <CAKv+Gu8MZ1O2U=OiONCdaFQjNGVPjqASMP7ubKCg-9ULdk7Whw@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: Access EFI MMIO data as unencrypted when SEV is active
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        KVM devel mailing list <kvm@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Andy Lutomirski <luto@kernel.org>,
        "# 4 . 15 . x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 July 2018 at 15:32, Brijesh Singh <brijesh.singh@amd.com> wrote:
> SEV guest fails to update the UEFI runtime variables stored in the
> flash. commit 1379edd59673 ("x86/efi: Access EFI data as encrypted
> when SEV is active") unconditionally maps all the UEFI runtime data
> as 'encrypted' (C=1). When SEV is active the UEFI runtime data marked
> as EFI_MEMORY_MAPPED_IO should be mapped as 'unencrypted' so that both
> guest and hypervisor can access the data.
>

I'm uncomfortable having to carry these heuristics in the kernel. The
UEFI memory map should be the definitive source of information
regarding how the OS should map the regions it describes, and if we
need to guess the encryption status, we are likely to get it wrong at
least some of the times.

Is any work underway to get the UEFI spec extended to take encrypted
memory into account? I am aware that we cannot disclose specifics, but
you should be able to disclose whether it is under discussion or not.

In the mean time, we will have to do something, I know that, but I
would like to discuss the proper solution before proceeding with the
stop gap one.

-- 
Ard.


> Fixes: 1379edd59673 (x86/efi: Access EFI data as encrypted ...)
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: linux-efi@vger.kernel.org
> Cc: kvm@vger.kernel.org
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: <stable@vger.kernel.org> # 4.15.x
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/platform/efi/efi_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index 77873ce..5f2eb32 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -417,7 +417,7 @@ static void __init __map_region(efi_memory_desc_t *md, u64 va)
>         if (!(md->attribute & EFI_MEMORY_WB))
>                 flags |= _PAGE_PCD;
>
> -       if (sev_active())
> +       if (sev_active() && md->type != EFI_MEMORY_MAPPED_IO)
>                 flags |= _PAGE_ENC;
>
>         pfn = md->phys_addr >> PAGE_SHIFT;
> --
> 2.7.4
>
