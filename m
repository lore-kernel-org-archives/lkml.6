Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FDDC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047EF208B6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047EF208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932902AbeFUJvP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 05:51:15 -0400
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:58387 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932677AbeFUJvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 05:51:14 -0400
Received: from mail.blacknight.com (unknown [81.17.254.26])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id 834721C29BA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 10:51:12 +0100 (IST)
Received: (qmail 8697 invoked from network); 21 Jun 2018 09:51:12 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.237.171])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 21 Jun 2018 09:51:12 -0000
Date:   Thu, 21 Jun 2018 10:51:12 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 13/19] mm/migrate: Use xchg instead of spinlock
Message-ID: <20180621095111.md7m5jhxxoswnykf@techsingularity.net>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1529514181-9842-14-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1529514181-9842-14-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 10:32:54PM +0530, Srikar Dronamraju wrote:
> Currently resetting the migrate rate limit is under a spinlock.
> The spinlock will only serialize the migrate rate limiting and something
> similar can actually be achieved by a simpler xchg.
> 
> Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
> JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
> 16    25804.1     25355.9     -1.73
> 1     73413       72812       -0.81
> 
> Running SPECjbb2005 on a 16 node machine and comparing bops/JVM
> JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
> 8     101748      110199      8.30
> 1     170818      176303      3.21
> 
> (numbers from v1 based on v4.17-rc5)
> Testcase       Time:         Min         Max         Avg      StdDev
> numa01.sh      Real:      435.67      707.28      527.49       97.85
> numa01.sh       Sys:       76.41      231.19      162.49       56.13
> numa01.sh      User:    38247.36    59033.52    45129.31     7642.69
> numa02.sh      Real:       60.35       62.09       61.09        0.69
> numa02.sh       Sys:       15.01       30.20       20.64        5.56
> numa02.sh      User:     5195.93     5294.82     5240.99       40.55
> numa03.sh      Real:      752.04      919.89      836.81       63.29
> numa03.sh       Sys:      115.10      133.35      125.46        7.78
> numa03.sh      User:    58736.44    70084.26    65103.67     4416.10
> numa04.sh      Real:      418.43      709.69      512.53      104.17
> numa04.sh       Sys:      242.99      370.47      297.39       42.20
> numa04.sh      User:    34916.14    48429.54    38955.65     4928.05
> numa05.sh      Real:      379.27      434.05      403.70       17.79
> numa05.sh       Sys:      145.94      344.50      268.72       68.53
> numa05.sh      User:    32679.32    35449.75    33989.10      913.19
> 
> Testcase       Time:         Min         Max         Avg      StdDev 	 %Change
> numa01.sh      Real:      490.04      774.86      596.26       96.46 	 -11.5%
> numa01.sh       Sys:      151.52      242.88      184.82       31.71 	 -12.0%
> numa01.sh      User:    41418.41    60844.59    48776.09     6564.27 	 -7.47%
> numa02.sh      Real:       60.14       62.94       60.98        1.00 	 0.180%
> numa02.sh       Sys:       16.11       30.77       21.20        5.28 	 -2.64%
> numa02.sh      User:     5184.33     5311.09     5228.50       44.24 	 0.238%
> numa03.sh      Real:      790.95      856.35      826.41       24.11 	 1.258%
> numa03.sh       Sys:      114.93      118.85      117.05        1.63 	 7.184%
> numa03.sh      User:    60990.99    64959.28    63470.43     1415.44 	 2.573%
> numa04.sh      Real:      434.37      597.92      504.87       59.70 	 1.517%
> numa04.sh       Sys:      237.63      397.40      289.74       55.98 	 2.640%
> numa04.sh      User:    34854.87    41121.83    38572.52     2615.84 	 0.993%
> numa05.sh      Real:      386.77      448.90      417.22       22.79 	 -3.24%
> numa05.sh       Sys:      149.23      379.95      303.04       79.55 	 -11.3%
> numa05.sh      User:    32951.76    35959.58    34562.18     1034.05 	 -1.65%
> 
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

However, I'm actively considering removing rate limiting entirely. It
has been reported elsewhere that it was a limiting factor for some
workloads. When it was introduced, it was to avoid worst-case migration
storms but I believe that those ping-pong style problems should now be
ok.

-- 
Mel Gorman
SUSE Labs
