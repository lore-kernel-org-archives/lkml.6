Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D515CC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2D021470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vD4yB7Lm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2D021470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbeJLCyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 22:54:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbeJLCyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 22:54:09 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C1E221470
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 19:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539285932;
        bh=YJo/qxuGm+DW/D8051DkEp1KmIgUQc8LeJ4cGi/xPBg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vD4yB7LmdaqYAPUJlz+e2T7pHKpb2ucjCK40MFMXPd78r5a4zZ9CqLRsEGL6kWwFl
         OUQJXsHTeiiYnM3qZQkGxR+xcRM7h3mJMPhdD5tD+TcqrAx821c48BOMpHHRzG5+I5
         s3VAiD5WtChGgeRFCs4Q5gqvrjq+4ghIX23OC8Ls=
Received: by mail-wr1-f45.google.com with SMTP id a13-v6so10933284wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 12:25:32 -0700 (PDT)
X-Gm-Message-State: ABuFfojxe/SPYj6Gt8BIYUgbQdrV3HFLaNFMUUtCSiUbO9TumabfBRTS
        brxDuDKCoFxnMbo9+6n4lfGYqKhkuMsQzWy/2k9WFA==
X-Google-Smtp-Source: ACcGV635e8kUOFuGxJpz93vjamKoGxtV+KoKHR4LWQeJg9R8YHA7b9vtDAfRtHnb1JTOGq6yXbkPNlHOm9STJ4X1kz8=
X-Received: by 2002:adf:9792:: with SMTP id s18-v6mr2857469wrb.283.1539285930778;
 Thu, 11 Oct 2018 12:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20181011185458.10186-1-kristen@linux.intel.com>
In-Reply-To: <20181011185458.10186-1-kristen@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 11 Oct 2018 12:25:18 -0700
X-Gmail-Original-Message-ID: <CALCETrW5sNz-TO8w8e+7d1oD_CmnUX_txnBuKe2+wM7qFaK64A@mail.gmail.com>
Message-ID: <CALCETrW5sNz-TO8w8e+7d1oD_CmnUX_txnBuKe2+wM7qFaK64A@mail.gmail.com>
Subject: Re: [PATCH] x86: entry: flush the cache if syscall error
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 11:55 AM Kristen Carlson Accardi
<kristen@linux.intel.com> wrote:
>
> This patch aims to make it harder to perform cache timing attacks on data
> left behind by system calls. If we have an error returned from a syscall,
> flush the L1 cache.
>
> It's important to note that this patch is not addressing any specific
> exploit, nor is it intended to be a complete defense against anything.
> It is intended to be a low cost way of eliminating some of side effects
> of a failed system call.
>
> A performance test using sysbench on one hyperthread and a script which
> attempts to repeatedly access files it does not have permission to access
> on the other hyperthread found no significant performance impact.
>

> +__visible inline void l1_cache_flush(struct pt_regs *regs)
> +{
> +       if (IS_ENABLED(CONFIG_SYSCALL_FLUSH) &&
> +           static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
> +               if (regs->ax == 0 || regs->ax == -EAGAIN ||
> +                   regs->ax == -EEXIST || regs->ax == -ENOENT ||
> +                   regs->ax == -EXDEV || regs->ax == -ETIMEDOUT ||
> +                   regs->ax == -ENOTCONN || regs->ax == -EINPROGRESS)
> +                       return;
> +
> +               wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
> +       }
> +}

Ugh.

What exactly is this trying to protect against?  And how many cycles
should we expect L1D_FLUSH to take?

ISTM that, if we have a situation where the L1D can be read by user
code, we lose, via hyperthreading, successful syscalls, /dev/random,
and may other vectors.  This seems like a small mitigation at a rather
large cost.
