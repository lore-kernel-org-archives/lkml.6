Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id l9agK/qvGVseUQAAmS7hNA
	; Thu, 07 Jun 2018 22:23:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 415AB6074D; Thu,  7 Jun 2018 22:23:29 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CsBRfGY2"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 86070601B4;
	Thu,  7 Jun 2018 22:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86070601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeFGWX0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 18:23:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50698 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeFGWXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 18:23:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w57MGveC109589;
        Thu, 7 Jun 2018 22:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=8N3T+bV227We34hrs18LPEKpOvyUZjtkfQZerhkZZMI=;
 b=CsBRfGY2hex9qXJS4ESPULhcFbmjricEQ40XHBYo+ZIuk3Oqh3UinNwlmWCevxdCEWe5
 lrEdAd+GaszOy1A8FGY4FrTs5egBZOPLaVbZDfZMAykzKeQ2vNlWRQxcI81hSLOQYE6U
 e488KephXP1KETdPVCD1LnkYyxX15AwHt42JU4IIohtYM06yVGFl4QkI88qsv6iJObeg
 5Z8KEmulK5hmtK+jglvV+ytmHIIEm+avLmRT6Szyq7aln1Li6UZFCVqvoSOS5HAQPEb3
 S6n1IxT1jEENRNXoL22rL9ch9zcfS+ZBbmfG5Rwb0wRLRhGRuloY5rxxmMsajsJfwQLo PQ==
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2jbvyptrrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jun 2018 22:23:13 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w57MNDqW021714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jun 2018 22:23:13 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w57MNBPD012607;
        Thu, 7 Jun 2018 22:23:11 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Jun 2018 15:23:11 -0700
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH v2 6/9] xen/gntdev: Add initial support for dma-buf UAPI
To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180601114132.22596-1-andr2000@gmail.com>
 <20180601114132.22596-7-andr2000@gmail.com>
 <29c1f1fb-2d52-e3df-adce-44fdee135413@oracle.com>
 <d2bbda68-af74-58b1-36a6-d8af47ad8beb@gmail.com>
 <7c73fae9-2dac-f3e8-bad8-0dadb73ad7af@oracle.com>
 <4e15c758-a314-9fdc-1d70-4a465137a6f9@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <41d794ce-a318-b2f1-5ad7-e9500175bdc8@oracle.com>
Date: Thu, 7 Jun 2018 18:26:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <4e15c758-a314-9fdc-1d70-4a465137a6f9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8917 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806070237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 03:17 AM, Oleksandr Andrushchenko wrote:
> On 06/07/2018 12:32 AM, Boris Ostrovsky wrote:
>> On 06/06/2018 05:06 AM, Oleksandr Andrushchenko wrote:
>>> On 06/04/2018 11:49 PM, Boris Ostrovsky wrote:
>>>>> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
>>>>> index 9813fc440c70..7d58dfb3e5e8 100644
>>>>> --- a/drivers/xen/gntdev.c
>>>>> +++ b/drivers/xen/gntdev.c
>>>> ...
>>>>
>>>>>    +#ifdef CONFIG_XEN_GNTDEV_DMABUF
>>>> This code belongs in gntdev-dmabuf.c.
>>> The reason I have this code here is that it is heavily
>>> tied to gntdev's internal functionality, e.g. map/unmap.
>>> I do not want to extend gntdev's API, so gntdev-dmabuf can
>>> access these. What is more dma-buf doesn't need to know about
>>> maps done by gntdev as there is no use of that information
>>> in gntdev-dmabuf. So, it seems more naturally to have
>>> dma-buf's related map/unmap code where it is: in gntdev.
>> Sorry, I don't follow. Why would this require extending the API? It's
>> just moving routines to a different file that is linked to the same
>> module.
> I do understand your intention here and tried to avoid dma-buf
> related code in gntdev.c as much as possible. So, let me explain
> my decision in more detail.
>
> There are 2 use-cases we have: dma-buf import and export.
>
> While importing a dma-buf all the dma-buf related functionality can
> easily be kept inside gntdev-dmabuf.c w/o any issue as all we need
> from gntdev.c is dev, dma_buf_fd, count and domid for that.
>
> But in case of dma-buf export we need to:
> 1. struct grant_map *map = gntdev_alloc_map(priv, count, dmabuf_flags);
> 2. gntdev_add_map(priv, map);
> 3. Set map->flags
> 4. ret = map_grant_pages(map);
> 5. And only now we are all set to export the new dma-buf from
> *map->pages*
>
> So, until 5) we use private gtndev.c's API not exported to outside world:
> a. struct grant_map
> b. static struct grant_map *gntdev_alloc_map(struct gntdev_priv *priv,
> int count,
>                       int dma_flags)
> c. static void gntdev_add_map(struct gntdev_priv *priv, struct
> grant_map *add)
> d. static int map_grant_pages(struct grant_map *map)
>
> Thus, all the above cannot be accessed from gntdev-dmabuf.c
> This is why I say that gntdev.c's API will need to be extended to
> provide the above
> a-d if we want all dma-buf export code to leave in gntdev-dmabuf.c.



I still don't understand why you feel this would be extending the API.
These routines and the struct can be declared in local header file and
this header file will not be visible to anyone but gntdev.c and
gntdev-dmabuf.c. You can, for example, put this into gntdev-dmabuf.h
(and then rename it to something else, like gntdev-common.h).



> But that doesn't seem good to me and what is more a-d are really
> gntdev.c's
> functionality, not dma-buf's which only needs pages and doesn't really
> care from
> where those come.
> That was the reason I partitioned export into 2 chunks: gntdev +
> gntdev-dmabuf.
>
> You might also ask why importing side does Xen related things
> (granting references+)
> in gntdev-dmabuf, not gntdev so it is consistent with the dma-buf
> exporter?
> This is because importer uses grant-table's API which seems to be not
> natural for gntdev.c,
> so it can leave in gntdev-dmabuf.c which has a use-case for that,
> while gntdev
> remains the same.


Yet another reason why this code should be moved: importing and
exporting functionalities logically belong together. The fat that they
are implemented using different methods is not relevant IMO.

If you have code which is under ifdef CONFIG_GNTDEV_DMABUF and you have
file called gntdev-dmabuf.c it sort of implies that this code should
live in that file (unless that code is intertwined with other code,
which is not the case here).


-boris



>> Since this is under CONFIG_XEN_GNTDEV_DMABUF then why shouldn't it be in
>> gntdev-dmabuf.c? In my view that's the file where all dma-related
>> "stuff" lives.
> Agree, but IMO grant_map stuff for dma-buf importer is right in its
> place in gntdev.c
> and all the rest of dma-buf specifics live in gntdev-dmabuf.c as they
> should
>>
>> -boris
>>
>>
>> -boris
>>
> Thank you,
> Oleksandr
