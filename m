Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EB9C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CC942081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tH06o0Hn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC942081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbeKAVAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:00:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56516 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbeKAVAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:00:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA1BnR4f144570;
        Thu, 1 Nov 2018 11:56:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=PVUuYKfEiJ81hjalAKLPtYFk+Rl9UJtj2dFNjRa5X4I=;
 b=tH06o0Hnk546JcJTcrJ8BPJM9XSAIz7OXwAh3AAZL+p0VoVwLi9cE5i3UMOSqxqOpskT
 /bTJT89oQFUtz2Z6/dx90mbbLYEsYgAjA9o7Zos+7IthW9pdw7wd6mztFQd/VU6GDk9V
 zwBaNaQ4+jjtccQgYg+yh//DcNdpaeOwIkYHp1ej9VAdNiHhDKyK7aVfGIwWNxlm5IYg
 W0dajrZYwytoXDNGG5emETA6NtqXE+1q+9Q0DeBoT3Nzo3PC2ffZz5hIwPIBRLt+z/Bp
 K+uLp1WRgDSLfgm4RXEEUZvD2s7gPfEYhi7DpOEvqiTMjskPcFHKdCLfXYOerNIvjP5g 4A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2ncfyq8c12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Nov 2018 11:56:59 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA1Buw2T002010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Nov 2018 11:56:58 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA1BuvRI024532;
        Thu, 1 Nov 2018 11:56:57 GMT
Received: from [10.152.33.198] (/10.152.33.198)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Nov 2018 04:56:56 -0700
From:   Steven Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH 00/10] steal tasks to improve CPU utilization
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <0e136ac6-1a08-bc7c-e4a5-5a7e967f8514@oracle.com>
Date:   Thu, 1 Nov 2018 07:56:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9063 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811010106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/2018 10:59 AM, Steve Sistare wrote:
> When a CPU has no more CFS tasks to run, and idle_balance() fails to
> find a task, then attempt to steal a task from an overloaded CPU in the
> same LLC. Maintain and use a bitmap of overloaded CPUs to efficiently
> identify candidates.  To minimize search time, steal the first migratable
> task that is found when the bitmap is traversed.  For fairness, search
> for migratable tasks on an overloaded CPU in order of next to run.
> [...] 
> Steve Sistare (10):
>   sched: Provide sparsemask, a reduced contention bitmap
>   sched/topology: Provide hooks to allocate data shared per LLC
>   sched/topology: Provide cfs_overload_cpus bitmap
>   sched/fair: Dynamically update cfs_overload_cpus
>   sched/fair: Hoist idle_stamp up from idle_balance
>   sched/fair: Generalize the detach_task interface
>   sched/fair: Provide can_migrate_task_llc
>   sched/fair: Steal work from an overloaded CPU when CPU goes idle
>   sched/fair: disable stealing if too many NUMA nodes
>   sched/fair: Provide idle search schedstats

(resend, reformatted)

Thanks very much to everyone who has commented on my patch series.
Here are the issues to be addressed in V2 of the series, and the person
that suggested it, or raised the issue that led to it.

Changes for V2:
  * Remove stray patch 10 hunk from patch 5 (Valentin)
  * Fix "warning: label out defined but not used" for !CONFIG_SCHED_SMT
    (Valentin)
  * Set SCHED_STEAL_NODE_LIMIT_DEFAULT to 2 (Steve)
  * Call try_steal iff avg_idle exceeds some small threshold (Steve, Valentin)

Possible future work:
  * Use sparsemask and stealing for RT (Steve, Peter)
  * Remove the core and socket levels from idle_balance() and let stealing
    handle those levels (Steve, Peter)
  * Delete idle_balance() and use stealing exclusively for handling new idle
    (Steve, Peter)
  * Test specjbb multi-warehouse on 8-node systems when stealing for
    large NUMA systems is revisited (Peter)
  * Enhance stealing to handle misfits (Valentin)
  * Lower time threshold for task_hot within LLC (Valentin)

Dropped:
  * Skip try_steal() if we bail out of idle_balance() because !this_rq->rd->overload 
    (Valentin)
    I tried it and saw no difference.  Dropped for simplicity.

Does anyone else plan to review the code?  Please tell me now, even if your
review will be delayed.  If yes, I will wait for all comments before producing
V2.  The code changes so far are small.

- Steve
