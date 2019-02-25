Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948F0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B9320C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o+sIwtjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfBYQte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:49:34 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55838 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbfBYQte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:49:34 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1PGi1fu068593;
        Mon, 25 Feb 2019 16:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=2DavdlfEcPUnZ5zlrCm/gMnuNXvBK6a6jQ40MXyfRN4=;
 b=o+sIwtjme3BGl5X7m88crmOr9mM+RYVdMKlB5tRKJTyW5GSs+1NPVHbFVM3kq82d+0Re
 OWptQ8ccl8MWYxNUxkjbYtdRTdoEfgyRgVr7zeaVTS+WDza8nuslcA3KDwxVmmrz9mUv
 y8mFGi8SqFhqTj8QxDHTbHFBDZi9dYoseBr8RyxbuppSJEicGyZdWOWxdhb5LyCF84LJ
 Jo8AeKK02wVuZQ5ctcs9HfVxSbGzQwUhzEXYqvoD12ANXZlbM3q30jxmwkVk+wGb8RAh
 KeE0Dn5ySuuz7nVIqy72r8JhOzbN2VAXj89i8qO1EorP9nG5dQnvAeCEggaOHDcp8M80 hg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2qtupdyg7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Feb 2019 16:49:15 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1PGn9mB026766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Feb 2019 16:49:10 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1PGn78D019409;
        Mon, 25 Feb 2019 16:49:08 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Feb 2019 08:49:07 -0800
Subject: Re: [PATCH v4] mm/hugetlb: Fix unsigned overflow in
 __nr_hugepages_store_common()
To:     David Rientjes <rientjes@google.com>
Cc:     Jing Xiangfeng <jingxiangfeng@huawei.com>, mhocko@kernel.org,
        akpm@linux-foundation.org, hughd@google.com, linux-mm@kvack.org,
        n-horiguchi@ah.jp.nec.com, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org
References: <1550885529-125561-1-git-send-email-jingxiangfeng@huawei.com>
 <388cbbf5-7086-1d04-4c49-049021504b9d@oracle.com>
 <alpine.DEB.2.21.1902241913000.34632@chino.kir.corp.google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8c167be7-06fa-a8c0-8ee7-0bfad41eaba2@oracle.com>
Date:   Mon, 25 Feb 2019 08:49:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902241913000.34632@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9178 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902250123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/19 7:17 PM, David Rientjes wrote:
> On Sun, 24 Feb 2019, Mike Kravetz wrote:
> 
>>> User can change a node specific hugetlb count. i.e.
>>> /sys/devices/system/node/node1/hugepages/hugepages-2048kB/nr_hugepages
>>> the calculated value of count is a total number of huge pages. It could
>>> be overflow when a user entering a crazy high value. If so, the total
>>> number of huge pages could be a small value which is not user expect.
>>> We can simply fix it by setting count to ULONG_MAX, then it goes on. This
>>> may be more in line with user's intention of allocating as many huge pages
>>> as possible.
>>>
>>> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
>>
>> Thank you.
>>
>> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
>>
>>> ---
>>>  mm/hugetlb.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index afef616..6688894 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -2423,7 +2423,14 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
>>>  		 * per node hstate attribute: adjust count to global,
>>>  		 * but restrict alloc/free to the specified node.
>>>  		 */
>>> +		unsigned long old_count = count;
>>>  		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
>>> +		/*
>>> +		 * If user specified count causes overflow, set to
>>> +		 * largest possible value.
>>> +		 */
>>> +		if (count < old_count)
>>> +			count = ULONG_MAX;
>>>  		init_nodemask_of_node(nodes_allowed, nid);
>>>  	} else
>>>  		nodes_allowed = &node_states[N_MEMORY];
>>>
> 
> Looks like this fixes the overflow issue, but isn't there already a 
> possible underflow since we don't hold hugetlb_lock?  Even if 
> count == 0, what prevents h->nr_huge_pages_node[nid] being greater than 
> h->nr_huge_pages here?  I think the per hstate values need to be read with 
> READ_ONCE() and stored on the stack to do any sane bounds checking.

Yes, without holding the lock there is the potential for issues.  Looking
back to when the node specific code was added there is a comment about
"re-use/share as much of the existing global hstate attribute initialization
and handling".  I suspect that is the reason for these calculations outside
the lock.

As you mention above, nr_huge_pages_node[nid] could be greater than
nr_huge_pages.  This is true even if we do READ_ONCE().  So, the code would
need to test for this condition and 'fix up' values or re-read.  It is just
racy without holding the lock.

If that is too ugly, then we could just add code for the node specific
adjustments.  set_max_huge_pages() is only called from here.  It would be
pretty easy to modify set_max_huge_pages() to take the node specific value
and do calculations/adjustments under the lock.
-- 
Mike Kravetz
