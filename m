Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622B7C71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5452098A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mbQ8xNlt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5452098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeJPCWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:22:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38370 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbeJPCWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:22:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9FIYGjJ018721;
        Mon, 15 Oct 2018 18:35:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=+l43h1IA0btkNct4kLOvCeqNoEw5BBbyqPrOu+U7Now=;
 b=mbQ8xNlt08uCfZkc9KbjBb2N7e+rHbnatkC7p9PFSeu8ewMxLH6Okr1hXCNp+Km0aGiX
 Me/5CtWFsXXDQo1t4QyRhMcJNsL0bsG40rOFjQL8wWQt2UlvNJvvZ/9R4605gxwBYnpL
 hWpPPu5u5d84GUDCHPVtFOygh/tqEBKs2fK6RDS5jYavg9/FubvJK+bGtp9CttDFjXQt
 WxuQkmuu2Slmqv/LmETeHi7JYMOkuZNKgr7knasDWDutibtH4Bk6IaqYJ6WU0fTC1Jah
 qmCzeNTHV0ARzo+waDZWLZ5D/yufuZYQ+ZPY3APc0S+KcYE4scm1To8rNGPjj0VDZp04 RQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2n39br4378-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Oct 2018 18:35:43 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9FIZg10001300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Oct 2018 18:35:43 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9FIZf9I005870;
        Mon, 15 Oct 2018 18:35:41 GMT
Received: from [10.154.131.235] (/10.154.131.235)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Oct 2018 11:35:41 -0700
Subject: Re: [PATCH v13 03/11] cpuset: Simply allocation and freeing of
 cpumasks
To:     Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
References: <1539366951-8498-1-git-send-email-longman@redhat.com>
 <1539366951-8498-4-git-send-email-longman@redhat.com>
From:   Tom Hromatka <tom.hromatka@oracle.com>
Message-ID: <fe132a9a-472d-22db-43ef-42c00b68c8dd@oracle.com>
Date:   Mon, 15 Oct 2018 12:35:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539366951-8498-4-git-send-email-longman@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9047 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810150161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2018 11:55 AM, Waiman Long wrote:
> The previous commit introduces a new subparts_cpus mask into the cpuset
> data structure and a new tmpmasks structure.  Managing the allocation
> and freeing of those cpumasks is becoming more complex.
>
> So a number of helper functions are added to simplify and streamline
> the management of those cpumasks. To make it simple, all the cpumasks
> are now pre-cleared on allocation.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/cgroup/cpuset.c | 104 +++++++++++++++++++++++++++++++++----------------
>   1 file changed, 71 insertions(+), 33 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 29a2bdc..9ac5f94 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -456,6 +456,57 @@ static int is_cpuset_subset(const struct cpuset *p, const struct cpuset *q)
>   }
>   
>   /**
> + * alloc_cpumasks - allocate three cpumasks for cpuset
> + * @cs:  the cpuset that have cpumasks to be allocated.
> + * @tmp: the tmpmasks structure pointer
> + * Return: 0 if successful, -ENOMEM otherwise.
> + *
> + * Only one of the two input arguments should be non-NULL.
> + */
> +static inline int alloc_cpumasks(struct cpuset *cs, struct tmpmasks *tmp)
> +{
> +	cpumask_var_t *pmask1, *pmask2, *pmask3;
> +
> +	if (cs) {
> +		pmask1 = &cs->cpus_allowed;
> +		pmask2 = &cs->effective_cpus;
> +		pmask3 = &cs->subparts_cpus;
> +	} else {
> +		pmask1 = &tmp->new_cpus;
> +		pmask2 = &tmp->addmask;
> +		pmask3 = &tmp->delmask;
> +	}
> +
> +	if (!zalloc_cpumask_var(pmask1, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	if (!zalloc_cpumask_var(pmask2, GFP_KERNEL))
> +		goto free_one;
> +
> +	if (!zalloc_cpumask_var(pmask3, GFP_KERNEL))
> +		goto free_two;
> +
> +	return 0;
> +
> +free_two:
> +	free_cpumask_var(*pmask2);
> +free_one:
> +	free_cpumask_var(*pmask1);
> +	return -ENOMEM;
> +}
> +
> +/**
> + * free_cpumasks - free cpumasks in a tmpmasks structure
> + * @tmp: the tmpmasks structure pointer
> + */
> +static inline void free_cpumasks(struct tmpmasks *tmp)
> +{
> +	free_cpumask_var(tmp->new_cpus);
> +	free_cpumask_var(tmp->addmask);
> +	free_cpumask_var(tmp->delmask);
> +}
> +

I hesitate to bring this up, but since you're respinning this
patch for a different bug...

Would it make sense to have free_cpumasks() have a similar
API and behavior to alloc_cpumasks()?  I could see this potentially
causing bugs/confusion in future patches.

Thanks.

Tom


