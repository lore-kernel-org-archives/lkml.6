Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0AFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41CCB20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 20:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y5KS5BvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41CCB20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbeK3H7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 02:59:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56472 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeK3H7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 02:59:47 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wATKhqTZ162622;
        Thu, 29 Nov 2018 20:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=grgPLULET8+uSvpuhndEgkZYH2nwxusd0Dk7CvvRPH0=;
 b=Y5KS5BvV6CtOpR46zY0HFs0fTpF4khwgCndzZidfk6kcHOaox5tajBmRe7xE/boevSIO
 BYcEW+Yhu08cpg4DutbJltngbX9/1EZIpULvXWUKMhrCAaRnzyhUzyz05TcrqgOwCeRq
 NK94/89BPrSmaO1takj0CyJ+NYXSg+qq+VhYHql3uLw+BXLPGi4LbELgiBOTrmG/kGIX
 IEW1TLpDKj/6XZKMWIXnCakoeaorD1raqp2+ZRfYMHa4iaSW9XzvxWYlmz8MwEo6u38u
 2z4IqEiaV05B9EQimYbDh3+/zCo45lHnM4PWnZ1ijQBqKrL3lq9O9n15EI1enBeuAJ9c XA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2nxy9rjjyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 20:52:57 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wATKquKN023427
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Nov 2018 20:52:57 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wATKquhU012122;
        Thu, 29 Nov 2018 20:52:56 GMT
Received: from [172.29.11.27] (/170.173.8.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Nov 2018 12:52:55 -0800
Subject: Re: [PATCH] hugetlbfs: Call VM_BUG_ON_PAGE earlier in free_huge_page
To:     William Kucharski <william.kucharski@oracle.com>,
        Yongkai Wu <nic.wuyk@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, nic_w@163.com,
        Michal Hocko <mhocko@kernel.org>
References: <1543491843-23438-1-git-send-email-nic_w@163.com>
 <0B408D50-D101-4457-B779-5951DEE0435A@oracle.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <211f80a2-9347-129c-0001-5f4abfd0b7dc@oracle.com>
Date:   Thu, 29 Nov 2018 12:52:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <0B408D50-D101-4457-B779-5951DEE0435A@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9092 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811290173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/18 5:51 AM, William Kucharski wrote:
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>
> 
>> On Nov 29, 2018, at 4:44 AM, Yongkai Wu <nic.wuyk@gmail.com> wrote:
>>
>> A stack trace was triggered by VM_BUG_ON_PAGE(page_mapcount(page),
>> page) in free_huge_page().  Unfortunately, the page->mapping field
>> was set to NULL before this test.  This made it more difficult to
>> determine the root cause of the problem.
>>
>> Move the VM_BUG_ON_PAGE tests earlier in the function so that if
>> they do trigger more information is present in the page struct.
>>
>> Signed-off-by: Yongkai Wu <nic_w@163.com>
>> Acked-by: Michal Hocko <mhocko@suse.com>
>> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

Thank you for fixing the formatting and commit message.

Adding Andrew on so he can add to his tree as appropriatre. Also Cc'ing Michal.

>> ---
>> mm/hugetlb.c | 5 +++--
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 7f2a28a..14ef274 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1248,10 +1248,11 @@ void free_huge_page(struct page *page)
>> 		(struct hugepage_subpool *)page_private(page);
>> 	bool restore_reserve;
>>
>> -	set_page_private(page, 0);
>> -	page->mapping = NULL;
>> 	VM_BUG_ON_PAGE(page_count(page), page);
>> 	VM_BUG_ON_PAGE(page_mapcount(page), page);
>> +
>> +	set_page_private(page, 0);
>> +	page->mapping = NULL;
>> 	restore_reserve = PagePrivate(page);
>> 	ClearPagePrivate(page);
>>
>> -- 
>> 1.8.3.1
>>
> 


-- 
Mike Kravetz
