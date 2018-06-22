Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37D0C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7994324983
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7994324983
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933996AbeFVWrX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:47:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42947 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754759AbeFVWrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:47:21 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWUpl-0004uq-1N; Sat, 23 Jun 2018 00:47:13 +0200
Date:   Sat, 23 Jun 2018 00:47:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Michael Rodin <michael-git@rodin.online>
cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] arch/x86/entry/vsyscall/vsyscall_gtod.c: remove
 __read_mostly from vclocks_used
In-Reply-To: <20180604172711.18962-1-michael-git@rodin.online>
Message-ID: <alpine.DEB.2.21.1806222333070.1589@nanos.tec.linutronix.de>
References: <20180604172711.18962-1-michael-git@rodin.online>
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

Michael,

On Mon, 4 Jun 2018, Michael Rodin wrote:

> The variable "vclocks_used" doesn't appear to be "read mostly".
> Measurements of the access frequency with perf stat [1] and
> perf report show, that approximately half of the accesses to
> this variable are write accesses and happen in update_vsyscall()
> in the file arch/x86/entry/vsyscall/vsyscall_gtod.c.
> The measurements were done with the kernel 4.13.0-43-generic used by
> ubuntu as well as with the stable kernel 4.16.7 with a custom config.
> I've used "perf bench sched" and iperf3 as workloads.
> 
> This was discovered during my master thesis in the CADOS project [2].

Nice find, but ...

The point is that the content of that variable changes once in a blue moon,
so the intent of marking it read_mostly is almost correct. Almost, because
the unconditional write even with the ever repeating same value is not
free. To the best of my knowledge there is no CPU implementation which
supports optimizing silent stores, but I might be just not up to date or
wrong as usual.

So there is a cost to the write and there are two things which have to be
looked at before just doing the obvious knee jerk reaction
's/read_mostly//'.

1) Does it make sense to avoid the write if the value hasn't changed? That
   might be pretty much a free lunch because the variable has to be read in
   the first place in order to OR the supplied value to it before writing
   it back.

2) The variable is in a totally separate cache line than what the following
   stores target, i.e. vsyscall_gtod_data

So it might make sense just to do #1 but as vsyscall_gtod_data is anyway
going to be dirtied it probably makes even more sense to move that
vclocks_used variable into struct vsyscall_gtod_data right away to reduce
the amount of cache lines touched by update_vsyscall().

Care to have a look at that?

Thanks,

	tglx
