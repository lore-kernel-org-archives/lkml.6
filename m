Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E4AC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C143206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C143206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeILB5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:57:14 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42411 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbeILB5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:57:14 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fzphd-0005jP-Pc; Tue, 11 Sep 2018 22:56:06 +0200
Date:   Tue, 11 Sep 2018 22:56:05 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Pasha Tatashin <Pavel.Tatashin@microsoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Revert "x86/tsc: Consolidate init code"
In-Reply-To: <20180911121548.GW5565@intel.com>
Message-ID: <alpine.DEB.2.21.1809112227520.1427@nanos.tec.linutronix.de>
References: <20180910121925.27682-1-ville.syrjala@linux.intel.com> <alpine.DEB.2.21.1809101443290.1292@nanos.tec.linutronix.de> <20180910140710.GR5565@intel.com> <alpine.DEB.2.21.1809101846160.1419@nanos.tec.linutronix.de> <20180911121548.GW5565@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-931252212-1536698711=:1427"
Content-ID: <alpine.DEB.2.21.1809112245240.1427@nanos.tec.linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-931252212-1536698711=:1427
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.21.1809112245241.1427@nanos.tec.linutronix.de>

On Tue, 11 Sep 2018, Ville Syrjälä wrote:

> On Mon, Sep 10, 2018 at 06:53:54PM +0200, Thomas Gleixner wrote:
> > On Mon, 10 Sep 2018, Ville Syrjälä wrote:
> > 
> > Good: 1718674.70 BogoMIPS (lpj=2863311530)
> > Bad:   859455.59 BogoMIPS (lpj=1431852151)
> > 
> > while both kernels agree on the CPU frequency of 996MHz. This pretty much
> > smells like the 32bit LPJ conversion bug which got fixed in rc3. Does the
> > problem persist with rc3?
> 
> Indeed looks to be fixed by commit 17f6bac22493 ("x86/tsc:
> Prevent result truncation on 32bit").

Not a surprise. That was pretty clear when I looked at dmesg because
bogomips were very bogus for both variants.

So can you now understand why I prefer a proper bug/regression report with
as much information as possible over a revert patch which lacks a proper
explanation and does not even fix the underlying issue at all?

Reverting that patch as you can see from bogus mips solves exactly
nothing. It's pure chance that it booted.

You could have spared my and your time by

    1) checking whether the problem persist in the latest upstream -rc
       first

    2) Providing useful information upfront

I don't care much about your time and how you think what's the best way to
get a discussion started, but I care very much about my time being wasted
for pointless discsussions which can be avoided more or less completely.

> I suppose we just got very lucky with older kernels.

The problem got initialy introduced with

  commit dd759d93f4dd ("x86/timers: Add simple udelay calibration")

but this was not fatal because it only affected the very early boot and was
fixed up by the correct LPJ calculation in tsc_init() before any serious
user was affected. I'll whip up a fix for the affected stable kernels
nevertheless.

Thanks

	tglx


--8323329-931252212-1536698711=:1427--
