Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7FE1AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 03:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286B820693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 03:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HLa3VHQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286B820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754402AbeFMDO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 23:14:58 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44430 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754202AbeFMDO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 23:14:57 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5D3ArXs168522;
        Wed, 13 Jun 2018 03:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=rk9H8ECkUHTZTHA16nbIj1YbQ2GtX4F/saF9QVPbo9M=;
 b=HLa3VHQJj/QjiMKyAG4gR+NM+jZNEn3cqso/K8no3R7LpQw0K03/kqD70fSxa8P0QvGw
 elS92sKdfSMJsfRaLiJuqFMcLqKkdYWGrVzTdZ1zi08nkBELM9u0kv/cXqvIxWpHXJmi
 /c0bZCmCrky3mSRnmftqi3J2BsLmKdIOYfYc8SMow826gfcsYIfMt2sufM19PK8qRMUm
 ze5bzJ3HUiwoajtPwl2QbZ+AzoYrldyDfq2hISexmc6SGcoUiK3nFYp/gbdYOict6rN1
 6jF4guf7AQisVFx2sEfNwF9/JUGgu6okzVwDPP4C9m/LInYx4MJmEhRL0TxuM4nSEOP6 yQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2jjp6c8hqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 03:14:46 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5D3Ej03023123
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 03:14:46 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5D3Eifa023035;
        Wed, 13 Jun 2018 03:14:44 GMT
Received: from [10.154.144.7] (/10.154.144.7)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 20:14:44 -0700
Subject: Re: [PATCH v3 9/9] xen/gntdev: Implement dma-buf import functionality
To:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180612134200.17456-1-andr2000@gmail.com>
 <20180612134200.17456-10-andr2000@gmail.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <b08fdccf-2f1b-a902-f00b-a4cecf44a1b1@oracle.com>
Date:   Tue, 12 Jun 2018 23:14:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612134200.17456-10-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8922 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=749
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806130036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/12/2018 09:42 AM, Oleksandr Andrushchenko wrote:

>   int gntdev_dmabuf_imp_release(struct gntdev_dmabuf_priv *priv, u32 fd)
>   {
> -	return -EINVAL;
> +	struct gntdev_dmabuf *gntdev_dmabuf;
> +	struct dma_buf_attachment *attach;
> +	struct dma_buf *dma_buf;
> +
> +	gntdev_dmabuf = dmabuf_imp_find_unlink(priv, fd);
> +	if (IS_ERR(gntdev_dmabuf))
> +		return PTR_ERR(gntdev_dmabuf);
> +
> +	pr_debug("Releasing DMA buffer with fd %d\n", fd);
> +
> +	attach = gntdev_dmabuf->u.imp.attach;
> +
> +	if (gntdev_dmabuf->u.imp.sgt)
> +		dma_buf_unmap_attachment(attach, gntdev_dmabuf->u.imp.sgt,
> +					 DMA_BIDIRECTIONAL);
> +	dma_buf = attach->dmabuf;
> +	dma_buf_detach(attach->dmabuf, attach);
> +	dma_buf_put(dma_buf);
> +
> +	dmabuf_imp_end_foreign_access(gntdev_dmabuf->u.imp.refs,
> +				      gntdev_dmabuf->nr_pages);



Should you first end foreign access, before doing anything?

-boris


> +	dmabuf_imp_free_storage(gntdev_dmabuf);
> +	return 0;
>   }
>   
