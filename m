Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AE5C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE49521582
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE49521582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeI0PFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:05:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47048 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbeI0PFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:05:31 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6D3DF10AB;
        Thu, 27 Sep 2018 08:48:21 +0000 (UTC)
Date:   Thu, 27 Sep 2018 10:48:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     John Crispin <john@phrozen.org>, frederic@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH stable] tick/nohz: Prevent bogus softirq pending warning
Message-ID: <20180927084817.GA10781@kroah.com>
References: <alpine.DEB.2.21.1808301702450.1210@nanos.tec.linutronix.de>
 <CAMuHMdXASyzFpLp7RF36HWZcDdQcvdZ+JsmSn+Az8ZHcFLJ1zA@mail.gmail.com>
 <CAMuHMdXyAQP_GYyHXJd7qq1ww25TbVs5QONDTqzLK_arGiLeMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXyAQP_GYyHXJd7qq1ww25TbVs5QONDTqzLK_arGiLeMQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 10:07:39AM +0200, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Wed, Sep 12, 2018 at 3:56 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Aug 30, 2018 at 5:06 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > Commit 0a0e0829f990 ("nohz: Fix missing tick reprogram when interrupting an
> > > inline softirq") got backported to stable trees and now causes the NOHZ
> > > softirq pending warning to trigger. It's not an upstream issue as the NOHZ
> > > update logic has been changed there.
> > >
> > > The problem is when a softirq disabled section gets interrupted and on
> > > return from interrupt the tick/nohz state is evaluated, which then can
> > > observe pending soft interrupts. These soft interrupts are legitimately
> > > pending because they cannot be processed as long as soft interrupts are
> > > disabled and the interrupted code will correctly process them when soft
> > > interrupts are reenabled.
> > >
> > > Add a check for softirqs disabled to the pending check to prevent the
> > > warning.
> > >
> > > Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
> > > Reported-by: John Crispin <john@phrozen.org>
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>
> > > Tested-by: John Crispin <john@phrozen.org>
> > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > Cc: Ingo Molnar <mingo@kernel.org>
> > > Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: stable@vger.kernel.org
> >
> > Fixes: 2d898915ccf4838c ("nohz: Fix missing tick reprogram when
> > interrupting an inline softirq")
> >
> > Issue in v4.14.x bisected to the above commit, and fixed by your patch.
> >
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> This issue is still present in v4.14.72. Can you please apply Thomas' fix?

Oops, sorry for the delay, now queued up.

greg k-h
