Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeB0QLB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 11:11:01 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46597 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752284AbeB0QK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 11:10:59 -0500
Date: Tue, 27 Feb 2018 17:11:11 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Felipe Balbi <felipe.balbi@linux.intel.com>
cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: HRTimer causing rtctest to fail
In-Reply-To: <87vaei601x.fsf@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1802271640010.1886@nanos.tec.linutronix.de>
References: <87vaei601x.fsf@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2018, Felipe Balbi wrote:
> I'm facing an odd problem with v4.16-rc2 (also reproducible on v4.15
> final) where rtctest fails sometimes which PIE coming too late with
> frequencies >= 1024 Hz.
> 
> I've modified rtctest.c a bit so that it continues running even after
> first failure just so I could get a glimpse of how many times it fails.
> 
> Here are the results:
> 
> Error 1024Hz i 17/20 diff 1089/976
> 
> Error 2048Hz i 2/20 diff 538/488
> Error 2048Hz i 9/20 diff 558/488
> Error 2048Hz i 16/20 diff 560/488
> 
> Error 4096Hz i 2/20 diff 305/244
> Error 4096Hz i 7/20 diff 288/244
> Error 4096Hz i 9/20 diff 285/244
> Error 4096Hz i 11/20 diff 310/244
> Error 4096Hz i 16/20 diff 284/244
> Error 4096Hz i 20/20 diff 317/244
> 
> 
> I added a few trace_printk() calls around rtc_dev_read() (and some other
> functions) and captured the time for entry and exit of that function. I
> noticed that HRTimer fires way too late and also way too early
> sometimes. On the order of 100+ us.

Power management, deep idle states?

> For example with iterations 17 of 1024 Hz (seen above) and 18 (also of
> 1024 Hz) I captured the following time stamps (all in uS):
> 
> |    Start |      End | Expected End | Diff |
> |----------+----------+--------------+------|
> | 35900626 | 35901711 |     35901603 | -108 | (too late)
> | 35901826 | 35902628 |     35902803 |  174 | (too early)

Too early? hrtimers never fire too early. The measurement in that test is
bogus:

                        gettimeofday(&start, NULL);
                        /* This blocks */
                        retval = read(fd, &data, sizeof(unsigned long));
                        if (retval == -1) {
                                perror("read");
                                exit(errno);
                        }
                        gettimeofday(&end, NULL);

It's measuring relative time between going to sleep and wakeup, so if an
event comes late, then the next one will claim to be early which is
nonsense because periodic mode runs on an absolute time line. 

		1	2       3       4	5	6	7
Expected:	|	|	|	|	|	|	|
Real:		 |	 |	   |	 |	 |	 |	 |

		 	           ^ late event
So 2->3 would give you (period + latency) and 3->4 (period - latency) ....

And if the task gets scheduled out before the taking the start time stamp
then this is also giving bogus results.

What the test really should figure out is the deviation of the absolute
time line. That's hard because the RTC code starts the hrtimer with:

     hrtimer_start(&rtc->pie_timer, period, HRTIMER_MODE_REL);

which means relative to 'now'. So there is no good way for user space to
determine the expected timeline.

> I can't come up with a proper explanation as to why HRTimer is firing at
> such wildly odd extremes. On most of the measurements, HRTimer executes
> within 5 uS of scheduled time and I can't convince myself that
> scheduling latency would get so high all of a sudden. Specially
> considering I'm testing with a 4 core machine and there's nothing else
> running on it. It's mostly idle.

Enable the hrtimer and scheduling tracepoints. That should give you a hint
what's going on.

Thanks,

	tglx
