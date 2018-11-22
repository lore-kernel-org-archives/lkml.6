Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D1FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA5C20685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA5C20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394406AbeKVV1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:27:22 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:47301 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732079AbeKVV1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:27:22 -0500
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPmWy-0003R4-Ed; Thu, 22 Nov 2018 11:48:20 +0100
Date:   Thu, 22 Nov 2018 11:48:14 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 15/24] x86/speculation: Add command line control for
 indirect branch speculation
In-Reply-To: <20181122101007.GB10365@zn.tnic>
Message-ID: <alpine.DEB.2.21.1811221145210.1531@nanos.tec.linutronix.de>
References: <20181121201430.559770965@linutronix.de> <20181121201723.764150349@linutronix.de> <20181121234312.GI27559@zn.tnic> <alpine.DEB.2.21.1811220048080.1665@nanos.tec.linutronix.de> <20181122091858.GJ2131@hirez.programming.kicks-ass.net>
 <20181122101007.GB10365@zn.tnic>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018, Borislav Petkov wrote:
> On Thu, Nov 22, 2018 at 10:18:58AM +0100, Peter Zijlstra wrote:
> > Right; that retpoline + IBPB case is one that came up earlier when we
> > talked about this stuff. The IBPB also helps against app2app BTB ASLR
> > attacks. So even if you have userspace retpoline, you might still want
> > IBPB.
> > 
> > But yes, this should be relatively straight forward to allow/fix with
> > the proposed code.
> 
> So I got some feedback from AMD that IBPB on context switch has a
> small perf impact and they wouldn't mind it being enabled by default
> considering that it provides protection against a lot of attack
> scenarios. Basically, what the recommendation says.
> 
> But if we go and do opt-in, then they're fine with it being off by
> default if we decide to do it so in the kernel.

So one way to do this would be to have additional options:

   prctl,ibpb and seccomp,ibpb

which then would keep the STIBP stuff as proposed and switch ibpb to always
mode. Adding the back to back optimization for the always ibpb mode is not
rocket science.

Thanks,

	tglx
