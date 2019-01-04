Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2FFC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EAC2184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 01:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZL0hjZsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfADBbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 20:31:51 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:52004 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfADBbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 20:31:50 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x041O4GH136832;
        Fri, 4 Jan 2019 01:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=5GXXRK3oNflNE5U/4fxiyOhBcb7W40a6bYVbMFGm9Ss=;
 b=ZL0hjZsFjwu5MQImtN/N7gOdnJSPkg/ITCnTkTi0Q6V7yfPhcuzjaXfvPCHpRfYaLY09
 9BgnrCGkD7MVlA4iDfgFkmzQwSW0jRSADPXG3Tae+7Vw1ddXiLDauvDZUsq//PCs2aea
 CEJ5lh4kc9ghGbq+DKSIZb4dOC1nQXC9KRLE6YKxiT/4RfYBynPw0vzxQjjvKjiMhMMT
 AaKgVoyWMFFLnOyfoV8mKlt7cOfPIhwpPcQsr0TTpTJrrzu+d67FgGYodrHsIUUc3EVf
 s0mRLx95Q1Up17Of7I89ehlX9x2o8nzsBo/yNHjIMOMghbcln24fATbrw5n87UCVCGRT dA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2pnxeea3mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jan 2019 01:31:38 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x041VbqA007195
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Jan 2019 01:31:37 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x041VZqI007141;
        Fri, 4 Jan 2019 01:31:36 GMT
Received: from [10.182.69.241] (/10.182.69.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Jan 2019 17:31:35 -0800
Subject: Re: [PATCH v2 1/2] swiotlb: add debugfs to track swiotlb buffer usage
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        konrad.wilk@oracle.com
References: <1544402278-8175-1-git-send-email-dongli.zhang@oracle.com>
 <41becd27-8c3a-da2b-e5ed-e361ba20e4d4@linux.intel.com>
 <34883ba5-b444-3d37-4d40-9b0a651dd2eb@oracle.com>
Cc:     Joe Jin <joe.jin@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <98fdfb0c-0207-9a0a-4875-b834cfd1b2c3@oracle.com>
Date:   Fri, 4 Jan 2019 09:34:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <34883ba5-b444-3d37-4d40-9b0a651dd2eb@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9125 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901040011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

Would you please take a look on those two patches?

In addition, there is another patch correcting an error in comment.

https://lkml.org/lkml/2018/12/5/1721

Thank you very much!

Dongli Zhang

On 12/11/2018 05:05 AM, Joe Jin wrote:
> On 12/10/18 12:00 PM, Tim Chen wrote:
>>> @@ -528,6 +538,9 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
>>>  		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n", size);
>>>  	return SWIOTLB_MAP_ERROR;
>>>  found:
>>> +#ifdef CONFIG_DEBUG_FS
>>> +	io_tlb_used += nslots;
>>> +#endif
>> One nit I have about this patch is there are too many CONFIG_DEBUG_FS.
>>
>> For example here, instead of io_tlb_used, we can have a macro defined,
>> perhaps something like inc_iotlb_used(nslots).  It can be placed in the
>> same section that swiotlb_create_debugfs is defined so there's a single
>> place where all the CONFIG_DEBUG_FS stuff is located.
>>
>> Then define inc_iotlb_used to be null when we don't have
>> CONFIG_DEBUG_FS.
>>
> 
> Dongli had removed above ifdef/endif on his next patch, "[PATCH v2 2/2]
> swiotlb: checking whether swiotlb buffer is full with io_tlb_used"
> 
> Thanks,
> Joe
> 
