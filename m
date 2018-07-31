Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9B5C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F5D20870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F5D20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbeGaV0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:26:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60359 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729924AbeGaV0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:26:16 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fkaZE-0002Wu-1k; Tue, 31 Jul 2018 21:44:24 +0200
Date:   Tue, 31 Jul 2018 21:44:20 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: RE: [PATCH V2] x86/speculation: Support Enhanced IBRS on future
 CPUs
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F475E3158@ORSMSX114.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.21.1807312139350.1713@nanos.tec.linutronix.de>
References: <1532978396-2197-1-git-send-email-sai.praneeth.prakhya@intel.com> <alpine.DEB.2.21.1807302153570.1725@nanos.tec.linutronix.de> <FFF73D592F13FD46B8700F0A279B802F4757790C@ORSMSX114.amr.corp.intel.com> <alpine.DEB.2.21.1807311018040.1725@nanos.tec.linutronix.de>
 <FFF73D592F13FD46B8700F0A279B802F475E3158@ORSMSX114.amr.corp.intel.com>
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

On Tue, 31 Jul 2018, Prakhya, Sai Praneeth wrote:

> > The feature strings are automatically generated from the define. The comment
> > can be used to supress them by an empty "" string or to modify them by a
> > "override" string at the beginning of the comment.
> 
> I overlooked "override" part. Sorry! about that.

Nothing to be sorry about. I just knew it because I stumbled over it my
self quite some time ago.

> > > > > +	/* Ensure SPEC_CTRL_IBRS is set after VMEXIT from a guest */
> > > > > +	x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
> > > >
> > > > And what exactly writes the MSR?
> > > >
> > >
> > > While booting, x86_spec_ctrl_setup_ap() does that and after VMEXIT
> > > x86_spec_ctrl_restore_host().
> > >
> > > As x86_spec_ctrl_setup_ap() does wrmsrl(MSR_IA32_SPEC_CTRL,
> > > x86_spec_ctrl_base), I thought writing here would be redundant.
> > 
> > x86_spec_ctrl_setup_ap() is only called on the AP but not on the BP. So the boot
> > processor will not have it set, unless something else writes the MSR. So you
> > really want to have an explicit write there.
> 
> Yes, that makes sense.
> But on the machine, I see IBRS bit set on all cores. As you said, someone else might 
> be writing the MSR. I will try to find that out and will update the patch accordingly.
> 
> I initially suspected it to be __ssb_select_mitigation() as I have 
> "spec_store_bypass_disable=on" in the kernel command line, but turns out it's not so.
> I will update you more on this.

There are lots of places like the firmware mitigation stuff and other
things which write that MSR. And because the bit is set in
x86_spec_ctrl_base it will be on at some point and stay so.

Writing it explicitely at the point where it is set makes it independent of
other mechanisms which touch that MSR and Just Works.

Thanks,

	tglx


