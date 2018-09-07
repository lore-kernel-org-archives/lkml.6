Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA29C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077412077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077412077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeIGVWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:22:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726399AbeIGVWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:22:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4DFE881A8071;
        Fri,  7 Sep 2018 16:40:17 +0000 (UTC)
Received: from treble (ovpn-125-2.rdu2.redhat.com [10.10.125.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38B051006EDE;
        Fri,  7 Sep 2018 16:40:16 +0000 (UTC)
Date:   Fri, 7 Sep 2018 11:40:14 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/3] x86/pti/64: Remove the SYSCALL64 entry trampoline
Message-ID: <20180907164014.g6logz3piqptaj2s@treble>
References: <cover.1536015544.git.luto@kernel.org>
 <8c7c6e483612c3e4e10ca89495dc160b1aa66878.1536015544.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8c7c6e483612c3e4e10ca89495dc160b1aa66878.1536015544.git.luto@kernel.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 07 Sep 2018 16:40:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 07 Sep 2018 16:40:17 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 03:59:44PM -0700, Andy Lutomirski wrote:
> The SYSCALL64 trampoline has a couple of nice properties:
> 
>  - The usual sequence of SWAPGS followed by two GS-relative accesses to
>    set up RSP is somewhat slow because the GS-relative accesses need
>    to wait for SWAPGS to finish.  The trampoline approach allows
>    RIP-relative accesses to set up RSP, which avoids the stall.
> 
>  - The trampoline avoids any percpu access before CR3 is set up,
>    which means that no percpu memory needs to be mapped in the user
>    page tables.  This prevents using Meltdown to read any percpu memory
>    outside the cpu_entry_area and prevents using timing leaks
>    to directly locate the percpu areas.
> 
> The downsides of using a trampoline may outweigh the upsides, however.
> It adds an extra non-contiguous I$ cache line to system calls, and it
> forces an indirect jump to transfer control back to the normal kernel
> text after CR3 is set up.  The latter is because x86 lacks a 64-bit
> direct jump instruction that could jump from the trampoline to the entry
> text.  With retpolines enabled, the indirect jump is extremely slow.
> 
> This patch changes the code to map the percpu TSS into the user page
> tables to allow the non-trampoline SYSCALL64 path to work under PTI.
> This does not add a new direct information leak, since the TSS is
> readable by Meltdown from the cpu_entry_area alias regardless.  It
> does allow a timing attack to locate the percpu area, but KASLR is
> more or less a lost cause against local attack on CPUs vulnerable to
> Meltdown regardless.  As far as I'm concerned, on current hardware,
> KASLR is only useful to mitigate remote attacks that try to attack
> the kernel without first gaining RCE against a vulnerable user
> process.
> 
> On Skylake, with CONFIG_RETPOLINE=y and KPTI on, this reduces
> syscall overhead from ~237ns to ~228ns.
> 
> There is a possible alternative approach: we could instead move the
> trampoline within 2G of the entry text and make a separate copy for
> each CPU.  Then we could use a direct jump to rejoin the normal
> entry path.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

The following commit should also be reverted:

  4d99e4136580 ("perf machine: Workaround missing maps for x86 PTI entry trampolines")

-- 
Josh
