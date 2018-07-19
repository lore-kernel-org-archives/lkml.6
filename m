Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567DEC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06714206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06714206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbeGSHcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 03:32:11 -0400
Received: from muru.com ([72.249.23.125]:52088 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727399AbeGSHcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 03:32:10 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 11E5C80BF;
        Thu, 19 Jul 2018 06:53:47 +0000 (UTC)
Date:   Wed, 18 Jul 2018 23:50:33 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 0/3] console, serial8250: Disable PM and DMA ops
Message-ID: <20180719065033.GK99251@atomide.com>
References: <ca78895ac7ac84ec1c7f2f33024237af329ffd7a.camel@linux.intel.com>
 <20180516100842.xuma7b3e727w7bpz@linutronix.de>
 <CAHp75Vc2bJQHiWYcdKK+7wwMw2fSWxMauxP-dMRUAUdKnet7WQ@mail.gmail.com>
 <20180516104734.357oevogppu5bsg4@linutronix.de>
 <20180517134820.GI98604@atomide.com>
 <CAHp75Veb+zBfh=44qmMevvrfCSRYhfUMJUMArsDBtgM-F_FknQ@mail.gmail.com>
 <20180517194834.GW25808@atomide.com>
 <CAHp75Vf7L3zsSgaj1vfoyNKdPo0w6Nu+mW5HuM97SKAK-1y2Pg@mail.gmail.com>
 <20180523180052.GP98604@atomide.com>
 <9bc02408588716c4ddb5a2ffb7d915019433fedc.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bc02408588716c4ddb5a2ffb7d915019433fedc.camel@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [180718 14:54]:
> On Wed, 2018-05-23 at 11:00 -0700, Tony Lindgren wrote:
> > I thought you said earlier the issue was that you wanted to keep
> > the console enabled all the time and never idle?
> 
> Yes, for kernel console.
> To be clear, if user supplies "console=ttySx" it keeps powered on
> always. But if there is no such parameter, we are fine with RPM.

I'm fine with that as long as we have a way to detach or disable
kernel console from userspace after booting so the console uart can
idle.

> Letting kernel console do power management on the systems without
> irq_safe hack is dangerous in terms of loosing important data (crash, or
> some other stuff which needs atomic context: kgdb?).

Yes in the long run we should get rid of all pm_runtime_irq_safe()
use. It increases the parent dev PM runtime usage count permanently
blocking the whole domain from idling.

Regards,

Tony
