Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD08C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27EE20652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27EE20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeJOW15 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:27:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56399 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeJOW15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:27:57 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gC44X-0000EH-MV; Mon, 15 Oct 2018 16:42:17 +0200
Date:   Mon, 15 Oct 2018 16:42:17 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: Use cpus_read_lock() while looking at
 cpu_online_mask
Message-ID: <20181015144217.nu5cp5mxlboyjbre@linutronix.de>
References: <20180910135615.tr3cvipwbhq6xug4@linutronix.de>
 <20180911160532.GJ4225@linux.vnet.ibm.com>
 <20180911162142.cc3vgook2gctus4c@linutronix.de>
 <20180911170222.GO4225@linux.vnet.ibm.com>
 <20180919205521.GE902964@devbig004.ftw2.facebook.com>
 <20180919221140.GH4222@linux.ibm.com>
 <20181012184114.w332lnkc34evd4sm@linutronix.de>
 <20181013134813.GD2674@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181013134813.GD2674@linux.ibm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-13 06:48:13 [-0700], Paul E. McKenney wrote:
> 
> My concern would be that it would queue it by default for the current
> CPU, which would serialize the processing, losing the concurrency of
> grace-period initialization.  But that was a long time ago, and perhaps
> workqueues have changed. 

but the code here is always using the first CPU of a NUMA node or did I
miss something?

> So, have you tried using rcuperf to test the
> update performance on a large system?

Something like this:
| tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuperf --configs TREE
| ----Start batch 1: Mon Oct 15 12:46:13 CEST 2018
| TREE 142: Starting build. …
| …
| Average grace-period duration: 19952.7 microseconds
| Minimum grace-period duration: 9004.51
| 50th percentile grace-period duration: 19998.3
| 90th percentile grace-period duration: 24994.4
| 99th percentile grace-period duration: 30002.1
| Maximum grace-period duration: 42998.2
| Grace periods: 6560 Batches: 209 Ratio: 31.3876
| Computed from rcuperf printk output.
| Completed in 27 vs. 1800
| 
| Average grace-period duration: 18700 microseconds
| Minimum grace-period duration: 7069.2
| 50th percentile grace-period duration: 18987.5
| 90th percentile grace-period duration: 22997
| 99th percentile grace-period duration: 28944.7
| Maximum grace-period duration: 36994.5
| Grace periods: 6551 Batches: 209 Ratio: 31.3445
| Computed from rcuperf printk output.
| Completed in 27 vs. 1800

two runs patched followed by two runs without the patched:
| Average grace-period duration: 19423.3 microseconds
| Minimum grace-period duration: 8006.93
| 50th percentile grace-period duration: 19002.8
| 90th percentile grace-period duration: 23997.5
| 99th percentile grace-period duration: 29995.7
| Maximum grace-period duration: 37997.9
| Grace periods: 6526 Batches: 208 Ratio: 31.375
| Computed from rcuperf printk output.
| Completed in 27 vs. 1800
| 
| Average grace-period duration: 18822.4 microseconds
| Minimum grace-period duration: 8348.15
| 50th percentile grace-period duration: 18996.9
| 90th percentile grace-period duration: 23000
| 99th percentile grace-period duration: 27999.5
| Maximum grace-period duration: 39001.9
| Grace periods: 6540 Batches: 209 Ratio: 31.2919
| Computed from rcuperf printk output.
| Completed in 27 vs. 1800

I think difference might come from cpufreq on the host. But in general,
this is what you have been asking for or did you want to see something
on the host (or an additional argument to the script)?

> If this change does not impact performance on an rcuperf test, why not
> send me a formal patch with Signed-off-by and commit log (including
> performance testing results)?  I will then apply it, it will be exposed
> to 0day and eventually -next testing, and if no problems arise, it will go
> to mainline, perhaps as soon as the merge window after the upcoming one.
> 
> Fair enough?
sure.

> 							Thanx, Paul
> 

Sebastian
