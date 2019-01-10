Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352AAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FD4206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfAJHNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:13:49 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38120 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbfAJHNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:13:49 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so4912788pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 23:13:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oYh2pk6F2N93fgKStblCLSkfY8pRw+12ZQ8vYdIXyW8=;
        b=dxM1xaYF7Gah6S3SNFDw7y40q5lubFKAOb5+9L4ckdEOZG+xme6pwbT7xn0PgjHMSK
         aUkd2Tz0lBFERHmYN45ApUAJnVpStLI0bFpIdfLab3GF90qtUuVsNPZHSh/OYsbPw2jL
         aTk57nxMVecDtsAX6KY25ICT8F//j9NJslWtkCt5iGej860m6A+H/+1VFVZoRIOmGXEO
         rRkNIc+bThCN1rycjaBaJO73QsQ+wMAqqTW+nLdu1f/Rm2UMvkYs0bTAPG/E4tnFjniv
         pesp58K7wUoQ901mkNwlK0ZTpkTyHYebnkFnKrqxvJWiV/SDutgTRH/nOin7KVxqzfBO
         41pg==
X-Gm-Message-State: AJcUukdCWcgCFtQaHdxTZcqWsl9dzIOjN6qHT6+Bi891FNOsygEV7Zpx
        3/sGEn8N0P5weimwVNdgOlw3Mw==
X-Google-Smtp-Source: ALg8bN5tmfiZNfB8Qgm7mkvYlGdI4f0isn9VBmMCR9h8hMEXDafKDljZaA16k/9Yf1bEvTfK08/atg==
X-Received: by 2002:a63:3507:: with SMTP id c7mr8385876pga.315.1547104428201;
        Wed, 09 Jan 2019 23:13:48 -0800 (PST)
Received: from [192.168.1.6] ([122.177.131.230])
        by smtp.gmail.com with ESMTPSA id x2sm105069338pfx.78.2019.01.09.23.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 23:13:47 -0800 (PST)
Subject: Re: [PATCH 3/3] x86/platform/UV: use efi_runtime_sem to serialise
 BIOS calls
To:     Hedi Berriche <hedi.berriche@hpe.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Russ Anderson <rja@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>, bhsharma@redhat.com,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>
References: <20190109104541.25733-1-hedi.berriche@hpe.com>
 <20190109104541.25733-4-hedi.berriche@hpe.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <134565bb-0f5e-27c7-199c-af6132dc0dc3@redhat.com>
Date:   Thu, 10 Jan 2019 12:43:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190109104541.25733-4-hedi.berriche@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hedi,

Thanks for the patchset.

I will give this a go on my sgi-uv300 machine and come back with more 
detailed inputs, but I wanted to ask about the hang/panic you mentioned 
in the cover letter when efi_scratch gets clobbered. Can you describe 
the same (for e.g. how to reproduce this).

Nitpicks below:

On 01/09/2019 04:15 PM, Hedi Berriche wrote:
> Calls into UV firmware must be protected against concurrency, use the
> now visible efi_runtime_sem lock to serialise them.
> 
> Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
> Reviewed-by: Russ Anderson <rja@hpe.com>
> Reviewed-by: Mike Travis <mike.travis@hpe.com>
> Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
> Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
> ---
>   arch/x86/include/asm/uv/bios.h |  3 ++-
>   arch/x86/platform/uv/bios_uv.c | 25 ++++++++++++++++++++++---
>   2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
> index 4eee646544b2..33e94aa0b1ff 100644
> --- a/arch/x86/include/asm/uv/bios.h
> +++ b/arch/x86/include/asm/uv/bios.h
> @@ -48,7 +48,8 @@ enum {
>   	BIOS_STATUS_SUCCESS		=  0,
>   	BIOS_STATUS_UNIMPLEMENTED	= -ENOSYS,
>   	BIOS_STATUS_EINVAL		= -EINVAL,
> -	BIOS_STATUS_UNAVAIL		= -EBUSY
> +	BIOS_STATUS_UNAVAIL		= -EBUSY,
> +	BIOS_STATUS_ABORT		= -EINTR
>   };
>   
>   /* Address map parameters */
> diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
> index cd05af157763..92f960798e20 100644
> --- a/arch/x86/platform/uv/bios_uv.c
> +++ b/arch/x86/platform/uv/bios_uv.c
> @@ -29,7 +29,8 @@
>   
>   struct uv_systab *uv_systab;
>   
> -s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
> +s64 __uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
> +			u64 a4, u64 a5)

Can we make this static?

>   {
>   	struct uv_systab *tab = uv_systab;
>   	s64 ret;
> @@ -44,13 +45,26 @@ s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
>   	 * If EFI_OLD_MEMMAP is set, we need to fall back to using our old EFI
>   	 * callback method, which uses efi_call() directly, with the kernel page tables:
>   	 */
> -	if (unlikely(test_bit(EFI_OLD_MEMMAP, &efi.flags)))
> +	if (unlikely(efi_enabled(EFI_OLD_MEMMAP)))
>   		ret = efi_call((void *)__va(tab->function), (u64)which, a1, a2, a3, a4, a5);
>   	else
>   		ret = efi_call_virt_pointer(tab, function, (u64)which, a1, a2, a3, a4, a5);
>   
>   	return ret;
>   }
> +
> +s64 uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3, u64 a4, u64 a5)
> +{
> +	s64 ret;
> +
> +	if (down_interruptible(&efi_runtime_sem))
> +		return BIOS_STATUS_ABORT;
> +
> +	ret = __uv_bios_call(which, a1, a2, a3, a4, a5);
> +	up(&efi_runtime_sem);
> +
> +	return ret;
> +}
>   EXPORT_SYMBOL_GPL(uv_bios_call);
>   
>   s64 uv_bios_call_irqsave(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
> @@ -59,10 +73,15 @@ s64 uv_bios_call_irqsave(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
>   	unsigned long bios_flags;
>   	s64 ret;
>   
> +	if (down_interruptible(&efi_runtime_sem))
> +		return BIOS_STATUS_ABORT;
> +
>   	local_irq_save(bios_flags);
> -	ret = uv_bios_call(which, a1, a2, a3, a4, a5);
> +	ret = __uv_bios_call(which, a1, a2, a3, a4, a5);
>   	local_irq_restore(bios_flags);
>   
> +	up(&efi_runtime_sem);
> +
>   	return ret;
>   }
>   

Thanks,
Bhupesh
