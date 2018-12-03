Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795DFC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4463A20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4463A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbeLCVwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:52:10 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39169 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbeLCVwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:52:10 -0500
Received: by mail-qt1-f194.google.com with SMTP id n21so15694019qtl.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 13:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wz3G1K0Wqct2QY1g8HOnYswKaEU/I5gQsQNRf+imps4=;
        b=JYU3YzzdazN8c0b68+WCOad2QOBfor+J0jsn6QzTbSgAdIkKUuz1Wh2c4rxsJ9ZCk5
         H03i7XpdGf0eeA36/gBMlfBy9NB0ZfqYiGbp2AqRiAAt0Zg7ThzDnlwaDt3loJFLKNb/
         PEjSGlU/DxMwv/hhltIaYJkNt6mxa/4YZbOIT0DvlDbMFp8qp4c/sNeffWUYqM7mdMMS
         ys8Gollf7IThM+0nE8sxL/d4c8v281mre++WebwrZChF6B6/dw/KITU05gG5Azb3tEA+
         bjm6HLPpL2Sle165J7SF9NlaI+M0QM1VX8QxhzsEJwelRcOWLx6kSQygiI6YJ7HH0bvr
         l7jQ==
X-Gm-Message-State: AA+aEWbjQjkrzajotcwIZTLfLjkcpyIR3hPTBGiIMclLrJT9JViOqzuQ
        cEBsMMcDzEkRV8b6su2AgXaICmyoWuALSAZyK+o=
X-Google-Smtp-Source: AFSGD/VZG2VieAMQM8L8JLVwrZC2CJU9F3fdxhqwMdhMSgQv79tym8p9rpuV1A7/MFQXfKzsGg0QxctbqsJi4keAHHw=
X-Received: by 2002:ac8:7451:: with SMTP id h17mr16754405qtr.319.1543873929119;
 Mon, 03 Dec 2018 13:52:09 -0800 (PST)
MIME-Version: 1.0
References: <20181130150956.27620-1-anders.roxell@linaro.org> <20181203192228.GC29028@arm.com>
In-Reply-To: <20181203192228.GC29028@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 3 Dec 2018 22:51:52 +0100
Message-ID: <CAK8P3a2gekEqUuvsC-_+ijhiqqff2bK-s2wQfkjn7z-HtNnMDQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: ftrace: add cond_resched() to func ftrace_make_(call|nop)
To:     Will Deacon <will.deacon@arm.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 8:22 PM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Anders,
>
> On Fri, Nov 30, 2018 at 04:09:56PM +0100, Anders Roxell wrote:
> > Both of those functions end up calling ftrace_modify_code(), which is
> > expensive because it changes the page tables and flush caches.
> > Microseconds add up because this is called in a loop for each dyn_ftrace
> > record, and this triggers the softlockup watchdog unless we let it sleep
> > occasionally.
> > Rework so that we call cond_resched() before going into the
> > ftrace_modify_code() function.
> >
> > Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  arch/arm64/kernel/ftrace.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
>
> It sounds like you're running into issues with the existing code, but I'd
> like to understand a bit more about exactly what you're seeing. Which part
> of the ftrace patching is proving to be expensive?
>
> The page table manipulation only happens once per module when using PLTs,
> and the cache maintenance is just a single line per patch site without an
> IPI.
>
> Is it the loop in ftrace_replace_code() that is causing the hassle?

Yes: with an allmodconfig kernel, the ftrace selftest calls ftrace_replace_code
to look >40000 through ftrace_make_call/ftrace_make_nop, and these
end up calling

static int __kprobes __aarch64_insn_write(void *addr, __le32 insn)
{
        void *waddr = addr;
        unsigned long flags = 0;
        int ret;

        raw_spin_lock_irqsave(&patch_lock, flags);
        waddr = patch_map(addr, FIX_TEXT_POKE0);

        ret = probe_kernel_write(waddr, &insn, AARCH64_INSN_SIZE);

        patch_unmap(FIX_TEXT_POKE0);
        raw_spin_unlock_irqrestore(&patch_lock, flags);

        return ret;
}
int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
{
        u32 *tp = addr;
        int ret;

        /* A64 instructions must be word aligned */
        if ((uintptr_t)tp & 0x3)
                return -EINVAL;

        ret = aarch64_insn_write(tp, insn);
        if (ret == 0)
                __flush_icache_range((uintptr_t)tp,
                                     (uintptr_t)tp + AARCH64_INSN_SIZE);

        return ret;
}

which seems to be where the main cost is. This is with inside of
qemu, and with lots of debugging options (in particular
kcov and ubsan) enabled, that make each function call
more expensive.

       Arnd
