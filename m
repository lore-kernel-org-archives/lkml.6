Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C41C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBCA206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 00:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GeW81E+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732618AbfBMANW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 19:13:22 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37594 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbfBMANW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 19:13:22 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1D03osC127411;
        Wed, 13 Feb 2019 00:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=i/DRl5Ab8RJflfKksWYbm6JgjdqdldbLWDY4G+e/3hk=;
 b=GeW81E+FpIl/jZBIKGaVE6nhvYyck8B5ybuMX41uaLSwmFrhYOSgD5pLycllWGeHKRo3
 zbY2QGemmqeIsasHRI+w3ykVQv+nfU/JILNsWaLBph79FapWe3vNZ7DphmMsIFnTnb1s
 T3rY4QG+chT/RvrGKYJOKhCTeJeLEpCONm/3svxaupyUeBHxEDLr2MWS+QemYSriAd+n
 B5dKzMgE855IeW4jNebnQo+Xa8cMWP9aBFET4xzIRZbVXyMzH75eIvAGD1rky/eD0Heu
 FeFRjZX+z/L9xxUXKVWOKdZa86SxU5offVhBusMxzx2emOye36SflqgHxkEBibvaw+hM mA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2qhre5f3sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 00:13:13 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1D0D7Mm008885
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 00:13:07 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1D0D60c022977;
        Wed, 13 Feb 2019 00:13:06 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Feb 2019 16:13:06 -0800
Subject: Re: [PATCH] mm,memory_hotplug: Explicitly pass the head to
 isolate_huge_page
To:     Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, david@redhat.com,
        anthony.yznaga@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190208090604.975-1-osalvador@suse.de>
 <20190212083329.GN15609@dhcp22.suse.cz>
 <20190212134546.gubfir6zzwrvmunr@d104.suse.de>
 <20190212144026.GY15609@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <52f7a47c-4a8b-c06d-04c0-48d9bb43823b@oracle.com>
Date:   Tue, 12 Feb 2019 16:13:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212144026.GY15609@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902120162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/19 6:40 AM, Michal Hocko wrote:
> On Tue 12-02-19 14:45:49, Oscar Salvador wrote:
>> On Tue, Feb 12, 2019 at 09:33:29AM +0100, Michal Hocko wrote:
>>>>  
>>>>  		if (PageHuge(page)) {
>>>>  			struct page *head = compound_head(page);
>>>> -			pfn = page_to_pfn(head) + (1<<compound_order(head)) - 1;
>>>>  			if (compound_order(head) > PFN_SECTION_SHIFT) {
>>>>  				ret = -EBUSY;
>>>>  				break;
>>>>  			}
>>>
>>> Why are we doing this, btw? 
>>
>> I assume you are referring to:
>>
>>>>                     if (compound_order(head) > PFN_SECTION_SHIFT) {
>>>>                             ret = -EBUSY;
>>>>                             break;
>>>>                     }
> 
> yes.
> 
>> I thought it was in case we stumble upon a gigantic page, and commit
>> (c8721bbbdd36 mm: memory-hotplug: enable memory hotplug to handle hugepage)
>> confirms it.
>>
>> But I am not really sure if the above condition would still hold on powerpc,
>> I wanted to check it but it is a bit more tricky than it is in x86_64 because
>> of the different hugetlb sizes.
>> Could it be that the above condition is not true, but still the order of that
>> hugetlb page goes beyond MAX_ORDER? It is something I have to check.

Well, commit 94310cbcaa3c ("mm/madvise: enable (soft|hard) offline of
HugeTLB pages at PGD level") should have allowed migration of gigantic
pages.  I believe it was added for 16GB pages on powerpc.  However, due
to subsequent changes I suspsect this no longer works.

> This check doesn't make much sense in principle. Why should we bail out
> based on a section size? We are offlining a pfn range. All that we care
> about is whether the hugetlb is migrateable.

Yes.  Do note that the do_migrate_range is only called from __offline_pages
with a start_pfn that was returned by scan_movable_pages.  scan_movable_pages
has the hugepage_migration_supported check for PageHuge pages.  So, it would
seem to be redundant to do another check in do_migrate_range.

-- 
Mike Kravetz
