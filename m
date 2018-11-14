Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0633C07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE7F208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE7F208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732429AbeKNWxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 17:53:17 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:54124 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbeKNWxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 17:53:17 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23992408AbeKNMuGhQx2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 1 other);
        Wed, 14 Nov 2018 13:50:06 +0100
Date:   Wed, 14 Nov 2018 12:50:06 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Matt Turner <mattst88@gmail.com>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: m41t80: Complete error propagation from SMBus
 calls
In-Reply-To: <20181114122005.GY29768@piout.net>
Message-ID: <alpine.LFD.2.21.1811141234140.21654@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1811070142240.20378@eddie.linux-mips.org> <20181114095737.GV29768@piout.net> <alpine.LFD.2.21.1811141139450.21654@eddie.linux-mips.org> <20181114122005.GY29768@piout.net>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018, Alexandre Belloni wrote:

> >  I think we can discuss that when I post the patches.  The m41t80 driver 
> > currently does not work for me anyway and has to be fixed because of:
> > 
> > i2c /dev entries driver
> > i2c-sibyte: i2c SMBus adapter module for SiByte board
> > i2c i2c-1: doesn't support I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_I2C_BLOCK
> > 
> > and the persistent part is only one patch in the upcoming number of 
> > changes.
> 
> Well, one of the solution for that (and tis is on my todo list) is to
> convert the driver to use regmap which would take care of using the
> proper i2c transfers. However, one of the concern when not having bock
> accesses is that the registers are not latched (as you seem to know).
> One thing I would like is then to avoid the multiple SEC register read
> when not necessary.

 Unfortunately the SMBus host does not give much choice here.  It does 
have some extensions for block transfers, but writes are limited to 5 
bytes and reads to 7 bytes.  The usual solution is to read repeatedly 
until the seconds match.  For writes it is not a problem, because it 
takes less than 1 second to write all the clock registers, so if you 
start with seconds, then the data written will be consistent.

 The Xicor chip is worse as it uses 16-bit addresses and that is not 
handled by SMBus support in our I2C core, however apparently that can be 
simulated by byte writes with that particular chip.  The SMBus host 
implements a protocol extension for 16-bit addressing, but I think it's 
not worth the hassle adding to SMBus support in our I2C core given how 
rare the Xicor setup are.

 Finally the SMBus host does support raw I2C transfers, but only with a 
polled bit-banged interface, where you need to time the loop correctly 
to get clocking of the individual bits right.  I don't think we want to 
go down that path.

  Maciej
