Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F20ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2482087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C2482087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeGMJmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:42:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59600 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeGMJmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:42:21 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6CE4DBB3;
        Fri, 13 Jul 2018 09:28:31 +0000 (UTC)
Date:   Fri, 13 Jul 2018 11:28:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v4] uart: fix race between uart_put_char() and
 uart_shutdown()
Message-ID: <20180713092828.GA6589@kroah.com>
References: <20180706212220.GC3583@cisco.lan>
 <20180711160744.32074-1-tycho@tycho.ws>
 <20180712150438.GF22502@kroah.com>
 <20180712150822.GC13192@cisco.cisco.com>
 <20180712154015.GC13114@kroah.com>
 <20180712181846.GD13192@cisco.cisco.com>
 <20180712182545.GA30099@kroah.com>
 <20180712183001.GE13192@cisco.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712183001.GE13192@cisco.cisco.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 12:30:01PM -0600, Tycho Andersen wrote:
> On Thu, Jul 12, 2018 at 08:25:45PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Jul 12, 2018 at 12:18:46PM -0600, Tycho Andersen wrote:
> > > On Thu, Jul 12, 2018 at 05:40:15PM +0200, Greg Kroah-Hartman wrote:
> > > > On Thu, Jul 12, 2018 at 09:08:22AM -0600, Tycho Andersen wrote:
> > > > > On Thu, Jul 12, 2018 at 05:04:38PM +0200, Greg Kroah-Hartman wrote:
> > > > > > On Wed, Jul 11, 2018 at 10:07:44AM -0600, Tycho Andersen wrote:
> > > > > > > +	if (uport)
> > > > > > > +		spin_lock_irqsave(&uport->lock, flags);
> > > > > > 
> > > > > > That's the same thing as just calling uart_port_lock(), why aren't you
> > > > > > doing that?
> > > > > 
> > > > > Because the compiler can't seem to "see" through the macros/ref calls,
> > > > > and I get the warning I mentioned here if I use them:
> > > > > 
> > > > > https://lkml.org/lkml/2018/7/6/840
> > > > 
> > > > What horrible version of gcc are you using that give you that?  Don't
> > > > open-code things just because of a broken compiler.
> > > 
> > > I've tried with both 7.3.0 and 5.4.0. I think the reason we see this
> > > here but not elsewhere in the file is because there's an actual
> > > function call (free_page()) in the critical section.
> > > 
> > > If we move that out, something like the below patch, it all works for
> > > me.
> > 
> > Ick.  Which version of this series had the problem?  Let me test it out
> > here...
> 
> v3, if you remove the initialization of flags from both functions you
> should see it.

Ok, I tried v3 out and yes, you are right, removing the "= 0" causes gcc
to complain.  The compiler is being dumb here, so I'll just leave it
as-is.  I've queued up the v3 version now, thanks for sticking with
this.

greg k-h
