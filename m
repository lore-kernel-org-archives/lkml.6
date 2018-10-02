Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A1CC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C34D2064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C34D2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeJBS4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:56:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59904 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbeJBS4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:56:20 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7JYC-0001G4-6h; Tue, 02 Oct 2018 14:13:16 +0200
Date:   Tue, 2 Oct 2018 14:13:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Juergen Gross <jgross@suse.com>
cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        sthemmin@microsoft.com, mikelley@microsoft.com, kys@microsoft.com,
        haiyangz@microsoft.com, yi.y.sun@linux.intel.com, hpa@zytor.com
Subject: Re: [tip:x86/hyperv] x86/hyperv: Enable PV qspinlock for Hyper-V
In-Reply-To: <0005fc50-4415-87a0-1954-fb15a1f8bd0b@suse.com>
Message-ID: <alpine.DEB.2.21.1810021412060.12704@nanos.tec.linutronix.de>
References: <1538028104-114050-3-git-send-email-yi.y.sun@linux.intel.com> <tip-aaa7fc34c003bd8133a49f7634480cef6288ad55@git.kernel.org> <0005fc50-4415-87a0-1954-fb15a1f8bd0b@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2018, Juergen Gross wrote:

> Sorry for noticing this only now, but I have been fighting with
> Xen PV qspinlocks last weekend:
> 
> > +	/*
> > +	 * Read HV_X64_MSR_GUEST_IDLE MSR can trigger the guest's
> > +	 * transition to the idle power state which can be exited
> > +	 * by an IPI even if IF flag is disabled.
> > +	 */
> 
> What if interrupts are enabled? Won't a kick happening here just
> interrupt and then the following rdmsr result in a hang?
> 
> I believe the correct way would be to:
> 
> - disable interrupts before above READ_ONCE() and restore them
>   after the rdmsrl()
> 
> - return early if in_nmi()
> 
> similar as the kvm specific variant is doing it.

Interesting question. I zapped the last commit for now until this is
clarified.

Thanks,

	tglx
