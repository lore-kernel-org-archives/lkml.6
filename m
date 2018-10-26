Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB75FC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8F420651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aOh96rg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8F420651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeJZXRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:17:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59794 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeJZXRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:17:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9QEcic3079494;
        Fri, 26 Oct 2018 14:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=viULrtccOyW9lyqJa6DBSc+1uEYr9+NiiQtSa02Shf8=;
 b=aOh96rg9kKGgG3DQRQK6GbrRAEuYl0zAsjNiufHhZ0TNBKRfkn3xA8AuSf7T4bsbl8ln
 WbtDHHRy8OMlfugBhokwNp8V0E9pKcU25W3i0hGq6ZAgbmOjcNBLzRtXG4swny7cERvN
 VyTLaFW2XkTNmvMRN5S6iy+vY9tO5N9ypKg9j3J5w+IqZD04L35nm1VbsdVBZJkUw/OT
 wHzuJeaYv5Er2Os6NHG1Spd1dxtZEdDlAsLHXxhm9k70+28Hj9ro3RmXrxESTw9tt+vl
 DNQ4K3nx3th27zfL66RJ4G8pE6eDZS0S1n7BF9hCc70clHZD7hbyeWsw0UikUFpvGVQc 5A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2n7w0r7ktc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 14:40:24 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9QEeNkB008128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 14:40:24 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9QEeNDn010157;
        Fri, 26 Oct 2018 14:40:23 GMT
Received: from [10.211.46.56] (/10.211.46.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Oct 2018 07:40:22 -0700
Subject: Re: [PATCH] xen-swiotlb: exchange memory with Xen only when pages are
 contiguous
To:     Christoph Helwig <hch@lst.de>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "DONGLI.ZHANG" <dongli.zhang@oracle.com>, konrad@kernel.org,
        John Sobecki <john.sobecki@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <bb6d87b4-c371-c6c0-8c48-bc95df018ad1@oracle.com>
 <20181024130246.GA22616@localhost.localdomain>
 <83900cf4-690c-9725-d022-d427fdeb4f7d@oracle.com>
 <581cb7ea-3112-791d-918d-9bb887e4744f@oracle.com>
 <24a62522-1629-5d0b-398e-6d2c1a0b97f7@oracle.com>
 <922914c9-22db-c5d1-33da-d07691ebd7d7@oracle.com>
 <a47fabe8-53d1-47b8-0efc-f9f1e5b4898a@oracle.com>
 <45f5ffe8-3f48-4485-53f0-5a056be69b0c@oracle.com>
 <5b64850f-9142-0360-fe4e-9e7bc74d2368@oracle.com>
 <20181026074802.GA4768@lst.de>
From:   Joe Jin <joe.jin@oracle.com>
Message-ID: <16606089-77c8-5701-e01e-1d2032c0e32a@oracle.com>
Date:   Fri, 26 Oct 2018 07:40:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181026074802.GA4768@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9057 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810260126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 10/26/18 12:48 AM, Christoph Helwig wrote:
> On Thu, Oct 25, 2018 at 11:56:02AM -0700, Joe Jin wrote:
>> I just discussed this patch with Boris in private, his opinions(Boris,
>> please correct me if any misunderstood) are:
>>
>> 1. With/without the check, both are incorrect, he thought we need to
>>    prevented unalloc'd free at here. 
>> 2. On freeing, if upper layer already checked the memory was DMA-able,
>>    the checking at here does not make sense, we can remove all checks.
>> 3. xen_create_contiguous_region() and xen_destroy_contiguous_region()
>>    to come in pairs.
>>
>> For #1 and #3, I think we need something associate it, like a list, on
>> allocating, add addr to it, on freeing, check if in the list.
> 
> Is there any way to figure out based on an address if the exchange
> operation happened?

Read the code path and I was not found anywhere will store related info,
on current code, it assuming if memory in DMA area also contiguous then
it from Xen, most time it's true, but if lucky that __get_free_pages()
returned memory is DMAable, it will not exchange with Xen, during my testing
I observed same(Xen DMA heap increased).

> 
>> For #2, I'm was not found anywhere validated the address on 
>> dma_free_coherent() callpath, not just xen-swiotlb.
> 
> At least for simple direct mappings there is no easy way to verify that
> without keeping a list, and for some of the ops that do vmap like> operations we have basic santiy checks, but nothing that really catches
> a wrong free.

I agree with you, add a list will help this issue, but it may introduce some
performance issue, especially on heavy DMA system.

Driver use DMA pool will help to avoid this issue, but not all kinds DMA ops
are suitable to create a pool.

Thanks,
Joe
