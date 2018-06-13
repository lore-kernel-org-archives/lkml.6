Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9987EC5CFF1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5D52086D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DHX7Dbdl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5D52086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935110AbeFMBMd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:12:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57454 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935038AbeFMBMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:12:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5D15rK7184614;
        Wed, 13 Jun 2018 01:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=dT0EAWnUj/+gHQNtmlaQGicVIPSfFPG0OPF9P7c9SO4=;
 b=DHX7Dbdlj33X6Iq2m8toWALl5H16LhxWpAPMNQxMdFjszMgyxGW5J/KEHEaqCLU7ClkA
 8YO4oxLsYlYED4fHQvzFDT/Tt2wA1QvBanFt86K3Uw/hsP0j+FZzSNHHo1/vft8uR9z/
 vkNYztt2raW4v+z9zcMTL2aEfKf4DyOAukSHi982qunqs0K0a0OXRugJJpH/Fmsqy4ge
 +tJ7RsVPiY2aWsej7qs+Rs77/qZeDfmCtS0D7CFg+4RHLz22wyl1pzsUcxyH5V+DQ056
 GhhGWu1fysNgJEjCj/8f1nB9XgS4YIDnLe+B1msHBsXGdpZRvUqK4hEKklotBdif4QUL 6A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2jjp6brbtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 01:12:19 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5D1CI1n010229
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 01:12:18 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5D1CHvw007646;
        Wed, 13 Jun 2018 01:12:17 GMT
Received: from [10.154.144.7] (/10.154.144.7)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 18:12:17 -0700
Subject: Re: [PATCH v3 4/9] xen/grant-table: Allow allocating buffers suitable
 for DMA
To:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180612134200.17456-1-andr2000@gmail.com>
 <20180612134200.17456-5-andr2000@gmail.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <4ab26c9a-155a-cd04-fbf6-c38c6429959b@oracle.com>
Date:   Tue, 12 Jun 2018 21:12:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612134200.17456-5-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8922 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806130011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2018 09:41 AM, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> Extend grant table module API to allow allocating buffers that can
> be used for DMA operations and mapping foreign grant references
> on top of those.
> The resulting buffer is similar to the one allocated by the balloon
> driver in terms that proper memory reservation is made
> ({increase|decrease}_reservation and VA mappings updated if needed).
> This is useful for sharing foreign buffers with HW drivers which
> cannot work with scattered buffers provided by the balloon driver,
> but require DMAable memory instead.
> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

with a small nit below


> ---
>   drivers/xen/Kconfig       | 13 ++++++
>   drivers/xen/grant-table.c | 97 +++++++++++++++++++++++++++++++++++++++
>   include/xen/grant_table.h | 18 ++++++++
>   3 files changed, 128 insertions(+)
> 
> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index e5d0c28372ea..39536ddfbce4 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -161,6 +161,19 @@ config XEN_GRANT_DEV_ALLOC
>   	  to other domains. This can be used to implement frontend drivers
>   	  or as part of an inter-domain shared memory channel.
>   
> +config XEN_GRANT_DMA_ALLOC
> +	bool "Allow allocating DMA capable buffers with grant reference module"
> +	depends on XEN && HAS_DMA
> +	help
> +	  Extends grant table module API to allow allocating DMA capable
> +	  buffers and mapping foreign grant references on top of it.
> +	  The resulting buffer is similar to one allocated by the balloon
> +	  driver in terms that proper memory reservation is made
> +	  ({increase|decrease}_reservation and VA mappings updated if needed).

I think you should drop the word "terms" and say "is made *by*" and "VA 
mappings *are* updated"

And similar change in the commit message.

-boris

