Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB7FC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C1C2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C1C2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbeJXPHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 11:07:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:43875 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbeJXPHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 11:07:48 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 23:41:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,419,1534834800"; 
   d="scan'208";a="268308235"
Received: from aaronlu.sh.intel.com (HELO intel.com) ([10.239.159.44])
  by orsmga005.jf.intel.com with ESMTP; 23 Oct 2018 23:41:01 -0700
Date:   Wed, 24 Oct 2018 14:41:00 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     "Ye, Xiaolong" <xiaolong.ye@intel.com>,
        Joel Fernandes <joelaf@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@android.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steve Muckle <smuckle@google.com>, "lkp@01.org" <lkp@01.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Chris Redpath <chris.redpath@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LKP] [lkp-robot] [sched/fair] d519329f72: unixbench.score -9.9%
 regression
Message-ID: <20181024064100.GA27054@intel.com>
References: <20180402032000.GD3101@yexl-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180402032000.GD3101@yexl-desktop>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 11:20:00AM +0800, Ye, Xiaolong wrote:
> 
> Greeting,
> 
> FYI, we noticed a -9.9% regression of unixbench.score due to commit:
> 
> 
> commit: d519329f72a6f36bc4f2b85452640cfe583b4f81 ("sched/fair: Update util_est only on util_avg updates")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> in testcase: unixbench
> on test machine: 8 threads Intel(R) Core(TM) i7 CPU 870 @ 2.93GHz with 6G memory
> with following parameters:
> 
>         runtime: 300s
>         nr_task: 100%
>         test: execl
> 
> test-description: UnixBench is the original BYTE UNIX benchmark suite aims to test performance of Unix-like system.
> test-url: https://github.com/kdlucas/byte-unixbench

I tested this workload on different machines with this commit
d519329f72a6f36bc4f2b85452 and its parent a07630b8b2c16f82, I also
tested with v4.19-rc8 to see if the regression is gone -
the performance drop is there with v4.19-rc8 and with different
machines so I assume this regression is not solved yet.
Here are detailed data:

cmdline used to run this workload:
./Run execl -c $nr_cpu -i 30

lkp-ivb-d04(Ivybridge desktop, 4 CPUs)
a07630b8b2c16f82 d519329f72a6f36bc4f2b85452
---------------- --------------------------
         %stddev     %change         %stddev
             \          |                \
      2924            -8.7%       2669        unixbench.score
 
a07630b8b2c16f82fd5b71d890079f4dd7599c1d/avg.json:  "unixbench.score": 2924.3333333333335,
d519329f72a6f36bc4f2b85452640cfe583b4f81/avg.json:  "unixbench.score": 2669.5333333333333,
v4.19-rc8/avg.json:  "unixbench.score": 2611.733333333333,

lkp-hsw-d01(Haswell desktop, 8 CPUs)
a07630b8b2c16f82 d519329f72a6f36bc4f2b85452
---------------- --------------------------
         %stddev     %change         %stddev
             \          |                \
      7090            -9.4%       6421        unixbench.score
 
a07630b8b2c16f82fd5b71d890079f4dd7599c1d/avg.json:  "unixbench.score": 7090.400000000001,
d519329f72a6f36bc4f2b85452640cfe583b4f81/avg.json:  "unixbench.score": 6421.233333333333,
v4.19-rc8/avg.json:  "unixbench.score": 6431.933333333333,

lkp-skl-2sp2(2 sockets Skylake, 80 CPUs)
a07630b8b2c16f82 d519329f72a6f36bc4f2b85452
---------------- --------------------------                                                                                                           
         %stddev     %change         %stddev                                                                                                          
             \          |                \                                                                                                            
      9657 ±  2%      -3.3%       9334        unixbench.score
      
a07630b8b2c16f82fd5b71d890079f4dd7599c1d/avg.json:  "unixbench.score": 9657.6,
d519329f72a6f36bc4f2b85452640cfe583b4f81/avg.json:  "unixbench.score": 9334.9,
v4.19-rc8/avg.json:  "unixbench.score": 9278.333333333334,

Please let me know if you need other information, thanks.
