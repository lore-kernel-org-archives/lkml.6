Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31694C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E7C20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDToMaQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E7C20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbeLDTs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:48:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:47130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbeLDTs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:48:57 -0500
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1103621508
        for <linux-kernel@vger.kernel.org>; Tue,  4 Dec 2018 19:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543952936;
        bh=PeO+d1oBQMLfzUD3OnXaXh0N8zLO9SpxmzAqjkvc6eQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fDToMaQduDiwYN/ACVbfyapeTtRZGS9Fv88T0QN5xOCIf9ihSQnVPp//dAaPU9xsE
         MdiEWxy276rGRAc+Xl5F1PG8oDuin4g+w3oQSJ7+DQ0xUMkej7AHxmtsHnrK2apXBN
         CFhjiQlMdLh30JkEcIMFcw3TXyBIBTUkgw5DQnkE=
Received: by mail-wm1-f46.google.com with SMTP id c126so10562562wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:48:55 -0800 (PST)
X-Gm-Message-State: AA+aEWY1+n1T6UmEzE4H1jZQpMfJyW8WlPXUGsJtwMXlBDWqJLRmY3HY
        IYiSkSs4/5u4lKlZKsjK7U59humsGm+xU7psJPpaCQ==
X-Google-Smtp-Source: AFSGD/W6Bp2wI/cgAwAdLuhct4fIzA7bb/KpkZ/BAvmJqAjbuDlrmit5R7BAkbBfAPr1T38gwbbQ5ADp7a4e5IhB+Cc=
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr14124009wmf.32.1543952934435;
 Tue, 04 Dec 2018 11:48:54 -0800 (PST)
MIME-Version: 1.0
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
 <20181128000754.18056-2-rick.p.edgecombe@intel.com> <4883FED1-D0EC-41B0-A90F-1A697756D41D@gmail.com>
 <CALCETrXvddt148fncMJqpjK98uatiK-44knYFWU0-ytf8X+iog@mail.gmail.com> <08141F66-F3E6-4CC5-AF91-1ED5F101A54C@gmail.com>
In-Reply-To: <08141F66-F3E6-4CC5-AF91-1ED5F101A54C@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 4 Dec 2018 11:48:42 -0800
X-Gmail-Original-Message-ID: <CALCETrXLrsKDBzDkN7sc9HYPWe9aV3NQzf4vMvM+FD8j6aA6AQ@mail.gmail.com>
Message-ID: <CALCETrXLrsKDBzDkN7sc9HYPWe9aV3NQzf4vMvM+FD8j6aA6AQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vmalloc: New flag for flush before releasing pages
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Tue, Dec 4, 2018 at 11:45 AM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> > On Dec 4, 2018, at 10:56 AM, Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Mon, Dec 3, 2018 at 5:43 PM Nadav Amit <nadav.amit@gmail.com> wrote:
> >>> On Nov 27, 2018, at 4:07 PM, Rick Edgecombe <rick.p.edgecombe@intel.c=
om> wrote:
> >>>
> >>> Since vfree will lazily flush the TLB, but not lazily free the underl=
ying pages,
> >>> it often leaves stale TLB entries to freed pages that could get re-us=
ed. This is
> >>> undesirable for cases where the memory being freed has special permis=
sions such
> >>> as executable.
> >>
> >> So I am trying to finish my patch-set for preventing transient W+X map=
pings
> >> from taking space, by handling kprobes & ftrace that I missed (thanks =
again for
> >> pointing it out).
> >>
> >> But all of the sudden, I don=E2=80=99t understand why we have the prob=
lem that this
> >> (your) patch-set deals with at all. We already change the mappings to =
make
> >> the memory writable before freeing the memory, so why can=E2=80=99t we=
 make it
> >> non-executable at the same time? Actually, why do we make the module m=
emory,
> >> including its data executable before freeing it???
> >
> > All the code you're looking at is IMO a very awkward and possibly
> > incorrect of doing what's actually necessary: putting the direct map
> > the way it wants to be.
> >
> > Can't we shove this entirely mess into vunmap?  Have a flag (as part
> > of vmalloc like in Rick's patch or as a flag passed to a vfree variant
> > directly) that makes the vunmap code that frees the underlying pages
> > also reset their permissions?
> >
> > Right now, we muck with set_memory_rw() and set_memory_nx(), which
> > both have very awkward (and inconsistent with each other!) semantics
> > when called on vmalloc memory.  And they have their own flushes, which
> > is inefficient.  Maybe the right solution is for vunmap to remove the
> > vmap area PTEs, call into a function like set_memory_rw() that resets
> > the direct maps to their default permissions *without* flushing, and
> > then to do a single flush for everything.  Or, even better, to cause
> > the change_page_attr code to do the flush and also to flush the vmap
> > area all at once so that very small free operations can flush single
> > pages instead of flushing globally.
>
> Thanks for the explanation. I read it just after I realized that indeed t=
he
> whole purpose of this code is to get cpa_process_alias()
> update the corresponding direct mapping.
>
> This thing (pageattr.c) indeed seems over-engineered and very unintuitive=
.
> Right now I have a list of patch-sets that I owe, so I don=E2=80=99t have=
 the time
> to deal with it.
>
> But, I still think that disable_ro_nx() should not call set_memory_x().
> IIUC, this breaks W+X of the direct-mapping which correspond with the mod=
ule
> memory. Does it ever stop being W+X?? I=E2=80=99ll have another look.
>

Dunno.  I did once chase down a bug where some memory got freed while
it was still read-only, and the results were hilarious and hard to
debug, since the explosion happened long after the buggy code
finished.

--Andy
