Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EA1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431C52145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431C52145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbeKUQsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 11:48:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:53292 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725939AbeKUQsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 11:48:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A6611AD02;
        Wed, 21 Nov 2018 06:14:58 +0000 (UTC)
Date:   Wed, 21 Nov 2018 07:14:56 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, thomas.lendacky@amd.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>, dave.hansen@intel.com,
        Casey Schaufler <casey.schaufler@intel.com>,
        "Mallick, Asit K" <asit.k.mallick@intel.com>,
        "Van De Ven, Arjan" <arjan@linux.intel.com>, jcm@redhat.com,
        longman9394@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        david.c.stewart@intel.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        stable@vger.kernel.org
Subject: Re: [Patch v6 14/16] x86/speculation: Use STIBP to restrict speculation
 on non-dumpable task
In-Reply-To: <CAHk-=wiRh4QVAHV086U02tDCJz9g8MYHegEHbxCZ6-Ap4ow5Lw@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.1811210700510.21108@cbobk.fhfr.pm>
References: <cover.1542757030.git.tim.c.chen@linux.intel.com> <6652faa67f8c4e90c737f9fd9c7e0e2d3cd51cca.1542757030.git.tim.c.chen@linux.intel.com> <CAHk-=wiRh4QVAHV086U02tDCJz9g8MYHegEHbxCZ6-Ap4ow5Lw@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018, Linus Torvalds wrote:

> > Implements arch_update_spec_restriction() for x86.  Use STIBP to
> > restrict speculative execution when running a task set to non-dumpable,
> > or clear the restriction if the task is set to dumpable.
> 
> I don't think this necessarily makes sense.
> 
> The new "auto" behavior is that we aim to restrict untrusted code (and
> the loader of such code uses prctrl to set that flag), then this whole
> "set STIBP for non-dumpable" makes little sense.
> 
> A non-dumpable app by definition is *more* trusted, not less trusted.

I understand your argument. I believe actually both ways of protection do 
make sense in some way (but it doesn't mean we should do it by default). 
Basically:

- process marks itself "I am loading untrusted code" via that prctl() in 
  order to avoid its untrusted code to be used as spectrev2 gadgets

- process marks itself "I am loading untrusted code" via that prctl() in
  order to have its all threads/subprocesses marked the same way, so that
  one thread can't influence speculative code flow of the other in order
  to read its memory (the "javascript in one browser tab reads secrets 
  from another tab")

- non-dumpable tasks have the branch predictor flushed when 
  context switching to them (IBPB) or when sibling is running untrusted 
  code (STIBP) in order not guarantee that its speculative code flow can
  never be influenced by previous / sibling process mistraining branch
  predictor for it, and therefore do not allow reading its secrets from 
  memory through gadgets that'd have to be in the process code itself

But I agree there are many reasons why this shouldn't be done by default 
if we accept 'prctl' as the default mode. Namely:

- the whole "proper gadgets need to be present in the process' .text" is 
  dubious by itself

- the unavoidable overhead it'd impose on network daemons that you can't 
  really get rid of

The distiled patchset that Thomas will be sending around today is not have 
the dumpability restriction in it.

Thanks,

-- 
Jiri Kosina
SUSE Labs

