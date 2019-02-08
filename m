Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29496C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08C72081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfBHJ6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:58:17 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43226 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfBHJ6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:58:17 -0500
Received: from p5492e0d8.dip0.t-ipconnect.de ([84.146.224.216] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gs2v0-0006To-Lj; Fri, 08 Feb 2019 10:57:58 +0100
Date:   Fri, 8 Feb 2019 10:57:57 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
cc:     Dmitry Safonov <dima@arista.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 16/32] x86/vdso: Generate vdso{,32}-timens.lds
In-Reply-To: <a2bbe610-7553-0ba6-b58b-1013e034b8f6@rasmusvillemoes.dk>
Message-ID: <alpine.DEB.2.21.1902081051410.1645@nanos.tec.linutronix.de>
References: <20190206001107.16488-1-dima@arista.com> <20190206001107.16488-17-dima@arista.com> <a2bbe610-7553-0ba6-b58b-1013e034b8f6@rasmusvillemoes.dk>
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

On Thu, 7 Feb 2019, Rasmus Villemoes wrote:

Cc: + Vincenzo, Will

> On 06/02/2019 01.10, Dmitry Safonov wrote:
> > As it has been discussed on timens RFC, adding a new conditional branch
> > `if (inside_time_ns)` on VDSO for all processes is undesirable.
> > It will add a penalty for everybody as branch predictor may mispredict
> > the jump. Also there are instruction cache lines wasted on cmp/jmp.
> > 
> > Those effects of introducing time namespace are very much unwanted
> > having in mind how much work have been spent on micro-optimisation
> > vdso code.
> > 
> > Addressing those problems, there are two versions of VDSO's .so:
> > for host tasks (without any penalty) and for processes inside of time
> > namespace with clk_to_ns() that subtracts offsets from host's time.
> > 
> > Unfortunately, to allow changing VDSO VMA on a running process,
> > the entry points to VDSO should have the same offsets (addresses).
> > That's needed as i.e. application that calls setns() may have already
> > resolved VDSO symbols in GOT/PLT.
> 
> These (14-19, if I'm reading them right) seems to add quite a lot of
> complexity and fragility to the build, and other architectures would
> probably have to add something similar to their vdso builds.

Yes and we really want to avoid that. The VDSO implementations are
pointlessly different accross the architectures and there is effort on the
way to consolidate them:

  https://lkml.kernel.org/r/20190115135539.24762-1-vincenzo.frascino@arm.com

I talked to Vincenzo earlier this week and he's working on a new version of
that. The timens stuff wants to go on top of the consolidation otherwise we
end up with another set of pointlessly different and differently broken
VDSO variants.

Thanks,

	tglx
