Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB3CC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A69920672
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:02:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A69920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbeLDQCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:02:45 -0500
Received: from foss.arm.com ([217.140.101.70]:35814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbeLDQCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:02:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 614C5A78;
        Tue,  4 Dec 2018 08:02:44 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2FD2C3F614;
        Tue,  4 Dec 2018 08:02:44 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 8C35D1AE0BA0; Tue,  4 Dec 2018 16:03:04 +0000 (GMT)
Date:   Tue, 4 Dec 2018 16:03:04 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        naveen.n.rao@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, jeyu@kernel.org,
        netdev@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>, kristen@linux.intel.com,
        Dave Hansen <dave.hansen@intel.com>, deneen.t.dock@intel.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] vmalloc: New flag for flush before releasing pages
Message-ID: <20181204160304.GB7195@arm.com>
References: <20181128000754.18056-1-rick.p.edgecombe@intel.com>
 <20181128000754.18056-2-rick.p.edgecombe@intel.com>
 <4883FED1-D0EC-41B0-A90F-1A697756D41D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4883FED1-D0EC-41B0-A90F-1A697756D41D@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 05:43:11PM -0800, Nadav Amit wrote:
> > On Nov 27, 2018, at 4:07 PM, Rick Edgecombe <rick.p.edgecombe@intel.com> wrote:
> > 
> > Since vfree will lazily flush the TLB, but not lazily free the underlying pages,
> > it often leaves stale TLB entries to freed pages that could get re-used. This is
> > undesirable for cases where the memory being freed has special permissions such
> > as executable.
> 
> So I am trying to finish my patch-set for preventing transient W+X mappings
> from taking space, by handling kprobes & ftrace that I missed (thanks again for
> pointing it out).
> 
> But all of the sudden, I don’t understand why we have the problem that this
> (your) patch-set deals with at all. We already change the mappings to make
> the memory writable before freeing the memory, so why can’t we make it
> non-executable at the same time? Actually, why do we make the module memory,
> including its data executable before freeing it???

Yeah, this is really confusing, but I have a suspicion it's a combination
of the various different configurations and hysterical raisins. We can't
rely on module_alloc() allocating from the vmalloc area (see nios2) nor
can we rely on disable_ro_nx() being available at build time.

If we *could* rely on module allocations always using vmalloc(), then
we could pass in Rick's new flag and drop disable_ro_nx() altogether
afaict -- who cares about the memory attributes of a mapping that's about
to disappear anyway?

Is it just nios2 that does something different?

Will
