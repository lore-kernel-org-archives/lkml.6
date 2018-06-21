Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3685C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4591204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 09:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4591204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932845AbeFUJHB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 05:07:01 -0400
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:59642 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932435AbeFUJG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 05:06:59 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id 86AECB89C7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 10:06:58 +0100 (IST)
Received: (qmail 14380 invoked from network); 21 Jun 2018 09:06:58 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.237.171])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 21 Jun 2018 09:06:58 -0000
Date:   Thu, 21 Jun 2018 10:06:53 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 02/19] sched/numa: Evaluate move once per node
Message-ID: <20180621090653.jtnlt373t7z7uhr7@techsingularity.net>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1529514181-9842-3-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1529514181-9842-3-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 10:32:43PM +0530, Srikar Dronamraju wrote:
> task_numa_compare() helps choose the best cpu to move or swap the
> selected task. To achieve this task_numa_compare() is called for every
> cpu in the node. Currently it evaluates if the task can be moved/swapped
> for each of the cpus. However the move evaluation is mostly independent
> of the cpu. Evaluating the move logic once per node, provides scope for
> simplifying task_numa_compare().
> 
> Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
> JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
> 16    25705.2     25058.2     -2.51
> 1     74433       72950       -1.99
> 
> Running SPECjbb2005 on a 16 node machine and comparing bops/JVM
> JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
> 8     96589.6     105930      9.670
> 1     181830      178624      -1.76
> 
> (numbers from v1 based on v4.17-rc5)
> Testcase       Time:         Min         Max         Avg      StdDev
> numa01.sh      Real:      440.65      941.32      758.98      189.17
> numa01.sh       Sys:      183.48      320.07      258.42       50.09
> numa01.sh      User:    37384.65    71818.14    60302.51    13798.96
> numa02.sh      Real:       61.24       65.35       62.49        1.49
> numa02.sh       Sys:       16.83       24.18       21.40        2.60
> numa02.sh      User:     5219.59     5356.34     5264.03       49.07
> numa03.sh      Real:      822.04      912.40      873.55       37.35
> numa03.sh       Sys:      118.80      140.94      132.90        7.60
> numa03.sh      User:    62485.19    70025.01    67208.33     2967.10
> numa04.sh      Real:      690.66      872.12      778.49       65.44
> numa04.sh       Sys:      459.26      563.03      494.03       42.39
> numa04.sh      User:    51116.44    70527.20    58849.44     8461.28
> numa05.sh      Real:      418.37      562.28      525.77       54.27
> numa05.sh       Sys:      299.45      481.00      392.49       64.27
> numa05.sh      User:    34115.09    41324.02    39105.30     2627.68
> 
> Testcase       Time:         Min         Max         Avg      StdDev 	 %Change
> numa01.sh      Real:      516.14      892.41      739.84      151.32 	 2.587%
> numa01.sh       Sys:      153.16      192.99      177.70       14.58 	 45.42%
> numa01.sh      User:    39821.04    69528.92    57193.87    10989.48 	 5.435%
> numa02.sh      Real:       60.91       62.35       61.58        0.63 	 1.477%
> numa02.sh       Sys:       16.47       26.16       21.20        3.85 	 0.943%
> numa02.sh      User:     5227.58     5309.61     5265.17       31.04 	 -0.02%
> numa03.sh      Real:      739.07      917.73      795.75       64.45 	 9.776%
> numa03.sh       Sys:       94.46      136.08      109.48       14.58 	 21.39%
> numa03.sh      User:    57478.56    72014.09    61764.48     5343.69 	 8.813%
> numa04.sh      Real:      442.61      715.43      530.31       96.12 	 46.79%
> numa04.sh       Sys:      224.90      348.63      285.61       48.83 	 72.97%
> numa04.sh      User:    35836.84    47522.47    40235.41     3985.26 	 46.26%
> numa05.sh      Real:      386.13      489.17      434.94       43.59 	 20.88%
> numa05.sh       Sys:      144.29      438.56      278.80      105.78 	 40.77%
> numa05.sh      User:    33255.86    36890.82    34879.31     1641.98 	 12.11%
> 
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
