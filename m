Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE75C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E881720834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wlFopwh3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E881720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbeLDS4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:56:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:52720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbeLDS4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:56:19 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A13B20851
        for <linux-kernel@vger.kernel.org>; Tue,  4 Dec 2018 18:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543949778;
        bh=iFtxg6LhjYpm8Evo/ahI8Rptn8CtMFv3JwG6zzvPXHk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wlFopwh3m9VtTIjsbQ850FdexYr8m8osKTWxvMxNBVgBVEdtQZBa83brClWrPWftH
         njiXTqsfNBt8iK2kXRbze8fhaHbFLT/NddiA8lWArPEefXNrBJ84o7BG3yIa6oqzFa
         PJnVS/WVMCtwgBQ3ckR3ZHC3xFpHf8MTFfADQVC0=
Received: by mail-wm1-f41.google.com with SMTP id y139so10695217wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 10:56:17 -0800 (PST)
X-Gm-Message-State: AA+aEWZLkZaS05hGHy98rLu95pSeeLEMIs08lKIhvlUHUOOfBTWxP7ON
        Dq03zH/lKjKKkmCEYaedtBy+lfFvpBiIXXbXnj5iWA==
X-Google-Smtp-Source: AFSGD/U7ltAUEqFB4kL1WdgJ0lnl3xIw3hk+FWLdUr0eiqg57Clxl/ae69uFWmAZyKLHd1ql0HpeXLEr69T8HmR02/s=
X-Received: by 2002:a1c:aa0f:: with SMTP id t15mr2740811wme.108.1543949776480;
 Tue, 04 Dec 2018 10:56:16 -0800 (PST)
MIME-Version: 1.0
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
 <20181128000754.18056-2-rick.p.edgecombe@intel.com> <4883FED1-D0EC-41B0-A90F-1A697756D41D@gmail.com>
In-Reply-To: <4883FED1-D0EC-41B0-A90F-1A697756D41D@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 4 Dec 2018 10:56:03 -0800
X-Gmail-Original-Message-ID: <CALCETrXvddt148fncMJqpjK98uatiK-44knYFWU0-ytf8X+iog@mail.gmail.com>
Message-ID: <CALCETrXvddt148fncMJqpjK98uatiK-44knYFWU0-ytf8X+iog@mail.gmail.com>
Subject: Re: [PATCH 1/2] vmalloc: New flag for flush before releasing pages
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, jeyu@kernel.org,
        Network Development <netdev@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 5:43 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> > On Nov 27, 2018, at 4:07 PM, Rick Edgecombe <rick.p.edgecombe@intel.com=
> wrote:
> >
> > Since vfree will lazily flush the TLB, but not lazily free the underlyi=
ng pages,
> > it often leaves stale TLB entries to freed pages that could get re-used=
. This is
> > undesirable for cases where the memory being freed has special permissi=
ons such
> > as executable.
>
> So I am trying to finish my patch-set for preventing transient W+X mappin=
gs
> from taking space, by handling kprobes & ftrace that I missed (thanks aga=
in for
> pointing it out).
>
> But all of the sudden, I don=E2=80=99t understand why we have the problem=
 that this
> (your) patch-set deals with at all. We already change the mappings to mak=
e
> the memory writable before freeing the memory, so why can=E2=80=99t we ma=
ke it
> non-executable at the same time? Actually, why do we make the module memo=
ry,
> including its data executable before freeing it???
>

All the code you're looking at is IMO a very awkward and possibly
incorrect of doing what's actually necessary: putting the direct map
the way it wants to be.

Can't we shove this entirely mess into vunmap?  Have a flag (as part
of vmalloc like in Rick's patch or as a flag passed to a vfree variant
directly) that makes the vunmap code that frees the underlying pages
also reset their permissions?

Right now, we muck with set_memory_rw() and set_memory_nx(), which
both have very awkward (and inconsistent with each other!) semantics
when called on vmalloc memory.  And they have their own flushes, which
is inefficient.  Maybe the right solution is for vunmap to remove the
vmap area PTEs, call into a function like set_memory_rw() that resets
the direct maps to their default permissions *without* flushing, and
then to do a single flush for everything.  Or, even better, to cause
the change_page_attr code to do the flush and also to flush the vmap
area all at once so that very small free operations can flush single
pages instead of flushing globally.
