Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816B3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385702077B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 17:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SayXUW/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 385702077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeHWUdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:33:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46714 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbeHWUdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:33:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7NGwod8169079;
        Thu, 23 Aug 2018 17:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=+vfOacba25ewEB/Hv6P+3QqgxyH0xomkmTfF8xQf3Qo=;
 b=SayXUW/uYxwF3lIiQkSYK8dJtjN9G2drVFgJ2d/XCQFBXs7Ji4jPqPAszBZ+iLBQeNNP
 WobMsTpdHu4k7mpP8/JbgG++MTaGJN910Qa8HTsgYNoD432wz5Zp84epfqbXmriDnLK/
 /WJw/mLFZ6b4Wlh2/JuFzsrxXpt3ElDVjc7N2+BQpmMHcRfcpg77PT0FCcOtYlWJXtHd
 xigGiet5craYekRrSC9IqTd6ZH7ZsgksaNIkbZuZvMlP+5QkYE4gJFWlPMTZry4hjN5a
 obg0TnMpTBaSuQisEjZWWDtSWzF3UQGpJ30CAP4rw5twC/tT6mIFcAnOgfAjE9VirsW9 zg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2kxbdqapt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Aug 2018 17:02:04 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7NH1wPA016060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Aug 2018 17:01:59 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7NH1vJJ016809;
        Thu, 23 Aug 2018 17:01:57 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Aug 2018 10:01:57 -0700
Subject: Re: [PATCH v3 1/2] mm: migration: fix migration of huge PMD shared
 pages
To:     Michal Hocko <mhocko@kernel.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
References: <20180821205902.21223-2-mike.kravetz@oracle.com>
 <201808220831.eM0je51n%fengguang.wu@intel.com>
 <975b740d-26a6-eb3f-c8ca-1a9995d0d343@oracle.com>
 <20180823124855.GI29735@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <12ea5339-f2b1-62b4-6d37-57d737fac34a@oracle.com>
Date:   Thu, 23 Aug 2018 10:01:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180823124855.GI29735@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8994 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808230176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/23/2018 05:48 AM, Michal Hocko wrote:
> On Tue 21-08-18 18:10:42, Mike Kravetz wrote:
> [...]
> 
> OK, after burning myself when trying to be clever here it seems like
> your proposed solution is indeed simpler.
> 
>> +bool huge_pmd_sharing_possible(struct vm_area_struct *vma,
>> +				unsigned long *start, unsigned long *end)
>> +{
>> +	unsigned long check_addr = *start;
>> +	bool ret = false;
>> +
>> +	if (!(vma->vm_flags & VM_MAYSHARE))
>> +		return ret;
>> +
>> +	for (check_addr = *start; check_addr < *end; check_addr += PUD_SIZE) {
>> +		unsigned long a_start = check_addr & PUD_MASK;
>> +		unsigned long a_end = a_start + PUD_SIZE;
> 
> I guess this should be rather in HPAGE_SIZE * PTRS_PER_PTE units as
> huge_pmd_unshare does.

Sure, I can do that.

However, I consider the statement making that calculation in huge_pmd_unshare
to be VERY ugly and confusing code.

	*addr = ALIGN(*addr, HPAGE_SIZE * PTRS_PER_PTE) - HPAGE_SIZE;

Note that it is adjusting the value of passed argument 'unsigned long *addr'.
This argument/value is part of a loop condition in all current callers of
huge_pmd_unshare.  For instance:

	for (; address < end; address += huge_page_size(h)) {

So, that calculation in huge_pmd_unshare gets the calling loop back to
the starting address of the unmapped range.  It even takes the loop increment
'huge_page_size(h)' into account.  That is why that ' - HPAGE_SIZE' is at
the end of the calculation.

ugly and confusing!  And on my list of things to clean up.
-- 
Mike Kravetz
