Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE39CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831652148C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831652148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391075AbeHPNco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 09:32:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53830 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbeHPNco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 09:32:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1DB0920703; Thu, 16 Aug 2018 12:35:05 +0200 (CEST)
Received: from localhost (unknown [78.250.249.73])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1E00420717;
        Thu, 16 Aug 2018 12:34:53 +0200 (CEST)
Date:   Thu, 16 Aug 2018 12:34:50 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] uio: ensure class is registered before devices
Message-ID: <20180816103450.GF21707@piout.net>
References: <20180816073941.13618-1-alexandre.belloni@bootlin.com>
 <20180816080112.GA3496@kroah.com>
 <20180816083438.GE21707@piout.net>
 <20180816100413.GA9141@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816100413.GA9141@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2018 12:04:13+0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 16, 2018 at 10:34:38AM +0200, Alexandre Belloni wrote:
> > On 16/08/2018 10:01:12+0200, Greg Kroah-Hartman wrote:
> > > On Thu, Aug 16, 2018 at 09:39:41AM +0200, Alexandre Belloni wrote:
> > > > When both uio and the uio drivers are built in the kernel, it is possible
> > > > for a driver to register devices before the uio class is registered.
> > > 
> > > How does this happen?  The link order should solve this issue, right?
> > > 
> > 
> > Sure, if we can ensure uio_init() is called before any driver calls
> > uio_register_device() then this would not happen. However, I'm not sure
> > how you would want to achieve that.
> 
> That is the job of the link order, does this not work properly today?
> How have you triggered this so that you could test your patch?
> 

I have a (not yet upstreamed) MFD driver in drivers/mfd that is
registering the uio device. It mostly look like uio_pci_generic.c.

When compiling both as builtin, it will crash that way.

There are no link dependency between uio_init and uio_register_device
calls so I guess the linker can't reorder that properly.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
