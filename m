Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A63C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7400D21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QL0GlCTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7400D21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeJDXFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:32968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727505AbeJDXFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:05:25 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEE4D2147D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Oct 2018 16:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538669488;
        bh=McW8l0g6u/rmKJBjUdIIj6PR8dE10qVwcKAaEBFicnE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QL0GlCTkOPO4qASli0QzgW2694Z1n5Q5Q4HExotJ9AfDwuteN2B1xBBLp4PSsxWpX
         nmI3LN1ikUeaslRm7KiWa86J2J1Yhkz+K2CcuWhIiSa4mSrLF3zqepu572NWgBN+Ne
         w7PblTK3Dh6jXr3Cy9xsKpZiJlFkc0jwueIKkxpc=
Received: by mail-wr1-f42.google.com with SMTP id a2-v6so3483348wrc.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 09:11:27 -0700 (PDT)
X-Gm-Message-State: ABuFfogz6g571VWrwzSgl2H/bk1ZSgLtnl6ieM1BXLarYBDbr1LR9JTR
        SOtpIGTon/JvFxlJnqP1HbGcOx4duFYkR9mlbus6jg==
X-Google-Smtp-Source: ACcGV62WUVHCeK6Uipu0KKC97xIy3fwJ+NfgSeD4pPVuy3IztqNDnYDiKMIUY2UIVL3crxxoDypFk4VaBNSnuDsWkyo=
X-Received: by 2002:adf:e387:: with SMTP id e7-v6mr5478846wrm.94.1538669486047;
 Thu, 04 Oct 2018 09:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180921150553.21016-1-yu-cheng.yu@intel.com> <20180921150553.21016-4-yu-cheng.yu@intel.com>
In-Reply-To: <20180921150553.21016-4-yu-cheng.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 4 Oct 2018 09:11:14 -0700
X-Gmail-Original-Message-ID: <CALCETrUj5_kc8qr5xNJSyE4Dz18BcYCcgA1i_CvqgJzZiwG+ig@mail.gmail.com>
Message-ID: <CALCETrUj5_kc8qr5xNJSyE4Dz18BcYCcgA1i_CvqgJzZiwG+ig@mail.gmail.com>
Subject: Re: [RFC PATCH v4 3/9] x86/cet/ibt: Add IBT legacy code bitmap
 allocation function
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 8:10 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> Indirect branch tracking provides an optional legacy code bitmap
> that indicates locations of non-IBT compatible code.  When set,
> each bit in the bitmap represents a page in the linear address is
> legacy code.
>
> We allocate the bitmap only when the application requests it.
> Most applications do not need the bitmap.
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/kernel/cet.c | 45 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
> index 6adfe795d692..a65d9745af08 100644
> --- a/arch/x86/kernel/cet.c
> +++ b/arch/x86/kernel/cet.c
> @@ -314,3 +314,48 @@ void cet_disable_ibt(void)
>         wrmsrl(MSR_IA32_U_CET, r);
>         current->thread.cet.ibt_enabled = 0;
>  }
> +
> +int cet_setup_ibt_bitmap(void)
> +{
> +       u64 r;
> +       unsigned long bitmap;
> +       unsigned long size;
> +
> +       if (!cpu_feature_enabled(X86_FEATURE_IBT))
> +               return -EOPNOTSUPP;
> +
> +       if (!current->thread.cet.ibt_bitmap_addr) {
> +               /*
> +                * Calculate size and put in thread header.
> +                * may_expand_vm() needs this information.
> +                */
> +               size = TASK_SIZE / PAGE_SIZE / BITS_PER_BYTE;
> +               current->thread.cet.ibt_bitmap_size = size;
> +               bitmap = do_mmap_locked(0, size, PROT_READ | PROT_WRITE,
> +                                       MAP_ANONYMOUS | MAP_PRIVATE,
> +                                       VM_DONTDUMP);
> +
> +               if (bitmap >= TASK_SIZE) {
> +                       current->thread.cet.ibt_bitmap_size = 0;
> +                       return -ENOMEM;
> +               }
> +
> +               current->thread.cet.ibt_bitmap_addr = bitmap;
> +       }
> +
> +       /*
> +        * Lower bits of MSR_IA32_CET_LEG_IW_EN are for IBT
> +        * settings.  Clear lower bits even bitmap is already
> +        * page-aligned.
> +        */
> +       bitmap = current->thread.cet.ibt_bitmap_addr;
> +       bitmap &= PAGE_MASK;
> +
> +       /*
> +        * Turn on IBT legacy bitmap.
> +        */
> +       rdmsrl(MSR_IA32_U_CET, r);
> +       r |= (MSR_IA32_CET_LEG_IW_EN | bitmap);
> +       wrmsrl(MSR_IA32_U_CET, r);
> +       return 0;

Why are you writing the MSRs in the case where the bitmap was already allocated?
