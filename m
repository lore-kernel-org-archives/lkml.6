Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6D8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA19F2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 18:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G3MyQXf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfBYSTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 13:19:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57780 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfBYSTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 13:19:40 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1PIJ5g3150947;
        Mon, 25 Feb 2019 18:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=MDhQ7hiB83vmUIdrFI1EFKPrSwA180BCDucKL8o87Lk=;
 b=G3MyQXf6+uo6xTbtLPRsXhmCHsT3b6XYp3jkb+9FgL2CduMCbiWpeHcc4JyocBkMKdWA
 DiyVMpk4H58UUqii5KsXmjbStDRw+UTZHAHDhe2PqaL5p3SVArHUt+9vqfvS/cAYiKvO
 zq6U9nvvvWdXrainkMAMcltwSvj9exyTHa5AeouTDxPEnI5fvwB6IWbHEbDGLktn/nTU
 N45P1QFZs8Cpwq0OZy5HpNRMU4YZhQvOlm6z3NmriGZ5Vecx2+qAfUTx8qzVYqVYvg4a
 4IUWjHxlug0Udbhu8KTkNMizcGQL6Reu8z5sbAExw85UYA5WZ0wZ7LRjPDJTE+TjLzrF OA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qtwktytsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Feb 2019 18:19:24 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1PIJHJW022181
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Feb 2019 18:19:18 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1PIJGA1003121;
        Mon, 25 Feb 2019 18:19:16 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Feb 2019 10:19:15 -0800
Subject: Re: [PATCH v4] mm/hugetlb: Fix unsigned overflow in
 __nr_hugepages_store_common()
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Jing Xiangfeng <jingxiangfeng@huawei.com>, mhocko@kernel.org,
        akpm@linux-foundation.org, hughd@google.com, linux-mm@kvack.org,
        n-horiguchi@ah.jp.nec.com, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org
References: <1550885529-125561-1-git-send-email-jingxiangfeng@huawei.com>
 <388cbbf5-7086-1d04-4c49-049021504b9d@oracle.com>
 <alpine.DEB.2.21.1902241913000.34632@chino.kir.corp.google.com>
 <8c167be7-06fa-a8c0-8ee7-0bfad41eaba2@oracle.com>
Message-ID: <13400ee2-3d3b-e5d6-2d78-a770820417de@oracle.com>
Date:   Mon, 25 Feb 2019 10:19:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <8c167be7-06fa-a8c0-8ee7-0bfad41eaba2@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9178 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902250134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2/24/19 7:17 PM, David Rientjes wrote:
>> On Sun, 24 Feb 2019, Mike Kravetz wrote:
>>>> @@ -2423,7 +2423,14 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
>>>>  		 * per node hstate attribute: adjust count to global,
>>>>  		 * but restrict alloc/free to the specified node.
>>>>  		 */
>>>> +		unsigned long old_count = count;
>>>>  		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
>>>> +		/*
>>>> +		 * If user specified count causes overflow, set to
>>>> +		 * largest possible value.
>>>> +		 */
>>>> +		if (count < old_count)
>>>> +			count = ULONG_MAX;
>>>>  		init_nodemask_of_node(nodes_allowed, nid);
>>>>  	} else
>>>>  		nodes_allowed = &node_states[N_MEMORY];
>>>>
>>
>> Looks like this fixes the overflow issue, but isn't there already a 
>> possible underflow since we don't hold hugetlb_lock?  Even if 
>> count == 0, what prevents h->nr_huge_pages_node[nid] being greater than 
>> h->nr_huge_pages here?  I think the per hstate values need to be read with 
>> READ_ONCE() and stored on the stack to do any sane bounds checking.
> 
> Yes, without holding the lock there is the potential for issues.  Looking
> back to when the node specific code was added there is a comment about
> "re-use/share as much of the existing global hstate attribute initialization
> and handling".  I suspect that is the reason for these calculations outside
> the lock.
> 
> As you mention above, nr_huge_pages_node[nid] could be greater than
> nr_huge_pages.  This is true even if we do READ_ONCE().  So, the code would
> need to test for this condition and 'fix up' values or re-read.  It is just
> racy without holding the lock.
> 
> If that is too ugly, then we could just add code for the node specific
> adjustments.  set_max_huge_pages() is only called from here.  It would be
> pretty easy to modify set_max_huge_pages() to take the node specific value
> and do calculations/adjustments under the lock.

Ok, what about just moving the calculation/check inside the lock as in the
untested patch below?

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1c5219193b9e..5afa77dc7bc8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2274,7 +2274,7 @@ static int adjust_pool_surplus(struct hstate *h,
nodemask_t *nodes_allowed,
 }

 #define persistent_huge_pages(h) (h->nr_huge_pages - h->surplus_huge_pages)
-static int set_max_huge_pages(struct hstate *h, unsigned long count,
+static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 						nodemask_t *nodes_allowed)
 {
 	unsigned long min_count, ret;
@@ -2289,6 +2289,23 @@ static int set_max_huge_pages(struct hstate *h, unsigned
long count,
 		goto decrease_pool;
 	}

+	spin_lock(&hugetlb_lock);
+
+	/*
+	 * Check for a node specific request.  Adjust global count, but
+	 * restrict alloc/free to the specified node.
+	 */
+	if (nid != NUMA_NO_NODE) {
+		unsigned long old_count = count;
+		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
+		/*
+		 * If user specified count causes overflow, set to
+		 * largest possible value.
+		 */
+		if (count < old_count)
+			count = ULONG_MAX;
+	}
+
 	/*
 	 * Increase the pool size
 	 * First take pages out of surplus state.  Then make up the
@@ -2300,7 +2317,6 @@ static int set_max_huge_pages(struct hstate *h, unsigned
long count,
 	 * pool might be one hugepage larger than it needs to be, but
 	 * within all the constraints specified by the sysctls.
 	 */
-	spin_lock(&hugetlb_lock);
 	while (h->surplus_huge_pages && count > persistent_huge_pages(h)) {
 		if (!adjust_pool_surplus(h, nodes_allowed, -1))
 			break;
@@ -2421,16 +2437,18 @@ static ssize_t __nr_hugepages_store_common(bool
obey_mempolicy,
 			nodes_allowed = &node_states[N_MEMORY];
 		}
 	} else if (nodes_allowed) {
+		/* Node specific request */
+		init_nodemask_of_node(nodes_allowed, nid);
+	} else {
 		/*
-		 * per node hstate attribute: adjust count to global,
-		 * but restrict alloc/free to the specified node.
+		 * Node specific request, but we could not allocate
+		 * node mask.  Pass in ALL nodes, and clear nid.
 		 */
-		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
-		init_nodemask_of_node(nodes_allowed, nid);
-	} else
+		nid = NUMA_NO_NODE;
 		nodes_allowed = &node_states[N_MEMORY];
+	}

-	err = set_max_huge_pages(h, count, nodes_allowed);
+	err = set_max_huge_pages(h, count, nid, nodes_allowed);
 	if (err)
 		goto out;

-- 
2.17.2

