Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C90C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22B620865
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ni0C2fdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22B620865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeK0GCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:02:03 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42658 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbeK0GCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:02:03 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAQIxHcR084443;
        Mon, 26 Nov 2018 19:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=umxBeqp5eTRJbe6D1rEYMTt9pRUw0mf8krP+i3Asds8=;
 b=Ni0C2fdGgjI2xEhIi4SA72zVLgdcIbFSONvfAxRbpc+KqQa0eMUlo9tqVxl46fwThCBO
 YiYNAtS3z+0UYXSSO4nhBtUqiBHN4UTLAehCsElLIENj6TtUWwlxAa+fFomrMyIKsLmC
 0msPhr9LOrEHrUqdM8quW+V1N7ODWS/G8ukwI4Br86QBMMaEiChv8y5Ggitgd8QOlkqz
 WGJS+VLR2IJ4YQkroFs1aqrwRj61INs1/9HkL4qI41rQVIWEkB1T4Zhgx+ZxwPx6KaWe
 xFk69ru+XPvNHuCtQalUo37yoZ3W72oqMXCfjRmcJY9Av9+GYHqPXautBTW1uYBzrim8 fg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2nxx2tyrkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 19:06:25 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAQJ6Ou4018766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Nov 2018 19:06:24 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAQJ6NSv002038;
        Mon, 26 Nov 2018 19:06:23 GMT
Received: from [10.152.35.100] (/10.152.35.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Nov 2018 11:06:23 -0800
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
 <0857925d-a24e-90ea-e28c-90d69b2f66dd@oracle.com>
 <7d9b6789-af17-bcab-e52d-7e05483e10ea@arm.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <bccc5096-1353-5103-8c45-3dc5193db4e1@oracle.com>
Date:   Mon, 26 Nov 2018 14:06:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <7d9b6789-af17-bcab-e52d-7e05483e10ea@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9089 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811260163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/2018 7:42 AM, Valentin Schneider wrote:
> On 19/11/2018 17:33, Steven Sistare wrote:
> [...]
>>>
>>> Thinking about misfit stealing, we can't use the sd_llc_shared's because
>>> on big.LITTLE misfit migrations happen across LLC domains.
>>>
>>> I was thinking of adding a misfit sparsemask to the root_domain, but
>>> then I thought we could do the same thing for cfs_overload_cpus.
>>>
>>> By doing so we'd have a single source of information for overloaded CPUs,
>>> and we could filter that down during idle balance - you mentioned earlier
>>> wanting to try stealing at each SD level. This would also let you get
>>> rid of [PATCH 02].
>>>
>>> The main part of try_steal() could then be written down as something like
>>> this:
>>>
>>> ----->8-----
>>>
>>> for_each_domain(this_cpu, sd) {
>>> 	span = sched_domain_span(sd)
>>> 		
>>> 	for_each_sparse_wrap(src_cpu, overload_cpus) {
>>> 		if (cpumask_test_cpu(src_cpu, span) &&
>>> 		    steal_from(dts_rq, dst_rf, &locked, src_cpu)) {
>>> 			stolen = 1;
>>> 			goto out;
>>> 		}
>>> 	}
>>> }
>>>
>>> ------8<-----
>>>
>>> We could limit the stealing to stop at the highest SD_SHARE_PKG_RESOURCES
>>> domain for now so there would be no behavioural change - but we'd
>>> factorize the #ifdef SCHED_SMT bit. Furthermore, the door would be open
>>> to further stealing.
>>>
>>> What do you think?
>>
>> That is not efficient for a multi-level search because at each domain level we 
>> would (re) iterate over overloaded candidates that do not belong in that level.
> 
> 
> Mmm I was thinking we could abuse the wrap() and start at
> (fls(prev_span) + 1), but we're not guaranteed to have contiguous spans -
> the Arm Juno for instance has [0, 3, 4], [1, 2] as MC-level domains, so
> that goes down the drain.
> 
> Another thing that has been trotting in my head would be some helper to
> create a cpumask from a sparsemask (some sort of sparsemask_span()),
> which would let us use the standard mask operators:
> 
> ----->8-----
> struct cpumask *overload_span = sparsemask_span(overload_cpus)
> 
> for_each_domain(this_cpu, sd)
> 	for_each_cpu_and(src_cpu, overload_span, sched_domain_span(sd))
> 		<steal_from here>
> -----8>-----
> 
> The cpumask could be part of the sparsemask struct to save us the
> allocation, and only updated when calling sparsemask_span().

I thought of providing something like this along with other sparsemask
utility functions, but I decided to be minimalist, and let others add
more functions if/when they become needed.  this_cpu_cpumask_var_ptr(select_idle_mask) 
is a temporary that could be used as the destination of the conversion.

Also, conversion adds cost, particularly on larger systems.  When comparing a
cpumask and a sparsemask, it is more efficient to iterate over the smaller
set, and test for membership in the larger, such as in try_steal:

    for_each_cpu(src_cpu, cpu_smt_mask(dst_cpu)) {
            if (sparsemask_test_elem(src_cpu, overload_cpus)
 
>> To extend stealing across LLC, I would like to keep the per-LLC sparsemask, 
>> but add to each SD a list of sparsemask pointers.  The list nodes would be
>> private, but the sparsemask structs would be shared.  Each list would include
>> the masks that overlap the SD's members.  The list would be a singleton at the
>> core and LLC levels (same as the socket level for most processors), and would 
>> have multiple elements at the NUMA level.
> 
> I see. As for misfit, creating asym_cpucapacity siblings of the sd_llc_*()
> functions seems a bit much - there'd be a lot of redundancy for basically
> just a single shared sparsemask, which is why I was rambling about moving
> things to root_domain.
> 
> Having different locations where sparsemasks are stored is a bit of a
> pain which I'd like to avoid, but if it can't be unified I suppose we'll
> have to live with it.

I don't follow.  A per-LLC sparsemask representing misfits can be allocated with
one more line in sd_llc_alloc, and you can steal across LLC using the list I
briefly described above.

- Steve
