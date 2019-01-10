Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54332C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CF9214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbfAJPT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:19:58 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33407 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfAJPT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:19:58 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1ghc7f-0005Pv-Fk; Thu, 10 Jan 2019 16:19:55 +0100
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1ghc7d-0005Pt-Qi; Thu, 10 Jan 2019 16:19:53 +0100
Date:   Thu, 10 Jan 2019 16:19:53 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] drivers/tty: increase priority for
 tty_buffer_worker
Message-ID: <20190110151953.qpat4t7lat6plfk6@pengutronix.de>
References: <20190110101232.9398-1-o.rempel@pengutronix.de>
 <20190110101232.9398-4-o.rempel@pengutronix.de>
 <CAADWXX_G7X6QkNuqnpMyr+MGP+nUhqPaifJrfC=m57mhJu2jdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADWXX_G7X6QkNuqnpMyr+MGP+nUhqPaifJrfC=m57mhJu2jdg@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 16:08:28 up 212 days, 17 min, 159 users,  load average: 0.08, 0.27,
 0.23
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 04:54:53AM -0800, Linus Torvalds wrote:
> On Thu, Jan 10, 2019 at 2:12 AM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >
> > sched_priority = 1 is enough to dramatically reduce latency
> > on have system load produced by tasks with default user space prio.
> 
> .. and is this perhaps a way for a user to then make the system spend
> inordinate amounts of time in the tty layer, and hurting other people?
> I'm thinking threads using pty's etc as a way to make the system
> unresponsive.
> 
> We have *never* had good results with random priority modifications.
> People used to do this for the X server, and it helped in very
> specific cases, and hurt enormously in others.
> 
> Why would anybody use a tty interface with a l;oopback adapter and
> care about latency?
> 
> I can kind of see why you want to do this from a theoretical point,
> but from a *practical* point of view it seems pointless. Why not use
> more appropriate models like networking or pipes etc. IOW, I think you
> should describe what you *really* are doing much more.
> 
> "hackbench with a loopback serial adapter" really doesn't sound like
> something that should worry a lot of people.

yes, you right.

> My gut feel is that if somebody still cares deeply about serial line
> latency, they should look at trying to see if they can do some of the
> work directly without the bounce to the workqueue. We use workqueues
> for a reason, but it's possible that some of it could be avoided at
> least in special cases... And yours sounds like a special case.

It is for industrial low latency RS-422 based application. The loopback
test is just easy way to test/reproduce it without additional hardware.

What is good, mainlineable way to implement it? 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
