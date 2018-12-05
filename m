Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDB4C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E1D20851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E1D20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeLELl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 06:41:29 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52734 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbeLELl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 06:41:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1A44A78;
        Wed,  5 Dec 2018 03:41:28 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 800083F575;
        Wed,  5 Dec 2018 03:41:28 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 361BC1AE0BAE; Wed,  5 Dec 2018 11:41:49 +0000 (GMT)
Date:   Wed, 5 Dec 2018 11:41:49 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
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
Subject: Re: [PATCH 1/2] vmalloc: New flag for flush before releasing pages
Message-ID: <20181205114148.GA15160@arm.com>
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
 <20181128000754.18056-2-rick.p.edgecombe@intel.com>
 <4883FED1-D0EC-41B0-A90F-1A697756D41D@gmail.com>
 <20181204160304.GB7195@arm.com>
 <51281e69a3722014f718a6840f43b2e6773eed90.camel@intel.com>
 <CALCETrUiEWkSjnruCbBSi8WsDm071YiU5WEqoPhZbjezS0CrFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrUiEWkSjnruCbBSi8WsDm071YiU5WEqoPhZbjezS0CrFw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 12:09:49PM -0800, Andy Lutomirski wrote:
> On Tue, Dec 4, 2018 at 12:02 PM Edgecombe, Rick P
> <rick.p.edgecombe@intel.com> wrote:
> >
> > On Tue, 2018-12-04 at 16:03 +0000, Will Deacon wrote:
> > > On Mon, Dec 03, 2018 at 05:43:11PM -0800, Nadav Amit wrote:
> > > > > On Nov 27, 2018, at 4:07 PM, Rick Edgecombe <rick.p.edgecombe@intel.com>
> > > > > wrote:
> > > > >
> > > > > Since vfree will lazily flush the TLB, but not lazily free the underlying
> > > > > pages,
> > > > > it often leaves stale TLB entries to freed pages that could get re-used.
> > > > > This is
> > > > > undesirable for cases where the memory being freed has special permissions
> > > > > such
> > > > > as executable.
> > > >
> > > > So I am trying to finish my patch-set for preventing transient W+X mappings
> > > > from taking space, by handling kprobes & ftrace that I missed (thanks again
> > > > for
> > > > pointing it out).
> > > >
> > > > But all of the sudden, I don’t understand why we have the problem that this
> > > > (your) patch-set deals with at all. We already change the mappings to make
> > > > the memory writable before freeing the memory, so why can’t we make it
> > > > non-executable at the same time? Actually, why do we make the module memory,
> > > > including its data executable before freeing it???
> > >
> > > Yeah, this is really confusing, but I have a suspicion it's a combination
> > > of the various different configurations and hysterical raisins. We can't
> > > rely on module_alloc() allocating from the vmalloc area (see nios2) nor
> > > can we rely on disable_ro_nx() being available at build time.
> > >
> > > If we *could* rely on module allocations always using vmalloc(), then
> > > we could pass in Rick's new flag and drop disable_ro_nx() altogether
> > > afaict -- who cares about the memory attributes of a mapping that's about
> > > to disappear anyway?
> > >
> > > Is it just nios2 that does something different?
> > >
> > Yea it is really intertwined. I think for x86, set_memory_nx everywhere would
> > solve it as well, in fact that was what I first thought the solution should be
> > until this was suggested. It's interesting that from the other thread Masami
> > Hiramatsu referenced, set_memory_nx was suggested last year and would have
> > inadvertently blocked this on x86. But, on the other architectures I have since
> > learned it is a bit different.
> >
> > It looks like actually most arch's don't re-define set_memory_*, and so all of
> > the frob_* functions are actually just noops. In which case allocating RWX is
> > needed to make it work at all, because that is what the allocation is going to
> > stay at. So in these archs, set_memory_nx won't solve it because it will do
> > nothing.
> >
> > On x86 I think you cannot get rid of disable_ro_nx fully because there is the
> > changing of the permissions on the directmap as well. You don't want some other
> > caller getting a page that was left RO when freed and then trying to write to
> > it, if I understand this.
> >
> 
> Exactly.

Of course, I forgot about the linear mapping. On arm64, we've just queued
support for reflecting changes to read-only permissions in the linear map
[1]. So, whilst the linear map is always non-executable, we will need to
make parts of it writable again when freeing the module.

> After slightly more thought, I suggest renaming VM_IMMEDIATE_UNMAP to
> VM_MAY_ADJUST_PERMS or similar.  It would have the semantics you want,
> but it would also call some arch hooks to put back the direct map
> permissions before the flush.  Does that seem reasonable?  It would
> need to be hooked up that implement set_memory_ro(), but that should
> be quite easy.  If nothing else, it could fall back to set_memory_ro()
> in the absence of a better implementation.

You mean set_memory_rw() here, right? Although, eliding the TLB invalidation
would open up a window where the vmap mapping is executable and the linear
mapping is writable, which is a bit rubbish.

Will

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/core&id=c55191e96caa9d787e8f682c5e525b7f8172a3b4
