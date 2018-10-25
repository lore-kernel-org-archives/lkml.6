Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B766C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1074020834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1074020834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeJZCEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:04:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727455AbeJZCEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:04:53 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9PHO7WH038002
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 13:31:07 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nbhh3j905-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 13:31:07 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Thu, 25 Oct 2018 18:31:05 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Oct 2018 18:31:01 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9PHV1Hi3604852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Oct 2018 17:31:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAADFA4053;
        Thu, 25 Oct 2018 17:31:00 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C42EA404D;
        Thu, 25 Oct 2018 17:30:59 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 25 Oct 2018 17:30:58 +0000 (GMT)
Date:   Thu, 25 Oct 2018 23:00:58 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Yi Wang <wang.yi59@zte.com.cn>, zhong.weidong@zte.com.cn,
        Yi Liu <liu.yi24@zte.com.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] sched/core: Don't mix isolcpus and housekeeping CPUs
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1540350169-18581-1-git-send-email-srikar@linux.vnet.ibm.com>
 <20181024100323.GO3109@worktop.c.hoisthospitality.com>
 <20181024103002.GB18466@linux.vnet.ibm.com>
 <20181025000707.GR3109@worktop.c.hoisthospitality.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181025000707.GR3109@worktop.c.hoisthospitality.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18102517-0016-0000-0000-00000219B0AE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102517-0017-0000-0000-00003271B9EB
Message-Id: <20181025173058.GD18466@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-25_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810250146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> That's completely broken. Nothing in the numa balancing path uses that
> variable and afaict preemption is actually enabled where that's used, so
> using that per-cpu variable at all is broken.
> 

I can demonstrate that even without numa balancing, there are
inconsistent behaviour with isolcpus on.

> 
> Both of you are fixing symptoms, not the cause.
> 

Okay.

> But it doesn't solve the problem.
> 
> You can create multiple partitions with cpusets but still have an
> unbound task in the root cgroup. That would suffer the exact same
> problems.
> 
> Thing is, load-balancing, of any kind, should respect sched_domains, and
> currently numa balancing barely looks at it.

Agreed that we should have looked at sched_domains. However I still believe
we can't have task->cpus_allowed with a mix of isolcpus and non-isolcpus.
won't it lead to inconsistent behaviour?

> 
> The proposed patch puts the minimal constraints on the numa balancer to
> respect sched_domains; but doesn't yet correctly deal with hotplug.

I was also thinking about hotplug. Also your proposed patch and even my
proposed patch don't seem to work well with the below scenario.

# cat /sys/devices/system/cpu/possible
0-31
# cat /sys/devices/system/cpu/isolated
1,5,9,13
# cat hist.sh
echo 0 > /proc/sys/kernel/numa_balancing
cd /sys/fs/cgroup/cpuset
mkdir -p student
cp cpuset.mems student/
cd student
echo "0-31" > cpuset.cpus
echo $$ > cgroup.procs 
echo "1-8" > cpuset.cpus
/home/srikar/work/ebizzy-0.3/ebizzy -S 1000 &
PID=$!
sleep 10
pidstat -p $! -t |tail -n +3 |head -n 10
pidstat -p $$ -t |tail -n +3
pkill ebizzy
#
# ./hist.sh
10:35:21  IST   UID      TGID       TID    %usr %system  %guest    %CPU   CPU  Command
10:35:21  IST     0      2645         -    8.70    0.01    0.00    8.71     1  ebizzy
10:35:21  IST     0         -      2645    0.01    0.00    0.00    0.01     1  |__ebizzy
10:35:21  IST     0         -      2647    0.14    0.00    0.00    0.14     1  |__ebizzy
10:35:21  IST     0         -      2648    0.13    0.00    0.00    0.13     1  |__ebizzy
10:35:21  IST     0         -      2649    0.13    0.00    0.00    0.13     1  |__ebizzy
10:35:21  IST     0         -      2650    0.13    0.00    0.00    0.13     1  |__ebizzy
10:35:21  IST     0         -      2651    0.13    0.00    0.00    0.13     1  |__ebizzy
10:35:21  IST     0         -      2652    0.13    0.00    0.00    0.13     1  |__ebizzy
10:35:21  IST     0         -      2653    0.13    0.00    0.00    0.13     1  |__ebizzy
10:35:23  IST   UID      TGID       TID    %usr %system  %guest    %CPU   CPU  Command
10:35:23  IST     0      2642         -    0.00    0.00    0.00    0.00     1  hist.sh
10:35:23  IST     0         -      2642    0.00    0.00    0.00    0.00     1  |__hist.sh
#

Note all the ebizzy and bash task that started it are on cpu 1. This happens
if the cpuset starts with an isolcpu, then all tasks in that cpuset might
only run in that cpu.  With a smaller cpuset, ebizzy always runs on cpu 1.
However, if I increase the cpuset, the chances of ebizzy spreading increases
but not always.

I only tried this on a powerpc kvm guest. I dont think there is anything to do
with arch/guest/host

I have something that seems to help out. Will post soon.

> isolcpus is just one case that goes wrong.
Similar to isolcpus, are there other cases that we need to worry about?

-- 
Thanks and Regards
Srikar Dronamraju

