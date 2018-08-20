Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B9AC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFB120C09
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Si1iUeY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFB120C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeHUBGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 21:06:23 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:44700 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeHUBGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 21:06:22 -0400
Received: by mail-io0-f193.google.com with SMTP id l8-v6so3283071ioj.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 14:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S60IQiaH6D3Igx5OKZaFDH6VZ24uqizJ3TYtT9chWPo=;
        b=Si1iUeY6Dqf3A8g8YizUVtg4mPZe561G93qibY+q+XuibRauC8QZ0tV6eQNocWqGh9
         iQ+yvg7hGZlJ4g/zdTuRCP511Fz2rS3mAukTCPveyZsEX0QcvcI0Ch8IUnccHE9/HRM4
         porB7h82BGAEKwyK/NVZp1rZ6f3Yzbk7ZT9BY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S60IQiaH6D3Igx5OKZaFDH6VZ24uqizJ3TYtT9chWPo=;
        b=HaQ4CqotRcf9YXoMFjCfPk09dLxrl/4Xbb6AlejxkCC9hb2vzMm/l2Te/HczDMpwkF
         fQFIEnBor/YDr8dlmRYvzjv9lUo/ZG9Kwt1OdiJnL4uLmCRLo8MeKWr61yyQUL2SKP6F
         8hJkP2lSM9jWmw9ZMfPj6uf+5HXZrxmA+meg4VM9BlLDqLcPkqzyy1FHQnKqSPVwKmHb
         KzaG9jM9B39TNv8vsXoXmIBCfElUCtF2QkO0H2ZBjO4fLmATrZPQnUnR+NUQfqtzsyiq
         SCLF63Fff3OlcwN280ERZCUypm33+1WEymOu5uAowV6tg5HLDjfqhI9uwRm9/LVDa+rS
         +OGg==
X-Gm-Message-State: AOUpUlEfZbTtLQOwcW+CvonKXIuznL941W/vWXmdXiqjW01ocLPOxaqd
        dZ5b+d54eC7CFjcVhjNmG+L5sQhmclFpps4ROxU=
X-Google-Smtp-Source: AA+uWPx1wWxUUEIJhVHyN1EXspMykyzaENdlrO1nrI88uEr9HJaRzlYTEJQx5om8hUGeencHYkPtCn9kA0pzTc370M4=
X-Received: by 2002:a6b:f609:: with SMTP id n9-v6mr24040541ioh.259.1534801742247;
 Mon, 20 Aug 2018 14:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180820212556.GC2230@char.us.oracle.com>
In-Reply-To: <20180820212556.GC2230@char.us.oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Aug 2018 14:48:51 -0700
Message-ID: <CA+55aFxZCyVZc4ZpRyZ3uDyakRSOG_=2XvnwMo4oejpsieF9=A@mail.gmail.com>
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs
 in mind (for KVM to isolate its guests per CPU)
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Liran Alon <liran.alon@oracle.com>,
        deepa.srinivasan@oracle.com, linux-mm <linux-mm@kvack.org>,
        juerg.haefliger@hpe.com, Khalid Aziz <khalid.aziz@oracle.com>,
        chris.hyser@oracle.com, Tyler Hicks <tyhicks@canonical.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Kees Cook <keescook@google.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Jon Masters <jcm@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        kanth.ghatraju@oracle.com, joao.m.martins@oracle.com,
        Jim Mattson <jmattson@google.com>, pradeep.vincent@oracle.com,
        Andi Kleen <ak@linux.intel.com>,
        John Haxby <john.haxby@oracle.com>,
        jsteckli@os.inf.tu-dresden.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 2:26 PM Konrad Rzeszutek Wilk
<konrad.wilk@oracle.com> wrote:
>
> See eXclusive Page Frame Ownership (https://lwn.net/Articles/700606/) which was posted
> way back in in 2016..

Ok, so my gut feel is that the above was reasonable within the context
of 2016, but that the XPFO model is completely pointless and wrong in
the post-Meltdown world we now live in.

Why?

Because with the Meltdown patches, we ALREADY HAVE the isolated page
tables that XPFO tries to do.

They are just the normal user page tables.

So don't go around doing other crazy things.

All you need to do is to literally:

 - before you enter VMX mode, switch to the user page tables

 - when you exit, switch back to the kernel page tables

don't do anything else.  You're done.

Now, this is complicated a bit by the fact that in order to enter VMX
mode with the user page tables, you do need to add the VMX state
itself to those user page tables (and add the actual trampoline code
to the vmenter too).

So it does imply we need to slightly extend the user mapping with a
few new patches, but that doesn't sound bad.

In fact, it sounds absolutely trivial to me.

The other thing you want to do is is the trivial optimization of "hey.
we exited VMX mode due to a host interrupt", which would look like
this:

 * switch to user page tables in order to do vmenter
 * vmenter
 * host interrupt happens
    - switch to kernel page tables to handle irq
    - do_IRQ etc
    - switch back to user page tables
    - iret
 * switch to kernel page tables because the vmenter returned

so you want to have some trivial short-circuiting of that last "switch
to user page tables and back" dance. It may actually be that we don't
even need it, because the irq code may just be looking at what *mode*
we were in, not what page tables we were in. I looked at that code
back in the meltdown days, but that's already so last-year now that we
have all these _other_ CPU bugs we handled.

But other than small details like that, doesn't this "use our Meltdown
user page table" sound like the right thing to do?

And note: no new VM code or complexity. None. We already have the
"isolated KVM context with only pages for the KVM process" case
handled.

Of course, after the long (and entirely unrelated) discussion about
the TLB flushing bug we had, I'm starting to worry about my own
competence, and maybe I'm missing something really fundamental, and
the XPFO patches do something else than what I think they do, or my
"hey, let's use our Meltdown code" idea has some fundamental weakness
that I'm missing.

              Linus
