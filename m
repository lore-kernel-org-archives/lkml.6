Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9D88FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521F620020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QQ8q9oeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521F620020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935520AbeFMMCV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:02:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58538 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935494AbeFMMCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:02:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5DBxWeg195402;
        Wed, 13 Jun 2018 12:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=11BwG5on6RgWSLmSUTMyUyQ6CvnUuBHx2Hiv//568K4=;
 b=QQ8q9oeRx7458bxuLZzK4JIclG2tLJ+oRk15k6dp5wdPOkZd/5TZp+TWGZ7pu8Bc1e9V
 TFv+I7zciwg78O93+xf5Ayq8kPZsdBWEZ5f5/kSFzEZcSo0aWDq6KkbV1EVyQ3SWDhOi
 ZBx8tknjV1jZPO57SookI4gYQvdev+Cig6XuBVcEURcrAGCFS8mCyDMStnwIsczCT1MS
 qYIPEq7RzN9XrHcvW/bJA24dJufr04KqRDlUQWysi75/Fg9x1311BL9gjwqC6vrqsA52
 0XGrXvrCu0rHdsjSjTyuvYK267wAAcXVlbSgPvFWIWPTImbW8lxRko+QXr4gl96tphxp 2g== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2jk0xr8d2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 12:02:08 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5DC27n2024134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 12:02:07 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5DC27lP017359;
        Wed, 13 Jun 2018 12:02:07 GMT
Received: from [10.39.203.215] (/10.39.203.215)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jun 2018 05:02:07 -0700
Subject: Re: [PATCH v3 3/9] xen/balloon: Share common memory reservation
 routines
To:     Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com
References: <20180612134200.17456-1-andr2000@gmail.com>
 <20180612134200.17456-4-andr2000@gmail.com>
 <d63f0cf5-5154-f2a3-155e-fdb6dd0959e2@oracle.com>
 <cbaeec5c-0d69-881c-2b42-54855e53015a@epam.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <b79713a9-3a2d-6465-3b22-622bfb7a4d3e@oracle.com>
Date:   Wed, 13 Jun 2018 08:02:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <cbaeec5c-0d69-881c-2b42-54855e53015a@epam.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8922 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806130134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/13/2018 02:26 AM, Oleksandr Andrushchenko wrote:
> On 06/13/2018 03:47 AM, Boris Ostrovsky wrote:
>>
>>
>> On 06/12/2018 09:41 AM, Oleksandr Andrushchenko wrote:
>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>>> diff --git a/include/xen/mem-reservation.h 
>>> b/include/xen/mem-reservation.h
>>> new file mode 100644
>>> index 000000000000..e0939387278d
>>> --- /dev/null
>>> +++ b/include/xen/mem-reservation.h
>>> @@ -0,0 +1,64 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +
>>> +/*
>>> + * Xen memory reservation utilities.
>>> + *
>>> + * Copyright (c) 2003, B Dragovic
>>> + * Copyright (c) 2003-2004, M Williamson, K Fraser
>>> + * Copyright (c) 2005 Dan M. Smith, IBM Corporation
>>> + * Copyright (c) 2010 Daniel Kiper
>>> + * Copyright (c) 2018 Oleksandr Andrushchenko, EPAM Systems Inc.
>>> + */
>>> +
>>> +#ifndef _XENMEM_RESERVATION_H
>>> +#define _XENMEM_RESERVATION_H
>>> +
>>> +#include <linux/kernel.h>
>>> +#include <linux/slab.h>
>>> +
>>> +#include <asm/xen/hypercall.h>
>>> +#include <asm/tlb.h>
>>> +
>>> +#include <xen/interface/memory.h>
>>> +#include <xen/page.h>
>>
>>
>> I should have noticed this in the previous post but I suspect most of 
>> these includes belong in the C file. For example, there is no reason 
>> for hypercall.h here.
>>
> Yes, it seems that the header can only have
> #include <xen/page.h>
> Will move the rest into the .c file


You may need something for clear_highpage() and maybe for Xen feature 
flags. But you'll find out for sure when you try to build. ;-)

-boris



>> -boris
>>
>>
>>> +
>>> +static inline void xenmem_reservation_scrub_page(struct page *page)
>>> +{
>>> +#ifdef CONFIG_XEN_SCRUB_PAGES
>>> +    clear_highpage(page);
>>> +#endif
>>> +}
>>> +
>>> +#ifdef CONFIG_XEN_HAVE_PVMMU
>>> +void __xenmem_reservation_va_mapping_update(unsigned long count,
>>> +                        struct page **pages,
>>> +                        xen_pfn_t *frames);
>>> +
>>> +void __xenmem_reservation_va_mapping_reset(unsigned long count,
>>> +                       struct page **pages);
>>> +#endif
>>> +
>>> +static inline void xenmem_reservation_va_mapping_update(unsigned 
>>> long count,
>>> +                            struct page **pages,
>>> +                            xen_pfn_t *frames)
>>> +{
>>> +#ifdef CONFIG_XEN_HAVE_PVMMU
>>> +    if (!xen_feature(XENFEAT_auto_translated_physmap))
>>> +        __xenmem_reservation_va_mapping_update(count, pages, frames);
>>> +#endif
>>> +}
>>> +
>>> +static inline void xenmem_reservation_va_mapping_reset(unsigned long 
>>> count,
>>> +                               struct page **pages)
>>> +{
>>> +#ifdef CONFIG_XEN_HAVE_PVMMU
>>> +    if (!xen_feature(XENFEAT_auto_translated_physmap))
>>> +        __xenmem_reservation_va_mapping_reset(count, pages);
>>> +#endif
>>> +}
>>> +
>>> +int xenmem_reservation_increase(int count, xen_pfn_t *frames);
>>> +
>>> +int xenmem_reservation_decrease(int count, xen_pfn_t *frames);
>>> +
>>> +#endif
>>>
> 
