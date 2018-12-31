Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD35C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 09:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BAE2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 09:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbeLaJlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 04:41:32 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:50468 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbeLaJlb (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 31 Dec 2018 04:41:31 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Mon, 31 Dec 2018 10:41:29 +0100
Received: from linux-l9pv.suse (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Mon, 31 Dec 2018 09:41:16 +0000
Date:   Mon, 31 Dec 2018 17:41:05 +0800
From:   joeyli <jlee@suse.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 0/2] [RFC] sysfs: Add hook for checking the file
 capability of opener
Message-ID: <20181231094105.GO3506@linux-l9pv.suse>
References: <20181230132856.24095-1-jlee@suse.com>
 <20181230144506.GA18985@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181230144506.GA18985@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, 

Thanks for your review!

On Sun, Dec 30, 2018 at 03:45:06PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Dec 30, 2018 at 09:28:54PM +0800, Lee, Chun-Yi wrote:
> > There have some discussion in the following mail loop about checking
> > capability in sysfs write handler:
> >     https://lkml.org/lkml/2018/9/13/978
> 
> A sysfs callback should not care about stuff like this.
> 
> Worst case, do a simple:
> 	if (!capable(CAP_FOO))
> 		return -EPERM
> 
> you don't care or need to worry about the file handle for that at all,
> right?
>

The capable() can be bypassed. Unprivileged process may reads or writes
those sysfs if file permission be relaxed by root for non-root user.
 
> > Sometimes we check the capability in sysfs implementation by using
> > capable function.
> 
> Which should be fine, right?
>

If file permission is enough to restrict sysfs that can only be used
by root. Why do some sysfs interfaces use capable()? It's not
redundancy? 
 
> > But the checking can be bypassed by opening sysfs
> > file within an unprivileged process then writing the file within a
> > privileged process. The tricking way has been exposed by Andy Lutomirski
> > for CVE-2013-1959.
> 
> And who does this for a sysfs file?  And why?
>

Just want to bypass the capable() checking. 
 
> > Because the sysfs_ops does not forward the file descriptor to the
> > show/store callback, there doesn't have chance to check the capability
> > of file's opener.
> 
> Which is by design.  If you care about open, you are using sysfs wrong.
>

OK~ So the sysfs doesn't care opener's capability.
 
> > This patch adds the hook to sysfs_ops that allows
> > different implementation in object and attribute levels for checking
> > file capable before accessing sysfs interfaces.
> 
> No, please no.
>
> > The callback function of kobject sysfs_ops is the first implementation
> > of new hook. It casts attribute to kobj_attribute then calls the file
> > capability callback function of attribute level. The same logic can
> > be implemented in other sysfs file types, like: device, driver and
> > bus type. 
> > 
> > The capability checking logic in wake_lock/wake_unlock sysfs interface
> > is the first example for kobject. It will check the opener's capability.
> 
> Why doesn't the file permission of that sysfs file determine who can or
> can not write to that file?
>

I agree that the file permission can restrict the writer of sysfs. But,
I still confused for why do some sysfs interface use capable()?

Thanks a lot!
Joey Lee 
