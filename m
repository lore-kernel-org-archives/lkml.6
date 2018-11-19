Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB59DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E300213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1RmqMQLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E300213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390908AbeKTD6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:58:45 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45722 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389240AbeKTD6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:58:45 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAJHTQDv026208;
        Mon, 19 Nov 2018 17:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=DakKZ15acmExGaqiEc+MxGJbLMNabOKj2W08MSdqlJ0=;
 b=1RmqMQLce9oUcSBoMoUHtlbYxtoMb+22hVI1QMNxgOP4hlYRqFd5hUfx1NxhUrb1VvG2
 UreIDDHs5c6D9MmbhovFlaEaqZH+WtWdvJT7uS8+fcyV8aMerpQGX015/Sw/xfM2y0eR
 x1mT4XuMG89mvqgW11nfUxtxaqlZMx5/nVKcmaXYio24okYJUlBTbipwhVXKAzrGhBGX
 QdYZLpCZlmfrQVpKsV57OVlmx+C7c4cdxKle9xdqtuJdCyl7HQzJ6wLBj1rKwpX9eWXW
 Tgo0CwLmynz+s1L+DAVE8lqU/HkSyxge+tABldjAuXeTc9ZqeBqLdTt5jYAMacZznF04 KQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2ntadtqg5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Nov 2018 17:33:54 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAJHXmMJ028608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Nov 2018 17:33:48 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAJHXmW0006636;
        Mon, 19 Nov 2018 17:33:48 GMT
Received: from [10.152.35.100] (/10.152.35.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 19 Nov 2018 09:33:47 -0800
Subject: Re: [PATCH v3 03/10] sched/topology: Provide cfs_overload_cpus bitmap
To:     Valentin Schneider <valentin.schneider@arm.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org
References: <1541767840-93588-1-git-send-email-steven.sistare@oracle.com>
 <1541767840-93588-4-git-send-email-steven.sistare@oracle.com>
 <de2d2824-d66e-8852-d67a-d58b478b74c1@arm.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <0857925d-a24e-90ea-e28c-90d69b2f66dd@oracle.com>
Date:   Mon, 19 Nov 2018 12:33:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <de2d2824-d66e-8852-d67a-d58b478b74c1@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9082 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811190160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2018 11:42 AM, Valentin Schneider wrote:
> Hi Steve,
> 
> On 09/11/2018 12:50, Steve Sistare wrote:
>> From: Steve Sistare <steve.sistare@oracle.com>
>>
>> Define and initialize a sparse bitmap of overloaded CPUs, per
>> last-level-cache scheduling domain, for use by the CFS scheduling class.
>> Save a pointer to cfs_overload_cpus in the rq for efficient access.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  include/linux/sched/topology.h |  1 +
>>  kernel/sched/sched.h           |  2 ++
>>  kernel/sched/topology.c        | 21 +++++++++++++++++++--
>>  3 files changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
>> index 6b99761..b173a77 100644
>> --- a/include/linux/sched/topology.h
>> +++ b/include/linux/sched/topology.h
>> @@ -72,6 +72,7 @@ struct sched_domain_shared {
>>  	atomic_t	ref;
>>  	atomic_t	nr_busy_cpus;
>>  	int		has_idle_cores;
>> +	struct sparsemask *cfs_overload_cpus;
> 
> Thinking about misfit stealing, we can't use the sd_llc_shared's because
> on big.LITTLE misfit migrations happen across LLC domains.
> 
> I was thinking of adding a misfit sparsemask to the root_domain, but
> then I thought we could do the same thing for cfs_overload_cpus.
> 
> By doing so we'd have a single source of information for overloaded CPUs,
> and we could filter that down during idle balance - you mentioned earlier
> wanting to try stealing at each SD level. This would also let you get
> rid of [PATCH 02].
> 
> The main part of try_steal() could then be written down as something like
> this:
> 
> ----->8-----
> 
> for_each_domain(this_cpu, sd) {
> 	span = sched_domain_span(sd)
> 		
> 	for_each_sparse_wrap(src_cpu, overload_cpus) {
> 		if (cpumask_test_cpu(src_cpu, span) &&
> 		    steal_from(dts_rq, dst_rf, &locked, src_cpu)) {
> 			stolen = 1;
> 			goto out;
> 		}
> 	}
> }
> 
> ------8<-----
> 
> We could limit the stealing to stop at the highest SD_SHARE_PKG_RESOURCES
> domain for now so there would be no behavioural change - but we'd
> factorize the #ifdef SCHED_SMT bit. Furthermore, the door would be open
> to further stealing.
> 
> What do you think?

That is not efficient for a multi-level search because at each domain level we 
would (re) iterate over overloaded candidates that do not belong in that level.
To extend stealing across LLC, I would like to keep the per-LLC sparsemask, 
but add to each SD a list of sparsemask pointers.  The list nodes would be
private, but the sparsemask structs would be shared.  Each list would include
the masks that overlap the SD's members.  The list would be a singleton at the
core and LLC levels (same as the socket level for most processors), and would 
have multiple elements at the NUMA level.

- Steve

