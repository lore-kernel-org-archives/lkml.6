Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A42C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0EF20883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbfAIG41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 01:56:27 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35347 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbfAIG40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 01:56:26 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so9572015itp.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 22:56:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TUd/juat8ZoWZOT+ZeChopJYAhBwed+H0awVEc8O7pE=;
        b=oiBocHiLycaWfXLwiWT4QqGa7w6p3E91vaeP5p/1fSspsszCEkfOyv+gWDoM5XM+I5
         jAGbmFP9Y0UTmB/TH4IbHsgj2NUO0R1VOw/Fa7ma4IvG4laEDOzD1J5CJLgpYXWTQwBP
         Ifsq2pmkF0CB3fp0OF9pG6sxOPxeZMybh0NG51HIQwwi8GALTO0qRrYzL+Ay5uvkscGz
         DHlF3fDyjlVxo6DwKSw6GjCLT4/mIG7cHUixoBy0M9krByWvC/6ISSaaqFUD0+aLfGNS
         JoEnn6qiR1yLjp7pTwtSwdMp/HUzISqPYXAmzBXGo4ZHDurzW8yCDBbMLcQZr71jfrZB
         7ZOg==
X-Gm-Message-State: AJcUukd8LozxU7epUyxkpNOkp9fnfEiZVA1WoHxQX8Eg6Gl6SSsPNlmc
        qaoVlAVtzp+ya8SfA/TsHiGgw/0FCCwdT4NO/sJm8AWBseQHkw==
X-Google-Smtp-Source: ALg8bN6NaXgK1WROMhMrmchmLmZcwNRmFiOJj7q2WKxA32cdM0vi4s4nmVgWYM5gScKoB+ERfj/n1taVu0tlBXOM8N8=
X-Received: by 2002:a24:ce42:: with SMTP id v63mr3293361itg.136.1547016985542;
 Tue, 08 Jan 2019 22:56:25 -0800 (PST)
MIME-Version: 1.0
References: <20190109064302.26780-1-kasong@redhat.com>
In-Reply-To: <20190109064302.26780-1-kasong@redhat.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Wed, 9 Jan 2019 14:56:14 +0800
Message-ID: <CACPcB9eB19F+FDBOypwKK1co+nA-GCpW2ophcwva9AL5Qq+jhA@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86, kexec_file_load: Don't setup EFI info if EFI
 runtime is not enabled
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, Dave Young <dyoung@redhat.com>,
        akpm@linux-foundation.org, kexec@lists.infradead.org,
        Baoquan He <bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CCing more people

On Wed, Jan 9, 2019 at 2:45 PM Kairui Song <kasong@redhat.com> wrote:
>
> Currenly with "efi=noruntime" in kernel command line, calling
> kexec_file_load will raise below problem:
>
> [   97.967067] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> [   97.967894] #PF error: [normal kernel read fault]
> ...
> [   97.980456] Call Trace:
> [   97.980724]  efi_runtime_map_copy+0x28/0x30
> [   97.981267]  bzImage64_load+0x688/0x872
> [   97.981794]  arch_kexec_kernel_image_load+0x6d/0x70
> [   97.982441]  kimage_file_alloc_init+0x13e/0x220
> [   97.983035]  __x64_sys_kexec_file_load+0x144/0x290
> [   97.983586]  do_syscall_64+0x55/0x1a0
> [   97.983962]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> When efi runtime is not enabled, efi memmap is not mapped, so just skip
> EFI info setup.
>
> Suggested-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>  arch/x86/kernel/kexec-bzimage64.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 0d5efa34f359..53917a3ebf94 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -167,6 +167,9 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
>         struct efi_info *current_ei = &boot_params.efi_info;
>         struct efi_info *ei = &params->efi_info;
>
> +       if (!efi_enabled(EFI_RUNTIME_SERVICES))
> +               return 0;
> +
>         if (!current_ei->efi_memmap_size)
>                 return 0;
>
> --
> 2.20.1
>


-- 
Best Regards,
Kairui Song
