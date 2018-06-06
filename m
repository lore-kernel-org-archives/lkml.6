Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D941360764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeFFNrU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:47:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57180 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751575AbeFFNrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:47:19 -0400
Date: Wed, 6 Jun 2018 06:47:09 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 18/19] sched/numa: Reset scan rate whenever task moves
 across nodes
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1528106428-19992-19-git-send-email-srikar@linux.vnet.ibm.com>
 <20180605095843.gfanebla26zvq62j@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180605095843.gfanebla26zvq62j@techsingularity.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18060613-0008-0000-0000-00000244C503
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060613-0009-0000-0000-000021AAD0E2
Message-Id: <20180606134709.GB20331@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-06_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806060160
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mel Gorman <mgorman@techsingularity.net> [2018-06-05 10:58:43]:

> On Mon, Jun 04, 2018 at 03:30:27PM +0530, Srikar Dronamraju wrote:
> > Currently task scan rate is reset when numa balancer migrates the task
> > to a different node. If numa balancer initiates a swap, reset is only
> > applicable to the task that initiates the swap. Similarly no scan rate
> > reset is done if the task is migrated across nodes by traditional load
> > balancer.
> > 
> > Instead move the scan reset to the migrate_task_rq. This ensures the
> > task moved out of its preferred node, either gets back to its preferred
> > node quickly or finds a new preferred node. Doing so, would be fair to
> > all tasks migrating across nodes.
> > 
> 
> By and large you need to be very careful resetting the scan rate without
> a lot of justification and I don't think this is enough. With scan rate
> resets, there is a significant risk that system CPU overhead is
> increased to do the page table updates and handle the resulting minor
> faults. There are cases where tasks can get pulled cross-node very
> frequently and we do not want NUMA balancing scanning agressively when
> that happens.
> 

I agree with your thoughts here. I will try to see if there are other
workloads that benefit from this change. My rational for this change
being, because a workload consolidated and slowed down its scanning
shouldn't adversely affect it from coming back to its preferred node.


> -- 
> Mel Gorman
> SUSE Labs
> 
