Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B998C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AD42083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 22:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18AD42083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753765AbeFSWem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 18:34:42 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58472 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeFSWel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 18:34:41 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVPCq-0004k6-Jh; Wed, 20 Jun 2018 00:34:32 +0200
Date:   Wed, 20 Jun 2018 00:34:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH 7/8] x86/lib_user_wait.h: Add APIs for user wait
 instructions
In-Reply-To: <20180619222718.GD112652@romley-ivt3.sc.intel.com>
Message-ID: <alpine.DEB.2.21.1806200032430.10546@nanos.tec.linutronix.de>
References: <1529118375-90191-1-git-send-email-fenghua.yu@intel.com> <1529118375-90191-8-git-send-email-fenghua.yu@intel.com> <alpine.DEB.2.21.1806191109580.1692@nanos.tec.linutronix.de> <20180619222718.GD112652@romley-ivt3.sc.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2018, Fenghua Yu wrote:
> On Tue, Jun 19, 2018 at 11:12:05AM +0200, Thomas Gleixner wrote:
> > On Fri, 15 Jun 2018, Fenghua Yu wrote:
> > 
> > > A few new user wait instructions UMONITOR, UMWAIT, and TPAUSE are
> > > published in the latest Intel Instruction Set Extensions document.
> > > 
> > > Define the APIs for user or kernel to use the instructions.
> > 
> > You're not defining APIs. You're adding a pile of misdesigned helper
> > functions which again add static storage per compilation unit and CPUID
> > fiddling.
> > 
> > If you want to add proper APIs then add the stuff to the VDSO and be done
> > with it.
> 
> The user wait instructions are mainly called by user apps; but they can
> be used in kernel as well.
> 
> I'm planning to provide five APIs to user:
> 1. If user wait feature is supported
> 2. nsec to tsc translation
> 3. umonitor function that exectes UMONITOR instruction
> 4. umwait function that executes UMWAIT instruction
> 5. tpause function that executes TPAUSE instruction
> 
> Seems 1-2 can be implemented in VDSO. But should I implement 3-5 in
> VDSO/kernel as well?

If you want a real API, then yes. If not, then an UAPI header is definitely
not the place for this.

Thanks

	tglx
