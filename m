Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4D0C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 23:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989412172A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 23:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989412172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbeH0Cwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 22:52:50 -0400
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:36255 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726946AbeH0Cwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 22:52:49 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl2.internode.on.net with ESMTP; 27 Aug 2018 08:38:45 +0930
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fu49F-0007Co-5y; Mon, 27 Aug 2018 09:08:45 +1000
Date:   Mon, 27 Aug 2018 09:08:45 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Waiman Long <longman@redhat.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] xfs: Reduce spinlock contention in log space
 slowpath code
Message-ID: <20180826230845.GD2234@dastard>
References: <1535316795-21560-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535316795-21560-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2018 at 04:53:12PM -0400, Waiman Long wrote:
> v1->v2:
>  - For patch 1, remove wake_q_empty() & add task_in_wake_q().
>  - Rewrite patch 2 after comments from Dave Chinner and break it down
>    to 2 separate patches. Now the original xfs logic was kept. The
>    patches just try to move the task wakeup calls to outside the
>    spinlock.
> 
> While running the AIM7 microbenchmark on a small xfs filesystem, it
> was found that there was a severe spinlock contention problem in the
> current XFS log space reservation code. To alleviate the problem, the

Again I'll ask: what is the performance when the log is made large
enough that your benchmark is *not hammering the slow path*? 

i.e. does running "mkfs.xfs -l size=2000m ..." instead of using the
default tiny log on your tiny test filesystem make the problem
go away? Without that information, we have no idea what the slow
path impact on peformance actually is, and whether it is worth
persuing optimising slow path behaviour that very, very few
production environments see lock contention in....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
