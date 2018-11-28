Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3111C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD68C205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD68C205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeK1Vot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:44:49 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:59334 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbeK1Vot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:44:49 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gRxJX-0003IA-IZ; Wed, 28 Nov 2018 11:43:27 +0100
Date:   Wed, 28 Nov 2018 11:43:26 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Jiri Kosina <jikos@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
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
Subject: Re: [patch 20/24] x86/speculation: Split out TIF update
In-Reply-To: <1086cc39-ba33-d6ea-e3d8-b30f694472e7@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1811281142290.1875@nanos.tec.linutronix.de>
References: <20181121201430.559770965@linutronix.de> <20181121201724.227260385@linutronix.de> <f976eb35-5dcd-387e-eb29-f7c6636fd17b@linux.intel.com> <alpine.DEB.2.21.1811222352340.1665@nanos.tec.linutronix.de> <20181123073735.GA12959@gmail.com>
 <c51dd20a-2cea-1bd1-bee7-48ca25f9bdb9@linux.intel.com> <alpine.DEB.2.21.1811262244510.1682@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1811270800090.21108@cbobk.fhfr.pm> <alpine.DEB.2.21.1811270809450.1682@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1811270820050.21108@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1811271350590.21108@cbobk.fhfr.pm> <alpine.DEB.2.21.1811272247140.1875@nanos.tec.linutronix.de> <nycvar.YFH.7.76.1811272302070.21108@cbobk.fhfr.pm> <alpine.DEB.2.21.1811272331240.1875@nanos.tec.linutronix.de>
 <1086cc39-ba33-d6ea-e3d8-b30f694472e7@linux.intel.com>
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

On Tue, 27 Nov 2018, Tim Chen wrote:
> On 11/27/2018 02:36 PM, Thomas Gleixner wrote:
> >> We need this special handling only if the next task has TIF_SPEC_UPDATE 
> >> set, which is one-off event globally (when seccomp marks all its threads 
> >> so due to seccomp filter change), and once all the TIF_SPEC_UPDATE tasks 
> >> schedule at least once, we're in a consistent state again and don't need 
> >> this, as every running task will then have its TIF consistent with MSR 
> >> value.
> > 
> > And how so? You set the bits is spec_flags. And then you set the TIF_UPDATE
> > bit which is evaluated once.
> > 
> > Then you OR the bits into tifp which is a local variable and has nothing to
> > do with the TIF flags of the next task. So on the next context switch this
> > will evaluate the previous state of the TIF bits and you could have spared
> > the whole exercise :)
> > 
> 
> This is better than my original implementation which was racy.
> Using task_spec_ssb_disable and task_spec_ib_disable to update TIF_* flags
> at context switch time makes the update logic very clear
> and extensible.

Clear yes. Extensible - hopefully not. This needs to end.

Thanks,

	tglx
