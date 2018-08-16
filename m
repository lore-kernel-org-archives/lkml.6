Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BE1C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672BA20936
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672BA20936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391102AbeHPNlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 09:41:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43826 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731031AbeHPNlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 09:41:46 -0400
Received: from localhost (unknown [37.168.156.28])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0A2F1516;
        Thu, 16 Aug 2018 10:44:04 +0000 (UTC)
Date:   Thu, 16 Aug 2018 12:44:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] uio: ensure class is registered before devices
Message-ID: <20180816104400.GA15593@kroah.com>
References: <20180816073941.13618-1-alexandre.belloni@bootlin.com>
 <20180816080112.GA3496@kroah.com>
 <20180816083438.GE21707@piout.net>
 <20180816100413.GA9141@kroah.com>
 <20180816103450.GF21707@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816103450.GF21707@piout.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 12:34:50PM +0200, Alexandre Belloni wrote:
> On 16/08/2018 12:04:13+0200, Greg Kroah-Hartman wrote:
> > On Thu, Aug 16, 2018 at 10:34:38AM +0200, Alexandre Belloni wrote:
> > > On 16/08/2018 10:01:12+0200, Greg Kroah-Hartman wrote:
> > > > On Thu, Aug 16, 2018 at 09:39:41AM +0200, Alexandre Belloni wrote:
> > > > > When both uio and the uio drivers are built in the kernel, it is possible
> > > > > for a driver to register devices before the uio class is registered.
> > > > 
> > > > How does this happen?  The link order should solve this issue, right?
> > > > 
> > > 
> > > Sure, if we can ensure uio_init() is called before any driver calls
> > > uio_register_device() then this would not happen. However, I'm not sure
> > > how you would want to achieve that.
> > 
> > That is the job of the link order, does this not work properly today?
> > How have you triggered this so that you could test your patch?
> > 
> 
> I have a (not yet upstreamed) MFD driver in drivers/mfd that is
> registering the uio device. It mostly look like uio_pci_generic.c.
> 
> When compiling both as builtin, it will crash that way.
> 
> There are no link dependency between uio_init and uio_register_device
> calls so I guess the linker can't reorder that properly.

Ah, ok, yes, that will break, I was looking at the kernel tree _today_ :)

I'll queue this up after 4.19-rc1 is out, thanks.

greg k-h
