Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE9CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 09:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A5F21726
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 09:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeLaJjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 04:39:33 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:59830 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeLaJjc (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 31 Dec 2018 04:39:32 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Mon, 31 Dec 2018 10:39:30 +0100
Received: from linux-l9pv.suse (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (TLS encrypted); Mon, 31 Dec 2018 09:39:04 +0000
Date:   Mon, 31 Dec 2018 17:38:51 +0800
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
Subject: Re: [PATCH 2/2] PM / Sleep: Check the file capability when writing
 wake lock interface
Message-ID: <20181231093851.GN3506@linux-l9pv.suse>
References: <20181230132856.24095-1-jlee@suse.com>
 <20181230132856.24095-3-jlee@suse.com>
 <20181230144835.GB18985@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181230144835.GB18985@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Sun, Dec 30, 2018 at 03:48:35PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Dec 30, 2018 at 09:28:56PM +0800, Lee, Chun-Yi wrote:
> > The wake lock/unlock sysfs interfaces check that the writer must has
> > CAP_BLOCK_SUSPEND capability. But the checking logic can be bypassed
> > by opening sysfs file within an unprivileged process and then writing
> > the file within a privileged process. The tricking way has been exposed
> > by Andy Lutomirski in CVE-2013-1959.
> 
> Don't you mean "open by privileged and then written by unprivileged?"
> Or if not, exactly how is this a problem?  You check the capabilities
> when you do the write and if that is not allowed then, well
>

Sorry for I didn't provide clear explanation.

The privileged means CAP_BLOCK_SUSPEND but not file permission. The file permission
has already relaxed for non-root user. Then the expected behavior is that non-root
process must has CAP_BLOCK_SUSPEND capability for writing wake_lock sysfs.

But, the CAP_BLOCK_SUSPEND restrict can be bypassed:

int main(int argc, char* argv[])
{
        int fd, ret = 0;

        fd = open("/sys/power/wake_lock", O_RDWR);
        if (fd < 0)
                err(1, "open wake_lock");

        if (dup2(fd, 1) != 1)	// overwrite the stdout with wake_lock
                err(1, "dup2");
        sleep(1);
        execl("./string", "string");	//string has capability

        return ret;
}

This program is an unpriviledged process (has no CAP_BLOCK_SUSPEND), it opened
wake_lock sysfs and overwrited stdout. Then it executes the "string" program
that has CAP_BLOCK_SUSPEND. The string program writes to stdout, which means
that it writes to wake_lock. So an unpriviledged opener can trick an priviledged
writer for writing sysfs.  
 
> And you are checking the namespace of the person trying to do the write
> when the write happens, which is correct here, right?
> 
> If you really want to mess with wake locks in a namespaced environment,
> then put it in a real namespaced environment, which is {HUGE HINT} not
> sysfs.
>

I don't want to mess with wake locks in namespace.
 
> So no, this patch isn't ok...
>

Thanks a lot!
Joey Lee 
