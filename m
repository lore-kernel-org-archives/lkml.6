Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F288C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F368218D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 00:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m1hW66jq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbfB0ADp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 19:03:45 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35528 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfB0ADo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 19:03:44 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1QNxH1f033438;
        Wed, 27 Feb 2019 00:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=VyO4ZrBMdrud25lLhZHSrL2iH8LB0S9KEvRat9Q0vfE=;
 b=m1hW66jqcPB1r6qR7HDIFFGoFpEGxlCnx8ykYAwqwsZbJ2e4r5C9xsAZONtel47j9BEG
 j6gQrLZ+AEzsbkhhlXSEJlADG2a2DPP8DyOHxAkZobIiDu/8jcK8dEp2Mmawp52xdsSo
 CO6J8++gNHQ0ZjEpZPfc6y5WNn4GcqFWzOVMw5/W1GssG9OsF49JyayOZlQeAsGeJ8kd
 iGwD8nsyWJaAZDHvIR3G1w448ljXEW1JYF+qNqq6kSg6EBBDEnMiBKvnuMEWZPH12kwi
 Hj+KnDsOxW90jpV7/YUbRc4lY/PHEZMRs6D9Rrd/x4iQBb0tIH/4tM+fjoSguSzymlws hA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qtupe81m0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 00:03:27 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1R03Qcd008984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 00:03:26 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1R03PHk020730;
        Wed, 27 Feb 2019 00:03:25 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Feb 2019 16:03:24 -0800
Subject: Re: [PATCH v4] mm/hugetlb: Fix unsigned overflow in
 __nr_hugepages_store_common()
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>
Cc:     Jing Xiangfeng <jingxiangfeng@huawei.com>, mhocko@kernel.org,
        hughd@google.com, linux-mm@kvack.org, n-horiguchi@ah.jp.nec.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org
References: <1550885529-125561-1-git-send-email-jingxiangfeng@huawei.com>
 <388cbbf5-7086-1d04-4c49-049021504b9d@oracle.com>
 <alpine.DEB.2.21.1902241913000.34632@chino.kir.corp.google.com>
 <8c167be7-06fa-a8c0-8ee7-0bfad41eaba2@oracle.com>
 <13400ee2-3d3b-e5d6-2d78-a770820417de@oracle.com>
 <alpine.DEB.2.21.1902251116180.167839@chino.kir.corp.google.com>
 <5C74A2DA.1030304@huawei.com>
 <alpine.DEB.2.21.1902252220310.40851@chino.kir.corp.google.com>
 <e2bded2f-40ca-c308-5525-0a21777ed221@oracle.com>
 <20190226143620.c6af15c7c897d3362b191e36@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <086c4a4b-a37d-f144-00c0-d9a4062cc5fe@oracle.com>
Date:   Tue, 26 Feb 2019 16:03:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190226143620.c6af15c7c897d3362b191e36@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9179 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902260162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/19 2:36 PM, Andrew Morton wrote:
>> ...
>>
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -2274,7 +2274,7 @@ static int adjust_pool_surplus(struct hstate *h,
>> nodemask_t *nodes_allowed,
> 
> Please tweak that email client to prevent the wordwraps.

Sorry about that.

>> +	/*
>> +	 * Check for a node specific request.  Adjust global count, but
>> +	 * restrict alloc/free to the specified node.
>> +	 */

Better comment might be:

	/*
	 * Check for a node specific request.
	 * Changing node specific huge page count may require a corresponding
	 * change to the global count.  In any case, the passed node mask
	 * (nodes_allowed) will restrict alloc/free to the specified node.
	 */

>> +	if (nid != NUMA_NO_NODE) {
>> +		unsigned long old_count = count;
>> +		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
>> +		/*
>> +		 * If user specified count causes overflow, set to
>> +		 * largest possible value.
>> +		 */

Updated comment:
		/*
		 * User may have specified a large count value which caused the
		 * above calculation to overflow.  In this case, they wanted
		 * to allocate as many huge pages as possible.  Set count to
		 * largest possible value to align with their intention.
		 */

>> +		if (count < old_count)
>> +			count = ULONG_MAX;
>> +	}
> 
> The above two comments explain the code, but do not reveal the
> reasoning behind the policy decisions which that code implements.
> 
>> ...
>>
>> +	} else {
>>  		/*
>> -		 * per node hstate attribute: adjust count to global,
>> -		 * but restrict alloc/free to the specified node.
>> +		 * Node specific request, but we could not allocate
>> +		 * node mask.  Pass in ALL nodes, and clear nid.
>>  		 */
> 
> Ditto here, somewhat.

I was just going to update the comments and send you a new patch, but
but your comment got me thinking about this situation.  I did not really
change the way this code operates.  As a reminder, the original code is like:

NODEMASK_ALLOC(nodemask_t, nodes_allowed, GFP_KERNEL | __GFP_NORETRY);

if (nid == NUMA_NO_NODE) {
	/* do something */
} else if (nodes_allowed) {
	/* do something else */
} else {
	nodes_allowed = &node_states[N_MEMORY];
}

So, the only way we get to that final else if if we can not allocate
a node mask (kmalloc a few words).  Right?  I wonder why we should
even try to continue in this case.  Why not just return right there?

The specified count value is either a request to increase number of
huge pages or decrease.  If we can't allocate a few words, we certainly
are not going to find memory to create huge pages.  There 'might' be
surplus pages which can be converted to permanent pages.  But remember
this is a 'node specific' request and we can't allocate a mask to pass
down to the conversion routines.  So, chances are good we would operate
on the wrong node.  The same goes for a request to 'free' huge pages.
Since, we can't allocate a node mask we are likely to free them from
the wrong node.

Unless my reasoning above is incorrect, I think that final else block
in __nr_hugepages_store_common() is wrong.

Any additional thoughts?
-- 
Mike Kravetz
