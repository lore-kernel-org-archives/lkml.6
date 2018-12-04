Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D207CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859302133F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzH3Ij0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 859302133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbeLDUKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:10:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:57466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbeLDUKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:10:05 -0500
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45E01214DA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Dec 2018 20:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543954203;
        bh=rHbnZG4MYjKT/ezKzLuM6i0ZWebai6pXr4qhMdGvoEA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lzH3Ij0k20L5VngphdWVlfN1ppK3uuKJjiq0kbIswYAiN49urw81aL0/nAEc1Aex9
         lrFDxLbzUYtM4Qxo48SALl6foXo4LLWAcSAVqN3G4WThcswqSjpC9UpiG6GIZZB4Fk
         0AErTsvykrEBuRj95n1I2F26b65RyxAyEIJGoq5Q=
Received: by mail-wr1-f42.google.com with SMTP id j10so17293737wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 12:10:03 -0800 (PST)
X-Gm-Message-State: AA+aEWZbbb6rhDB3GpYQlejMNuAiyF5PmdLtL9GTPxY+J3Iqt2A72Bjf
        Wgg7l3XUc/Q6gkZeFeo2cCO5CBknvx7nuRphv86VAw==
X-Google-Smtp-Source: AFSGD/UUsMsNs3NgBUcv8KIV0H2nSeTU0YoylSI48qNNxddMpoH9tWPXxph7k9drZD4NShzGRnRp+04tdSaF6lWsFaw=
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr18519605wro.77.1543954201627;
 Tue, 04 Dec 2018 12:10:01 -0800 (PST)
MIME-Version: 1.0
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
 <20181128000754.18056-2-rick.p.edgecombe@intel.com> <4883FED1-D0EC-41B0-A90F-1A697756D41D@gmail.com>
 <20181204160304.GB7195@arm.com> <51281e69a3722014f718a6840f43b2e6773eed90.camel@intel.com>
In-Reply-To: <51281e69a3722014f718a6840f43b2e6773eed90.camel@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 4 Dec 2018 12:09:49 -0800
X-Gmail-Original-Message-ID: <CALCETrUiEWkSjnruCbBSi8WsDm071YiU5WEqoPhZbjezS0CrFw@mail.gmail.com>
Message-ID: <CALCETrUiEWkSjnruCbBSi8WsDm071YiU5WEqoPhZbjezS0CrFw@mail.gmail.com>
Subject: Re: [PATCH 1/2] vmalloc: New flag for flush before releasing pages
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, jeyu@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux-MM <linux-mm@kvack.org>, Jann Horn <jannh@google.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 12:02 PM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Tue, 2018-12-04 at 16:03 +0000, Will Deacon wrote:
> > On Mon, Dec 03, 2018 at 05:43:11PM -0800, Nadav Amit wrote:
> > > > On Nov 27, 2018, at 4:07 PM, Rick Edgecombe <rick.p.edgecombe@intel=
.com>
> > > > wrote:
> > > >
> > > > Since vfree will lazily flush the TLB, but not lazily free the unde=
rlying
> > > > pages,
> > > > it often leaves stale TLB entries to freed pages that could get re-=
used.
> > > > This is
> > > > undesirable for cases where the memory being freed has special perm=
issions
> > > > such
> > > > as executable.
> > >
> > > So I am trying to finish my patch-set for preventing transient W+X ma=
ppings
> > > from taking space, by handling kprobes & ftrace that I missed (thanks=
 again
> > > for
> > > pointing it out).
> > >
> > > But all of the sudden, I don=E2=80=99t understand why we have the pro=
blem that this
> > > (your) patch-set deals with at all. We already change the mappings to=
 make
> > > the memory writable before freeing the memory, so why can=E2=80=99t w=
e make it
> > > non-executable at the same time? Actually, why do we make the module =
memory,
> > > including its data executable before freeing it???
> >
> > Yeah, this is really confusing, but I have a suspicion it's a combinati=
on
> > of the various different configurations and hysterical raisins. We can'=
t
> > rely on module_alloc() allocating from the vmalloc area (see nios2) nor
> > can we rely on disable_ro_nx() being available at build time.
> >
> > If we *could* rely on module allocations always using vmalloc(), then
> > we could pass in Rick's new flag and drop disable_ro_nx() altogether
> > afaict -- who cares about the memory attributes of a mapping that's abo=
ut
> > to disappear anyway?
> >
> > Is it just nios2 that does something different?
> >
> > Will
>
> Yea it is really intertwined. I think for x86, set_memory_nx everywhere w=
ould
> solve it as well, in fact that was what I first thought the solution shou=
ld be
> until this was suggested. It's interesting that from the other thread Mas=
ami
> Hiramatsu referenced, set_memory_nx was suggested last year and would hav=
e
> inadvertently blocked this on x86. But, on the other architectures I have=
 since
> learned it is a bit different.
>
> It looks like actually most arch's don't re-define set_memory_*, and so a=
ll of
> the frob_* functions are actually just noops. In which case allocating RW=
X is
> needed to make it work at all, because that is what the allocation is goi=
ng to
> stay at. So in these archs, set_memory_nx won't solve it because it will =
do
> nothing.
>
> On x86 I think you cannot get rid of disable_ro_nx fully because there is=
 the
> changing of the permissions on the directmap as well. You don't want some=
 other
> caller getting a page that was left RO when freed and then trying to writ=
e to
> it, if I understand this.
>

Exactly.

After slightly more thought, I suggest renaming VM_IMMEDIATE_UNMAP to
VM_MAY_ADJUST_PERMS or similar.  It would have the semantics you want,
but it would also call some arch hooks to put back the direct map
permissions before the flush.  Does that seem reasonable?  It would
need to be hooked up that implement set_memory_ro(), but that should
be quite easy.  If nothing else, it could fall back to set_memory_ro()
in the absence of a better implementation.
