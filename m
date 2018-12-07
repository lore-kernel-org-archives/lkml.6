Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01286C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78F320837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78F320837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeLGTSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:18:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:8254 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbeLGTSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 14:18:49 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Dec 2018 11:18:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,327,1539673200"; 
   d="scan'208";a="107845816"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by fmsmga008.fm.intel.com with ESMTP; 07 Dec 2018 11:18:48 -0800
Date:   Fri, 7 Dec 2018 11:18:48 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dave.hansen@linux.intel.com, Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>, yu-cheng.yu@intel.com,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86/fault: Decode and print #PF oops in human readable
 form
Message-ID: <20181207191848.GD10404@linux.intel.com>
References: <CAHk-=whk_fsnxVMvF1T2fFCaP2WrvSybABrLQCWLJyCvHw6NKA@mail.gmail.com>
 <20181207184423.1962-1-sean.j.christopherson@intel.com>
 <CAHk-=whMhJ84SqnUa0qAV-xkP6ghictLv8RLxOrp8mXKfp5zqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whMhJ84SqnUa0qAV-xkP6ghictLv8RLxOrp8mXKfp5zqQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 10:52:49AM -0800, Linus Torvalds wrote:
> On Fri, Dec 7, 2018 at 10:44 AM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> >
> > Remove the per-bit decoding of the error code and instead print the raw
> > error code followed by a brief description of what caused the fault, the
> > effective privilege level of the faulting access, and whether the fault
> > originated in user code or kernel code.
> 
> This doesn't quite work as-is, though.
> 
> For example, at least the PK bit is independent of the other bits and
> would be interesting in the human-legible version, but doesn't show up
> there at all.

Heh, I actually intentionally omitted protection keys thinking it'd be
superfluous, i.e. "go look at the error code bits if you care that much".

> That said, I think the end result might be more legible than the
> previous version, so this approach may well be good, it just needs at
> least that "permissions violation"  part to be extended with whether
> it was PK or not.
> 
> Also, shouldn't we show the SGX bit too as some kind of "during SGX"
> extension on the "in user/kernel space" part?

The SGX bit isn't defined in mainline yet.  But yeah, I can see how
printing e.g. "SGX EPCM violation" would be a lot more helpful than
a vanilla "permissions violation".  I'll send a v2 with the PK bit
added and a slightly reworded changelog.
