Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AF6C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 09:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD0120834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 09:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFD0120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbeLAVIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 16:08:37 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49142 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbeLAVIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 16:08:37 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 21FC520741; Sat,  1 Dec 2018 10:56:27 +0100 (CET)
Received: from localhost (den31-3-83-152-168-85.fbx.proxad.net [83.152.168.85])
        by mail.bootlin.com (Postfix) with ESMTPSA id A2E9320CFB;
        Sat,  1 Dec 2018 10:55:51 +0100 (CET)
Date:   Sat, 1 Dec 2018 10:55:51 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/4] selftests: timers: move PIE tests out of rtctest
Message-ID: <20181201095551.GN8952@piout.net>
References: <20180419125030.5076-1-alexandre.belloni@bootlin.com>
 <20180419125030.5076-2-alexandre.belloni@bootlin.com>
 <a304b6f1-11db-543b-2cb3-372f34dc7697@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a304b6f1-11db-543b-2cb3-372f34dc7697@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 29/11/2018 17:57:05-0200, Rafael David Tinoco wrote:
> On 4/19/18 9:50 AM, Alexandre Belloni wrote:
> > Since commit 6610e0893b8bc ("RTC: Rework RTC code to use timerqueue for
> > events"), PIE are completely handled using hrtimers, without actually using
> > any underlying hardware RTC.
> > 
> > Move PIE testing out of rtctest. It still depends on the presence of an RTC
> > (to access the device file) but doesn't depend on it actually working.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> >  tools/testing/selftests/timers/.gitignore |   1 +
> >  tools/testing/selftests/timers/Makefile   |   2 +-
> >  tools/testing/selftests/timers/rtcpie.c   | 132 ++++++++++++++++++++++
> >  tools/testing/selftests/timers/rtctest.c  |  83 +-------------
> >  4 files changed, 138 insertions(+), 80 deletions(-)
> >  create mode 100644 tools/testing/selftests/timers/rtcpie.c
> > 
> ...
> > +	/* The frequencies 128Hz, 256Hz, ... 8192Hz are only allowed for root. */
> > +	for (tmp=2; tmp<=64; tmp*=2) {
> > +
> > +		retval = ioctl(fd, RTC_IRQP_SET, tmp);
> > +		if (retval == -1) {
> > +			/* not all RTCs can change their periodic IRQ rate */
> > +			if (errno == EINVAL) {
> > +				fprintf(stderr,
> > +					"\n...Periodic IRQ rate is fixed\n");
> > +				goto done;
> > +			}
> > +			perror("RTC_IRQP_SET ioctl");
> > +			exit(errno);
> > +		}
> 
> Hello Alexandre,
> 
> In our tests, having failures under 64Hz is quite common in embedded
> systems with few number of CPUs/Cores:
> 
> --------
> root@bug3402:opt$ find /sys -name rtc0
> /sys/devices/platform/9010000.pl031/rtc/rtc0
> /sys/class/rtc/rtc0
> 
> selftests: timers: rtcpie
> Periodic IRQ rate is 1Hz.
> Counting 20 interrupts at:
> 2Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
> 4Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
> 8Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
> 16Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
> 32Hz:	 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20
> 64Hz:	
> PIE delta error: 0.017697 should be close to 0.015625
> not ok 1..9 selftests: timers: rtcpie [FAIL]
> --------
> 
> Mainly because 64Hz gives us.. ~16ms in the test, and the variation
> being taken in consideration for an error, for this test, is 10%, which
> is ~1.6ms... pretty close to scheduler limit for lower number of CPUs in
> a functional testing environment.
> 

I would think that enabling HR timers would actually make things better,
not matter how many CPUs are in the system. At least, this was the case
for AT91.

> Would you mind if we change the default for up to 32Hz ? Or, do you have
> any other suggestion ?
> 

I must admit that the whole point of moving this test out of rtctest was
that I didn't want to maintain it. John is the one responsible for the
timers so he will have to take that decision.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
