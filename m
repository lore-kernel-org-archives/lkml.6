Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013D3C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5F92184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfACWsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 17:48:36 -0500
Received: from mga11.intel.com ([192.55.52.93]:37535 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbfACWsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 17:48:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 14:48:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,436,1539673200"; 
   d="scan'208";a="132770756"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jan 2019 14:48:35 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 7E422301B2E; Thu,  3 Jan 2019 14:48:35 -0800 (PST)
Date:   Thu, 3 Jan 2019 14:48:35 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [RFC v2 1/6] x86: introduce kernel restartable sequence
Message-ID: <20190103224835.GG6118@tassilo.jf.intel.com>
References: <20181231072112.21051-1-namit@vmware.com>
 <20181231072112.21051-2-namit@vmware.com>
 <87va35e61a.fsf@linux.intel.com>
 <263A441C-F062-491F-9E95-F00FA2092A99@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <263A441C-F062-491F-9E95-F00FA2092A99@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok… I’ll try to think about another solution. Just note that this is just
> used as a hint to avoid unnecessary lookups. (IOW, nothing will break if the
> prefix is used.)

Are you sure actually? 

The empty prefix could mean 8bit register accesses.

> > You're doing the equivalent of patching a private system call
> > into your own kernel without working with upstream, don't do that.
> 
> I don’t understand this comment though. Can you please explain?

Instruction encoding = system call ABI
Upstream = CPU vendors

Early in Linux's history, naive Linux distribution vendors patched in their own
private system calls without waiting for upstream to define an ABI, which caused
endless compatibility problems. These days this is very frowned upon.

> > Better to find some other solution to do the restart.
> > How about simply using a per cpu variable? That should be cheaper
> > anyways.
> 
> The problem is that the per-cpu variable needs to be updated after the call
> is executed, when we are already not in the context of the “injected” code.
> I can increase it before the call, and decrease it after return - but this
> can create (in theory) long periods in which the code is “unpatchable”,
> increase the code size and slow performance.
> 
> Anyhow, I’ll give more thought. Ideas are welcomed.

Write the address of the instruction into the per cpu variable.

-Andi

