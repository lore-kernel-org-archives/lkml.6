Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E5AC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C4020834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="33CEHkpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C4020834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbeJZRaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:30:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58838 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeJZRaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:30:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9Q8rjDs047562;
        Fri, 26 Oct 2018 08:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=UZLE4JxKt/KMLfEuFn9/+2BwdcZ5ttZCEZlRoTEwFow=;
 b=33CEHkpKRWWgKsGBRqnQycgkV1A9AWv7bVVxJhFpKMQpsZ+IncZVa1CNqtts8jPbzXE9
 tawyJ3Ni9+OtRwL+VtooyvC9E4jLQxNZ5m8dFPOy9Vz3ITD1YTLQ6Z9zxonKQqER3pl2
 iTUInVwFprGD+j531l17pK2J4ViesIKDpthmnSQclA6jjLS+HxmKoGqbsohySXrDaKAm
 0Yib61TerrIE8jMKQhA55e72qfM7cSl4f25V0JCfj7tOoK6yA/rEdOMEwut9SADV6D/f
 SdRRRnGZpFvpI3GpqT6yTMrDX4zB+L+YGyCGdN9F2OG8bCwohBeYQfsSbg1h8vOI2Wkl 5w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2n7vaqe3d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 08:54:36 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9Q8saef003971
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 08:54:36 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9Q8sZ4B017190;
        Fri, 26 Oct 2018 08:54:35 GMT
Received: from [10.191.16.181] (/10.191.16.181)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Oct 2018 01:54:35 -0700
Subject: Re: [PATCH] xen-swiotlb: exchange memory with Xen only when pages are
 contiguous
To:     Joe Jin <joe.jin@oracle.com>
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
Cc:     Christoph Helwig <hch@lst.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        konrad@kernel.org, John Sobecki <john.sobecki@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <10301c25-5bbf-51b6-6cb2-77e30bcd9a99@oracle.com>
Date:   Fri, 26 Oct 2018 16:54:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181026074802.GA4768@lst.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9057 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=913
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810260079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On 10/26/2018 03:48 PM, Christoph Helwig wrote:
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

If dom0 (or any domain) is happy, although it could try to exchange all its
continuous dma pages back to xen hypervisor. From the perspective of each
domain, they always would like to keep as much continuous dma page as possible.

I am thinking something different. If there is malicious domU keep exchanging
memory and allocating continuous pages from xen hypervisor, will the
continuously dma pages be used up (sort of DoS attack)?

I am not sure if there is anything in xen hypervisor to prevent such behavior?

Dongli Zhang

> 
> Is there any way to figure out based on an address if the exchange
> operation happened?
> 
>> For #2, I'm was not found anywhere validated the address on 
>> dma_free_coherent() callpath, not just xen-swiotlb.
> 
> At least for simple direct mappings there is no easy way to verify that
> without keeping a list, and for some of the ops that do vmap like
> operations we have basic santiy checks, but nothing that really catches
> a wrong free.
> 
