Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A4BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CE620869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69CE620869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeICTjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:39:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55275 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICTjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:39:18 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fwqcd-00025Z-M4; Mon, 03 Sep 2018 17:18:35 +0200
Date:   Mon, 3 Sep 2018 17:18:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Jiri Kosina <jikos@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v2 3/3] x86/speculation: Enable cross-hyperthread spectre
 v2 STIBP mitigation
In-Reply-To: <20180903143656.GD24142@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1809031716090.1383@nanos.tec.linutronix.de>
References: <nycvar.YFH.7.76.1809031444160.25787@cbobk.fhfr.pm> <20180903143444.GW24124@hirez.programming.kicks-ass.net> <20180903143656.GD24142@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Sep 2018, Peter Zijlstra wrote:
> On Mon, Sep 03, 2018 at 04:34:44PM +0200, Peter Zijlstra wrote:
> > On Mon, Sep 03, 2018 at 02:45:31PM +0200, Jiri Kosina wrote:
> > 
> > > +static bool __init stibp_needed(void)
> > > +{
> > > +	return (cpu_smt_control != CPU_SMT_NOT_SUPPORTED &&
> > > +			boot_cpu_has(X86_FEATURE_STIBP));
> > > +}
> > 
> > Should that not be:
> > 
> > 	((cpu_smt_control != CPU_SMT_NOT_SUPPORTED) ||
> 
> s/||/&&/
> 
> > 	 (cpu_smt_control != CPU_SMT_FORCE_DISABLED)) &&
> > 	boot_cpu_has(X86_FEATURE_STIBP);
> > 
> > instead?

At least. Ideally we update it when SMT control is switched. There is no
point to have it enabled when SMT is set to DISABLED, but then we need to
set it when enabled again. With the minimal logic above its speculatively
enabled even when not required.

Thanks,

	tglx

