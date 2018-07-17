Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6B2ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B869320693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TwkpM2aS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B869320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbeGQUpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:45:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48290 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730052AbeGQUpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:45:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6HK4RR4156713;
        Tue, 17 Jul 2018 20:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=JkurF3O8WqbmuAbA6yGjEcENe7XtxbtUau59CsaAQy4=;
 b=TwkpM2aS7PaoUYhiZKAk8Crb8C3LJFx7J5vXRnhZv7/VhD1CRVAq5RaXwW/h4zpNV9QV
 sN2eIef+/sIXHAg0thPTdaKe8srRCHFZzsScQIXbcaEtUpkj8aWBLFKSSsQf4IEoJtg2
 9Y8ZYhwNhHYXhMcZ2j9uRHMqZ6DlqxQKd7d/txtRNglom87Q+MaBhBiP4yJ167JLgTJD
 mhbYFl5mgw42q6Unj6LK5SOB26dy6eR5dNCKU2pLP/3wx3ePAECfMgnyjhPxg1xvcIdt
 uY+FtY8Pl4SAfEi5pWwQIjsOvxxbIEd/gHIeQi0L/VGcsB82izti0w/+BGgFaSX7N2ut Jw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2k7a342aw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 20:10:43 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6HKAfXr026610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 20:10:42 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6HKAe6G002678;
        Tue, 17 Jul 2018 20:10:40 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 13:10:40 -0700
Subject: Re: [PATCH v2 1/2] mm: fix race on soft-offlining free huge pages
To:     Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        xishi.qiuxishi@alibaba-inc.com, zy.zhengyi@alibaba-inc.com,
        linux-kernel@vger.kernel.org
References: <1531805552-19547-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1531805552-19547-2-git-send-email-n-horiguchi@ah.jp.nec.com>
 <20180717142743.GJ7193@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <773a2f4e-c420-e973-cadd-4144730d28e8@oracle.com>
Date:   Tue, 17 Jul 2018 13:10:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180717142743.GJ7193@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8957 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807170209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/17/2018 07:27 AM, Michal Hocko wrote:
> On Tue 17-07-18 14:32:31, Naoya Horiguchi wrote:
>> There's a race condition between soft offline and hugetlb_fault which
>> causes unexpected process killing and/or hugetlb allocation failure.
>>
>> The process killing is caused by the following flow:
>>
>>   CPU 0               CPU 1              CPU 2
>>
>>   soft offline
>>     get_any_page
>>     // find the hugetlb is free
>>                       mmap a hugetlb file
>>                       page fault
>>                         ...
>>                           hugetlb_fault
>>                             hugetlb_no_page
>>                               alloc_huge_page
>>                               // succeed
>>       soft_offline_free_page
>>       // set hwpoison flag
>>                                          mmap the hugetlb file
>>                                          page fault
>>                                            ...
>>                                              hugetlb_fault
>>                                                hugetlb_no_page
>>                                                  find_lock_page
>>                                                    return VM_FAULT_HWPOISON
>>                                            mm_fault_error
>>                                              do_sigbus
>>                                              // kill the process
>>
>>
>> The hugetlb allocation failure comes from the following flow:
>>
>>   CPU 0                          CPU 1
>>
>>                                  mmap a hugetlb file
>>                                  // reserve all free page but don't fault-in
>>   soft offline
>>     get_any_page
>>     // find the hugetlb is free
>>       soft_offline_free_page
>>       // set hwpoison flag
>>         dissolve_free_huge_page
>>         // fail because all free hugepages are reserved
>>                                  page fault
>>                                    ...
>>                                      hugetlb_fault
>>                                        hugetlb_no_page
>>                                          alloc_huge_page
>>                                            ...
>>                                              dequeue_huge_page_node_exact
>>                                              // ignore hwpoisoned hugepage
>>                                              // and finally fail due to no-mem
>>
>> The root cause of this is that current soft-offline code is written
>> based on an assumption that PageHWPoison flag should beset at first to
>> avoid accessing the corrupted data.  This makes sense for memory_failure()
>> or hard offline, but does not for soft offline because soft offline is
>> about corrected (not uncorrected) error and is safe from data lost.
>> This patch changes soft offline semantics where it sets PageHWPoison flag
>> only after containment of the error page completes successfully.
> 
> Could you please expand on the worklow here please? The code is really
> hard to grasp. I must be missing something because the thing shouldn't
> be really complicated. Either the page is in the free pool and you just
> remove it from the allocator (with hugetlb asking for a new hugeltb page
> to guaratee reserves) or it is used and you just migrate the content to
> a new page (again with the hugetlb reserves consideration). Why should
> PageHWPoison flag ordering make any relevance?

My understanding may not be corect, but just looking at the current code
for soft_offline_free_page helps me understand:

static void soft_offline_free_page(struct page *page)
{
	struct page *head = compound_head(page);

	if (!TestSetPageHWPoison(head)) {
		num_poisoned_pages_inc();
		if (PageHuge(head))
			dissolve_free_huge_page(page);
	}
}

The HWPoison flag is set before even checking to determine if the huge
page can be dissolved.  So, someone could could attempt to pull the page
off the free list (if free) or fault/map it (if already associated with
a file) which leads to the  failures described above.  The patches ensure
that we only set HWPoison after successfully dissolving the page. At least
that is how I understand it.

It seems that soft_offline_free_page can be called for in use pages.
Certainly, that is the case in the first workflow above.  With the
suggested changes, I think this is OK for huge pages.  However, it seems
that setting HWPoison on a in use non-huge page could cause issues?

While looking at the code, I noticed this comment in __get_any_page()
        /*
         * When the target page is a free hugepage, just remove it
         * from free hugepage list.
         */
Did that apply to some code that was removed?  It does not seem to make
any sense in that routine.
-- 
Mike Kravetz
