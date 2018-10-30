Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AB4C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 02:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0DC21019
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 02:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3zi0eS2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0DC21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeJ3Lng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 07:43:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36556 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbeJ3Lng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 07:43:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9U2mcA3091147;
        Tue, 30 Oct 2018 02:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=4Zievn0L5ba1Ow40nAHHfrEZPZ4Ar5ufeUc2x/g91yg=;
 b=3zi0eS2jGk1Y1I6jWidMXO2b1zijPOgvh0hnraQQ23I+Gen9bYswv0mhx2lkRRAxAeQL
 FSGczX/c0zSS3wGbiTG/SGFOOcx5KCHWZ4h1c9RO49ygiqAJj+6WnL9L1zGdJGOC7JUf
 yRl9GtLV3JIn2wZHEUiWl1ie7NworcROMZIohDym5MNop2Kh6uRGz2Z1mYodKNntykQT
 MfNUIgHqFjdv0L5fC+Np4EofjTmD79Rx/EHCnjB3S8GBAwtzrdclLT8SYi1zNH5UTi4t
 nUPW/XY1JQP64PA171D+JndejYS/nH2T2J5PHuQHkVm0b9Y8eqiFdUC5xa2QzLrVchr5 yw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2ncgnqs8v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 02:51:54 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9U2psPD016960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Oct 2018 02:51:54 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9U2prns022690;
        Tue, 30 Oct 2018 02:51:53 GMT
Received: from [10.0.0.83] (/73.231.240.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Oct 2018 19:51:52 -0700
Subject: Re: [PATCH] xen-swiotlb: exchange memory with Xen only when pages are
 contiguous
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     "DONGLI.ZHANG" <dongli.zhang@oracle.com>, konrad@kernel.org,
        Christoph Helwig <hch@lst.de>,
        John Sobecki <john.sobecki@oracle.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org\"" <linux-kernel@vger.kernel.org>
References: <bb6d87b4-c371-c6c0-8c48-bc95df018ad1@oracle.com>
 <20181024130246.GA22616@localhost.localdomain>
 <83900cf4-690c-9725-d022-d427fdeb4f7d@oracle.com>
 <581cb7ea-3112-791d-918d-9bb887e4744f@oracle.com>
 <24a62522-1629-5d0b-398e-6d2c1a0b97f7@oracle.com>
 <922914c9-22db-c5d1-33da-d07691ebd7d7@oracle.com>
 <a47fabe8-53d1-47b8-0efc-f9f1e5b4898a@oracle.com>
 <45f5ffe8-3f48-4485-53f0-5a056be69b0c@oracle.com>
 <5b64850f-9142-0360-fe4e-9e7bc74d2368@oracle.com>
From:   Joe Jin <joe.jin@oracle.com>
Message-ID: <3e65208c-cb11-d918-00eb-012a97e56fec@oracle.com>
Date:   Mon, 29 Oct 2018 19:51:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5b64850f-9142-0360-fe4e-9e7bc74d2368@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9061 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810300023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/18 11:56 AM, Joe Jin wrote:
> I just discussed this patch with Boris in private, his opinions(Boris,
> please correct me if any misunderstood) are:
> 
> 1. With/without the check, both are incorrect, he thought we need to
>    prevented unalloc'd free at here. 
> 2. On freeing, if upper layer already checked the memory was DMA-able,
>    the checking at here does not make sense, we can remove all checks.
> 3. xen_create_contiguous_region() and xen_destroy_contiguous_region()
>    to come in pairs.
I tried to added radix_tree to track allocating/freeing and I found some
memory only allocated but was not freed, I guess it caused by driver used
dma_pool, that means if lots of such requests, the list will consume lot
of memory for it. Will continue to work on it, if anyone have good idea
for it please let me know, I'd like to try it.

Thanks,
Joe
