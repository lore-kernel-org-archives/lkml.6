Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEADC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8822054F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rJe+MRvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8822054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbeJYWll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:41:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40736 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeJYWlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:41:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9PDwiu6160421;
        Thu, 25 Oct 2018 14:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=cZPUfBds47iyo9IkfBsqaMFibXWorHXCGkNO1+Y2FQ8=;
 b=rJe+MRvvQAen3ZAacDwllqVrHtGV7YnQTAlhEcZ/CQq/Ll3/VfbuC+2rHi2NP0lGWDjU
 TB/B9Ndu4bNvykGPu9mH9Zqn5rTageXzyaqPcJuccG1H7yyy+d9Dn0j/HUOPEDxauYmp
 bLbZbGNx7E4MuF8JYhAcgg6WelpvSnCX2xIx7j0CiCjada688zjdzem8MvkdNJJP3ns3
 xtRWqX6xT+pT1d0Ygu1LYd2ZxvWCQCLl72PTZgvIofBjgLC05g5nEpe7bd+nmj0mvGGY
 r5lRlsL/0ed+EmdEp2EzjdmT1Spys6hoitst+JGTs96epdPhb5z34go9bjxSc5h99rWQ +A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2n7vaq9ub6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 14:08:17 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9PE8Fb9030904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 14:08:16 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9PE8Fwq021173;
        Thu, 25 Oct 2018 14:08:15 GMT
Received: from [10.152.35.100] (/10.152.35.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Oct 2018 07:08:15 -0700
Subject: Re: [PATCH 08/10] sched/fair: Steal work from an overloaded CPU when
 CPU goes idle
To:     Valentin Schneider <valentin.schneider@arm.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
 <1540220381-424433-9-git-send-email-steven.sistare@oracle.com>
 <223bfcdb-bb0c-b25e-04dc-26226a7c3ab3@arm.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <b8bec531-125b-065f-9160-1df03cc25a9e@oracle.com>
Date:   Thu, 25 Oct 2018 10:07:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <223bfcdb-bb0c-b25e-04dc-26226a7c3ab3@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9056 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810250121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2018 9:48 AM, Valentin Schneider wrote:
> Hi Steve,
> 
> On 22/10/2018 15:59, Steve Sistare wrote:
> [...]
>> +/*
>> + * Try to steal a runnable CFS task from a CPU in the same LLC as @dst_rq,
>> + * and migrate it to @dst_rq.  rq_lock is held on entry and return, but
>> + * may be dropped in between.  Return 1 on success, 0 on failure, and -1
>> + * if a task in a different scheduling class has become runnable on @dst_rq.
>> + */
>> +static int try_steal(struct rq *dst_rq, struct rq_flags *dst_rf)
>> +{
>> +	int src_cpu;
>> +	int dst_cpu = dst_rq->cpu;
>> +	bool locked = true;
>> +	int stolen = 0;
>> +	struct sparsemask *overload_cpus;
>> +
>> +	if (!sched_feat(STEAL))
>> +		return 0;
>> +
>> +	if (!cpu_active(dst_cpu))
>> +		return 0;
>> +
>> +	/* Get bitmap of overloaded CPUs in the same LLC as @dst_rq */
>> +
>> +	rcu_read_lock();
>> +	overload_cpus = rcu_dereference(dst_rq->cfs_overload_cpus);
>> +	if (!overload_cpus) {
>> +		rcu_read_unlock();
>> +		return 0;
>> +	}
>> +
>> +#ifdef CONFIG_SCHED_SMT
>> +	/*
>> +	 * First try overloaded CPUs on the same core to preserve cache warmth.
>> +	 */
>> +	if (static_branch_likely(&sched_smt_present)) {
>> +		for_each_cpu(src_cpu, cpu_smt_mask(dst_cpu)) {
>> +			if (sparsemask_test_elem(src_cpu, overload_cpus) &&
>> +			    steal_from(dst_rq, dst_rf, &locked, src_cpu)) {
>> +				stolen = 1;
>> +				goto out;
>> +			}
>> +		}
>> +	}
>> +#endif	/* CONFIG_SCHED_SMT */
>> +
>> [...]
>> +
>> +	for_each_sparse_wrap(src_cpu, overload_cpus, dst_cpu) {
>> +		if (steal_from(dst_rq, dst_rf, &locked, src_cpu)) {
>> +			stolen = 1;
>> +			break;
> 			^^^^^^
> You might want to have a 'goto out' there for consistency and to make GCC
> happy for !CONFIG_SCHED_SMT (I get a "warning: label ‘out’ defined but not
> used")

Absolutely, will fix in next version.  Thanks for the careful review.

- Steve
