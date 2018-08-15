Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6598AC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 00:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050F22154D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 00:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L05ETR0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050F22154D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeHODFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 23:05:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36864 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbeHODFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 23:05:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7F0DZQM070761;
        Wed, 15 Aug 2018 00:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=NdlPTBLLTtynXuhR3+yfPpeThgEsUQ9eY8Qyb8KpBVA=;
 b=L05ETR0IbQt6zhbc5pwmAuUuPdke2llPs3n2MW4LEnYFeKR+rVKwNam4EwwU1RLnudUI
 ykfiKyRUH5gJXDJ+XjlWZu5a6jnKm5mSstT9Ofs/k7E1BbgN/tnSPdaHjke3WsnMXfN+
 eKPuMUZgm+Yf/IujsraJv7Y1Dc10UA4TqZcu5EyUUUs0K1ndy61hHKIA+AJ76DcdB68m
 O9+bRITkJV03itBiKgSp5ZkfvIyq4wPIKbnHhZfCK7WHkbap3JasCVxwMRE0Gnx432js
 LwN4gIvf/cCBrBdY9e4Jhu3khdtAOSx5E7XiEzExDV0G/R+p919daNOTCbf61wQ6zHB9 Ew== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2ksreq2nhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Aug 2018 00:16:02 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7F0G03Y028114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Aug 2018 00:16:00 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7F0Fww0024575;
        Wed, 15 Aug 2018 00:15:58 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Aug 2018 17:15:58 -0700
Subject: Re: [PATCH] mm: migration: fix migration of huge PMD shared pages
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180813034108.27269-1-mike.kravetz@oracle.com>
 <20180813105821.j4tg6iyrdxgwyr3y@kshutemo-mobl1>
 <d4cf0f85-e010-36f2-3fae-f7983e4f6505@oracle.com>
 <20180814084837.nl7dkea7aov2pzao@black.fi.intel.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <17bfe24d-957f-2985-f134-3ebe2648aecb@oracle.com>
Date:   Tue, 14 Aug 2018 17:15:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180814084837.nl7dkea7aov2pzao@black.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8985 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808150001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 01:48 AM, Kirill A. Shutemov wrote:
> On Mon, Aug 13, 2018 at 11:21:41PM +0000, Mike Kravetz wrote:
>> On 08/13/2018 03:58 AM, Kirill A. Shutemov wrote:
>>> On Sun, Aug 12, 2018 at 08:41:08PM -0700, Mike Kravetz wrote:
>>>> I am not %100 sure on the required flushing, so suggestions would be
>>>> appreciated.  This also should go to stable.  It has been around for
>>>> a long time so still looking for an appropriate 'fixes:'.
>>>
>>> I believe we need flushing. And huge_pmd_unshare() usage in
>>> __unmap_hugepage_range() looks suspicious: I don't see how we flush TLB in
>>> that case.
>>
>> Thanks Kirill,
>>
>> __unmap_hugepage_range() has two callers:
>> 1) unmap_hugepage_range, which wraps the call with tlb_gather_mmu and
>>    tlb_finish_mmu on the range.  IIUC, this should cause an appropriate
>>    TLB flush.
>> 2) __unmap_hugepage_range_final via unmap_single_vma.  unmap_single_vma
>>   has three callers:
>>   - unmap_vmas which assumes the caller will flush the whole range after
>>     return.
>>   - zap_page_range wraps the call with tlb_gather_mmu/tlb_finish_mmu
>>   - zap_page_range_single wraps the call with tlb_gather_mmu/tlb_finish_mmu
>>
>> So, it appears we are covered.  But, I could be missing something.
> 
> My problem here is that the mapping that moved by huge_pmd_unshare() in
> not accounted into mmu_gather and can be missed on tlb_finish_mmu().

Ah, I think I now see the issue you are concerned with.

When huge_pmd_unshare succeeds we effectively unmap a PUD_SIZE area.
The routine __unmap_hugepage_range may only have been passed a range
that is a subset of PUD_SIZE.  In the case I was trying to address,
try_to_unmap_one() the 'range' will certainly be less than PUD_SIZE.
Upon further thought, I think that even in the case of try_to_unmap_one
we should flush PUD_SIZE range.

My first thought would be to embed this flushing within huge_pmd_unshare
itself.  Perhaps, whenever huge_pmd_unshare succeeds we should do an
explicit:
flush_cache_range(PUD_SIZE)
flush_tlb_range(PUD_SIZE)
mmu_notifier_invalidate_range(PUD_SIZE)
That would take some of the burden off the callers of huge_pmd_unshare.
However, I am not sure if the flushing calls above play nice in all the
calling environments.  I'll look into it some more, but would appreciate
additional comments.

-- 
Mike Kravetz
