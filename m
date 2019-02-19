Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65288C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264212083E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SOZEFbEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbfBSXpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:45:39 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53664 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfBSXpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:45:39 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1JNYAQH065206;
        Tue, 19 Feb 2019 23:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=yGxVKhrftDygTl5lZaO5v48lN0wf8DRvUMBFEzWt4Wo=;
 b=SOZEFbEGvRkQZqOz8LPLHXKMYDOgYA7ij4eAPkZzZlmxXyT/erU4AIsh+Z1S+tXKyyKo
 NbHyJdn2L30kQFSp76mp07fAqZicJhvcXHrdd5+oxa2PqGfNx8jgrauILV1dNLOfWvzz
 K+OLbAHlIc6o1VFqLmajs+DbqWIxLycTYamZmSsRvWt0yrZEycIXxcheutL5pKJBlOxc
 tyeWECWuaw4T379dgazMfgH6kB765enFl+1OxWDJH3b12Y4iPDnvKlaIa7H79D4HNRkx
 +5/9UKev37345KtuaZ4aDuO3PUxZFTe/+DWoVMy2HsEb4m8nkJsoAmJJQLN6XKbIlZ8w BA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2qp81e6n2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Feb 2019 23:45:22 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1JNjMgQ030083
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Feb 2019 23:45:22 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1JNjKKv019543;
        Tue, 19 Feb 2019 23:45:21 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Feb 2019 15:45:20 -0800
Subject: Re: [PATCH] mm/hugetlb: Fix unsigned overflow in
 __nr_hugepages_store_common()
To:     Michal Hocko <mhocko@kernel.org>,
        Jingxiangfeng <jingxiangfeng@huawei.com>
Cc:     akpm@linux-foundation.org, hughd@google.com,
        n-horiguchi@ah.jp.nec.com, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org
References: <1550323872-119049-1-git-send-email-jingxiangfeng@huawei.com>
 <20190218092750.GF4525@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7ec68c26-3caf-0446-9c93-461025c51c01@oracle.com>
Date:   Tue, 19 Feb 2019 15:45:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218092750.GF4525@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902190160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/19 1:27 AM, Michal Hocko wrote:
> On Sat 16-02-19 21:31:12, Jingxiangfeng wrote:
>> From: Jing Xiangfeng <jingxiangfeng@huawei.com>
>>
>> We can use the following command to dynamically allocate huge pages:
>> 	echo NR_HUGEPAGES > /proc/sys/vm/nr_hugepages
>> The count in  __nr_hugepages_store_common() is parsed from /proc/sys/vm/nr_hugepages,
>> The maximum number of count is ULONG_MAX,
>> the operation 'count += h->nr_huge_pages - h->nr_huge_pages_node[nid]' overflow and count will be a wrong number.
> 
> Could you be more specific of what is the runtime effect on the
> overflow? I haven't checked closer but I would assume that we will
> simply shrink the pool size because count will become a small number.
> 

Well, the first thing to note is that this code only applies to case where
someone is changing a node specific hugetlb count.  i.e.
/sys/devices/system/node/node1/hugepages/hugepages-2048kB
In this case, the calculated value of count is a maximum or minimum total
number of huge pages.  However, only the number of huge pages on the specified
node is adjusted to try and achieve this maximum or minimum.

So, in the case of overflow the number of huge pages on the specified node
could be reduced.  I say 'could' because it really is dependent on previous
values.  In some situations the node specific value will be increased.

Minor point is that the description in the commit message does not match
the code changed.

> Is there any reason to report an error in that case? We do not report
> errors when we cannot allocate the requested number of huge pages so why
> is this case any different?

Another issue to consider is that h->nr_huge_pages is an unsigned long,
and h->nr_huge_pages_node[] is an unsigned int.  The sysfs store routines
treat them both as unsigned longs.  Ideally, the store routines should
distinguish between the two.

In reality, an actual overflow is unlikely.  If my math is correct (not
likely) it would take something like 8 Petabytes to overflow the node specific
counts.

In the case of a user entering a crazy high value and causing an overflow,
an error return might not be out of line.  Another option would be to simply
set count to ULONG_MAX if we detect overflow (or UINT_MAX if we are paranoid)
and continue on.  This may be more in line with user's intention of allocating
as many huge pages as possible.

Thoughts?
-- 
Mike Kravetz
