Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbeEVPdy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:33:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:51492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751196AbeEVPdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:33:44 -0400
Date: Tue, 22 May 2018 17:33:40 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
cc: Ales Novak <alnovak@suse.cz>, a.zummo@towertech.it,
        akpm@linux-foundation.org, rtc-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: rtc: fix chardev initialization races
In-Reply-To: <20180522133955.jrqijs7xj3cz2lr4@pengutronix.de>
Message-ID: <nycvar.YFH.7.76.1805221726300.27054@cbobk.fhfr.pm>
References: <1393410793-7315-1-git-send-email-alnovak@suse.cz> <20180521122509.GA4251@taurus.defre.kleine-koenig.org> <nycvar.YFH.7.76.1805221407100.27054@cbobk.fhfr.pm> <20180522133955.jrqijs7xj3cz2lr4@pengutronix.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 May 2018, Uwe Kleine-König wrote:
> [adding linux-rtc ML and Alexandre to Cc:]
> 
> Hello,
> 
> On Tue, May 22, 2018 at 02:09:36PM +0200, Jiri Kosina wrote:
> > On Mon, 21 May 2018, Uwe Kleine-König wrote:
> > 
> > > > The race looks like that (thanks Jiri):
> > > > 
> > > > CPU0:                                CPU1:
> > > > sys_load_module()
> > > >  do_init_module()
> > > >   do_one_initcall()
> > > >    cmos_do_probe()
> > > >     rtc_device_register()
> > > >      __register_chrdev()
> > > >      cdev->owner = struct module*
> > > >                                      open("/dev/rtc0")
> > > >     rtc_device_unregister()
> > > >   module_put()
> > > >   free_module()
> > > >    module_free(mod->module_core)
> > > >    /* struct module *module is now
> > > >       freed */
> > > >                                       chrdev_open()
> > > >                                        spin_lock(cdev_lock)
> > > >                                        cdev_get()
> > > >                                         try_module_get()
> > > >                                          module_is_live()
> > > >                                          /* dereferences already
> > > >                                             freed struct module* */
> > > 
> > > [Context: For a patch to rtc-pcf2127.c Alexandre Belloni asked not to
> > > fail after rtc_device_register successfully finished and pointed to this
> > > reasoning as explaination.]
> > > 
> > > If there is really such a race then (I hope) there is
> > > something in the cdev code that needs fixing. According to my
> > > understanding, when rtc_device_unregister returned, the cdev is gone and
> > > so chrdev_open is supposed to fail.
> > 
> > Oh wow, hello back to 4 years ago!
> 
> :-)
> 

> > Looking at the current code, I don't think there is no such race any more, 
> > as the last thing cmos_do_probe() -> __rtc_register_device() does that can 
> > potentially fail is the chardev creation itself.
> 
> OK, so you agree that it's also save to do something in a driver's probe
> after rtc_device_register() and call rtc_device_unregister() in the error
> path, right? 

Hmm, not really; that's what the code apparently did 4 years ago (judging 
from the scenario in the old mail, I of course forgot all the details), 
but doesn't do it any more.

Looking at the current code, if you call rtc_device_unregister() in the 
probe path, where is the guarantee that cdev_get() will not derefernce 
already freed struct module*?

Thanks,

-- 
Jiri Kosina
SUSE Labs
