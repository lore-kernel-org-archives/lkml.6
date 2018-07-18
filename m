Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F2BECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C38B2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:51:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C38B2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbeGRP3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:29:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:63821 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730987AbeGRP3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:29:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2018 07:50:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,370,1526367600"; 
   d="scan'208";a="58662792"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga006.jf.intel.com with ESMTP; 18 Jul 2018 07:50:56 -0700
Message-ID: <9bc02408588716c4ddb5a2ffb7d915019433fedc.camel@linux.intel.com>
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
Date:   Wed, 18 Jul 2018 17:50:55 +0300
In-Reply-To: <20180523180052.GP98604@atomide.com>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
         <ca78895ac7ac84ec1c7f2f33024237af329ffd7a.camel@linux.intel.com>
         <20180516100842.xuma7b3e727w7bpz@linutronix.de>
         <CAHp75Vc2bJQHiWYcdKK+7wwMw2fSWxMauxP-dMRUAUdKnet7WQ@mail.gmail.com>
         <20180516104734.357oevogppu5bsg4@linutronix.de>
         <20180517134820.GI98604@atomide.com>
         <CAHp75Veb+zBfh=44qmMevvrfCSRYhfUMJUMArsDBtgM-F_FknQ@mail.gmail.com>
         <20180517194834.GW25808@atomide.com>
         <CAHp75Vf7L3zsSgaj1vfoyNKdPo0w6Nu+mW5HuM97SKAK-1y2Pg@mail.gmail.com>
         <20180523180052.GP98604@atomide.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-23 at 11:00 -0700, Tony Lindgren wrote:
> * Andy Shevchenko <andy.shevchenko@gmail.com> [180522 21:54]:
> > On Thu, May 17, 2018 at 10:48 PM, Tony Lindgren <tony@atomide.com>
> > wrote:
> > > * Andy Shevchenko <andy.shevchenko@gmail.com> [180517 16:38]:
> > > > On Thu, May 17, 2018 at 4:48 PM, Tony Lindgren <tony@atomide.com
> > > > > wrote:
> > > > > * Sebastian Andrzej Siewior <bigeasy@linutronix.de> [180516
> > > > > 10:49]:
> > > > > The idea breaking PM seems silly to me considering that we've
> > > > > had
> > > > > it working for years already.
> > > > 
> > > > Same question  / note. World is much more complex than just
> > > > being OMAP.
> > > 
> > > Sorry but you are making assumptions about hardware being powered
> > > on
> > > all the time.
> > 
> > Nope, other way around. The so called "support" _prevents_ our
> > hardware to go to sleep.
> 
> Hmm sorry now I'm all confused what issues you're having.
> 
> I thought you said earlier the issue was that you wanted to keep
> the console enabled all the time and never idle?

Yes, for kernel console.
To be clear, if user supplies "console=ttySx" it keeps powered on
always. But if there is no such parameter, we are fine with RPM.

Letting kernel console do power management on the systems without
irq_safe hack is dangerous in terms of loosing important data (crash, or
some other stuff which needs atomic context: kgdb?).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
