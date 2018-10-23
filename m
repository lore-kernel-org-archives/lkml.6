Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D51DC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8A720813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 17:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8A720813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbeJXCB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 22:01:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725997AbeJXCBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 22:01:25 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9NHOZDF072604
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 13:37:04 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2na6ab57uy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 13:37:03 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Tue, 23 Oct 2018 18:37:01 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Oct 2018 18:36:57 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9NHauhK6947216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Oct 2018 17:36:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A809A4203F;
        Tue, 23 Oct 2018 17:36:56 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65F5D4204C;
        Tue, 23 Oct 2018 17:36:55 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 23 Oct 2018 17:36:55 +0000 (GMT)
Date:   Tue, 23 Oct 2018 23:06:54 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Yi Wang <wang.yi59@zte.com.cn>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        liu.yi24@zte.com.cn
Subject: Re: [PATCH] sched/numa: fix choosing isolated CPUs when
 task_numa_migrate()
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1540177516-38613-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1540177516-38613-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18102317-4275-0000-0000-000002D284D1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102317-4276-0000-0000-000037DE8951
Message-Id: <20181023173654.GB7111@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810230141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Yi Wang,

> When trying to migrate to a CPU in task_numa_migrate(), we invoke
> task_numa_find_cpu() to choose a spot, in which function we skip
> the CPU which is not in cpus_allowed, but forgot to concern the
> isolated CPUs, and this may cause the task would run on the isolcpus.
>
> This patch fixes this issue by checking the load_balance_mask.
>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Reviewed-by: Yi Liu <liu.yi24@zte.com.cn>
> ---
>  kernel/sched/fair.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>

I had proposed something similar
http://lkml.kernel.org/r/1491326848-5748-1-git-send-email-srikar@linux.vnet.ibm.com

but at that time, Peter felt we should fix it at different level.
http://lkml.kernel.org/r/20170406073659.y6ubqriyshax4v4m@hirez.programming.kicks-ass.net

and I think he is right.

I have system with 32 cpus, have passed isolcpus as a kernel parameter.

$ grep -o "isolcpus=[,,1-9]*" /proc/cmdline
isolcpus=1,5,9,13
$ grep -i cpus_allowed /proc/$$/status
Cpus_allowed:   ffffdddd
Cpus_allowed_list:      0,2-4,6-8,10-12,14-31


So for a task running on top_cpuset will not have isolcpus as part of the
cpus_allowed.

However if a said task were to call sched_setaffinity, then there is every
likely hood of the cpus being passed being a mix of isolcpus and
nonisolcpus.

For example 
perf bench numa mem --no-data_rand_walk -p 4 -t 8 -G 0 -P 3072 -T 0 -l 50 -c -s 1000

$ for i in $(pgrep -f perf); do  grep -i cpus_allowed_list  /proc/$i/task/*/status ; done | head -n 10
Cpus_allowed_list:      0,2-4,6-8,10-12,14-31
/proc/2107/task/2107/status:Cpus_allowed_list:  0-31
/proc/2107/task/2196/status:Cpus_allowed_list:  0-31
/proc/2107/task/2197/status:Cpus_allowed_list:  0-31
/proc/2107/task/2198/status:Cpus_allowed_list:  0-31
/proc/2107/task/2199/status:Cpus_allowed_list:  0-31
/proc/2107/task/2200/status:Cpus_allowed_list:  0-31
/proc/2107/task/2201/status:Cpus_allowed_list:  0-31
/proc/2107/task/2202/status:Cpus_allowed_list:  0-31
/proc/2107/task/2203/status:Cpus_allowed_list:  0-31

So the cpus_allowed has a mix of isolcpus and nonisolcpus.

While this patch fixes the problem, there is a risk of missing other places
like update_numa_stats also iterates and accounts for tasks stats running on
isolcpus.

I will send a patch with a slightly different approach.
Request you to review and verify the same.

--
Thanks and Regards
Srikar Dronamraju

