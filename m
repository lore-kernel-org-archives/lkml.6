Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4747AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE6B208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 22:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tk42Kih6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE6B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeK1JPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 04:15:49 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39332 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeK1JPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 04:15:49 -0500
Received: by mail-yb1-f194.google.com with SMTP id w17-v6so9770711ybl.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 14:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2Bn0AIaLoCyxPbCwdB+CiH0+4Gj/6ALN7l5EUCaW5aY=;
        b=Tk42Kih6l+hUqdTBnuPAJDcmdpgAnUqaSSInIi23AubMOSqohTLTYwhX6Mw+M+Q1O6
         RF9T72sqRjCk9ipBm5eg5IL1yMVq8s7ca+XRQNhLzjUo7jrmynPoTAWzaVrawZbwY6i8
         x+FTUrSFfKL3KibR8Fld9JKpBg9/R/8vJ4rMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2Bn0AIaLoCyxPbCwdB+CiH0+4Gj/6ALN7l5EUCaW5aY=;
        b=Fi3PWiOD1lZTARrba7hhMO5qz54b9RQKtHz2SdN1Y0F1Uw6i83xdA5MORLB1U+DTcU
         dYlVtaxIZnDxoV8nCnrJl12TeBOtmwmP2YXoT8mhLS/9QzgyfjOY52DSCe9va1OGs2Xn
         TLdhIQVNho+MHy5srb/symWMw61p27KC9owT6fKJV3z6zexiRe9EjE43nIjFyeDJ6KaH
         wwCGvz2DA1tkQ/N762p76/i7oK/RR5bLEP8qEJxvzP5fD+rs8z12K42oY67VyfL/xl0+
         lVNYhAn/OjD8FcWIldCwXwVKu0TNGnCuboi18Uk38NPbhLFnDwB9GWfb+R1jxgyjmhjQ
         PadA==
X-Gm-Message-State: AA+aEWaQo8Dh/F9PPu0baZp0paWHnjKy3kfS1AreAyZQ1juGokf9qkgn
        lw9GzH9Wa28w1B4g6SM/mSj/hSC0tvI=
X-Google-Smtp-Source: AFSGD/VdLGUyw8kGos+eEWpc93qZeK4TnAFseGS5eeZ5LxaEkxX1ni8BjUixyq2KrtZxikXnGsIwEA==
X-Received: by 2002:a25:cc1:: with SMTP id 184-v6mr34841705ybm.47.1543356988046;
        Tue, 27 Nov 2018 14:16:28 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id z74sm1695473ywz.51.2018.11.27.14.16.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 14:16:27 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id w17-v6so9770679ybl.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 14:16:26 -0800 (PST)
X-Received: by 2002:a25:a22a:: with SMTP id b39-v6mr21877185ybi.209.1543356986295;
 Tue, 27 Nov 2018 14:16:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:b906:0:0:0:0:0 with HTTP; Tue, 27 Nov 2018 14:16:25
 -0800 (PST)
In-Reply-To: <20181121113944.GD27797@zn.tnic>
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com> <20181121113944.GD27797@zn.tnic>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 27 Nov 2018 14:16:25 -0800
X-Gmail-Original-Message-ID: <CAGXu5jKYxgLPD4YonGSXjECJS=c18rxWmuFC1eeUJK9fLeTxcg@mail.gmail.com>
Message-ID: <CAGXu5jKYxgLPD4YonGSXjECJS=c18rxWmuFC1eeUJK9fLeTxcg@mail.gmail.com>
Subject: Re: [PATCH v2] x86_64, vmcoreinfo: Append 'page_offset_base' to vmcoreinfo
To:     Borislav Petkov <bp@alien8.de>
Cc:     Bhupesh Sharma <bhsharma@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        Baoquan He <bhe@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Dave Anderson <anderson@redhat.com>,
        James Morse <james.morse@arm.com>,
        Omar Sandoval <osandov@fb.com>, X86 ML <x86@kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 3:39 AM, Borislav Petkov <bp@alien8.de> wrote:
> + Kees.
>
> On Fri, Nov 16, 2018 at 03:17:49AM +0530, Bhupesh Sharma wrote:
>> x86_64 kernel uses 'page_offset_base' variable to point to the
>> start of direct mapping of all physical memory. This variable
>> is also updated for KASLR boot cases, so this can be exported
>> via vmcoreinfo as a standard ABI between kernel and user-space,
>> to allow user-space utilities to use the same for calculating
>> the start of direct mapping of all physical memory.

Why is KERNELOFFSET= not sufficient?

See commit b6085a865762 ("x86, kaslr: export offset in VMCOREINFO ELF notes")

+       vmcoreinfo_append_str("KERNELOFFSET=%lx\n",
+                             (unsigned long)&_text - __START_KERNEL);

-Kees

>> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
>> index 4c8acdfdc5a7..6161d77c5bfb 100644
>> --- a/arch/x86/kernel/machine_kexec_64.c
>> +++ b/arch/x86/kernel/machine_kexec_64.c
>> @@ -356,6 +356,9 @@ void arch_crash_save_vmcoreinfo(void)
>>       VMCOREINFO_SYMBOL(init_top_pgt);
>>       vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
>>                       pgtable_l5_enabled());
>> +#ifdef CONFIG_RANDOMIZE_BASE
>> +     VMCOREINFO_NUMBER(page_offset_base);
>> +#endif
>>
>>  #ifdef CONFIG_NUMA
>>       VMCOREINFO_SYMBOL(node_data);

-- 
Kees Cook
