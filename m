Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CA4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9F020665
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eMomHCq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9F020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbeK1Ljg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:39:36 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34344 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeK1Ljg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 06:39:36 -0500
Received: by mail-yb1-f196.google.com with SMTP id a67-v6so8379494ybg.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 16:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=62JmnOQJP2lO3L0gCfOHK/LfogQgd8R1+Hk63mm/Yx4=;
        b=eMomHCq7/8ZBPnywh9rtQeHoXoTRkzO8P4wC2WcBimD/N62LgpVVBwfa5ZUA8SEJpd
         QIohMdEAug9GGj982wm7fuK67wBRjGuijDDIEF3NSLMGwRWvPNWhIJMlkGc4z8nbddmf
         vo2QkCdo2Z58UvkrAvy3aKSj6flESd4slg994=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=62JmnOQJP2lO3L0gCfOHK/LfogQgd8R1+Hk63mm/Yx4=;
        b=OtKF2zx/bBKlidSHyl4NCPSmwjOZXlo9FZDQV/rK/r3a1y+MCuNJVTe5ScGhNt5yu8
         x3hNqxJdY4+ShblxtR0968LHc8+aaBbxBII3z8xrIBC6b2ROaNY7a0J8780pgz/Qkkr1
         bSWLbJ77Lt1IfbsmH5macncZZYceKxX7b3K/BKssBy5x3ARd5jzz3Tb0V3QvT+ONJ11t
         oNYKEvEHDfWp7nGpszmfzlT0cOr4CnxheZ+uE863Is3I4mpt2NzT9kbn6iNWhLEIEx/x
         W1cbqhHn4fzxJA0DGR7vKehw3nwlZpO9UpbTxdfwxzZTFCzC09WIyl4QhF5/2BJRlpiG
         ZR4g==
X-Gm-Message-State: AA+aEWbdEC+ZAzVDXMlARs715rCfjCTukgaaiEQ7d4WPyo8R6Ad0Z+W3
        knobt0aEVHS8JR94s+7cdWcOYukr4vg=
X-Google-Smtp-Source: AFSGD/WQXJTzDvJPX7fTJLSbPDNambRuGl/w04Pd3xpxVXP7TVoLSc6wfHTv+aYMoX4xA4DIpJ2PnQ==
X-Received: by 2002:a25:14d5:: with SMTP id 204-v6mr26644146ybu.109.1543365595662;
        Tue, 27 Nov 2018 16:39:55 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id x132sm2207095ywx.27.2018.11.27.16.39.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 16:39:52 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id f6-v6so8476015ybg.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 16:39:52 -0800 (PST)
X-Received: by 2002:a25:a445:: with SMTP id f63-v6mr34342804ybi.171.1543365591765;
 Tue, 27 Nov 2018 16:39:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Tue, 27 Nov 2018 16:39:50
 -0800 (PST)
In-Reply-To: <20181127232916.GG1824@MiWiFi-R3L-srv>
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
 <20181121113944.GD27797@zn.tnic> <CAGXu5jKYxgLPD4YonGSXjECJS=c18rxWmuFC1eeUJK9fLeTxcg@mail.gmail.com>
 <20181127232916.GG1824@MiWiFi-R3L-srv>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 27 Nov 2018 16:39:50 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJzVMmqJ9JvFqDhDx=QShiWisWO0bY49cD5r-7By5dxFg@mail.gmail.com>
Message-ID: <CAGXu5jJzVMmqJ9JvFqDhDx=QShiWisWO0bY49cD5r-7By5dxFg@mail.gmail.com>
Subject: Re: [PATCH v2] x86_64, vmcoreinfo: Append 'page_offset_base' to vmcoreinfo
To:     Baoquan He <bhe@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, X86 ML <x86@kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Dave Anderson <anderson@redhat.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 3:29 PM, Baoquan He <bhe@redhat.com> wrote:
> On 11/27/18 at 02:16pm, Kees Cook wrote:
>> Why is KERNELOFFSET= not sufficient?
>>
>> See commit b6085a865762 ("x86, kaslr: export offset in VMCOREINFO ELF notes")
>>
>> +       vmcoreinfo_append_str("KERNELOFFSET=%lx\n",
>> +                             (unsigned long)&_text - __START_KERNEL);
>
> KERNELOFFSET is virtual address delta after kernel text KASLR, namely
> the offset from the original default kernel text virtual address,
> 0xffffffff88000000.
>
> While after memory region KASLR in kernel_randomize_memory(), the
> starting address of the direct mapping of physical memory, PAGE_OFFSET,
> is changed too. We need get it to analyze memory in makedumpfile/crash.
> Currently we deduce it from elf program segment of kcore:
> Program Headers:
>   Type           Offset             VirtAddr           PhysAddr
>                  FileSiz            MemSiz              Flags  Align
> ......
>
>   LOAD           0x00000a62c0004000 0xffff8a62c0001000 0x0000000000001000
>                  0x000000000009c000 0x000000000009c000  RWE    1000
>
> page_offset = 0xffff8a62c0001000 - 0x0000000000001000;
> Since we put the direct mapping segments at the bottom part of kcore, we
> can always get page_offset right.
>
> Thanks
> Baoquan
>
>>
>> -Kees
>>
>> >> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
>> >> index 4c8acdfdc5a7..6161d77c5bfb 100644
>> >> --- a/arch/x86/kernel/machine_kexec_64.c
>> >> +++ b/arch/x86/kernel/machine_kexec_64.c
>> >> @@ -356,6 +356,9 @@ void arch_crash_save_vmcoreinfo(void)
>> >>       VMCOREINFO_SYMBOL(init_top_pgt);
>> >>       vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
>> >>                       pgtable_l5_enabled());
>> >> +#ifdef CONFIG_RANDOMIZE_BASE

Okay, gotcha. In that case, shouldn't this be CONFIG_RANDOMIZE_MEMORY?

-Kees

>> >> +     VMCOREINFO_NUMBER(page_offset_base);
>> >> +#endif
>> >>
>> >>  #ifdef CONFIG_NUMA
>> >>       VMCOREINFO_SYMBOL(node_data);
>>
>> --
>> Kees Cook
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec



-- 
Kees Cook
