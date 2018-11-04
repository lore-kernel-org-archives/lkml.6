Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EA8C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 10:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72842082A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 10:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72842082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbeKDTeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 14:34:19 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:60970 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbeKDTeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 14:34:19 -0500
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gJFVW-0004Ww-AJ; Sun, 04 Nov 2018 11:19:50 +0100
Date:   Sun, 4 Nov 2018 11:19:49 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Holger Schurig <holgerschurig@gmail.com>
cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org
Subject: Re: BUG: "do_IRQ: 0.39 No irq handler for vector" from a 16550
 port
In-Reply-To: <87h8gzfr2p.fsf@gmail.com>
Message-ID: <alpine.DEB.2.21.1811041110380.3160@nanos.tec.linutronix.de>
References: <87k1lvg2z4.fsf@gmail.com> <87h8gzfr2p.fsf@gmail.com>
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

On Fri, 2 Nov 2018, Holger Schurig wrote:

> I said that kernel 4.9 doesn't show the issue. The same was for later
> kernels up to 4.13.
> 
> I had a compilation issue with 4.14 (which I later solved, something
> unrelated with tools/objcopy when compiling for a different
> architecture), so I did a git bisect between v4.13 and v4.15. This is
> the outcome:
>
> git bisect bad 464d12309e1b5829597793db551ae8ecaecf4036
> # first bad commit: [464d12309e1b5829597793db551ae8ecaecf4036] x86/vector: Switch IOAPIC to global reservation mode

Which is not surprising because the old model just hid the issue of
interrupts which came in after the interrupt had been torn down.

I have no idea what causes this, but it seems to be related to the
particular hardware/BIOS combination.

Thanks,

	tglx



