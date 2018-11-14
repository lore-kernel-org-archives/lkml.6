Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2CBC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF55208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF55208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732747AbeKNWJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 17:09:04 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:49022 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbeKNWJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 17:09:04 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23992362AbeKNMFPSER-C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 1 other);
        Wed, 14 Nov 2018 13:05:15 +0100
Date:   Wed, 14 Nov 2018 12:05:14 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Matt Turner <mattst88@gmail.com>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: m41t80: Complete error propagation from SMBus
 calls
In-Reply-To: <20181114095737.GV29768@piout.net>
Message-ID: <alpine.LFD.2.21.1811141139450.21654@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1811070142240.20378@eddie.linux-mips.org> <20181114095737.GV29768@piout.net>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018, Alexandre Belloni wrote:

> >  I'll be posting further patches over the coming weeks, based on my 
> > original effort as archived here: <https://lkml.org/lkml/2008/5/12/385>,
> > <https://lore.kernel.org/patchwork/project/lkml/list/?series=73524&archive=both> 
> > However I have just realised they'll need another iteration before I post 
> > them.  So for now just these two obvious fixes.
> > 
> 
> Regarding the persistent part, do you really need more than what is
> provided? As far as I know, the timekeeping core is already taking care
> of using the best source to get the suspended time.

 For that we have platform code duplicating what the RTC framework 
already does.  Some of that cannot be made to work reasonably.  See e.g. 
arch/mips/dec/time.c or arch/mips/sibyte/swarm/rtc_*.c.

 The DEC code is technically sound, but spreads the same function (RTC 
r/w access) across another place, in addition to drivers/rtc/rtc-cmos.c.  
The SiByte code bypasses the I2C driver and therefore cannot be 
converted to use I2C interrupts, which means system latency problems.  
The write part used for NTP can be removed right away by making it 
return -ENODEV, and I have separate patches to do that for these 
platforms.  The read part cannot AFAICT.

 I think we can discuss that when I post the patches.  The m41t80 driver 
currently does not work for me anyway and has to be fixed because of:

i2c /dev entries driver
i2c-sibyte: i2c SMBus adapter module for SiByte board
i2c i2c-1: doesn't support I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_I2C_BLOCK

and the persistent part is only one patch in the upcoming number of 
changes.

 Thanks for taking the other three patches.

  Maciej
