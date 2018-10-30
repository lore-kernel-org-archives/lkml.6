Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979CBC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F5920831
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LrZPeuBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F5920831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbeJ3XGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:06:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34502 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbeJ3XGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:06:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9UE4LPJ112338;
        Tue, 30 Oct 2018 14:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=5Ad89uNrru7yFGWtmS1GlTbYipXiO9MoWvJf1J1lWLg=;
 b=LrZPeuBPb671czKH2YHsVPtVhHo7+cT08BsvUeDO6T/Rq1w+CGUkUXACiTiketEETAln
 htayi+Qy7bBBLw8wRTO4bT/qKI4Wi1YhLQlJZqe0Bn994D9+VNKkEx42/xCvgslzAo3M
 6rldn0WzrjEO/PfTj1IFZHhxzXtLEWz3d43jc2sX4mk9d3cXLexbbhmus2FHrlggRcdf
 dFMebGa476vOeGFieuy5/OEnGBDadAw2NYMB5UYX0J+T29bCeoN5ninfKbjQ3B4hnlLv
 0yVe7fAhxfgPzS9lH2P3hxSVP1edfP1CiQP9XBRWMaCeEwkOrKhbmIrolm/Vb5XN2VwM Kw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2ncfypvhdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 14:12:51 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9UECoKK021088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 14:12:50 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9UEClor010435;
        Tue, 30 Oct 2018 14:12:47 GMT
Received: from [10.211.47.88] (/10.211.47.88)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Oct 2018 07:12:47 -0700
Subject: Re: [Xen-devel] [PATCH] xen-swiotlb: exchange memory with Xen only
 when pages are contiguous
To:     Paul Durrant <Paul.Durrant@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     John Sobecki <john.sobecki@oracle.com>,
        "DONGLI.ZHANG" <dongli.zhang@oracle.com>,
        "linux-kernel@vger.kernel.org\"" <linux-kernel@vger.kernel.org>,
        "konrad@kernel.org" <konrad@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Christoph Helwig <hch@lst.de>
References: <bb6d87b4-c371-c6c0-8c48-bc95df018ad1@oracle.com>
 <20181024130246.GA22616@localhost.localdomain>
 <83900cf4-690c-9725-d022-d427fdeb4f7d@oracle.com>
 <581cb7ea-3112-791d-918d-9bb887e4744f@oracle.com>
 <24a62522-1629-5d0b-398e-6d2c1a0b97f7@oracle.com>
 <922914c9-22db-c5d1-33da-d07691ebd7d7@oracle.com>
 <a47fabe8-53d1-47b8-0efc-f9f1e5b4898a@oracle.com>
 <45f5ffe8-3f48-4485-53f0-5a056be69b0c@oracle.com>
 <5b64850f-9142-0360-fe4e-9e7bc74d2368@oracle.com>
 <3e65208c-cb11-d918-00eb-012a97e56fec@oracle.com>
 <57e5593233c64dc0a36c7d4c750a1ed4@AMSPEX02CL03.citrite.net>
From:   Joe Jin <joe.jin@oracle.com>
Message-ID: <cd2efe58-4efb-cf5b-db6e-0bc7838bd9c9@oracle.com>
Date:   Tue, 30 Oct 2018 07:12:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <57e5593233c64dc0a36c7d4c750a1ed4@AMSPEX02CL03.citrite.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9061 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810300123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 1:59 AM, Paul Durrant wrote:
>> On 10/25/18 11:56 AM, Joe Jin wrote:
>>> I just discussed this patch with Boris in private, his opinions(Boris,
>>> please correct me if any misunderstood) are:
>>>
>>> 1. With/without the check, both are incorrect, he thought we need to
>>>    prevented unalloc'd free at here.
>>> 2. On freeing, if upper layer already checked the memory was DMA-able,
>>>    the checking at here does not make sense, we can remove all checks.
>>> 3. xen_create_contiguous_region() and xen_destroy_contiguous_region()
>>>    to come in pairs.
>> I tried to added radix_tree to track allocating/freeing and I found some
>> memory only allocated but was not freed, I guess it caused by driver used
>> dma_pool, that means if lots of such requests, the list will consume lot
>> of memory for it. Will continue to work on it, if anyone have good idea
>> for it please let me know, I'd like to try it.
>>
> FWIW, in my Xen PV-IOMMU test patches, I have also tried keeping a list of ranges mapped for DMA and have discovered apparent issues with some drivers, particularly tg3, that seem to free mappings that have not been allocated (or possibly double-free). I've never fully tracked down the issue.

Call trace of first called xen_swiotlb_alloc_coherent(The pages never backed to Xen):

[   23.436333]  [<ffffffff814040c9>] xen_swiotlb_alloc_coherent+0x169/0x510
[   23.436623]  [<ffffffff811eb38d>] ? kmem_cache_alloc_trace+0x1ed/0x280
[   23.436900]  [<ffffffff811d72af>] dma_pool_alloc+0x11f/0x260
[   23.437190]  [<ffffffff81537442>] ehci_qh_alloc+0x52/0x120
[   23.437481]  [<ffffffff8153b80f>] ehci_setup+0x2bf/0x8e0
[   23.437760]  [<ffffffff81476d06>] ? __dev_printk+0x46/0xa0
[   23.438042]  [<ffffffff814770b3>] ? _dev_info+0x53/0x60
[   23.438327]  [<ffffffff8153f620>] ehci_pci_setup+0xc0/0x5f0
[   23.438615]  [<ffffffff81519fcd>] usb_add_hcd+0x25d/0xaf0
[   23.438901]  [<ffffffff8152c9a6>] usb_hcd_pci_probe+0x406/0x520
[   23.439177]  [<ffffffff8153f486>] ehci_pci_probe+0x36/0x40
[   23.439469]  [<ffffffff8136e99a>] local_pci_probe+0x4a/0xb0
[   23.439752]  [<ffffffff8136fba5>] ? pci_match_device+0xe5/0x110
[   23.440027]  [<ffffffff8136fce1>] pci_device_probe+0xd1/0x120
[   23.440320]  [<ffffffff8147b13c>] driver_probe_device+0x20c/0x4d0
[   23.440599]  [<ffffffff8147b4eb>] __driver_attach+0x9b/0xa0
[   23.440879]  [<ffffffff8147b450>] ? __device_attach+0x50/0x50

Above was EHCI used DMA pool to allocate DMA memory.

During my testing, ~1000 entries was not freed, if more PCI devices
use DMA pool, the tree/list will have more entries, looks it's not a
good idea that use a list to track it.

Thanks,
Joe
