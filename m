Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46EFC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52DC20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52DC20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeLMFlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 00:41:04 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42805 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLMFlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 00:41:02 -0500
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so650926lja.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 21:41:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RdExr9ScLXuFlHdGApBXnvCBZ6A9ybHxgm4qPwl7d2k=;
        b=R03RKye8a3UygvnC+e19ys5TkmCOu9ILhBL5KQDdRtinAnhMBuaZtCG8mJY63Cr0jE
         AR1fNSsn6FblRtpI+k+YWoAQ8Z/MOPsypHyr9nzFJkiDAz1aXjdXdF8mWf5UwCzhpMFQ
         WBG0NqvL8IRx2hRXCGJFXWdm+ZeRyoOqH35Ao+q7jdIWbxO8OJ3bTED0GmLQVM0YL5Nc
         GLE9cQKddq4JS69LtqreCDcW1IrMB1zGmzsG+eZ+MAYFTGC6WeLCJzihIjJ0wFu77/3A
         Ygygvt4KpG3ekK/nfpqBNCxzlMgPalsfrogGUiZGuIJVc8wrEsd0BCW4NfjvNqErI3QF
         q1KQ==
X-Gm-Message-State: AA+aEWbbxs/Fces9lXK2zrzNffiObqOJ6JmvaE+si9JbkTQP8tanSG21
        6ZZJ7DsHuDW5JL7yT4joUH/j37t8ee0jUTd1CUf5uw==
X-Google-Smtp-Source: AFSGD/UKbRcPqqrmjvA7OMyV7/LFdCleXnEHfprh/dgWzgLUHUUlCh9tcedPXw9uY+LV1rBfuokboFuwY5riOOR1w8g=
X-Received: by 2002:a2e:9957:: with SMTP id r23-v6mr13204805ljj.98.1544679660240;
 Wed, 12 Dec 2018 21:41:00 -0800 (PST)
MIME-Version: 1.0
References: <1544654224.18411.11.camel@lca.pw> <20181213052259.56352-1-cai@lca.pw>
In-Reply-To: <20181213052259.56352-1-cai@lca.pw>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Thu, 13 Dec 2018 11:10:47 +0530
Message-ID: <CACi5LpP+NHa1WQg78xm1y1YM0KXnFJ72pw+YrizxR5y7yt4AiQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: invalidate TLB before turning MMU on
To:     cai@lca.pw
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Bhupesh SHARMA <bhupesh.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian Cai,

On Thu, Dec 13, 2018 at 10:53 AM Qian Cai <cai@lca.pw> wrote:
>
> On this HPE Apollo 70 arm64 server with 256 CPUs, triggering a crash
> dump just hung. It has 4 threads on each core. Each 2-core share a same
> L1 and L2 caches, so that is 8 CPUs shares those. All CPUs share a same
> L3 cache.
>
> It turned out that this was due to the TLB contained stale entries (or
> uninitialized junk which just happened to look valid) from the first
> kernel before turning the MMU on in the second kernel which caused this
> instruction hung,
>
> msr     sctlr_el1, x0
>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/arm64/kernel/head.S | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 4471f570a295..5196f3d729de 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -771,6 +771,10 @@ ENTRY(__enable_mmu)
>         msr     ttbr0_el1, x2                   // load TTBR0
>         msr     ttbr1_el1, x1                   // load TTBR1
>         isb
> +       dsb     nshst
> +       tlbi    vmalle1                         // invalidate TLB
> +       dsb     nsh
> +       isb

This will be executed both for the primary and kdump kernel, right? I
don't think we really want to invalidate the TLB when booting the
primary kernel.
It would be too slow and considering that we need to minimize boot
timings on embedded arm64 devices, I think it would not be a good
idea.

>         msr     sctlr_el1, x0
>         isb
>         /*
> --
> 2.17.2 (Apple Git-113)
>

Also did you check this issue I reported on the HPE apollo machines
some days back with the kdump kernel boot
<https://www.spinics.net/lists/kexec/msg21750.html>.
Can you please confirm that you are not facing the same issue (as I
suspect from reading your earlier Bug Report) on the HPE apollo
machine. Also adding 'earlycon' to the bootargs being passed to the
kdump kernel you can see if you are able to atleast get some console
output from the kdump kernel.

Thanks,
Bhupesh
