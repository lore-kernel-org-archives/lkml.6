Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782EDC4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 12:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230F82146E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 12:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Imc2kINv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230F82146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbeHSQJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 12:09:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54410 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbeHSQJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 12:09:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7JCv91T018481;
        Sun, 19 Aug 2018 12:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding :
 subject : to : cc : from : message-id; s=corp-2018-07-02;
 bh=TlmxYMabTCWRQy20bX2E8IWYk2H53NntTSADNw4Pj4Y=;
 b=Imc2kINvePjMSBoPSpgLBJuqZNQhmFexcAEza4zW7mhOUYmOXrc8W5t3cT+GYpc0O8RB
 RN58mxZTS7031mp6nz2A9lbjJwWED+mEhyQcO7BOBPxmPL/1otwUz5r1Vqgu2X1fHixK
 t9qqawvkRTMeXjapfYuZBbkAoSnjG2H8z/AGHyjgyzSnBOO+WybI/no5XRY7vi0HSV6i
 Ykqba+Wr2BBGp3qrmcxZEQMUDKm/Gojgl/ZLs1uFf7TQczOxCu+icFr4FPoknrC0lpbH
 nAbHDgmX8g/p44SPh2nDCvXPI7cUWdwbF+8y9qEfMUMO83zlewyKvcxyzypUu0yZSguE cw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2kxavtav6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Aug 2018 12:57:37 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7JCvanC002229
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Aug 2018 12:57:36 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7JCvYFO010086;
        Sun, 19 Aug 2018 12:57:35 GMT
Received: from [192.168.29.126] (/209.6.39.171)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 19 Aug 2018 12:57:34 +0000
Date:   Sun, 19 Aug 2018 08:57:31 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <1534619091-14258-1-git-send-email-estebanzacr.20@gmail.com>
References: <1534619091-14258-1-git-send-email-estebanzacr.20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] swiotlb: Fix uninitialized pointer on DMA ops
To:     Esteban Zamora <estebanzacr.20@gmail.com>, estebanzacr.20@gmail.com
CC:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <779B2AB6-0FF2-4A58-A333-E7207184E0BE@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8989 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=819
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808190144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On August 18, 2018 3:04:51 PM EDT, Esteban Zamora <estebanzacr=2E20@gmail=
=2Ecom> wrote:
>The mmap function pointer on swiotlb_dma_ops struct is
>uninitialized, which causes a random crash when calling
>the dma_mmap_coherent function on platforms where no DMA
>address translation hardware is available=2E
>
>Set this pointer to NULL in order to fix the issue=2E


By default unused entries in =2Erodata structure (like this one) are zero =
- meaning they are NULL if not set by the complier=2E

You should be able to verify this by looking at the objdump of the kernel =
and find this structure=2E


>
>Signed-off-by: Esteban Zamora <estebanzacr=2E20@gmail=2Ecom>
>---
> kernel/dma/swiotlb=2Ec | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/kernel/dma/swiotlb=2Ec b/kernel/dma/swiotlb=2Ec
>index 4f8a6db=2E=2E9a7718c 100644
>--- a/kernel/dma/swiotlb=2Ec
>+++ b/kernel/dma/swiotlb=2Ec
>@@ -1082,5 +1082,6 @@ const struct dma_map_ops swiotlb_dma_ops =3D {
> 	=2Emap_page		=3D swiotlb_map_page,
> 	=2Eunmap_page		=3D swiotlb_unmap_page,
> 	=2Edma_supported		=3D dma_direct_supported,
>+	=2Emmap                   =3D NULL,
> };
> EXPORT_SYMBOL(swiotlb_dma_ops);

