Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DE9C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D914620883
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D914620883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbeILCQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:16:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42443 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbeILCQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:16:57 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fzq0M-00065g-FT; Tue, 11 Sep 2018 23:15:26 +0200
Date:   Tue, 11 Sep 2018 23:15:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Schaufler, Casey" <casey.schaufler@intel.com>
cc:     Jiri Kosina <jikos@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v5 1/2] x86/speculation: apply IBPB more strictly to
 avoid cross-process data leak
In-Reply-To: <99FC4B6EFCEFD44486C35F4C281DC6732144AF87@ORSMSX107.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.21.1809112302580.1427@nanos.tec.linutronix.de>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809101123020.15880@cbobk.fhfr.pm> <99FC4B6EFCEFD44486C35F4C281DC6732144ADF9@ORSMSX107.amr.corp.intel.com> <nycvar.YFH.7.76.1809102111410.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC6732144AEC9@ORSMSX107.amr.corp.intel.com> <nycvar.YFH.7.76.1809102132480.15880@cbobk.fhfr.pm> <99FC4B6EFCEFD44486C35F4C281DC6732144AF24@ORSMSX107.amr.corp.intel.com> <nycvar.YFH.7.76.1809102235010.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC6732144AF87@ORSMSX107.amr.corp.intel.com>
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

On Mon, 10 Sep 2018, Schaufler, Casey wrote:
> > -----Original Message-----
> > From: Jiri Kosina [mailto:jikos@kernel.org]
> > Sent: Monday, September 10, 2018 1:42 PM
> > To: Schaufler, Casey <casey.schaufler@intel.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>;
> > Peter Zijlstra <peterz@infradead.org>; Josh Poimboeuf
> > <jpoimboe@redhat.com>; Andrea Arcangeli <aarcange@redhat.com>;
> > Woodhouse, David <dwmw@amazon.co.uk>; Andi Kleen <ak@linux.intel.com>;
> > Tim Chen <tim.c.chen@linux.intel.com>; linux-kernel@vger.kernel.org;
> > x86@kernel.org

Casey, can you please spare us the completely redundant copy of the mail
header?

> Short of a patch to show the changes (which I wish I could do today, but
> really can't) what I want to see is:
>
> 	- Put ptrace back to using the security module interfaces.
> 	- Identify where this causes locking issues and work with the module
> 	  owners (a reasonable lot, all) to provide lock safe paths for the IBPB case.
> 
> Otherwise, I have to add a new LSM hook right after your ptrace call and
> duplicate a whole lot of what you've just turned off, plus creating lock
> safe code that duplicates what ptrace already does. While I would rather
> have the side-channel checks be separate from the ptrace checks I can't
> justify doing both.

I'm not yet convinced that making these decisions purely based on LSM is a
good idea. The LSM based decision can optionally replace the built in
default decision at runtime, but it cannot replace it because its simpler
for most people to install a new kernel than fiddling with LSM.

We want a halfways sane default solution for this ASAP and Jiri's patch is
straight forward providing one without preventing you from adding your
magic LSM stuff once you have time to work on it including all (locking)
problems it creates. Nice try to offload that to Jiri.

Thanks,

	tglx
