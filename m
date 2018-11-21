Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F114BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FF6214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZuQbNa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FF6214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbeKVB7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:59:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:55500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbeKVB7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:59:12 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6877D214F1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542813859;
        bh=zoGE4NFolTS70Rh8ZjCfP7diJadRHmSYarwzm6AxZ/c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dZuQbNa8FPzS1u6JmJ7ealeM4+bPG7ikbbFbPC5sndzVt0XwVt7VlRk2cIzGOpc7f
         9TlPLHCGCKUV6w1gT7fXOoGCsINorkpJSr4Oq8HuBesLKHDbcPM7qM5rJFUh8cLb+i
         XVZ2maho4QDvqpY4LdzZ1hUrKHfGYGTs6jinjb8o=
Received: by mail-wr1-f45.google.com with SMTP id p4so6113316wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 07:24:19 -0800 (PST)
X-Gm-Message-State: AA+aEWbhiV1CDV75sXhS6pgQibzcdn/X52mQ1BWNkmMVt0sE7uaNqDjq
        XGfdpWEq1JUSqR48KRHJIBWZe7zJmu+xV1al2NQB+Q==
X-Google-Smtp-Source: AFSGD/WA47FL9rOyCvm/0PjG+mtZNQX72FedjDWikwqn+UsMuZwBW8seFHjQfuqFcuQzAvmRfhDB5MNqhMm+bfSMYS8=
X-Received: by 2002:adf:ea81:: with SMTP id s1mr6122764wrm.309.1542813857846;
 Wed, 21 Nov 2018 07:24:17 -0800 (PST)
MIME-Version: 1.0
References: <5AF03EBD02000078001C1303@prv1-mh.provo.novell.com>
 <5AF03EBD02000000000F91D6@prv1-mh.provo.novell.com> <5AF03EBD02000078001FE590@prv1-mh.provo.novell.com>
 <5BF52F0E02000078001FE5BE@prv1-mh.provo.novell.com>
In-Reply-To: <5BF52F0E02000078001FE5BE@prv1-mh.provo.novell.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 21 Nov 2018 07:24:05 -0800
X-Gmail-Original-Message-ID: <CALCETrUa4iw+y+EXSqq_ibJQAfR0+U52Q=tO8_bj1YJgtMUP+Q@mail.gmail.com>
Message-ID: <CALCETrUa4iw+y+EXSqq_ibJQAfR0+U52Q=tO8_bj1YJgtMUP+Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86-64/Xen: fix stack switching
To:     Jan Beulich <JBeulich@suse.com>
Cc:     Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Lutomirski <luto@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 2:10 AM Jan Beulich <JBeulich@suse.com> wrote:
>
> While in the native case entry into the kernel happens on the trampoline
> stack, PV Xen kernels get entered with the current thread stack right
> away. Hence source and destination stacks are identical in that case,
> and special care is needed.
>
> Other than in sync_regs() the copying done on the INT80 path as well as
> on the NMI path itself isn't NMI / #MC safe, as either of these events
> occurring in the middle of the stack copying would clobber data on the
> (source) stack. (Of course, in the NMI case only #MC could break
> things.)
>
> I'm not altering the similar code in interrupt_entry(), as that code
> path is unreachable afaict when running PV Xen guests.
>
> Fixes: 7f2590a110b837af5679d08fc25c6227c5a8c497
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Cc: stable@kernel.org
> ---
> v2: Correct placement of .Lint80_keep_stack label.
> ---
>  arch/x86/entry/entry_64.S        |    8 ++++++++
>  arch/x86/entry/entry_64_compat.S |   10 ++++++++--
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> --- 4.20-rc3/arch/x86/entry/entry_64.S
> +++ 4.20-rc3-x86_64-stack-switch-Xen/arch/x86/entry/entry_64.S
> @@ -1380,6 +1380,12 @@ ENTRY(nmi)
>         swapgs
>         cld
>         SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
> +
> +       movq    PER_CPU_VAR(cpu_current_top_of_stack), %rdx
> +       subq    $8, %rdx
> +       xorq    %rsp, %rdx
> +       shrq    $PAGE_SHIFT, %rdx
> +       jz      .Lnmi_keep_stack

This code shouldn't even be reachable on Xen:

commit 43e4111086a70c78bedb6ad990bee97f17b27a6e
Author: Juergen Gross <jgross@suse.com>
Date:   Thu Nov 2 00:59:07 2017 -0700

    xen, x86/entry/64: Add xen NMI trap entry

    Instead of trying to execute any NMI via the bare metal's NMI trap
    handler use a Xen specific one for PV domains, like we do for e.g.
    debug traps. As in a PV domain the NMI is handled via the normal
    kernel stack this is the correct thing to do.

    This will enable us to get rid of the very fragile and questionable
    dependencies between the bare metal NMI handler and Xen assumptions
    believed to be broken anyway.


>         movq    %rsp, %rdx
>         movq    PER_CPU_VAR(cpu_current_top_of_stack), %rsp
>         UNWIND_HINT_IRET_REGS base=%rdx offset=8
> @@ -1389,6 +1395,8 @@ ENTRY(nmi)
>         pushq   2*8(%rdx)       /* pt_regs->cs */
>         pushq   1*8(%rdx)       /* pt_regs->rip */
>         UNWIND_HINT_IRET_REGS
> +.Lnmi_keep_stack:
> +
>         pushq   $-1             /* pt_regs->orig_ax */
>         PUSH_AND_CLEAR_REGS rdx=(%rdx)
>         ENCODE_FRAME_POINTER
> --- 4.20-rc3/arch/x86/entry/entry_64_compat.S
> +++ 4.20-rc3-x86_64-stack-switch-Xen/arch/x86/entry/entry_64_compat.S
> @@ -361,17 +361,23 @@ ENTRY(entry_INT80_compat)
>
>         /* Need to switch before accessing the thread stack. */
>         SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
> +
> +       movq    PER_CPU_VAR(cpu_current_top_of_stack), %rdi
> +       subq    $8, %rdi
> +       xorq    %rsp, %rdi
> +       shrq    $PAGE_SHIFT, %rdi
> +       jz      .Lint80_keep_stack

This comparison is IMO the wrong test entirely.  How about something like:

/* On Xen PV, entry_INT80_compat is called on the thread stack, so
rewinding to the top of the thread stack would allow an NMI to
overwrite the hardware frame before we copy it. */
ALTERNATIVE "", "jmp .Lint80_keep_stack", X86_FEATURE_XENPV
