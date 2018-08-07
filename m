Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB33C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70CE2172E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70CE2172E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389670AbeHGUdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:33:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727198AbeHGUdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:33:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C18FA7D84D;
        Tue,  7 Aug 2018 18:17:35 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 673BD7C56;
        Tue,  7 Aug 2018 18:17:35 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id w77IHZVB025672;
        Tue, 7 Aug 2018 14:17:35 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id w77IHYMN025668;
        Tue, 7 Aug 2018 14:17:34 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 7 Aug 2018 14:17:34 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
cc:     Marcin Wojtas <mw@semihalf.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matt Sealey <neko@bakuhatsu.net>,
        Jingoo Han <jingoohan1@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CAKv+Gu_HasYTYLy3d_1vhBHA=M5i40DmU3EuVHhzT4pRiahcmA@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.1808071414340.25017@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com> <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com> <CAKv+Gu9_h-WFi1j4+DWUN_dMj75SKKHxWoDH8WQ9P7S7MNpZQg@mail.gmail.com>
 <alpine.LRH.2.02.1808060553130.30832@file01.intranet.prod.int.rdu2.redhat.com> <99fff4fe-afa9-f12f-a518-472a9dd1c530@arm.com> <CAKv+Gu_C2g=C=gMpk4a5jpDORnxZY6t1v=HDoy59m5vwNBxBBg@mail.gmail.com> <alpine.LRH.2.02.1808061306490.12989@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu_8Rq6X24ZOYvG7+kQQGSGYAZuu_co4k1nJS8K7rkrWMA@mail.gmail.com> <alpine.LRH.2.02.1808061552090.11930@file01.intranet.prod.int.rdu2.redhat.com> <CAKv+Gu_iCgAeGmrajZ_euMcFLntWG1a51HF_HQ1TO=fV_v__AQ@mail.gmail.com> <CAPv3WKdCMpy6KarducQEtSYP35zdELhparkmPPMKGMUhsdk1Qw@mail.gmail.com>
 <alpine.LRH.2.02.1808071331260.16565@file01.intranet.prod.int.rdu2.redhat.com> <CAKv+Gu_HasYTYLy3d_1vhBHA=M5i40DmU3EuVHhzT4pRiahcmA@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 07 Aug 2018 18:17:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 07 Aug 2018 18:17:35 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'mpatocka@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Aug 2018, Ard Biesheuvel wrote:

> On 7 August 2018 at 19:39, Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> >
> > On Tue, 7 Aug 2018, Marcin Wojtas wrote:
> >
> >> Ard, Mikulas,
> >>
> >> After some self-caused setup issues I was able to run the test on my
> >> MacchiatoBin with the kernel v4.18-rc8. It's been running for 1h+ now,
> >> loading the CPU to 100% and no single error event...
> >>
> >> I built the binary file with:
> >> gcc-linaro-7.2.1-2017.11-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc -O2
> >>
> >> Maybe it's the older firmware issue?
> >
> > I have downloaded and built the firmware recently (it has timestamp Jul 30
> > 2018).
> >
> > Do you still have your firmware file "flash-image.bin" that you used, so
> > that I could try it?
> >
> >> Please send the full bootlog with
> >> the very first line after reset. My board rev is v1.3 and I use
> >> mainline UEFI (newest edk2 + edk2-platforms) + newest publicly
> >> available ARM-TF and earliest firmware for this board.
> >>
> >> Best regards,
> >> Marcin
> >
> 
> Mikulas,
> 
> Is the issue reproducible with an nvidia card + nouveau driver as well ?
> 
> Given the screen corruption i see with radeon even on other arm
> systems, i'd like to ensure that this is a platform bug not a driver
> bug.

I see the same memcpy-to-framebuffer corruption on Radeon HD 6450 and 
nVidia Quadro NVS 285.

3D acceleration on nVidia is slow, but it doesn't have visible glitches.

Mikulas
