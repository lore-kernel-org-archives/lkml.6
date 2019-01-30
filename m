Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F855C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B91420881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ef5r+ypH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbfA3XOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:14:25 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48188 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfA3XOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:14:24 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0UNDoAD083642;
        Wed, 30 Jan 2019 23:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=oRY8IIy+LzhfOUy5KtCkTy2Mvv+fVM7jDXgCUqjIfj0=;
 b=Ef5r+ypHarZqKR2GIKCNPyLlXdwxG3W4mZ4MfIHr90RgBOf0jur7zeY0LRt8UvzbCwQv
 FO9C8NmIMXeGFYSpBzcdexYuDWUMSFegFPloaBVQUuA0zHcI9FuEOEbjQFPg3ABI4Ud/
 ng61oqOsGOpDzJgc06svNz7UcpZySiYB0zx91zIWbC8bRRGi2SUvKhSL4HzS6I91krsg
 Be42tKYpeGxhsKS6KIe1VMq7A6CoYyAy9DKkPXGeHiChQesjsCZ52+eBkwgW8SJNDupc
 11vz38sttV6BoxZb2a9Ib2oPseTgyFfd2ClqjAp2ML/45HTIDnw6nxHQyjw3jQ6xHGCd 3w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2q8d2edrj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jan 2019 23:14:09 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0UNE3Wa014722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jan 2019 23:14:03 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0UNE2Qe002159;
        Wed, 30 Jan 2019 23:14:02 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Jan 2019 15:14:02 -0800
Subject: Re: [LSF/MM TOPIC] NUMA remote THP vs NUMA local non-THP under
 MADV_HUGEPAGE
To:     Andrea Arcangeli <aarcange@redhat.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Blake Caldwell <blake.caldwell@colorado.edu>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>
References: <20190129234058.GH31695@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <609a56e4-c8b7-154f-dcbc-a12817fb22a0@oracle.com>
Date:   Wed, 30 Jan 2019 15:14:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129234058.GH31695@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9152 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901300167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/19 3:40 PM, Andrea Arcangeli wrote:
> In addition to the above "NUMA remote THP vs NUMA local non-THP
> tradeoff" topic, there are other developments in "userfaultfd" land that
> are approaching merge readiness and that would be possible to provide a
> short overview about:
> 
> - Peter Xu made significant progress in finalizing the userfaultfd-WP
>   support over the last few months. That feature was planned from the
>   start and it will allow userland to do some new things that weren't
>   possible to achieve before. In addition to synchronously blocking
>   write faults to be resolved by an userland manager, it has also the
>   ability to obsolete the softdirty feature, because it can provide
>   the same information, but with O(1) complexity (as opposed of the
>   current softdirty O(N) complexity) similarly to what the Page
>   Modification Logging (PML) does in hardware for EPT write accesses.

I would be interested in this topic as well.  IIRC, Peter's patches do
not address hugetlbfs support.  I put together patches for this some
time back.  At the time, they worked as well as userfaultfd-WP support
for normal base pages: not too well :).  Once base page support is
finalized, I suspect I will be involved in hugetlbfs support.

-- 
Mike Kravetz
