Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6053AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF12208AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tYh7sMby"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF12208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934984AbeFMAr5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 20:47:57 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58270 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934897AbeFMArz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 20:47:55 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5D0kvhZ087588;
        Wed, 13 Jun 2018 00:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=1o2y63mJoa4ibguG3jofqWmIG73zvUVZORdrK+eyzm8=;
 b=tYh7sMbyDynidOQmy5J1+GBmL6OApqMK9rswo6mL6SIeS0YgaQnBZaY4NSWrZuLcVJyL
 nt67OGGBmuoukrtZqxnJ3k43HY+pDWTAcGUlU+ggEZoJOtItXwMjl0tNjj1FKZJ1X0To
 v3iDec24bYg6E0Iug5HaY+udMDCw55l2YjTTUFE1XOEafgCuCE98Q/shoGMsDpCBPdyw
 +s6DiZClcWYKYA2zMoJPlMzG7lvr9fGE85aNKKsyOpcRTICTflzUu4sgnWwYG/nyBFhL
 gJe/M5EMcSXUIYCRqshUr82q82s9+/9w1KyfGe0WrNYp7wcp/GUdRfy40A/zJAVOhPUv 1A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2jjp6c8aqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 00:47:42 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5D0lf7p030045
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 00:47:41 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5D0lduB020813;
        Wed, 13 Jun 2018 00:47:40 GMT
Received: from [10.154.144.7] (/10.154.144.7)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 17:47:39 -0700
Subject: Re: [PATCH v3 3/9] xen/balloon: Share common memory reservation
 routines
To:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180612134200.17456-1-andr2000@gmail.com>
 <20180612134200.17456-4-andr2000@gmail.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <d63f0cf5-5154-f2a3-155e-fdb6dd0959e2@oracle.com>
Date:   Tue, 12 Jun 2018 20:47:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612134200.17456-4-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8922 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806130007
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2018 09:41 AM, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

> diff --git a/include/xen/mem-reservation.h b/include/xen/mem-reservation.h
> new file mode 100644
> index 000000000000..e0939387278d
> --- /dev/null
> +++ b/include/xen/mem-reservation.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Xen memory reservation utilities.
> + *
> + * Copyright (c) 2003, B Dragovic
> + * Copyright (c) 2003-2004, M Williamson, K Fraser
> + * Copyright (c) 2005 Dan M. Smith, IBM Corporation
> + * Copyright (c) 2010 Daniel Kiper
> + * Copyright (c) 2018 Oleksandr Andrushchenko, EPAM Systems Inc.
> + */
> +
> +#ifndef _XENMEM_RESERVATION_H
> +#define _XENMEM_RESERVATION_H
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +
> +#include <asm/xen/hypercall.h>
> +#include <asm/tlb.h>
> +
> +#include <xen/interface/memory.h>
> +#include <xen/page.h>


I should have noticed this in the previous post but I suspect most of 
these includes belong in the C file. For example, there is no reason for 
hypercall.h here.

-boris


> +
> +static inline void xenmem_reservation_scrub_page(struct page *page)
> +{
> +#ifdef CONFIG_XEN_SCRUB_PAGES
> +	clear_highpage(page);
> +#endif
> +}
> +
> +#ifdef CONFIG_XEN_HAVE_PVMMU
> +void __xenmem_reservation_va_mapping_update(unsigned long count,
> +					    struct page **pages,
> +					    xen_pfn_t *frames);
> +
> +void __xenmem_reservation_va_mapping_reset(unsigned long count,
> +					   struct page **pages);
> +#endif
> +
> +static inline void xenmem_reservation_va_mapping_update(unsigned long count,
> +							struct page **pages,
> +							xen_pfn_t *frames)
> +{
> +#ifdef CONFIG_XEN_HAVE_PVMMU
> +	if (!xen_feature(XENFEAT_auto_translated_physmap))
> +		__xenmem_reservation_va_mapping_update(count, pages, frames);
> +#endif
> +}
> +
> +static inline void xenmem_reservation_va_mapping_reset(unsigned long count,
> +						       struct page **pages)
> +{
> +#ifdef CONFIG_XEN_HAVE_PVMMU
> +	if (!xen_feature(XENFEAT_auto_translated_physmap))
> +		__xenmem_reservation_va_mapping_reset(count, pages);
> +#endif
> +}
> +
> +int xenmem_reservation_increase(int count, xen_pfn_t *frames);
> +
> +int xenmem_reservation_decrease(int count, xen_pfn_t *frames);
> +
> +#endif
> 
