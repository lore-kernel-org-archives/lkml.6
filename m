Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C64C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A97A20989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544051810;
	bh=LQNeZgdotgA5zUyaVs+F8s8TonzSnfRs9CCRmMkMy88=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=B1+obsoNdTJxtZxpApLNojg47wJkyTLbsa1k/YUG4E4+RanSZlzTC5JKLSp9JemKY
	 WijI5phq/ac1+OeX4bMYBsVZ87INyP7weJrRuTQ3d7/XZNxJDRbgktEVfcO2GAMQPk
	 B7hnm1LRtb5JaiGIH0Gn+LM5ld7g82Ii/rmS6eBE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A97A20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbeLEXQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:16:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:49762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727645AbeLEXQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:16:48 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD2E0214DA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Dec 2018 23:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544051807;
        bh=LQNeZgdotgA5zUyaVs+F8s8TonzSnfRs9CCRmMkMy88=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p8d8iJ1YA7VXQOHfehykZUHGh0R6N5l6dYBW0Q774J8ulVQLmHk/NezPhAuYY111x
         qAwrK31FF6+LmwXjY9rpcpX6aOACXcZR5sORDHrtfwkbUjydLW/3nEYXrke3QmVbk6
         tw9nXoQGGrA5fzjkQ/Os5/EXwqFlHc+Fh9J8nypU=
Received: by mail-wm1-f52.google.com with SMTP id y185so12832198wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:16:46 -0800 (PST)
X-Gm-Message-State: AA+aEWZr7Czuf50RBylNt+0rWwDupTA6GrA4CvPRUSIe0u3KOOF3S0ER
        OZBZfVM2+zuln8lGYAx7UkLzxUqpPjAz8A7y0FChsw==
X-Google-Smtp-Source: AFSGD/Vq7p5EZlOQjfWxf/hzOiBixKOltbzsLuF/4tasE9w6K5eVW6BNkaML+bH3ZJ9wMbM9048y+qevnYquzVGJrw4=
X-Received: by 2002:a1c:aa0f:: with SMTP id t15mr6727166wme.108.1544051805174;
 Wed, 05 Dec 2018 15:16:45 -0800 (PST)
MIME-Version: 1.0
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
 <20181128000754.18056-2-rick.p.edgecombe@intel.com> <4883FED1-D0EC-41B0-A90F-1A697756D41D@gmail.com>
 <20181204160304.GB7195@arm.com> <51281e69a3722014f718a6840f43b2e6773eed90.camel@intel.com>
 <CALCETrUiEWkSjnruCbBSi8WsDm071YiU5WEqoPhZbjezS0CrFw@mail.gmail.com> <20181205114148.GA15160@arm.com>
In-Reply-To: <20181205114148.GA15160@arm.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 5 Dec 2018 15:16:33 -0800
X-Gmail-Original-Message-ID: <CALCETrUdTShjY+tQoRsE1uR1cnL9cr2Trbz-g5=WaLGA3rWXzA@mail.gmail.com>
Message-ID: <CALCETrUdTShjY+tQoRsE1uR1cnL9cr2Trbz-g5=WaLGA3rWXzA@mail.gmail.com>
Subject: Re: [PATCH 1/2] vmalloc: New flag for flush before releasing pages
To:     Will Deacon <will.deacon@arm.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
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

On Wed, Dec 5, 2018 at 3:41 AM Will Deacon <will.deacon@arm.com> wrote:
>
> On Tue, Dec 04, 2018 at 12:09:49PM -0800, Andy Lutomirski wrote:
> > On Tue, Dec 4, 2018 at 12:02 PM Edgecombe, Rick P
> > <rick.p.edgecombe@intel.com> wrote:
> > >
> > > On Tue, 2018-12-04 at 16:03 +0000, Will Deacon wrote:
> > > > On Mon, Dec 03, 2018 at 05:43:11PM -0800, Nadav Amit wrote:
> > > > > > On Nov 27, 2018, at 4:07 PM, Rick Edgecombe <rick.p.edgecombe@i=
ntel.com>
> > > > > > wrote:
> > > > > >
> > > > > > Since vfree will lazily flush the TLB, but not lazily free the =
underlying
> > > > > > pages,
> > > > > > it often leaves stale TLB entries to freed pages that could get=
 re-used.
> > > > > > This is
> > > > > > undesirable for cases where the memory being freed has special =
permissions
> > > > > > such
> > > > > > as executable.
> > > > >
> > > > > So I am trying to finish my patch-set for preventing transient W+=
X mappings
> > > > > from taking space, by handling kprobes & ftrace that I missed (th=
anks again
> > > > > for
> > > > > pointing it out).
> > > > >
> > > > > But all of the sudden, I don=E2=80=99t understand why we have the=
 problem that this
> > > > > (your) patch-set deals with at all. We already change the mapping=
s to make
> > > > > the memory writable before freeing the memory, so why can=E2=80=
=99t we make it
> > > > > non-executable at the same time? Actually, why do we make the mod=
ule memory,
> > > > > including its data executable before freeing it???
> > > >
> > > > Yeah, this is really confusing, but I have a suspicion it's a combi=
nation
> > > > of the various different configurations and hysterical raisins. We =
can't
> > > > rely on module_alloc() allocating from the vmalloc area (see nios2)=
 nor
> > > > can we rely on disable_ro_nx() being available at build time.
> > > >
> > > > If we *could* rely on module allocations always using vmalloc(), th=
en
> > > > we could pass in Rick's new flag and drop disable_ro_nx() altogethe=
r
> > > > afaict -- who cares about the memory attributes of a mapping that's=
 about
> > > > to disappear anyway?
> > > >
> > > > Is it just nios2 that does something different?
> > > >
> > > Yea it is really intertwined. I think for x86, set_memory_nx everywhe=
re would
> > > solve it as well, in fact that was what I first thought the solution =
should be
> > > until this was suggested. It's interesting that from the other thread=
 Masami
> > > Hiramatsu referenced, set_memory_nx was suggested last year and would=
 have
> > > inadvertently blocked this on x86. But, on the other architectures I =
have since
> > > learned it is a bit different.
> > >
> > > It looks like actually most arch's don't re-define set_memory_*, and =
so all of
> > > the frob_* functions are actually just noops. In which case allocatin=
g RWX is
> > > needed to make it work at all, because that is what the allocation is=
 going to
> > > stay at. So in these archs, set_memory_nx won't solve it because it w=
ill do
> > > nothing.
> > >
> > > On x86 I think you cannot get rid of disable_ro_nx fully because ther=
e is the
> > > changing of the permissions on the directmap as well. You don't want =
some other
> > > caller getting a page that was left RO when freed and then trying to =
write to
> > > it, if I understand this.
> > >
> >
> > Exactly.
>
> Of course, I forgot about the linear mapping. On arm64, we've just queued
> support for reflecting changes to read-only permissions in the linear map
> [1]. So, whilst the linear map is always non-executable, we will need to
> make parts of it writable again when freeing the module.
>
> > After slightly more thought, I suggest renaming VM_IMMEDIATE_UNMAP to
> > VM_MAY_ADJUST_PERMS or similar.  It would have the semantics you want,
> > but it would also call some arch hooks to put back the direct map
> > permissions before the flush.  Does that seem reasonable?  It would
> > need to be hooked up that implement set_memory_ro(), but that should
> > be quite easy.  If nothing else, it could fall back to set_memory_ro()
> > in the absence of a better implementation.
>
> You mean set_memory_rw() here, right? Although, eliding the TLB invalidat=
ion
> would open up a window where the vmap mapping is executable and the linea=
r
> mapping is writable, which is a bit rubbish.
>

Right, and Rick pointed out the same issue.  Instead, we should set
the direct map not-present or its ARM equivalent, then do the flush,
then make it RW.  I assume this also works on arm and arm64, although
I don't know for sure.  On x86, the CPU won't cache not-present PTEs.
