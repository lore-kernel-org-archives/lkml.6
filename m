Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35004C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063472133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547242568;
	bh=gDY6+IdFDq93ljheSpflfGjlP2lVwu7hobIWeoEpNSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RUxNRMaAJb63RreIVDWbEmBOu44Lepu1muW6bh/FR3PGhogirUtrcuh4GQk8XGdN1
	 hxT8LhJmF30Ew8VFswcX6QkejcyDtY9/Xfkcb7oM6S28e/0RRkzmYILAoIJHhoPDMs
	 AxKsgiJ8ySlxbex3irTgPcSGkNojm2z7435TaZwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfAKVgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:36:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:41396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfAKVgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:36:06 -0500
Received: from localhost (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA2E22084C;
        Fri, 11 Jan 2019 21:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547242565;
        bh=gDY6+IdFDq93ljheSpflfGjlP2lVwu7hobIWeoEpNSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2PNYM2Ys5Ir8RIbuRzjrmQNch3CguNWyEEH5+NBW/fshVK9KYDSbyjntEP7DlEh+J
         TF8FgKW7uGiaB5i/hvQvAPgQ9u3LgRlORwewef5Fd6WdEnMY5R+NiBwfGN6h+dgqqd
         VHe/lNT/2DkWpcwQLVrMxIWHlzok1KPV3JSVJFh4=
Date:   Fri, 11 Jan 2019 22:36:02 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()") may
 have revealed another problem
Message-ID: <20190111213601.GA18741@lerouge>
References: <20180828022545.GA25943@lerouge>
 <alpine.DEB.2.21.1809271805190.8118@nanos.tec.linutronix.de>
 <20180928131855.GB8795@lerouge>
 <c472b6bf-e4af-d807-e63f-75211ce295bd@gmail.com>
 <20181227065321.GA3749@lerouge>
 <e838fa7f-f43f-7b3c-aae6-edb4f6734964@gmail.com>
 <20181228013109.GB3749@lerouge>
 <d9647487-28db-d138-ae3e-3fd0d2fbe589@gmail.com>
 <5aa51fc1-5a5c-0c61-5c28-0d9ca98e4514@gmail.com>
 <596c9dc3-5cf4-73e8-b3ea-40fcb8c5f711@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <596c9dc3-5cf4-73e8-b3ea-40fcb8c5f711@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 11:20:50PM +0100, Heiner Kallweit wrote:
> On 28.12.2018 07:39, Heiner Kallweit wrote:
> > On 28.12.2018 07:34, Heiner Kallweit wrote:
> >> On 28.12.2018 02:31, Frederic Weisbecker wrote:
> >>> On Fri, Dec 28, 2018 at 12:11:12AM +0100, Heiner Kallweit wrote:
> >>>>
> >> [...]
> >>>
> >>> Interesting, the softirq is raised from hardirq but it's not handled in the end of
> >>> the IRQ. Are you running threaded IRQS by any chance? If so I would expect ksoftirqd
> >>> to handle the pending work before we go idle. However I can imagine a small window
> >>> where such an expectation may not be met: if the softirq is raised after the ksoftirqd
> >>> thread is parked (CPUHP_AP_SMPBOOT_THREADS), which is right before we disable the CPU
> >>> (CPUHP_TEARDOWN_CPU).
> >>>
> >> I have a network driver (r8169) using NAPI which runs in softirq context AFAIK.
> >> For testing purposes I sometimes trigger system suspend via network, so there is
> >> network adapter activity when system suspends. Apart from that nothing really
> >> exciting:
> >>             CPU0       CPU1       CPU2       CPU3
> >>    0:         43          0          0          0   IO-APIC    2-edge      timer
> >>    1:          4          0          0          0   IO-APIC    1-edge      i8042
> >>    8:          0          1          0          0   IO-APIC    8-fasteoi   rtc0
> >>    9:          0          0          0          0   IO-APIC    9-fasteoi   acpi
> >>   12:          0          0          0          5   IO-APIC   12-edge      i8042
> >>  120:          0          0          0          0   PCI-MSI 311296-edge      PCIe PME
> >>  121:          0          0          0          0   PCI-MSI 315392-edge      PCIe PME
> >>  122:          0          0          0          0   PCI-MSI 327680-edge      PCIe PME
> >>  123:          0          0       3328          0   PCI-MSI 294912-edge      ahci[0000:00:12.0]
> >>  124:          0        133          0          0   PCI-MSI 344064-edge      xhci_hcd
> >>  125:          0          0         32          0   PCI-MSI 245760-edge      mei_me
> >>  127:        381          0          0          0   PCI-MSI 1572864-edge      enp3s0
> >>  128:          0          0          0        236   PCI-MSI 32768-edge      i915
> >>  129:          0        374          0          0   PCI-MSI 229376-edge      snd_hda_intel:card0
> >>
> >>> I don't know if we can afford to ignore a softirq even at this late stage. We should
> >>> probably avoid leaking any. So here is a possible fix, if you don't mind trying:
> >>>
> >> I tested your patch and at least in the first minutes of testing couldn't reproduce
> >> the issue any longer. I tested manual system suspend and the following script you
> >> sent when we started to analyze the issue.
> >>
> > 
> > Also after some more time the issue didn't occur again. So it seems your analysis
> > was right and also the approach to fix it. Thanks!
> > Will let you know in case the issue should pop up again under special
> > circumstances.
> > 
> Frederic, so far this fix didn't appear in linux-next, are you going to submit it?

Yep, I'll cook up a proper changelog and let Thomas judge if the change is worth.
