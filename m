Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16403C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12D82156B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12D82156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeHBViQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:38:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33782 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeHBViP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:38:15 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 39F6BC8A;
        Thu,  2 Aug 2018 19:45:40 +0000 (UTC)
Date:   Thu, 2 Aug 2018 21:45:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/246] 4.14.60-stable review
Message-ID: <20180802194536.GA22671@kroah.com>
References: <20180801165011.700991984@linuxfoundation.org>
 <20180802154325.GB5137@roeck-us.net>
 <20180802182517.GA24531@roeck-us.net>
 <20180802190946.GA25832@roeck-us.net>
 <20180802194135.GA13901@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802194135.GA13901@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 09:41:35PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Aug 02, 2018 at 12:09:46PM -0700, Guenter Roeck wrote:
> > On Thu, Aug 02, 2018 at 11:25:17AM -0700, Guenter Roeck wrote:
> > > On Thu, Aug 02, 2018 at 08:43:25AM -0700, Guenter Roeck wrote:
> > > > On Wed, Aug 01, 2018 at 06:48:30PM +0200, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 4.14.60 release.
> > > > > There are 246 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > > 
> > > > > Responses should be made by Fri Aug  3 16:49:18 UTC 2018.
> > > > > Anything received after that time might be too late.
> > > > > 
> > > > 
> > > > Build results:
> > > > 	total: 148 pass: 148 fail: 0
> > > > Qemu test results:
> > > > 	total: 198 pass: 198 fail: 0
> > > > 
> > > > Details are available at http://kerneltests.org/builders/.
> > > > 
> > > 
> > > I spoke too early. parisc images crash after adding some configuration
> > > options. I don't see the crash with v4.14.59. I'll send another update
> > > later after figuring out what is going on.
> > > 
> > 
> > The patch causing the problem is commit 27608f359da88eaf ("fasync: Fix deadlock
> > between task-context and interrupt-context kill_fasync()"), see bisect log
> > below.
> > 
> > Kernel log message is as follows.
> > 
> > PDC_CHASSIS: Fault (1), CHASSIS  0
> > Backtrace:
> >  [<10267738>] dput.part.5+0x1dc/0x1f0
> >  [<1026776c>] dput+0x20/0x30
> >  [<1024f79c>] __fput+0x14c/0x230
> >  [<1024f8e4>] ____fput+0x18/0x28
> >  [<1019abe0>] task_work_run+0xa4/0xd8
> >  [<1016d044>] do_notify_resume+0x7c/0x84
> >  [<1015c258>] syscall_do_signal+0x50/0x9c
> > 
> > The problem only affects v4.14.60-rc1; all other stable releases and release
> > candidates are fine.
> 
> That is really odd as that commit is also in the 4.17 and 4.9 -rc
> releases.
> 
> I'll go drop it from all queues just to be safe, odds are something in
> that backport isn't correct.
> 
> thanks for the testing and bisection, much appreciated.

I've pushed out -rc2 releases for all of these with that patch removed.

thanks,

greg k-h
