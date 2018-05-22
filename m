Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752884AbeEVMJl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:09:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:33781 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751512AbeEVMJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:09:38 -0400
Date: Tue, 22 May 2018 14:09:36 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <uwe@kleine-koenig.org>
cc: Ales Novak <alnovak@suse.cz>, a.zummo@towertech.it,
        akpm@linux-foundation.org, rtc-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: rtc: fix chardev initialization races
In-Reply-To: <20180521122509.GA4251@taurus.defre.kleine-koenig.org>
Message-ID: <nycvar.YFH.7.76.1805221407100.27054@cbobk.fhfr.pm>
References: <1393410793-7315-1-git-send-email-alnovak@suse.cz> <20180521122509.GA4251@taurus.defre.kleine-koenig.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2018, Uwe Kleine-König wrote:

> > The race looks like that (thanks Jiri):
> > 
> > CPU0:                                CPU1:
> > sys_load_module()
> >  do_init_module()
> >   do_one_initcall()
> >    cmos_do_probe()
> >     rtc_device_register()
> >      __register_chrdev()
> >      cdev->owner = struct module*
> >                                      open("/dev/rtc0")
> >     rtc_device_unregister()
> >   module_put()
> >   free_module()
> >    module_free(mod->module_core)
> >    /* struct module *module is now
> >       freed */
> >                                       chrdev_open()
> >                                        spin_lock(cdev_lock)
> >                                        cdev_get()
> >                                         try_module_get()
> >                                          module_is_live()
> >                                          /* dereferences already
> >                                             freed struct module* */
> 
> [Context: For a patch to rtc-pcf2127.c Alexandre Belloni asked not to
> fail after rtc_device_register successfully finished and pointed to this
> reasoning as explaination.]
> 
> If there is really such a race then (I hope) there is
> something in the cdev code that needs fixing. According to my
> understanding, when rtc_device_unregister returned, the cdev is gone and
> so chrdev_open is supposed to fail.

Oh wow, hello back to 4 years ago!

Looking at the current code, I don't think there is no such race any more, 
as the last thing cmos_do_probe() -> __rtc_register_device() does that can 
potentially fail is the chardev creation itself.

IOW if it exists, it's guaranteed to not go away on a probe error handling 
path (and the rest is protected via ops_lock mutex).

-- 
Jiri Kosina
SUSE Labs
