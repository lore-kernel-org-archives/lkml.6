Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC45C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB4921758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 23:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kr9U/tTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB4921758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbeHNCG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 22:06:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46506 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbeHNCG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 22:06:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7DNJgvU036153;
        Mon, 13 Aug 2018 23:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=FNFhU4laZjNJo3ZEv9PCdM+hVcyR4mFJPemB2qPgdOc=;
 b=Kr9U/tTJhmycd3dxMffnrXnG6qmPtyIOjHl/SQ+L08A1yRtXQY2QWGlpPXSiNnPh1uPL
 RfgRa/TqNbOuYIUeLOBXesnqYYgc9Z9FkupLygjlUy1KrbeWMQ/3crSgTEO1Gacjpmas
 dbI/UXXGuCiKw6o7YTSsPHxaqHBa4p+cVFnKL9qmSXRWYygdwBxFmqeqX4vMZ6dH1n8Z
 t++HqZKI8hZ4hKV7uOGbq9Wn7ONKp8rCRduxu9j/448gOma4STotPmnj9MZe4+tdpNN6
 d58Zc2ieeKrw07+yBk6/a6e6MHgzKfrx4NqLPlbcPmWm5pBgeIIsZXGb+KQJWs1xB+5O aQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2ksqrp6akr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Aug 2018 23:21:47 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7DNLjI1022417
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Aug 2018 23:21:46 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7DNLh86015214;
        Mon, 13 Aug 2018 23:21:43 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Aug 2018 16:21:43 -0700
Subject: Re: [PATCH] mm: migration: fix migration of huge PMD shared pages
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180813034108.27269-1-mike.kravetz@oracle.com>
 <20180813105821.j4tg6iyrdxgwyr3y@kshutemo-mobl1>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d4cf0f85-e010-36f2-3fae-f7983e4f6505@oracle.com>
Date:   Mon, 13 Aug 2018 16:21:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180813105821.j4tg6iyrdxgwyr3y@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8984 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=971
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808130233
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/13/2018 03:58 AM, Kirill A. Shutemov wrote:
> On Sun, Aug 12, 2018 at 08:41:08PM -0700, Mike Kravetz wrote:
>> The page migration code employs try_to_unmap() to try and unmap the
>> source page.  This is accomplished by using rmap_walk to find all
>> vmas where the page is mapped.  This search stops when page mapcount
>> is zero.  For shared PMD huge pages, the page map count is always 1
>> not matter the number of mappings.  Shared mappings are tracked via
>> the reference count of the PMD page.  Therefore, try_to_unmap stops
>> prematurely and does not completely unmap all mappings of the source
>> page.
>>
>> This problem can result is data corruption as writes to the original
>> source page can happen after contents of the page are copied to the
>> target page.  Hence, data is lost.
>>
>> This problem was originally seen as DB corruption of shared global
>> areas after a huge page was soft offlined.  DB developers noticed
>> they could reproduce the issue by (hotplug) offlining memory used
>> to back huge pages.  A simple testcase can reproduce the problem by
>> creating a shared PMD mapping (note that this must be at least
>> PUD_SIZE in size and PUD_SIZE aligned (1GB on x86)), and using
>> migrate_pages() to migrate process pages between nodes.
>>
>> To fix, have the try_to_unmap_one routine check for huge PMD sharing
>> by calling huge_pmd_unshare for hugetlbfs huge pages.  If it is a
>> shared mapping it will be 'unshared' which removes the page table
>> entry and drops reference on PMD page.  After this, flush caches and
>> TLB.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>> I am not %100 sure on the required flushing, so suggestions would be
>> appreciated.  This also should go to stable.  It has been around for
>> a long time so still looking for an appropriate 'fixes:'.
> 
> I believe we need flushing. And huge_pmd_unshare() usage in
> __unmap_hugepage_range() looks suspicious: I don't see how we flush TLB in
> that case.

Thanks Kirill,

__unmap_hugepage_range() has two callers:
1) unmap_hugepage_range, which wraps the call with tlb_gather_mmu and
   tlb_finish_mmu on the range.  IIUC, this should cause an appropriate
   TLB flush.
2) __unmap_hugepage_range_final via unmap_single_vma.  unmap_single_vma
  has three callers:
  - unmap_vmas which assumes the caller will flush the whole range after
    return.
  - zap_page_range wraps the call with tlb_gather_mmu/tlb_finish_mmu
  - zap_page_range_single wraps the call with tlb_gather_mmu/tlb_finish_mmu

So, it appears we are covered.  But, I could be missing something.

My primary reason for asking the question was with respect to the code
added to try_to_unmap_one.  In my testing, the changes I added appeared
to be required.  Just wanted to make sure.

I need to fix a build issue and will send another version.
-- 
Mike Kravetz
