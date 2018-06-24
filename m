Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A991EC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 06:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5965D208FC
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 06:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5965D208FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751600AbeFXGnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 02:43:55 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44665 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751371AbeFXGny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 02:43:54 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWykK-0002Sw-CT; Sun, 24 Jun 2018 08:43:36 +0200
Date:   Sun, 24 Jun 2018 08:43:35 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
cc:     Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 02/16] x86/split_lock: Handle #AC exception for split
 lock in kernel mode
In-Reply-To: <20180624011738.GI18979@romley-ivt3.sc.intel.com>
Message-ID: <alpine.DEB.2.21.1806240838510.8650@nanos.tec.linutronix.de>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com> <1527435965-202085-3-git-send-email-fenghua.yu@intel.com> <alpine.DEB.2.21.1806212301590.1591@nanos.tec.linutronix.de> <20180623042033.GF18979@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1806231108540.8650@nanos.tec.linutronix.de> <20180623150521.GG18979@romley-ivt3.sc.intel.com> <alpine.DEB.2.21.1806240245160.8650@nanos.tec.linutronix.de> <20180624011738.GI18979@romley-ivt3.sc.intel.com>
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

On Sat, 23 Jun 2018, Fenghua Yu wrote:

> On Sun, Jun 24, 2018 at 02:55:08AM +0200, Thomas Gleixner wrote:
> > On Sat, 23 Jun 2018, Fenghua Yu wrote:
> > > On Sat, Jun 23, 2018 at 11:17:03AM +0200, Thomas Gleixner wrote:
> > > > On Fri, 22 Jun 2018, Fenghua Yu wrote:
> > It's not treated as failure. The firmware simply does not have an handler
> > for #AC installed and dies. I hope you yelled at the firmware people
> > already.
> 
> I think firmware does handle the split lock in its #AC handler because
> firmware shows the following log and system hangs:
> 
> !!!! IA32 Exception Type - 11(#AC - Alignment Check)  CPU Apic ID - 00000014!
> !
> ExceptionData - 00000000
> EIP  - 6A9DB6C3, CS  - 00000010, EFLAGS - 00010006
> ...

They even have a handler which makes the thing die, but never bothered to
enable #AC in the first place. So the handler is there to catch the case
that an operating system dares to enable #AC. Thank god, I don't have to
review that source code.

Thanks,

	tglx
