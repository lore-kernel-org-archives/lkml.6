Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61399C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97FC214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97FC214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbeIZRFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:05:09 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43606 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeIZRFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:05:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id x24-v6so22775589lfe.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 03:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M0afTeUMik/pKJbXYWkFFBROPj0k+/qdGyabKMFW/Pc=;
        b=Exgeqbivql9unBQto513L8iY+Lj1Xl0qL1PFc3zzlzvG/DXtwikZa3kZMGB44CTVK3
         wl1/vQDJFQ1MHqSkeljPquYVGNW2A0L7vRoXhvJiCrN9hVtNV7S8Go+x4XgJCI5BOdGf
         VhUwGciNYHDjHes4s68fm90MsZ8FThCFubvp3Frjsqkwb2InQrXsvQ/rd787/5xvhNao
         jyZTPscxuOFVVfVYQQGiuXC1zQvNHYrYSqssVoR1y244pffs6TWVOUlPjYSOt3FKVIQV
         bMiAmUsbMuqYPMwZaFc1iVH81yw5Aam33I5Fw9OoeTo8+5LHTYUwNzLTeR+hILzX7yS4
         fIjw==
X-Gm-Message-State: ABuFfoih0lsj4jiEzUsV3tsbqAKv8/bPPop4X5UaW4fIK1EJKCrJW4Qu
        WeqTKmVVCBYh3q4djYF67py92ZUEVJpuKA0G55Nc7w==
X-Google-Smtp-Source: ACcGV62lr9y7rTpwApMngFHxJ1010RvFlObQEOH6NbreV0s17ohUyZWeY1C0IGRVcSU6x1VCkQ3zUaHs2lyfg+wmCzE=
X-Received: by 2002:a19:d3c4:: with SMTP id k187-v6mr3910927lfg.101.1537959165445;
 Wed, 26 Sep 2018 03:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180925111020.23834-1-kasong@redhat.com> <6e15796e-31e9-2dc6-4a31-5c1b01554b45@amd.com>
 <20180925172608.GB15464@zn.tnic> <20180926073252.GC2555@MiWiFi-R3L-srv>
In-Reply-To: <20180926073252.GC2555@MiWiFi-R3L-srv>
From:   Kairui Song <kasong@redhat.com>
Date:   Wed, 26 Sep 2018 18:52:33 +0800
Message-ID: <CACPcB9efDdBGnU53wRLw8uP0fzLcq0c2O8V3z=8xW_DMSOUtYw@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Fix kexec booting failure after SEV early boot support
To:     Thomas.Lendacky@amd.com
Cc:     Baoquan He <bhe@redhat.com>, bp@suse.de, brijesh.singh@amd.com,
        x86@kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com,
        tglx@linutronix.de, Dave Young <dyoung@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 3:33 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 09/25/18 at 07:26pm, Borislav Petkov wrote:
> > IINM, the problem can be addressed in a simpler way by getting rid of
> > enc_bit and thus getting rid of the need to do relative addressing of
> > anything and simply doing the whole dance of figuring out the C-bit each
> > time. It probably wouldn't be even measurable...
>
> Couldn't agree more.
>
> Obviously enc_bit is redundent here. We only check eax each time,
> removing it can fix the RIP-relative addressing issue in kexec.
>
> diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
> index eaa843a52907..0b60eb867d25 100644
> --- a/arch/x86/boot/compressed/mem_encrypt.S
> +++ b/arch/x86/boot/compressed/mem_encrypt.S
> @@ -27,19 +27,6 @@ ENTRY(get_sev_encryption_bit)
>         push    %edx
>         push    %edi
>
> -       /*
> -        * RIP-relative addressing is needed to access the encryption bit
> -        * variable. Since we are running in 32-bit mode we need this call/pop
> -        * sequence to get the proper relative addressing.
> -        */
> -       call    1f
> -1:     popl    %edi
> -       subl    $1b, %edi
> -
> -       movl    enc_bit(%edi), %eax
> -       cmpl    $0, %eax
> -       jge     .Lsev_exit
> -
>         /* Check if running under a hypervisor */
>         movl    $1, %eax
>         cpuid
> @@ -69,12 +56,10 @@ ENTRY(get_sev_encryption_bit)
>
>         movl    %ebx, %eax
>         andl    $0x3f, %eax             /* Return the encryption bit location */
> -       movl    %eax, enc_bit(%edi)
>         jmp     .Lsev_exit
>
>  .Lno_sev:
>         xor     %eax, %eax
> -       movl    %eax, enc_bit(%edi)
>
>  .Lsev_exit:
>         pop     %edi
> @@ -113,9 +98,6 @@ ENTRY(set_sev_encryption_mask)
>  ENDPROC(set_sev_encryption_mask)
>
>         .data
> -enc_bit:
> -       .int    0xffffffff
> -
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>         .balign 8
>  GLOBAL(sme_me_mask)

That is much cleaner indeed, I'm not sure if enc_bit have any other
usage, if not we can just drop it for sure.

Hi Thomas, can you help confirm if enc_bit is only a cache to avoid
doing the cpuid stuff?

-- 
Best Regards,
Kairui Song
