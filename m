Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F15060555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbeFFMzm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:55:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752009AbeFFMzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:55:38 -0400
Date: Wed, 6 Jun 2018 05:55:29 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1528204074.7898.126.camel@surriel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18060612-4275-0000-0000-0000028AC158
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060612-4276-0000-0000-00003791CB04
Message-Id: <20180606125529.GF30328@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806060150
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > I thought about this. Lets say we evaluated that destination node can
> > allow movement. While we iterate through the list of cpus trying to
> > find
> > the best cpu node, we find a idle cpu towards the end of the list.
> > However if another task as already raced with us to move a task to
> > this
> > node, then we should bail out. Keeping the check in task_numa_compare
> > will allow us to do this.
> 
> Your check is called once for every invocation
> of task_numa_compare. It does not matter whether
> it is inside or outside, except on the outside
> the variable manipulation will be easier to read.
> 

Okay I mistook your comment; Basically you want the check to be moved
within the for-loop in task_numa_find_cpu.
I will do the needful.

> > 
> > While we can't complete avoid this, the second check will try to make
> > sure we don't hop on/hop off just for small incremental numa
> > improvement.
> 
> However, all those racing tasks start searching
> the CPUs on a node from the same start position.
> 
> That means they may all get stuck on the same
> task/cpu A, and not select the better task/cpu B.

> 
> What am I missing? 

All tasks will not be stuck at task/cpu A.

"[PATCH 10/19] sched/numa: Stop multiple tasks from moving to the
cpu..." the first task to set cpu A as swap target will ensure
subsequent tasks wont be allowed to set cpu A as target for swap till it
finds a better task/cpu. Because of this there a very very small chance
of a second task unable to find a task to swap.
