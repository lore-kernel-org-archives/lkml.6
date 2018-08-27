Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A9BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 00:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D53C2174A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 00:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D53C2174A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeH0EL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 00:11:28 -0400
Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:8835 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725779AbeH0EL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 00:11:27 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Aug 2018 00:11:26 EDT
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail03.adl2.internode.on.net with ESMTP; 27 Aug 2018 09:51:35 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fu5Hi-0007Gq-I4; Mon, 27 Aug 2018 10:21:34 +1000
Date:   Mon, 27 Aug 2018 10:21:34 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Waiman Long <longman@redhat.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] xfs: Prevent multiple wakeups of the same log
 space waiter
Message-ID: <20180827002134.GE2234@dastard>
References: <1535316795-21560-1-git-send-email-longman@redhat.com>
 <1535316795-21560-3-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535316795-21560-3-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2018 at 04:53:14PM -0400, Waiman Long wrote:
> The current log space reservation code allows multiple wakeups of the
> same sleeping waiter to happen. This is a just a waste of cpu time as
> well as increasing spin lock hold time. So a new XLOG_TIC_WAKING flag is
> added to track if a task is being waken up and skip the wake_up_process()
> call if the flag is set.
> 
> Running the AIM7 fserver workload on a 2-socket 24-core 48-thread
> Broadwell system with a small xfs filesystem on ramfs, the performance
> increased from 91,486 jobs/min to 192,666 jobs/min with this change.

Oh, I just noticed you are using a ramfs for this benchmark,

tl; dr: Once you pass a certain point, ramdisks can be *much* slower
than SSDs on journal intensive workloads like AIM7. Hence it would be
useful to see if you have the same problems on, say, high
performance nvme SSDs.

-----

Ramdisks have substantially different means log IO completion and
wakeup behaviour compared to real storage on real production
systems. Basically, ramdisks are synchronous and real storage is
asynchronous.

That is, on a ramdisk the IO completion is run synchronously in the
same task as the IO submission because the IO is just a memcpy().
Hence a single dispatch thread can only drive an IO queue depth of 1
IO - there is no concurrency possible. This serialises large parts
of the XFS journal - the journal is really an asynchronous IO engine
that gets it's performance from driving deep IO queues and batching
commits while IO is in flight.

Ramdisks also have very low IO latency, which means there's only a
very small window for "IO in flight" batching optimisations to be
made effectively. It effectively stops such algorithms from working
completely. This means the XFS journal behaves very differently on
ramdisks when compared to normal storage.

The submission batching techniques reduces log IOs by a factor of
10-20 under heavy synchrnous transaction loads when there is any
noticeable journal IO delay - a few tens of microseconds is enough
for it to function effectively, but a ramdisk doesn't even have this
delay on journal IO.  The submission batching also has the
effect of reducing log space wakeups by the same factor there are
less IO completions signalling that space has been made available.

Further, when we get async IO completions from real hardware, they
get processed in batches by a completion workqueue - this leads to
there typically only being a single reservation space update from
all batched IO completions. This tends to reduce log space wakeups
due to log IO completion by a factor of 6-8 as the log can have up
to 8 concurrent IOs in flight at a time.

And when we throw in the lack of batching, merging and IO completion
aggregation of metadata writeback because ramdisks are synchrnous
and don't queue or merge adjacent IOs, we end up with lots more
contention on the AIL lock and much more frequent log space wakeups
(i.e. from log tail movement updates). This futher exacerbates the
problems the log already has with synchronous IO.

IOWs, log space wakeups on real storage are likely to be 50-100x
lower than on a ramdisk for the same metadata and journal intensive
workload, and as such those workloads often run faster on real
storage than they do on ramdisks.

This can be trivially seen with dbench, a simple IO benchmark that
hammers the journal. On a ramdisk, I can only get 2-2.5GB/s
throughput from the benchmark before the log bottlenecks at about
20,000 log tiny IOs per second. In comparison, on an old, badly
abused Samsung 850EVO SSD, I see 5-6GB/s in 2,000 log IOs per second
because of the pipelining and IO batching in the XFS journal async
IO engine and the massive reduction in metadata IO due to merging of
adjacent IOs in the block layer. i.e. the journal and metadata
writeback design allows the filesystem to operate at a much higher
synchronous transaction rate than would otherwise be possible by
taking advantage of the IO concurrency that storage provides us
with.

So if you use proper storage hardware (e.g. nvme SSD) and/or an
appropriately sized log, does the slowpath wakeup contention go
away? Can you please test both of these things and report the
results so we can properly evaluate the impact of these changes?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
