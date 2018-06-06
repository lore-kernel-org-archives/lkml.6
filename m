Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3AE960290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbeFFPcO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 11:32:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751546AbeFFPcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 11:32:13 -0400
Date: Wed, 6 Jun 2018 08:32:04 -0700
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Rik van Riel <riel@surriel.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 16/19] sched/numa: Detect if node actively handling
 migration
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1528106428-19992-1-git-send-email-srikar@linux.vnet.ibm.com>
 <1528106428-19992-17-git-send-email-srikar@linux.vnet.ibm.com>
 <1528142755.7898.122.camel@surriel.com>
 <20180605035616.GD30328@linux.vnet.ibm.com>
 <1528204074.7898.126.camel@surriel.com>
 <20180606125529.GF30328@linux.vnet.ibm.com>
 <1528293314.7898.132.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1528293314.7898.132.camel@surriel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18060615-0028-0000-0000-000002CDCBE7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060615-0029-0000-0000-00002384D7F2
Message-Id: <20180606153204.GA39860@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=811 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806060176
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > All tasks will not be stuck at task/cpu A.
> > 
> > "[PATCH 10/19] sched/numa: Stop multiple tasks from moving to the
> > cpu..." the first task to set cpu A as swap target will ensure
> > subsequent tasks wont be allowed to set cpu A as target for swap till
> > it
> > finds a better task/cpu. Because of this there a very very small
> > chance
> > of a second task unable to find a task to swap.
> 
> Would it not be better for task_numa_compare to skip
> from consideration CPUs that somebody else is already
> trying to migrate a task to, but still search for the
> best location, instead of settling for a worse location
> to migrate to?

Yes its better to skip cpus if they are already in migration.
And we are already doing it with the above patch. However as I said
earlier 

- Task T1 sets Cpu 1 as best_cpu, 
- Task T2 finds cpu1 and skips Cpu1
- Task T1 finds cpu2 slightly better than cpu1.
- Task T1 resets cpu1 as best_cpu, sets best_cpu as cpu2.
- Task T2 finds cpu2 and skips cpu2
- Task T1 finds cpu3 as best_cpu slightly better than cpu2.
- Task T1 resets cpu2 as best_cpu, sets best_cpu as cpu3.
- Task T2 finds cpu3 and skips cpu3

So after this T1 was able to find a cpu but T2 couldn't find a cpu even
though there were 3 cpus that were available for 2 task to swap.

Again, this is too corner case, that I am okay to drop.
