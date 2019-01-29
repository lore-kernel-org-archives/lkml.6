Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8960FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDCB214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfA2RnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:43:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49210 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726852AbfA2RnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:43:14 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0THYSG5083037
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 12:43:13 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qasn8xgdr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 12:43:12 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 29 Jan 2019 17:43:11 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 29 Jan 2019 17:43:07 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0THh6cR24903760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Jan 2019 17:43:06 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FF15AC062;
        Tue, 29 Jan 2019 17:43:06 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 419DFAC059;
        Tue, 29 Jan 2019 17:42:55 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.217.24])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Tue, 29 Jan 2019 17:42:53 +0000 (GMT)
References: <87zhrj8kcp.fsf@morokweng.localdomain>
User-agent: mu4e 1.0; emacs 26.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     virtualization@lists.linux-foundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        David Gibson <david@gibson.dropbear.id.au>,
        Alexey Kardashevskiy <aik@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ram Pai <linuxram@us.ibm.com>
Subject: Re: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
In-reply-to: <87zhrj8kcp.fsf@morokweng.localdomain>
Date:   Tue, 29 Jan 2019 15:42:44 -0200
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19012917-0040-0000-0000-000004B932F7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010500; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01153551; UDB=6.00593882; IPR=6.00933917;
 MB=3.00025343; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-29 17:43:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012917-0041-0000-0000-000008C447A6
Message-Id: <87womn8inf.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixing address of powerpc mailing list.

Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:

> Hello,
>
> With Christoph's rework of the DMA API that recently landed, the patch
> below is the only change needed in virtio to make it work in a POWER
> secure guest under the ultravisor.
>
> The other change we need (making sure the device's dma_map_ops is NULL
> so that the dma-direct/swiotlb code is used) can be made in
> powerpc-specific code.
>
> Of course, I also have patches (soon to be posted as RFC) which hook up
> <linux/mem_encrypt.h> to the powerpc secure guest support code.
>
> What do you think?
>
> From d0629a36a75c678b4a72b853f8f7f8c17eedd6b3 Mon Sep 17 00:00:00 2001
> From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Date: Thu, 24 Jan 2019 22:08:02 -0200
> Subject: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
>
> The host can't access the guest memory when it's encrypted, so using
> regular memory pages for the ring isn't an option. Go through the DMA API.
>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  drivers/virtio/virtio_ring.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index cd7e755484e3..321a27075380 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -259,8 +259,11 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>  	 * not work without an even larger kludge.  Instead, enable
>  	 * the DMA API if we're a Xen guest, which at least allows
>  	 * all of the sensible Xen configurations to work correctly.
> +	 *
> +	 * Also, if guest memory is encrypted the host can't access
> +	 * it directly. In this case, we'll need to use the DMA API.
>  	 */
> -	if (xen_domain())
> +	if (xen_domain() || sev_active())
>  		return true;
>
>  	return false;


-- 
Thiago Jung Bauermann
IBM Linux Technology Center

