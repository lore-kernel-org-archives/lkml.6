Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3DFC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CB120867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CB120867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbeIYWRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:17:55 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:32911 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbeIYWRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:17:55 -0400
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id EB8AA63149;
        Tue, 25 Sep 2018 16:09:43 +0000 (UTC)
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id 2BBA2B2;
        Tue, 25 Sep 2018 16:09:43 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (anatevka.americas.hpqcorp.net [10.34.81.6])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 7CC9049;
        Tue, 25 Sep 2018 16:09:42 +0000 (UTC)
Date:   Tue, 25 Sep 2018 10:09:42 -0600
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     erosca@de.adit-jv.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: watchdog: Add gettimeout and get|set
 pretimeout
Message-ID: <20180925160942.GA25620@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <1537570526-65241-1-git-send-email-jerry.hoemann@hpe.com>
 <0c6376ec-a3f4-7798-8f30-829480c41f79@kernel.org>
 <20180924014750.GA22296@anatevka.americas.hpqcorp.net>
 <1c4e6b40-dc4e-5706-0a31-1741ba19ca09@kernel.org>
 <f8616e56-004a-e296-0f84-8ebd019ad027@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8616e56-004a-e296-0f84-8ebd019ad027@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 09:50:18AM -0600, Shuah Khan wrote:
> >>> Also can you run this test as normal user?
> >>
> >> No.  Must be run as root to open /dev/watchdog.  When /dev/watchdog is opened, the
> >> WD is started and if not updated properly, the system will crash.
> > 
> > Hmm. I don't understand why the system would panic if non-root user can't open the
> > device, at least in the context of this test. 
> > 
> >         fd = open("/dev/watchdog", O_WRONLY);
> > 
> >         if (fd == -1) {
> >                 printf("Watchdog device not enabled.\n");
> >                 exit(-1);
> >         }
> > 
> > 
> > Shouldn't it just exit based on the code above?
> > 
> >>
> > 
> >> "cat /dev/watchdog" is one of my favorite ways to crash a system.  :)  :)
> > 
> > That doesn't sound great, if a non-root user can bring the system down!!
> >  
> 
> This got me concerned enough that I tried this with softdog. It behaved just
> the way I expected it.
> 
> cat /dev/watchdog
> cat: /dev/watchdog: Permission denied
> 
> Running the test as non-root does the following as per the current logic.
> 
> watchdog-test -b
> Watchdog device not enabled.
> 
> I think this logic could be improved to detect that a non-root user is running
> the test and print appropriate message.
> 
> However, I am not seeing the behavior you are describing that "cat /dev/watchdog"
> panics the syste. Did you mean running a root which is expected unless you terminate
> before the timeout? If you are seeing this as non-root user on you system, the
> watchdog driver could be suspect.
> 
> thanks,
> -- Shuah

Sorry, for misunderstanding.  Let me rephrase:

When you asked if the test can be run as a normal user::

No.  The test must be run as root to open /dev/watchdog as the permission
on /dev/watchdog allow only root to open it.  The reason that we only
allow root to open /dev/watchdog is that it is trivial to crash
the system.  Just open /dev/watchdog and don't update the watchdog.

One of my favorite ways to crash the system is to
as root "cat /dev/watchdog."




-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
