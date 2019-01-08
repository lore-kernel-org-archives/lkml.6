Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DDCC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08482089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfAHKBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:01:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:58350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727367AbfAHKBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:01:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 49423B0DD;
        Tue,  8 Jan 2019 10:01:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 698531E157A; Tue,  8 Jan 2019 11:01:28 +0100 (CET)
Date:   Tue, 8 Jan 2019 11:01:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Orion Poplawski <orion@nwra.com>
Cc:     linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org, Vivek Trivedi <t.vivek@samsung.com>,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH] fanotify: allow freeze on suspend when waiting for
 response from userspace
Message-ID: <20190108100128.GB8076@quack2.suse.cz>
References: <c1bb16b7-9eee-9cea-2c96-a512d8b3b9c7@nwra.com>
 <dfcfb136-7030-86d8-9462-f5ab96051009@nwra.com>
 <41fc7839-f2f1-22d8-b038-5f5ed577ac3b@nwra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41fc7839-f2f1-22d8-b038-5f5ed577ac3b@nwra.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 29-12-18 21:00:28, Orion Poplawski wrote:
> On 12/29/18 3:34 PM, Orion Poplawski wrote:
> > On 12/29/18 3:04 PM, Orion Poplawski wrote:
> > > > On Thu 22-02-18 15:14:54, Kunal Shubham wrote:
> > > > > >> On Fri 16-02-18 15:14:40, t.vivek@samsung.com wrote:
> > > > > >> From: Vivek Trivedi <t.vivek@samsung.com>
> > > > > >> >> If fanotify userspace response server thread is frozen first,
> > > > > >> it may fail to send response from userspace to kernel
> > > > > space listener.
> > > > > >> In this scenario, fanotify response listener will never get response
> > > > > >> from userepace and fail to suspend.
> > > > > >> >> Use freeze-friendly wait API to handle this issue.
> > > > > >> >> Same problem was reported here:
> > > > > >> https://bbs.archlinux.org/viewtopic.php?id=232270
> > > > > >> >> Freezing of tasks failed after 20.005 seconds
> > > > > >> (1 tasks refusing to freeze, wq_busy=0)
> > > > > >> >> Backtrace:
> > > > > >> [<c0582f80>] (__schedule) from [<c05835d0>] (schedule+0x4c/0xa4)
> > > > > >> [<c0583584>] (schedule) from [<c01cb648>]
> > > > > (fanotify_handle_event+0x1c8/0x218)
> > > > > >> [<c01cb480>] (fanotify_handle_event) from [<c01c8238>]
> > > > > (fsnotify+0x17c/0x38c)
> > > > > >> [<c01c80bc>] (fsnotify) from [<c02676dc>]
> > > > > (security_file_open+0x88/0x8c)
> > > > > >> [<c0267654>] (security_file_open) from [<c01854b0>]
> > > > > (do_dentry_open+0xc0/0x338)
> > > > > >> [<c01853f0>] (do_dentry_open) from [<c0185a38>] (vfs_open+0x54/0x58)
> > > > > >> [<c01859e4>] (vfs_open) from [<c0195480>]
> > > > > (do_last.isra.10+0x45c/0xcf8)
> > > > > >> [<c0195024>] (do_last.isra.10) from [<c0196140>]
> > > > > (path_openat+0x424/0x600)
> > > > > >> [<c0195d1c>] (path_openat) from [<c0197498>]
> > > > > (do_filp_open+0x3c/0x98)
> > > > > >> [<c019745c>] (do_filp_open) from [<c0186b44>]
> > > > > (do_sys_open+0x120/0x1e4)
> > > > > >> [<c0186a24>] (do_sys_open) from [<c0186c30>] (SyS_open+0x28/0x2c)
> > > > > >> [<c0186c08>] (SyS_open) from [<c0010200>]
> > > > > (__sys_trace_return+0x0/0x20)
> > > > > >
> > > > > > Yeah, good catch.
> > > > > >
> > > > > >> @@ -63,7 +64,9 @@ static int fanotify_get_response(struct
> > > > > fsnotify_group *group,
> > > > > >> >>      pr_debug("%s: group=%p event=%p\n", __func__, group, event);
> > > > > >> >> -    wait_event(group->fanotify_data.access_waitq,
> > > > > event->response);
> > > > > >> +    while (!event->response)
> > > > > >> +        wait_event_freezable(group->fanotify_data.access_waitq,
> > > > > >> +                     event->response);
> > > > > >
> > > > > > But if the process gets a signal while waiting, we will
> > > > > just livelock the
> > > > > > kernel in this loop as wait_event_freezable() will keep returning
> > > > > > ERESTARTSYS. So you need to be a bit more clever here...
> > > > > 
> > > > > Hi Jack,
> > > > > Thanks for the quick review.
> > > > > To avoid livelock issue, is it fine to use below change? If
> > > > > agree, I will send v2 patch.
> > > > > 
> > > > > @@ -63,7 +64,11 @@ static int fanotify_get_response(struct
> > > > > fsnotify_group *group,
> > > > > 
> > > > >         pr_debug("%s: group=%p event=%p\n", __func__, group, event);
> > > > > 
> > > > > -       wait_event(group->fanotify_data.access_waitq, event->response);
> > > > > +       while (!event->response) {
> > > > > +               if
> > > > > (wait_event_freezable(group->fanotify_data.access_waitq,
> > > > > +                                       event->response))
> > > > > +                       flush_signals(current);
> > > > > +       }
> > > > 
> > > > Hum, I don't think this is correct either as this way if any signal was
> > > > delivered while waiting for fanotify response, we'd just lose it while
> > > > previously it has been properly handled. So what I think needs
> > > > to be done
> > > > is that we just use wait_event_freezable() and propagate non-zero return
> > > > value (-ERESTARTSYS) up to the caller to handle the signal and
> > > > restart the
> > > > syscall as necessary.
> > > > 
> > > >                                 Honza
> > > > -- 
> > > > Jan Kara <jack@suse.com>
> > > > SUSE Labs, CR
> > > 
> > > Is there any progress here?  This has become a real pain for us
> > > while running BitDefender on EL7 laptops.  I tried applying the
> > > following to the EL7 kernel:
> > > 
> > > diff -up
> > > linux-3.10.0-957.1.3.el7.x86_64/fs/notify/fanotify/fanotify.c.orig kernel-3.10.0-957.1.3.el7/linux-3.10.0-957.1.3.el7.x86_64/fs/notify/fanotify/fanotify.c
> > > 
> > > ---
> > > linux-3.10.0-957.1.3.el7.x86_64/fs/notify/fanotify/fanotify.c.orig
> > > 2018-11-15 10:07:13.000000000 -0700
> > > +++ linux-3.10.0-957.1.3.el7.x86_64/fs/notify/fanotify/fanotify.c
> > > 2018-12-28 15:44:26.452895337 -0700
> > > @@ -9,6 +9,7 @@
> > >   #include <linux/types.h>
> > >   #include <linux/wait.h>
> > >   #include <linux/audit.h>
> > > +#include <linux/freezer.h>
> > > 
> > >   #include "fanotify.h"
> > > 
> > > @@ -64,7 +65,12 @@ static int fanotify_get_response(struct
> > > 
> > >          pr_debug("%s: group=%p event=%p\n", __func__, group, event);
> > > 
> > > -       wait_event(group->fanotify_data.access_waitq, event->response);
> > > +       while (!event->response) {
> > > +               ret =
> > > wait_event_freezable(group->fanotify_data.access_waitq,
> > > +                                          event->response);
> > > +               if (ret < 0)
> > > +                       return ret;
> > > +       }
> > > 
> > >          /* userspace responded, convert to something usable */
> > >          switch (event->response & ~FAN_AUDIT) {
> > > 
> > > but I get a kernel panic shortly after logging in to the system.
> > > 
> 
> I tried a slightly different patch to see if setting event->response = 0
> helps and to confirm the return value of wait_event_freezable:
> 
> --- linux-3.10.0-957.1.3.el7/fs/notify/fanotify/fanotify.c 2018-11-15
> 10:07:13.000000000 -0700
> +++ linux-3.10.0-957.1.3.el7.fanotify.x86_64/fs/notify/fanotify/fanotify.c
> 2018-12-29 16:05:53.451125868 -0700
> @@ -9,6 +9,7 @@
>  #include <linux/types.h>
>  #include <linux/wait.h>
>  #include <linux/audit.h>
> +#include <linux/freezer.h>
> 
>  #include "fanotify.h"
> 
> @@ -64,7 +65,15 @@
> 
>         pr_debug("%s: group=%p event=%p\n", __func__, group, event);
> 
> -       wait_event(group->fanotify_data.access_waitq, event->response);
> +       while (!event->response) {
> +               ret =
> wait_event_freezable(group->fanotify_data.access_waitq,
> +                                          event->response);
> +               if (ret < 0) {
> +                       pr_debug("%s: group=%p event=%p about to return
> ret=%d\n", __func__,
> +                                group, event, ret);
> +                       goto finish;
> +               }
> +       }
> 
>         /* userspace responded, convert to something usable */
>         switch (event->response & ~FAN_AUDIT) {
> @@ -75,7 +84,7 @@
>         default:
>                 ret = -EPERM;
>         }
> -
> +finish:
>         /* Check if the response should be audited */
>         if (event->response & FAN_AUDIT)
>                 audit_fanotify(event->response & ~FAN_AUDIT);
> 
> 
> and I enabled the pr_debug.  This does indeed trigger the panic:
> 
> 
> [ 4181.113781] fanotify_get_response: group=ffff9e3af9952b00
> event=ffff9e3aea426c80 about to return ret=-512
> [ 4181.113788] ------------[ cut here ]------------
> [ 4181.113804] WARNING: CPU: 0 PID: 24290 at fs/notify/notification.c:84
> fsnotify_destroy_event+0x6b/0x70
> 
> So it appears that the notify system cannot handle simply passing
> -ERESTARTSYS back up the stack here.

Yeah, the solution needs to be more involved than this and I didn't get to
it so far. I'll have a look now if I can come up with something usable...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
