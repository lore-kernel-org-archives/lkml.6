Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07959C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5329217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 12:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550578750;
	bh=rhp0tL21cRIxcBhxTt3aCrKDczKZ5oqAqZa92OHkjj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ErdYk8XehF5yBfoju5wHCCZyGSsufRcUnsMoVS91MjSH/Xqgl5pMDK5WQllD39BpF
	 ML5HorTa9oHUdyUFkap+MWObns27/vlR9OQbnoM51CQRLi9NgZ+pwTIlllvT7ZjhLa
	 uVldEy+NYyq9C/s0D37ZCUaRfPGTFoJIgXtkJRj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfBSMTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 07:19:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfBSMTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 07:19:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2C83217D7;
        Tue, 19 Feb 2019 12:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550578747;
        bh=rhp0tL21cRIxcBhxTt3aCrKDczKZ5oqAqZa92OHkjj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hL41tv+/TVcEoLwqKKK3pNu4yVbAVS1sbASCeN10pANzTNZe9ynMthb4vNTja31fP
         EIVgjxn7YF+MaVB2b3l1UMxbPtTgo6N68P5UUPMXRdP01qmWu4B6G1tR+iaUogTy6v
         sMm5NtmnEj0rchITNWKqpLMxIJdKZyy6zlCWraLw=
Date:   Tue, 19 Feb 2019 13:19:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
Subject: Re: [LKP] [driver core]  570d020012: will-it-scale.per_thread_ops
 -12.2% regression
Message-ID: <20190219121904.GA24103@kroah.com>
References: <20190218075442.GI29177@shao2-debian>
 <20190219005945.GA16734@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219005945.GA16734@richard>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 08:59:45AM +0800, Wei Yang wrote:
> On Mon, Feb 18, 2019 at 03:54:42PM +0800, kernel test robot wrote:
> >Greeting,
> >
> >FYI, we noticed a -12.2% regression of will-it-scale.per_thread_ops due to commit:
> >
> >
> >commit: 570d0200123fb4f809aa2f6226e93a458d664d70 ("driver core: move device->knode_class to device_private")
> >https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >
> 
> This is interesting.
> 
> I didn't expect the move of this field will impact the performance.
> 
> The reason is struct device is a hotter memory than device->device_private?
> 
> >in testcase: will-it-scale
> >on test machine: 288 threads Knights Mill with 80G memory
> >with following parameters:
> >
> >	nr_task: 100%
> >	mode: thread
> >	test: unlink2
> >	cpufreq_governor: performance
> >
> >test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> >test-url: https://github.com/antonblanchard/will-it-scale
> >
> >In addition to that, the commit also has significant impact on the following tests:
> >
> >+------------------+---------------------------------------------------------------+
> >| testcase: change | will-it-scale: will-it-scale.per_thread_ops -29.9% regression |
> >| test machine     | 288 threads Knights Mill with 80G memory                      |
> >| test parameters  | cpufreq_governor=performance                                  |
> >|                  | mode=thread                                                   |
> >|                  | nr_task=100%                                                  |
> >|                  | test=signal1                                                  |

Ok, I'm going to blame your testing system, or something here, and not
the above patch.

All this test does is call raise(3).  That does not touch the driver
core at all.

> >+------------------+---------------------------------------------------------------+
> >| testcase: change | will-it-scale: will-it-scale.per_thread_ops -16.5% regression |
> >| test machine     | 288 threads Knights Mill with 80G memory                      |
> >| test parameters  | cpufreq_governor=performance                                  |
> >|                  | mode=thread                                                   |
> >|                  | nr_task=100%                                                  |
> >|                  | test=open1                                                    |
> >+------------------+---------------------------------------------------------------+

Same here, open1 just calls open/close a lot.  No driver core
interaction at all there either.

So are you _sure_ this is the offending patch?

thanks,

greg k-h
