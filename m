Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4460C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1524217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 22:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfACWVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 17:21:39 -0500
Received: from mga02.intel.com ([134.134.136.20]:54250 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727196AbfACWVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 17:21:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 14:21:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,436,1539673200"; 
   d="scan'208";a="123132905"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jan 2019 14:21:37 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id A0D8D301B2E; Thu,  3 Jan 2019 14:21:37 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>, X86 ML <x86@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [RFC v2 1/6] x86: introduce kernel restartable sequence
References: <20181231072112.21051-1-namit@vmware.com>
        <20181231072112.21051-2-namit@vmware.com>
Date:   Thu, 03 Jan 2019 14:21:37 -0800
In-Reply-To: <20181231072112.21051-2-namit@vmware.com> (Nadav Amit's message
        of "Sun, 30 Dec 2018 23:21:07 -0800")
Message-ID: <87va35e61a.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nadav Amit <namit@vmware.com> writes:

I see another poor man's attempt to reinvent TSX.

> It is sometimes beneficial to have a restartable sequence - very few
> instructions which if they are preempted jump to a predefined point.
>
> To provide such functionality on x86-64, we use an empty REX-prefix
> (opcode 0x40) as an indication for instruction in such a sequence. Before
> calling the schedule IRQ routine, if the "magic" prefix is found, we
> call a routine to adjust the instruction pointer.  It is expected that
> this opcode is not in common use.

You cannot just assume something like that. x86 is a constantly
evolving architecture. The prefix might well have meaning at
some point.

Before doing something like that you would need to ask the CPU
vendors to reserve the sequence you're using for software use.

You're doing the equivalent of patching a private system call
into your own kernel without working with upstream, don't do that.

Better to find some other solution to do the restart.
How about simply using a per cpu variable? That should be cheaper
anyways.

-Andi
