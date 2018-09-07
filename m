Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685C6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1311120652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1311120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbeIHA4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:56:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36992 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeIHA4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:56:11 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyN8I-0001Yl-Tp; Fri, 07 Sep 2018 22:13:35 +0200
Date:   Fri, 7 Sep 2018 22:13:34 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bhupesh Sharma <bhsharma@redhat.com>
cc:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        Al Stone <astone@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V4 3/3] x86/efi: Introduce EFI_PAGE_FAULT_HANDLER
In-Reply-To: <CACi5LpM4QoRn5bAwR-ZJHhaih7N41HYGx6MPZXAY78jFsbu9dg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809072200030.1402@nanos.tec.linutronix.de>
References: <1536276468-28499-1-git-send-email-sai.praneeth.prakhya@intel.com> <1536276468-28499-4-git-send-email-sai.praneeth.prakhya@intel.com> <20180907112207.GS24106@hirez.programming.kicks-ass.net> <FFF73D592F13FD46B8700F0A279B802F485BA5C1@ORSMSX114.amr.corp.intel.com>
 <e10acaa8-f5d8-85f3-219c-86fafd793a87@redhat.com> <FFF73D592F13FD46B8700F0A279B802F485BA620@ORSMSX114.amr.corp.intel.com> <alpine.DEB.2.21.1809072116530.1402@nanos.tec.linutronix.de> <CACi5LpM4QoRn5bAwR-ZJHhaih7N41HYGx6MPZXAY78jFsbu9dg@mail.gmail.com>
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

On Sat, 8 Sep 2018, Bhupesh Sharma wrote:
> On Sat, Sep 8, 2018 at 12:52 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > If the distro patched their kernel to deal with buggy firmware, then:
> >
> >  1) why did they not upstream it ?
> 
> Because some of the kernel fixes are (for such cases), well to be
> honest, ugly.. and probably not suitable for placement in quirks
> files/common code present upstream as they introduce lots of #ifdef
> jugglery.
> 
> Also the x86 machines with such buggy BIOS firmwares are too old (but
> still used in some production environment) and the OS workarounds are
> suggested by the vendors themselves and they historically had issues
> getting the quirks upstream.

Right, because they did not even try. And the distros just integrated that
mess instead of telling them to fix the crappy firmware. And that can be
fixed. I know for sure because the RT qualification program at RH has made
vendors to fix their crap in order to get the rubber stamp.

> >  2) why should we worry about that ?
> 
> As this allows one to still promote upgrading such machines to
> upstream kernel versions and keep the kernel running on them as close
> as possible to mainline.

If the firmware is buggy and trips faults in the EFI mess then mainline
will just crash and burn.

So how are you going to upgrade these machines to a mainline kernel with
that fault handler disabled? Not at all.

If you need to patch the kernel in order to make it work on mainline, then
still that EFI fault handler has ZERO impact. Because those patches need to
prevent the firmware from faulting in the first place. If they have magic
fault handlers for this crap themself, then the patches will conflict
anyway, config switch or not.

You have to come up with something more convincing.

Thanks,

	tglx
