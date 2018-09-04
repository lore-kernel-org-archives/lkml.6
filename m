Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C7CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384A920659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UjlCFeYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384A920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeIDWWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:22:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43324 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeIDWWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:22:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w84HrjPF040492;
        Tue, 4 Sep 2018 17:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=LLKOSJjrLwfIdtPxwafP7grqTYqRndZCGCyv4pImstU=;
 b=UjlCFeYuJH/krsAfj9Mb+Q/hj4Z7CI4jB4Rmwgh2Td7v3YKFo8Bd3ItEdTGZzuHnHIs9
 TnxmeWOQ+lO24dYGz+EEjzaOCHnatcdmdxNxeuaGz8YYZrVSpovibzAWYy62iX46CVjH
 ZAktpbn1mdWdCwYCPXiQvM5W2yFUcMlUyop9CF5Iyjy0YDpsRhdELVEjpAIPeBMpF5S3
 gmywhjNit9MYEUyGcJCCbC5iD17TF5U1CRM1It8DCUgsJXTwM7xNLsaoqcgTtu/I60pA
 j2nk7CIfSlVT/JDyHNPVqW3Tk1tNirx404rMevn4wPRud1f9DY3bNmZFapAz52UiZLCv pg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2m7kdqeq9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Sep 2018 17:56:03 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w84Hu0ia007349
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Sep 2018 17:56:01 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w84HtuPb005698;
        Tue, 4 Sep 2018 17:55:56 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Sep 2018 10:55:56 -0700
Subject: Re: [PATCH v6 1/2] mm: migration: fix migration of huge PMD shared
 pages
To:     Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, linux-rdma@vger.kernel.org,
        Matan Barak <matanb@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Dimitri Sivanich <sivanich@sgi.com>
References: <20180829181424.GB3784@redhat.com>
 <20180829183906.GF10223@dhcp22.suse.cz> <20180829211106.GC3784@redhat.com>
 <20180830105616.GD2656@dhcp22.suse.cz> <20180830140825.GA3529@redhat.com>
 <20180830161800.GJ2656@dhcp22.suse.cz> <20180830165751.GD3529@redhat.com>
 <e0c0c966-6706-4ca2-4077-e79322756a9b@oracle.com>
 <20180830183944.GE3529@redhat.com> <20180903055654.GA14951@dhcp22.suse.cz>
 <20180904140035.GA3526@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <4b275965-3e6e-2a68-4b39-d09902bbc573@oracle.com>
Date:   Tue, 4 Sep 2018 10:55:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180904140035.GA3526@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9006 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809040178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2018 07:00 AM, Jerome Glisse wrote:
> On Mon, Sep 03, 2018 at 07:56:54AM +0200, Michal Hocko wrote:
>> On Thu 30-08-18 14:39:44, Jerome Glisse wrote:
>>> For all intents and purposes this is not a backport of the original
>>> patch so maybe we should just drop the commit reference and just
>>> explains that it is there to fix mmu notifier in respect to huge page
>>> migration.
>>>
>>> The original patches fix more than this case because newer featurers
>>> like THP migration, THP swapping, ... added more cases where things
>>> would have been wrong. But in 4.4 frame there is only huge tlb fs
>>> migration.
>>
>> And THP migration is still a problem with 4.4 AFAICS. All other cases
>> simply split the huge page but THP migration keeps it in one piece and
>> as such it is theoretically broken as you have explained. So I would
>> stick with what I posted with some more clarifications in the changelog
>> if you think it is appropriate (suggestions welcome).
> 
> Reading code there is no THP migration in 4.4 only huge tlb migration.
> Look at handle_mm_fault which do not know how to handle swap pmd, only
> the huge tlb fs fault handler knows how to handle those. Hence why i
> was checking for huge tlb exactly as page_check_address() to only range
> invalidate for huge tlb fs migration.

I agree with Jérôme that THP migration was added after 4.4.  But, I could
be missing something.

> But i am fine with doing the range invalidation with all.

Since the shared pmd patch which will ultimately go on top of this needs
the PageHuge checks, my preference would be Jérôme's patch.

However, IMO I am not certain we really need/want a separate patch.  We
could just add the notifiers to the shared pmd patch.  Back porting the
shared pmd patch will also require some fixup.

Either would work.  I'll admit I do not know what stable maintainers would
prefer.
-- 
Mike Kravetz
