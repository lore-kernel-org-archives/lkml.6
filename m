Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7207BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF972073D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EF972073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeIEC3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 22:29:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:55091 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbeIEC3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 22:29:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B8E652072C; Wed,  5 Sep 2018 00:02:18 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8BC7F208AF;
        Wed,  5 Sep 2018 00:02:08 +0200 (CEST)
Date:   Wed, 5 Sep 2018 00:02:07 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Ales Novak <alnovak@suse.cz>,
        a.zummo@towertech.it, akpm@linux-foundation.org,
        rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: rtc: fix chardev initialization races
Message-ID: <20180904220207.GK13888@piout.net>
References: <1393410793-7315-1-git-send-email-alnovak@suse.cz>
 <20180521122509.GA4251@taurus.defre.kleine-koenig.org>
 <nycvar.YFH.7.76.1805221407100.27054@cbobk.fhfr.pm>
 <20180522133955.jrqijs7xj3cz2lr4@pengutronix.de>
 <nycvar.YFH.7.76.1805221726300.27054@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.YFH.7.76.1805221726300.27054@cbobk.fhfr.pm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2018 17:33:40+0200, Jiri Kosina wrote:
> On Tue, 22 May 2018, Uwe Kleine-König wrote:
> > [adding linux-rtc ML and Alexandre to Cc:]
> > 
> > Hello,
> > 
> > On Tue, May 22, 2018 at 02:09:36PM +0200, Jiri Kosina wrote:
> > > On Mon, 21 May 2018, Uwe Kleine-König wrote:
> > > 
> > > > > The race looks like that (thanks Jiri):
> > > > > 
> > > > > CPU0:                                CPU1:
> > > > > sys_load_module()
> > > > >  do_init_module()
> > > > >   do_one_initcall()
> > > > >    cmos_do_probe()
> > > > >     rtc_device_register()
> > > > >      __register_chrdev()
> > > > >      cdev->owner = struct module*
> > > > >                                      open("/dev/rtc0")
> > > > >     rtc_device_unregister()
> > > > >   module_put()
> > > > >   free_module()
> > > > >    module_free(mod->module_core)
> > > > >    /* struct module *module is now
> > > > >       freed */
> > > > >                                       chrdev_open()
> > > > >                                        spin_lock(cdev_lock)
> > > > >                                        cdev_get()
> > > > >                                         try_module_get()
> > > > >                                          module_is_live()
> > > > >                                          /* dereferences already
> > > > >                                             freed struct module* */
> > > > 
> > > > [Context: For a patch to rtc-pcf2127.c Alexandre Belloni asked not to
> > > > fail after rtc_device_register successfully finished and pointed to this
> > > > reasoning as explaination.]
> > > > 
> > > > If there is really such a race then (I hope) there is
> > > > something in the cdev code that needs fixing. According to my
> > > > understanding, when rtc_device_unregister returned, the cdev is gone and
> > > > so chrdev_open is supposed to fail.
> > > 
> > > Oh wow, hello back to 4 years ago!
> > 
> > :-)
> > 
> 
> > > Looking at the current code, I don't think there is no such race any more, 
> > > as the last thing cmos_do_probe() -> __rtc_register_device() does that can 
> > > potentially fail is the chardev creation itself.
> > 
> > OK, so you agree that it's also save to do something in a driver's probe
> > after rtc_device_register() and call rtc_device_unregister() in the error
> > path, right? 
> 
> Hmm, not really; that's what the code apparently did 4 years ago (judging 
> from the scenario in the old mail, I of course forgot all the details), 
> but doesn't do it any more.
> 
> Looking at the current code, if you call rtc_device_unregister() in the 
> probe path, where is the guarantee that cdev_get() will not derefernce 
> already freed struct module*?
> 

I've also tried to produce it and couldn't. The whole magic happens in
kobj_lookup. Freeing the module before ends up with the application
opening the char dev getting -ENXIO. Freeing the module after
kobj_lookup is not possible and ends up with -EBUSY.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
