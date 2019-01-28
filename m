Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A0BC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FFD2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548663799;
	bh=CDuTNVgfGfdfsdqHOILuN4/sQtGCbQMlhWeiJ9bCA/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YApXyK7xkthFOcogO0mmXkEUbnjcofW0vKt3Ea4XxWiJZxpZWItaCszl2kDFU0ddd
	 Ix9Ej31DK7U6FswKdSOxNSXuvBAP4HWgsn2CV09Y9YSl0Phw1FdgsfpPENXFRK9LD3
	 9+uSofX2OJzmtfOrzCZ9fis+1+WNG+9a+cl1O46E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfA1IXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:23:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:59182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfA1IXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:23:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 255BE2148E;
        Mon, 28 Jan 2019 08:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548663796;
        bh=CDuTNVgfGfdfsdqHOILuN4/sQtGCbQMlhWeiJ9bCA/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h0pMFqEztXQdKYIYNX3xfcyJxwRTtcUSwU6OFakWm9aO7tH5kWSs3qa54h5lkEkdR
         BQ24ulB7FSK7q80PfLHI4bZLvOfIm+wocapkls39i6+EFs3p3YPMa18WKbiFDfHaPi
         3zDwzl7TXHYHi+a3lYxn7jPxnZFXmR+UIEHIETj4=
Date:   Mon, 28 Jan 2019 09:23:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] drivers/tty: increase priority for
 tty_buffer_worker
Message-ID: <20190128082313.GA15182@kroah.com>
References: <20190110101232.9398-1-o.rempel@pengutronix.de>
 <20190110101232.9398-4-o.rempel@pengutronix.de>
 <CAADWXX_G7X6QkNuqnpMyr+MGP+nUhqPaifJrfC=m57mhJu2jdg@mail.gmail.com>
 <20190110151953.qpat4t7lat6plfk6@pengutronix.de>
 <20190110163030.GB19693@kroah.com>
 <7a593f3b-0019-c30f-30e8-34eae7b96cf0@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a593f3b-0019-c30f-30e8-34eae7b96cf0@pengutronix.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 09:05:30AM +0100, Oleksij Rempel wrote:
> 
> 
> On 10.01.19 17:30, Greg Kroah-Hartman wrote:
> > On Thu, Jan 10, 2019 at 04:19:53PM +0100, Oleksij Rempel wrote:
> > > > My gut feel is that if somebody still cares deeply about serial line
> > > > latency, they should look at trying to see if they can do some of the
> > > > work directly without the bounce to the workqueue. We use workqueues
> > > > for a reason, but it's possible that some of it could be avoided at
> > > > least in special cases... And yours sounds like a special case.
> > > 
> > > It is for industrial low latency RS-422 based application. The loopback
> > > test is just easy way to test/reproduce it without additional hardware.
> > > 
> > > What is good, mainlineable way to implement it?
> > 
> > What is the real problem your systems are having?  Are they serial-port
> > limited?  Is latency a big issue?  Trying to tune for a fake workload
> > isn't the best way to solve anything :)
> 
> The system in question is a high power laser cutter with live image-based inspection
> and adjustment of the cutting process. In this setup the RS422 interface is used to
> control parameters of the laser cutting unit in a tie control loop with the camera.
> This loops needs to operate at 1000 Hz.
> 
> The xy-stage moves with a speed of approx. 60m/min, i.e. within 1ms it
> moves about 1mm. For a high precision control process a jitter of ± 500 us (+/- 0.5mm)
> is unacceptable.

Are you using the rt kernel patch for this type of thing?  That should
bound your jitter at a much more deterministic level.

thanks,

greg k-h
