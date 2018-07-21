Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF37BECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 21:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667F320864
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 21:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ue9RRV+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667F320864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbeGUWkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 18:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728166AbeGUWkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 18:40:13 -0400
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF5AC20875
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 21:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532209561;
        bh=MPio0gvhtelbCQvqD7OQBz7v7atJ027Vg/wNk1Jm/FM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Ue9RRV+ezeDN0VUS+mOulHucy33gHs3Z1PXdXXimGwOKWanKahdKfNEdFWwbK8eee
         98UThJnhWGG+tTO6yHDfdhwNnZGqAstlLR4UTm87om0ExWn6LJN9E+tUd0Owlr6T8k
         /CtgZ9RvvhvomuNUcfi+82GNtnBL7X5G4aGUVSmo=
Received: by mail-wm0-f42.google.com with SMTP id l2-v6so6792305wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 14:46:00 -0700 (PDT)
X-Gm-Message-State: AOUpUlE6EYXnxMvsqV3bkxHrln5k3bnfAyAqFTeimIwahLBsMn+clZtD
        CZXul+8TSVHLB5Kixmrd/SHF20CrlJlWNIXy1++KGA==
X-Google-Smtp-Source: AAOMgpcJtSg5dF6SWzAa8O+GkZR9vAzAxms0vQE+d0VAkjO50fbi7PklEYlu2x8vew2umiK87LLVxKgewR8KPcGejog=
X-Received: by 2002:a1c:8b0d:: with SMTP id n13-v6mr3970179wmd.46.1532209559270;
 Sat, 21 Jul 2018 14:45:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Sat, 21 Jul 2018 14:45:38
 -0700 (PDT)
In-Reply-To: <20180721194909.23903-1-m.v.b@runbox.com>
References: <20180721194909.23903-1-m.v.b@runbox.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 21 Jul 2018 14:45:38 -0700
X-Gmail-Original-Message-ID: <CALCETrX435cC7Hi2aTLVrBecZEEeJ3_TgQnTwbObNrt9MKvFzg@mail.gmail.com>
Message-ID: <CALCETrX435cC7Hi2aTLVrBecZEEeJ3_TgQnTwbObNrt9MKvFzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/entry/64: Do not clear %rbx under Xen
To:     "M. Vefa Bicakci" <m.v.b@runbox.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, X86 ML <x86@kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 12:49 PM, M. Vefa Bicakci <m.v.b@runbox.com> wrote:
> Commit 3ac6d8c787b8 ("x86/entry/64: Clear registers for
> exceptions/interrupts, to reduce speculation attack surface") unintendedly
> broke Xen PV virtual machines by clearing the %rbx register at the end of
> xen_failsafe_callback before the latter jumps to error_exit.
> error_exit expects the %rbx register to be a flag indicating whether
> there should be a return to kernel mode.
>
> This commit makes sure that the %rbx register is not cleared by
> the PUSH_AND_CLEAR_REGS macro, when the macro in question is instantiated
> by xen_failsafe_callback, to avoid the issue.

Seems like a genuine problem, but:

> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index c7449f377a77..96e8ff34129e 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1129,7 +1129,7 @@ ENTRY(xen_failsafe_callback)
>         addq    $0x30, %rsp
>         UNWIND_HINT_IRET_REGS
>         pushq   $-1 /* orig_ax = -1 => not a system call */
> -       PUSH_AND_CLEAR_REGS
> +       PUSH_AND_CLEAR_REGS clear_rbx=0
>         ENCODE_FRAME_POINTER
>         jmp     error_exit

The old code first set RBX to zero then, if frame pointers are on,
sets it to some special non-zero value, then crosses its fingers and
hopes for the best.  Your patched code just skips the zeroing part, so
RBX either contains the ENCODE_FRAME_POINTER result or is
uninitialized.

How about actually initializing rbx to something sensible like, say, 1?
