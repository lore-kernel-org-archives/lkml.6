Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F068AC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6891208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6891208A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932967AbeFUKGg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:06:36 -0400
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:34383 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932677AbeFUKGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:06:35 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id 4008FB8A91
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 11:06:33 +0100 (IST)
Received: (qmail 31857 invoked from network); 21 Jun 2018 10:06:33 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.237.171])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 21 Jun 2018 10:06:33 -0000
Date:   Thu, 21 Jun 2018 11:06:32 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 19/19] sched/numa: Move task_placement closer to
 numa_migrate_preferred
Message-ID: <20180621100632.bz4tukh6voftq3bo@techsingularity.net>
References: <1529514181-9842-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1529514181-9842-20-git-send-email-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1529514181-9842-20-git-send-email-srikar@linux.vnet.ibm.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 10:33:00PM +0530, Srikar Dronamraju wrote:
> numa_migrate_preferred is called periodically or when task preferred
> node changes. Preferred node evaluations happen once per scan sequence.
> 
> If the scan completion happens just after the periodic numa migration,
> then we try to migrate to the preferred node and the preferred node might
> change, needing another node migration.
> 
> Avoid this by checking for scan sequence completion only when checking
> for periodic migration.
> 
> Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
> JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
> 16    25862.6     26158.1     1.14258
> 1     74357       72725       -2.19482
> 
> Running SPECjbb2005 on a 16 node machine and comparing bops/JVM
> JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
> 8     117019      113992      -2.58
> 1     179095      174947      -2.31
> 
> (numbers from v1 based on v4.17-rc5)
> Testcase       Time:         Min         Max         Avg      StdDev
> numa01.sh      Real:      449.46      770.77      615.22      101.70
> numa01.sh       Sys:      132.72      208.17      170.46       24.96
> numa01.sh      User:    39185.26    60290.89    50066.76     6807.84
> numa02.sh      Real:       60.85       61.79       61.28        0.37
> numa02.sh       Sys:       15.34       24.71       21.08        3.61
> numa02.sh      User:     5204.41     5249.85     5231.21       17.60
> numa03.sh      Real:      785.50      916.97      840.77       44.98
> numa03.sh       Sys:      108.08      133.60      119.43        8.82
> numa03.sh      User:    61422.86    70919.75    64720.87     3310.61
> numa04.sh      Real:      429.57      587.37      480.80       57.40
> numa04.sh       Sys:      240.61      321.97      290.84       33.58
> numa04.sh      User:    34597.65    40498.99    37079.48     2060.72
> numa05.sh      Real:      392.09      431.25      414.65       13.82
> numa05.sh       Sys:      229.41      372.48      297.54       53.14
> numa05.sh      User:    33390.86    34697.49    34222.43      556.42
> 
> 
> Testcase       Time:         Min         Max         Avg      StdDev 	%Change
> numa01.sh      Real:      424.63      566.18      498.12       59.26 	 23.50%
> numa01.sh       Sys:      160.19      256.53      208.98       37.02 	 -18.4%
> numa01.sh      User:    37320.00    46225.58    42001.57     3482.45 	 19.20%
> numa02.sh      Real:       60.17       62.47       60.91        0.85 	 0.607%
> numa02.sh       Sys:       15.30       22.82       17.04        2.90 	 23.70%
> numa02.sh      User:     5202.13     5255.51     5219.08       20.14 	 0.232%
> numa03.sh      Real:      823.91      844.89      833.86        8.46 	 0.828%
> numa03.sh       Sys:      130.69      148.29      140.47        6.21 	 -14.9%
> numa03.sh      User:    62519.15    64262.20    63613.38      620.05 	 1.740%
> numa04.sh      Real:      515.30      603.74      548.56       30.93 	 -12.3%
> numa04.sh       Sys:      459.73      525.48      489.18       21.63 	 -40.5%
> numa04.sh      User:    40561.96    44919.18    42047.87     1526.85 	 -11.8%
> numa05.sh      Real:      396.58      454.37      421.13       19.71 	 -1.53%
> numa05.sh       Sys:      208.72      422.02      348.90       73.60 	 -14.7%
> numa05.sh      User:    33124.08    36109.35    34846.47     1089.74 	 -1.79%
> 
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
