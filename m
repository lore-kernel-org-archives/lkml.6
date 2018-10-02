Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCCCC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2605C21470
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2605C21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbeJBTZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:25:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727662AbeJBTZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:25:06 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w92CYisL012761
        for <linux-kernel@vger.kernel.org>; Tue, 2 Oct 2018 08:41:57 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mv7wuag2g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 08:41:57 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Tue, 2 Oct 2018 13:41:55 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Oct 2018 13:41:53 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w92Cfqr646465114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Oct 2018 12:41:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A6B311C05B;
        Tue,  2 Oct 2018 15:41:29 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED74F11C050;
        Tue,  2 Oct 2018 15:41:27 +0100 (BST)
Received: from linux.vnet.ibm.com (unknown [9.102.1.150])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue,  2 Oct 2018 15:41:27 +0100 (BST)
Date:   Tue, 2 Oct 2018 18:11:49 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jirka Hladky <jhladky@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] mm, numa: Migrate pages to local nodes quicker early
 in the lifetime of a task
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20181001100525.29789-1-mgorman@techsingularity.net>
 <20181001100525.29789-3-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181001100525.29789-3-mgorman@techsingularity.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18100212-0012-0000-0000-000002B150FB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100212-0013-0000-0000-000020E58333
Message-Id: <20181002124149.GB4593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-02_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=928 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810020125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 25c7c7e09cbd..7fc4a371bdd2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1392,6 +1392,17 @@ bool should_numa_migrate_memory(struct task_struct *p, struct page * page,
>  	int last_cpupid, this_cpupid;
>
>  	this_cpupid = cpu_pid_to_cpupid(dst_cpu, current->pid);
> +	last_cpupid = page_cpupid_xchg_last(page, this_cpupid);
> +
> +	/*
> +	 * Allow first faults or private faults to migrate immediately early in
> +	 * the lifetime of a task. The magic number 4 is based on waiting for
> +	 * two full passes of the "multi-stage node selection" test that is
> +	 * executed below.
> +	 */
> +	if ((p->numa_preferred_nid == -1 || p->numa_scan_seq <= 4) &&
> +	    (cpupid_pid_unset(last_cpupid) || cpupid_match_pid(p, last_cpupid)))
> +		return true;
>

This does have issues when using with workloads that access more shared faults
than private faults.

In such workloads, this change would spread the memory causing regression in
behaviour.

5 runs of on 2 socket/ 4 node power 8 box


Without this patch
./numa01.sh      Real:  382.82    454.29    422.31    29.72
./numa01.sh      Sys:   40.12     74.53     58.50     13.37
./numa01.sh      User:  34230.22  46398.84  40292.62  4915.93

With this patch
./numa01.sh      Real:  415.56    555.04    473.45    51.17    -10.8016%
./numa01.sh      Sys:   43.42     94.22     73.59     17.31    -20.5055%
./numa01.sh      User:  35271.95  56644.19  45615.72  7165.01  -11.6694%

Since we are looking at time, smaller numbers are better.

----------------------------------------
# cat numa01.sh
#! /bin/bash
# numa01.sh corresponds to 2 perf bench processes each having ncpus/2 threads
# 50 loops of 3G process memory.

THREADS=${THREADS:-$(($(getconf _NPROCESSORS_ONLN)/2))}
perf bench numa mem --no-data_rand_walk -p 2 -t $THREADS -G 0 -P 3072 -T 0 -l 50 -c -s 2000 $@
----------------------------------------

I know this is a synthetic benchmark, but wonder if benchmarks run on vm
guest show similar behaviour when noticed from host.

SPECJbb did show some small loss and gains.

Our numa grouping is not fast enough. It can take sometimes several
iterations before all the tasks belonging to the same group end up being
part of the group. With the current check we end up spreading memory faster
than we should hence hurting the chance of early consolidation.

Can we restrict to something like this?

if (p->numa_scan_seq >=MIN && p->numa_scan_seq <= MIN+4 &&
    (cpupid_match_pid(p, last_cpupid)))
	return true;

meaning, we ran atleast MIN number of scans, and we find the task to be most likely
task using this page.

-- 
Thanks and Regards
Srikar Dronamraju

