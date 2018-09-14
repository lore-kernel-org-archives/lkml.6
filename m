Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C39ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0292B20881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0292B20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeINQT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 12:19:29 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47541 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeINQT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 12:19:29 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g0luR-0002ck-R2; Fri, 14 Sep 2018 13:05:11 +0200
Date:   Fri, 14 Sep 2018 13:05:10 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jiri Kosina <jikos@kernel.org>
cc:     "Schaufler, Casey" <casey.schaufler@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v6 1/3] x86/speculation: apply IBPB more strictly to
 avoid cross-process data leak
In-Reply-To: <nycvar.YFH.7.76.1809141259010.15880@cbobk.fhfr.pm>
Message-ID: <alpine.DEB.2.21.1809141304180.1473@nanos.tec.linutronix.de>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809121055070.15880@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809121105330.15880@cbobk.fhfr.pm> <99FC4B6EFCEFD44486C35F4C281DC6732144BFBC@ORSMSX107.amr.corp.intel.com>
 <nycvar.YFH.7.76.1809141259010.15880@cbobk.fhfr.pm>
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

On Fri, 14 Sep 2018, Jiri Kosina wrote:
> On Thu, 13 Sep 2018, Schaufler, Casey wrote:
> 
> > > -	return security_ptrace_access_check(task, mode);
> > > +	if (!(mode & PTRACE_MODE_NOACCESS_CHK))
> > > +		return security_ptrace_access_check(task, mode);
> > > +	return 0;
> > 
> > Because PTRACE_MODE_IBPB includes PTRACE_MODE_NOAUDIT you
> > shouldn't need this change. 
> 
> That is true, but that's not my concern here. 
> 
> 	security_ptrace_access_check() -> call_int_hook() -> P->hook.FUNC().
> 
> If it's somehow guaranteed that all functions called this ways are fine to 
> be called from scheduler context (wrt. locks), then it's all fine and I'll 
> happily drop that check.
> 
> Is it guaranteed?

The related question is whether it is guaranteed for backports. We don't
want to end up with a separate hell there.

Thanks,

	tglx
