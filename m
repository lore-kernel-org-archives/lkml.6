Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0140C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7907F20854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 18:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U+nZ7naY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7907F20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbeGVTZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 15:25:36 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35529 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730506AbeGVTZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 15:25:35 -0400
Received: by mail-io0-f193.google.com with SMTP id w11-v6so8270885iob.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 11:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4H2b//X01nwgyuSxluobo3FDtc6XUHdPLtYQoFidPx8=;
        b=U+nZ7naYLlC0d6IlaaTva3lKNP6u/O+IcIBkRrspvxvyVqcpNYNTcwWD8F8VkY+CR2
         BtTwqutABSZE47Aq8yIjfgJwntdeW+l/3X1+Qg4goy9wlZIcKL2A2TQtW3x+C4WlrYTP
         IR7MqFipQPaLxm0lWi2fgHoyhUGOoDtfaJIPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4H2b//X01nwgyuSxluobo3FDtc6XUHdPLtYQoFidPx8=;
        b=gXLKCys1peSbea+3mvc2ipe3VPWWR4t90gy9veQ5HMPUmRaP5W/7FFpv4pPPL2Z2dK
         YBTWCiQ/F40R1XCddV8pjlO/jpIdMhngb/4KdZ6m5p8/Q5MUBeJWPegncsmPLIqw8n33
         igThvCMqzxweo3Z7BhrbPZLmeB//13S/mmnXfy2YHmWDVoKJ9hMqZIwnXgGcPzDyFnlq
         0l3TSeogSqOnmJx1ovMp2/sA3TRdCnZNcN5f5JPawQQtg0jlalAX2UWcYTbJLGORYtYn
         EeoU3cb7J158tclrb1RuqnfHtqwCmR6qEl6oEjFrJqOLKWx7IcT8QeeFdw1aloChzEe3
         QaIA==
X-Gm-Message-State: AOUpUlHLfXpxxqoWJkxBbWM0ZwzN9MvfrAAS+3VTg+CshzXMlLLsHo0B
        HbnPDyYWqCR89KiNAXSPN9kQwYGzmmZIl8u6Hh8=
X-Google-Smtp-Source: AAOMgpebyqVyH30/XSc5bKfGtm2QzsisQMYrZdznndTl0dMcWFcCruaHduKYCn953O5fgOXkqdghpk3fjy2xUdR/hG0=
X-Received: by 2002:a6b:f612:: with SMTP id n18-v6mr8200579ioh.259.1532284081511;
 Sun, 22 Jul 2018 11:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1532281180.git.luto@kernel.org> <1e3d01ce04315218d3f8ee269528bb774a4d1d60.1532281180.git.luto@kernel.org>
In-Reply-To: <1e3d01ce04315218d3f8ee269528bb774a4d1d60.1532281180.git.luto@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Jul 2018 11:27:50 -0700
Message-ID: <CA+55aFz1ne3KTzni2Yvsp8ZRFzk+s78ZhKyGeLZvmRivBhFMfA@mail.gmail.com>
Subject: Re: [RFC 2/2] x86/pti/64: Remove the SYSCALL64 entry trampoline
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 10:45 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> This patch changes the code to map the percpu TSS into the user page
> tables to allow the non-trampoline SYSCALL64 path to work under PTI.

Me likey.

However:

> This does not add a new direct information leak, since the TSS is
> readable by Meltdown from the cpu_entry_area alias regardless.

Afaik, it does now potentially expose through meltdown the per-thread
entry stack info, which is new.

But I don't think that's a show-stopper.

>  static void __init pti_clone_user_shared(void)
>  {
> +       for_each_possible_cpu(cpu) {

But this code is pretty disgusting and seems wrong.

Do you really want to do all trhe _possible_ cpu's, not just the
online ones? I'd rather expose less (think MAXCPU) and then have the
CPU hotplug code expose the page as the CPU comes up?

> +               unsigned long va = (unsigned long)&per_cpu(cpu_tss_rw, cpu);
> +               phys_addr_t pa = per_cpu_ptr_to_phys((void *)va);
> +               pte_t *target_pte;
> +
> +               target_pte = pti_user_pagetable_walk_pte(va);

This function only exists if CONFIG_X86_VSYSCALL_EMULATION, so it
won't even compile under (very unusual) configurations.

The "disgusting" part is that I think it could/should share more code
with the vsyscall case, and the whole target-pte checking and setting
should be shared too.

Beause not being shared, I react to this:

> +               set_pte(target_pte, pfn_pte(pa >> PAGE_SHIFT, PAGE_KERNEL));

Hmm. The vsyscall code just does

        *target_pte = ..

without any set_pte() stuff. Do we want/need the PVOP cases, and if
so, why doesn't the vsyscall case need it?

Anyway, I love the approach, and how this gets rid of the nasty
trampoline, so no real complaints, just "this needs some fixups".

                Linus
