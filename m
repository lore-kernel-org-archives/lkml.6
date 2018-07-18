Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FF0ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFFE20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 15:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFFE20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbeGRPwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:52:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:27294 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbeGRPwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:52:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2018 08:14:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,370,1526367600"; 
   d="scan'208";a="58668810"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 18 Jul 2018 08:14:04 -0700
Message-ID: <c10bb604a6bf416e2092ae64a2cb9bb4658ea0eb.camel@linux.intel.com>
Subject: Re: [PATCH v1 0/3] console, serial8250: Disable PM and DMA ops
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 Jul 2018 18:14:03 +0300
In-Reply-To: <20180523175859.GO98604@atomide.com>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
         <ca78895ac7ac84ec1c7f2f33024237af329ffd7a.camel@linux.intel.com>
         <20180516100842.xuma7b3e727w7bpz@linutronix.de>
         <CAHp75Vc2bJQHiWYcdKK+7wwMw2fSWxMauxP-dMRUAUdKnet7WQ@mail.gmail.com>
         <20180516104734.357oevogppu5bsg4@linutronix.de>
         <ed9879ef42a70d2609f60f73834cabb7e3df9e2f.camel@linux.intel.com>
         <20180517135621.GJ98604@atomide.com>
         <CAHp75VfqAK6+dPWWkQXjy0V-AFSGLSDJ9CmnUv=ba0F66TDTVg@mail.gmail.com>
         <20180517193008.GV25808@atomide.com>
         <CAHp75Ve56pyEC41XZ9i9yxBNberQe=ee2miQL0v9T4vRtkWPBQ@mail.gmail.com>
         <20180523175859.GO98604@atomide.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-23 at 10:58 -0700, Tony Lindgren wrote:
> * Andy Shevchenko <andy.shevchenko@gmail.com> [180522 21:42]:
> > On Thu, May 17, 2018 at 10:30 PM, Tony Lindgren <tony@atomide.com>
> > wrote:
> > > So how about add some "noidle" kernel command line parameter for
> > > console
> > > that calls
> > > pm_runtime_forbid() and then you have the UART permanently
> > > on.
> > 
> > IIUC _forbid() can be overwritten via sysfs.
> > And I would prefer to do other way around, something like
> > console.idle
> > and put default for OMAP to yes and no for everything else.
> 
> OK yeah console.idle sounds good to me. We should default to a
> safe option.

I'll see what we can do here.

> > > Hmm I guess you could make also serial8250_rpm_get() do nothing
> > > based on that.
> > 
> > Have you seen entire series which I keep here:
> > https://bitbucket.org/andy-shev/linux/branch/topic/uart/rpm?
> > Among other things it gets rid of those specific callbacks entirely.
> 
> Well I was not Cc:ed on it, I browsed it in some archive and it
> seemed unsafe to me. But if you figured out a way to do it
> conditionally
> based on console.idle
>  without causing regressions.

I restored that branch with some updated patches. It's far from done and
doesn't have any new stuff (yet) regrading to this discussion.

> > > I do agree the serial runtime PM has an issue if it depends on
> > > pm_runtime_irq_safe() being set.
> > 
> > It's more than an issue. The  so called "support" of RPM for UART is
> > _based on the hack_.
> > I would love to NAK that in the first place if I would have known of
> > it in time.
> 
> Hmm well it seems that you too have been patching the 8250_rpm
> functions for years and then now what after multiple years you
> hit this issue? :)

Nope, I hit it as soon as I tried.

I can't find easily the discussion (hmm... yes, I was so pissed off that
time, I put a bit of harsh in that) I had with Sebastian few years back,
but at least I reported about an issue.

> > > > So, I can, of course just remove callbacks from the console
> > > > ->write().
> > > > Though it will prevent to use kernel console anyway.
> > > 
> > > Please et's not start breaking things, we already see a constant
> > > flow of regressions on weekly basis.
> > 
> > Now we are stick with a hack and the case based on that is against
> > fixing things.
> > This is how it looks from my side.
> 
> Sorry yeah I agree there are issues, but let's fix it properly

Agree.

>  with
> no regressions.

...though I think a word "regression" is inappropriate here. Regression
is what the support did in the first place. Pity I didn't know about it
at that time.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
