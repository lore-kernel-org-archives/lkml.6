Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AFFECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3D42077B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIR1PKKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3D42077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbeGQUin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:38:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730027AbeGQUim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:38:42 -0400
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E91620834
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 20:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531857869;
        bh=W3m6y5FiKhTM8zUTgIIJg4Q9yMvxEpuw2xp8Z3qe/5w=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=qIR1PKKiqVAyBT0fAvgMcQRuStU8PtgJ9K50GvShL/O3Y8Ql9DX2kcGRdzYR74Pfv
         zZEEsToh2bqfSqvNT/AYn9BwKDcMMdKNV8Q5sA0WdirXr2d9zEPE27eyKa9qJ/s9cz
         Zy02fPDx/gJcXwtN3IbttD9dz6awMpHPUzWbO744=
Received: by mail-wm0-f53.google.com with SMTP id h20-v6so555784wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:04:29 -0700 (PDT)
X-Gm-Message-State: AOUpUlEfQ5gTW4fk7I2vXi8WjkUm1FKWKuPZSCaUsg+L+I/Tpr/hLgU0
        noLb/LLYJAh4VkaqdlTlI8r6McwXPd/IiTwOnuYRDg==
X-Google-Smtp-Source: AAOMgpdCieXSPcXelWPNCN9Ep4NlHJC3M6OW2RyKsFzLCUx7OoMosWQXYAmmLfp4fJYGV+JPfjpfNeJeTZOjWaELG88=
X-Received: by 2002:a1c:ef0f:: with SMTP id n15-v6mr2109118wmh.116.1531857868131;
 Tue, 17 Jul 2018 13:04:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 13:04:07
 -0700 (PDT)
In-Reply-To: <20180716190337.26133-5-riel@surriel.com>
References: <20180716190337.26133-1-riel@surriel.com> <20180716190337.26133-5-riel@surriel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 17 Jul 2018 13:04:07 -0700
X-Gmail-Original-Message-ID: <CALCETrUMntRe_LYX5wj9YD4xZ+84QExK+ZNb3yxEBDEKa7nePQ@mail.gmail.com>
Message-ID: <CALCETrUMntRe_LYX5wj9YD4xZ+84QExK+ZNb3yxEBDEKa7nePQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
To:     Rik van Riel <riel@surriel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 12:03 PM, Rik van Riel <riel@surriel.com> wrote:
> Lazy TLB mode can result in an idle CPU being woken up by a TLB flush,
> when all it really needs to do is reload %CR3 at the next context switch,
> assuming no page table pages got freed.
>
> Memory ordering is used to prevent race conditions between switch_mm_irqs_off,
> which checks whether .tlb_gen changed, and the TLB invalidation code, which
> increments .tlb_gen whenever page table entries get invalidated.
>
> The atomic increment in inc_mm_tlb_gen is its own barrier; the context
> switch code adds an explicit barrier between reading tlbstate.is_lazy and
> next->context.tlb_gen.
>
> Unlike the 2016 version of this patch, CPUs with cpu_tlbstate.is_lazy set
> are not removed from the mm_cpumask(mm), since that would prevent the TLB
> flush IPIs at page table free time from being sent to all the CPUs
> that need them.
>
> This patch reduces total CPU use in the system by about 1-2% for a
> memcache workload on two socket systems, and by about 1% for a heavily
> multi-process netperf between two systems.
>

I'm not 100% certain I'm replying to the right email, and I haven't
gotten the tip-bot notification at all, but:

I think you've introduced a minor-ish performance regression due to
changing the old (admittedly terribly documented) control flow a bit.
Before, if real_prev == next, we would skip:

load_mm_cr4(next);
switch_ldt(real_prev, next);

Now we don't any more.  I think you should reinstate that
optimization.  It's probably as simple as wrapping them in an if
(real_priv != next) with a comment like /* Remote changes that would
require a cr4 or ldt reload will unconditionally send an IPI even to
lazy CPUs.  So, if we aren't changing our mm, we don't need to refresh
cr4 or the ldt */

Hmm.  load_mm_cr4() should bypass itself when mm == &init_mm.  Want to
fix that part or should I?

--Andy
