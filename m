Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0ECC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 10:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071CB218AF
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 10:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546252861;
	bh=xc5/gIvNxDnpj64JC6uK7YnQwnhqe1oLUCct72yCcCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NSS6QFcpZ5Q0SH2SAPr20hrUfwj6FPidMNzvW8otudIEgStKSRIq0DXrPGtZu0ikI
	 PRU7dgUjYGhDJhXyMn0BzceQqeHFygAb78yQxZFd2eMfEfEncskJ/QzrfVlBSkOjnP
	 iIOS2W+9Jgc0Al/HKyOGLxl1QeXXmcI4oYgPbpvo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeLaKlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 05:41:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:43408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbeLaKk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 05:40:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A727F21019;
        Mon, 31 Dec 2018 10:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546252858;
        bh=xc5/gIvNxDnpj64JC6uK7YnQwnhqe1oLUCct72yCcCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0oPQlDWAp3ETW9bL5hWEzELj1Ma2axb1y0WGq53Eqii6K5bcMTEsycMAt4PFgridz
         kIQr/8paMRdnJ9GoS+g2RGyP0tf1t1Afc5/hTAiEmoRp6SVyYyr9TcVtUIJ2MWmYzO
         RuvL7ZQOE1VZv7owM6wps+g6oAqesXKzhfb7IsGo=
Date:   Mon, 31 Dec 2018 11:40:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     joeyli <jlee@suse.com>
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
Subject: Re: [PATCH 2/2] PM / Sleep: Check the file capability when writing
 wake lock interface
Message-ID: <20181231104055.GB27420@kroah.com>
References: <20181230132856.24095-1-jlee@suse.com>
 <20181230132856.24095-3-jlee@suse.com>
 <20181230144835.GB18985@kroah.com>
 <20181231093851.GN3506@linux-l9pv.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181231093851.GN3506@linux-l9pv.suse>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 05:38:51PM +0800, joeyli wrote:
> Hi Greg,
> 
> On Sun, Dec 30, 2018 at 03:48:35PM +0100, Greg Kroah-Hartman wrote:
> > On Sun, Dec 30, 2018 at 09:28:56PM +0800, Lee, Chun-Yi wrote:
> > > The wake lock/unlock sysfs interfaces check that the writer must has
> > > CAP_BLOCK_SUSPEND capability. But the checking logic can be bypassed
> > > by opening sysfs file within an unprivileged process and then writing
> > > the file within a privileged process. The tricking way has been exposed
> > > by Andy Lutomirski in CVE-2013-1959.
> > 
> > Don't you mean "open by privileged and then written by unprivileged?"
> > Or if not, exactly how is this a problem?  You check the capabilities
> > when you do the write and if that is not allowed then, well
> >
> 
> Sorry for I didn't provide clear explanation.
> 
> The privileged means CAP_BLOCK_SUSPEND but not file permission. The file permission
> has already relaxed for non-root user. Then the expected behavior is that non-root
> process must has CAP_BLOCK_SUSPEND capability for writing wake_lock sysfs.
> 
> But, the CAP_BLOCK_SUSPEND restrict can be bypassed:
> 
> int main(int argc, char* argv[])
> {
>         int fd, ret = 0;
> 
>         fd = open("/sys/power/wake_lock", O_RDWR);
>         if (fd < 0)
>                 err(1, "open wake_lock");
> 
>         if (dup2(fd, 1) != 1)	// overwrite the stdout with wake_lock
>                 err(1, "dup2");
>         sleep(1);
>         execl("./string", "string");	//string has capability
> 
>         return ret;
> }
> 
> This program is an unpriviledged process (has no CAP_BLOCK_SUSPEND), it opened
> wake_lock sysfs and overwrited stdout. Then it executes the "string" program
> that has CAP_BLOCK_SUSPEND.

That's the problem right there, do not give CAP_BLOCK_SUSPEND rights to
"string".  If any user can run that program, there's nothing the kernel
can do about this, right?  Just don't allow that program on the system :)

> The string program writes to stdout, which means that it writes to
> wake_lock. So an unpriviledged opener can trick an priviledged writer
> for writing sysfs.  

That sounds like a userspace program that was somehow given incorrect
rights by the admin, and a user is taking advantage of it.  That's not
the kernel's fault.

> > And you are checking the namespace of the person trying to do the write
> > when the write happens, which is correct here, right?
> > 
> > If you really want to mess with wake locks in a namespaced environment,
> > then put it in a real namespaced environment, which is {HUGE HINT} not
> > sysfs.
> >
> 
> I don't want to mess with wake locks in namespace.

Neither do I :)

so all should be fine, don't allow crazy executables with odd
permissions to be run by any user and you should be fine.  That's always
been the case, right?

thanks,

greg k-h
