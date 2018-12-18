Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F87C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0002184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NTm0J/nh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbeLRWeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:34:21 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51898 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeLRWeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:34:21 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBIMXt5S038577;
        Tue, 18 Dec 2018 22:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=fHll4Mwq9spFcn9qCxpSL1OrbDW9LJYBzAibBxGaqO8=;
 b=NTm0J/nhBob2p+XnKiq81Okbx9S8VnC264Qk97uqUunGLQHt3P5kbkDVj8Y+DOC4qIAK
 2LknLELwUzhhoFRK1fu91UIM+Lc3bbwms98Ii/z/X+TUQSlxI6UyPczTzl+qxIWFihXM
 0zWZANpCXSlFbrX4BjBNOmqmf/Ksr3g1lFjNE1cLFvrq8hajIfbX+diXUgG3eDQ7LTHf
 ZH4sad6xO5vXMS5cocAjmtHQXirld11k53U0qgf9B3JZE7Qm+3fgfRqBEcGgDZQNS3IR
 MiIcGeV3H+bIp/SIjmcvVVvuwrvRf0Fjq1BMyiPGHymo5gFhqXLNKS8Sfp6/Gajbwlu5 4g== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2pcs1tp75e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 22:34:07 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBIMY5QD022509
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Dec 2018 22:34:05 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBIMY3uR029234;
        Tue, 18 Dec 2018 22:34:03 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Dec 2018 14:34:03 -0800
Subject: Re: [PATCH 2/3] hugetlbfs: Use i_mmap_rwsem to fix page
 fault/truncate race
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        stable@vger.kernel.org
References: <20181203200850.6460-1-mike.kravetz@oracle.com>
 <20181203200850.6460-3-mike.kravetz@oracle.com>
 <27f8893b-57b3-088d-2d48-9e8acc5987bd@linux.ibm.com>
 <f6fd9491-4b3d-16ca-f606-025c78756936@oracle.com>
 <dbc4abb9-aa7b-6515-0f37-23a77b50ff6e@oracle.com>
 <20181218141053.e2725111ce5cc91493efab5f@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <dd36ee7e-939f-f324-6ab6-3d0178617c63@oracle.com>
Date:   Tue, 18 Dec 2018 14:34:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181218141053.e2725111ce5cc91493efab5f@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9111 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=829
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812180184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/18 2:10 PM, Andrew Morton wrote:
> On Mon, 17 Dec 2018 16:17:52 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
>> ...
>>
>>> As you suggested in a comment to the subsequent patch, it would be better to
>>> combine the patches and remove the dead code when it becomes dead.  I will
>>> work on that.  Actually some of the code in patch 3 applies to patch 1 and
>>> some applies to patch 2.  So, it will not be simply combining patch 2 and 3.
>>
>> On second thought, the cleanups in patch 3 only apply to patch 2.  So, just
>> combining those two patches with a slightly updated commit message as below
>> makes the most sense.
> 
> All confused.  I dropped the current version, let's try again.
> 
> This:
> 
>> Hoping to get more comments on the overall direction and locking changes
>> of this and the previous patch.
> 
> and this:
> 
>> Cc: <stable@vger.kernel.org>
>> Fixes: ebed4bfc8da8 ("hugetlb: fix absurd HugePages_Rsvd")
> 
> make for a hot combination.  Could people please prioritize review of
> this code?
> 
> Perhaps a refresh and resend is in order.

Will send out a new version shortly.  No functional changes.  Only changes
to the way the patches are structured.

I guess fixing in stable could be open for discussion.  These issues have
been around for more than 10 years.  I am not aware of anyone hitting them
in actual real world usage.  The problems were only "found" through code
inspection while working other issues in the same code.  However, after
discovering the issues it was pretty easy to write user space code to
expose them.

-- 
Mike Kravetz
