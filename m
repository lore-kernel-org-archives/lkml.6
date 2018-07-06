Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADD4C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5520C2408B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5520C2408B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gliwa.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753535AbeGFGaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:30:04 -0400
Received: from s30320.gliwa.com ([148.251.52.238]:45610 "EHLO mail.gliwa.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751862AbeGFGaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:30:03 -0400
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Jul 2018 02:30:02 EDT
Received: by mail.gliwa.com (Postfix, from userid 992)
        id A8F673441D3; Fri,  6 Jul 2018 08:22:01 +0200 (CEST)
X-Virus-Checker-Version: ClamAV 0.100.0/24727/Fri Jul 6 06:49:21 2018
X-Virus-Status: OK
Received: from [192.168.1.91] (x590f6efd.dyn.telefonica.de [89.15.110.253])
        by mail.gliwa.com (Postfix) with ESMTPSA id 5A32D3441CE;
        Fri,  6 Jul 2018 08:22:01 +0200 (CEST)
From:   Claudio <claudio.fontana@gliwa.com>
Subject: ftrace performance (sched events): cyclictest shows 25% more latency
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Message-ID: <73e2f61e-7e7b-d8be-6c94-896cf94e7567@gliwa.com>
Date:   Fri, 6 Jul 2018 08:22:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have been experimenting with the idea of leaving ftrace enabled, with sched events,
on production systems.

The main concern that I am having at the moment is about the impact on the system.
Enabling the sched events that I currently need for the tracing application
seems to slow down context-switches considerably, and make the system less responsive.

I have tested with cyclictest on the mainline kernel, and noticed an increase of min, avg latencies of around 25%.

Is this expected?

Some initial investigation into ftrace seems to point at the reservation and commit of the events into the ring buffer
as the highest sources of overhead, while event parameters copying, including COMM, does not seem to have any noticeable effect
relative to those costs.

I have been running 20 times the following test, and thrown away the first results:

$ sudo ./cyclictest --smp -p95 -m -s -N -l 100000 -q

$ uname -a
Linux claudio-HP-ProBook-470-G5 4.18.0-rc3+ #3 SMP Tue Jul 3 15:50:30 CEST 2018 x86_64 x86_64 x86_64 GNU/Linux

For brevity, this is a comparison of one test's results. All other test results show the same ~25% increase.

On the left side, the run without ftrace sched events, on the right side with ftrace sched events enabled.

CPU    Count      Min       Act        Avg        Max        Count      Min-ftrace Act-ftrace Avg-ftrace Max-ftrace
0     100000      2339       2936       2841     139478     100000       2900       3182       3566      93056
1      66742      2365       3386       2874      93639      66750       2959       3786       3646     154074
2      50080      2376       3058       2910     196221      50097       2997       4209       3655      18707
3      40076      2394       3461       2931      17914      40091       3006       4417       3750      17159
4      33404      2371       3612       2834      15336      33419       2997       3836       3594      23172
5      28635      2387       3313       2885      25863      28649       2995       3795       3647       9956
6      25058      2384       3428       2968      12162      25071       3051       4366       3719      18151
7      22275      2381       2859       2982      10706      22287       3046       5078       3825      10781

I would be thankful for any advice or comments on this,
especially with the goal in mind to lower as much as possible the runtime impact on the system.

Thank you,

Claudio Fontana
