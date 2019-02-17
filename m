Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D8FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397292184E
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 23:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfBQX7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 18:59:55 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:39720 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfBQX7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 18:59:54 -0500
Received: from darkstar.musicnaut.iki.fi (85-76-79-75-nat.elisa-mobile.fi [85.76.79.75])
        by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 2CAB02001F;
        Mon, 18 Feb 2019 01:59:52 +0200 (EET)
Date:   Mon, 18 Feb 2019 01:59:52 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Alexandre Oliva <lxoliva@fsfla.org>
Cc:     Tom Li <tomli@tomli.me>, James Hogan <jhogan@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] On the Current Troubles of Mainlining Loongson Platform
 Drivers
Message-ID: <20190217235951.GA20700@darkstar.musicnaut.iki.fi>
References: <20190208083038.GA1433@localhost.localdomain>
 <orbm3i5xrn.fsf@lxoliva.fsfla.org>
 <20190211125506.GA21280@localhost.localdomain>
 <orimxq3q9j.fsf@lxoliva.fsfla.org>
 <20190211230614.GB22242@darkstar.musicnaut.iki.fi>
 <orva1jj9ht.fsf@lxoliva.fsfla.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orva1jj9ht.fsf@lxoliva.fsfla.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 01:59:26AM -0300, Alexandre Oliva wrote:
> On Feb 11, 2019, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> 
> > ATA (libata) CS5536 driver is having issues with spurious IRQs and often
> > disables IRQs completely during the boot. You should see a warning
> > in dmesg. This was the reason for slowness on my FuLoong mini-PC. A
> > workaround is to switch to old IDE driver.
> 
> Thanks.  I see a NIEN quirk in ide-iops.c that's enabled for the hard
> drive model I've got on my yeeloong, but that's not even compiled in my
> freeloong builds.  I don't see any changes in libata between 4.19 and
> 4.20 that could explain the regression either.

I tested few older kernels, and it seems that the spurious IRQ issue has
been always there after switching to libata (commit 7ff7a5b1bfff). It has
been unnoticed as the 100000 irq limit wasn't reached during boot. But
since libata probe is asynchronous some other kernel thread may delay it,
and apparently some change in recent kernels adds enough delay to make the
IRQ count to hit the limit.

> I'm afraid there's no observable change in behavior after installing the
> proposed patch at
> https://lore.kernel.org/linux-mips/20190106124607.GK27785@darkstar.musicnaut.iki.fi/
> 
> The kernel still disables irq14 early on, and then runs slow.

This hack works only for CONFIG_PATA_CS5536. You are probably using PATA_AMD.

A.
