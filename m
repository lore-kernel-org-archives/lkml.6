Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5DEC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C764C208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C764C208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbeGaISn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:18:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726591AbeGaISm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:18:42 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6V6dOnp091798
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 02:39:57 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kjhrkhx3u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 02:39:56 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <khandual@linux.vnet.ibm.com>;
        Tue, 31 Jul 2018 07:39:54 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 31 Jul 2018 07:39:50 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6V6dnIi41812104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Jul 2018 06:39:49 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0F8E4C04E;
        Tue, 31 Jul 2018 09:40:01 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A32114C04A;
        Tue, 31 Jul 2018 09:39:58 +0100 (BST)
Received: from [9.202.14.95] (unknown [9.202.14.95])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jul 2018 09:39:58 +0100 (BST)
Subject: Re: [RFC 2/4] virtio: Override device's DMA OPS with
 virtio_direct_dma_ops selectively
To:     Christoph Hellwig <hch@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180720035941.6844-3-khandual@linux.vnet.ibm.com>
 <c443ad8c-fb81-302d-edb2-5521831d38da@linux.vnet.ibm.com>
 <20180729001344-mutt-send-email-mst@kernel.org>
 <20180730093027.GC26245@infradead.org>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        aik@ozlabs.ru, robh@kernel.org, joe@perches.com,
        elfring@users.sourceforge.net, david@gibson.dropbear.id.au,
        jasowang@redhat.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
        linuxram@us.ibm.com, haren@linux.vnet.ibm.com, paulus@samba.org,
        srikar@linux.vnet.ibm.com
From:   Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date:   Tue, 31 Jul 2018 12:09:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180730093027.GC26245@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18073106-0012-0000-0000-0000029161A1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18073106-0013-0000-0000-000020C3632F
Message-Id: <52dcdcf5-971f-a53d-6cee-603668033596@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-31_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807310072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/30/2018 03:00 PM, Christoph Hellwig wrote:
>>> +
>>> +	if (xen_domain())
>>> +		goto skip_override;
>>> +
>>> +	if (virtio_has_iommu_quirk(dev))
>>> +		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);
>>> +
>>> + skip_override:
>>> +
>>
>> I prefer normal if scoping as opposed to goto spaghetti pls.
>> Better yet move vring_use_dma_api here and use it.
>> Less of a chance something will break.
> 
> I agree about avoid pointless gotos here, but we can do things
> perfectly well without either gotos or a confusing helper here
> if we structure it right. E.g.:
> 
> 	// suitably detailed comment here
> 	if (!xen_domain() &&
> 	    !virtio_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM))
> 		set_dma_ops(dev->dev.parent, &virtio_direct_dma_ops);

I had updated this patch calling vring_use_dma_api() as a helper
as suggested by Michael but yes we can have the above condition
with a comment block. I will change this patch accordingly.

> 
> and while we're at it - modifying dma ops for the parent looks very
> dangerous.  I don't think we can do that, as it could break iommu
> setup interactions.  IFF we set a specific dma map ops it has to be
> on the virtio device itself, of which we have full control.

I understand your concern. At present virtio core calls parent's DMA
ops callbacks when device has VIRTIO_F_IOMMU_PLATFORM flag set. Most
likely those DMA OPS are architecture specific ones which can really
configure IOMMU. Most probably all devices and their parents share
the same DMA ops callback. IIUC as long as the entire system has a
single DMA ops structure, it should be okay. But I may be missing
other implications. I tried changing virtio core so that it always
calls device's DMA ops instead of it's parent DMA ops, it hit the
following WARN_ON for devices without IOMMU flag and hit both the
WARN_ON and BUG_ON for devices with the IOMMU flag.

static inline void *dma_alloc_attrs(struct device *dev, size_t size,
                                       dma_addr_t *dma_handle, gfp_t flag,
                                       unsigned long attrs)
{
        const struct dma_map_ops *ops = get_dma_ops(dev);
        void *cpu_addr;

        BUG_ON(!ops);
        WARN_ON_ONCE(dev && !dev->coherent_dma_mask);

--------

Seems like virtio device's DMA ops and coherent_dma_mask was never
set correctly assuming that virtio core always called parent's DMA
OPS all the time. We may have to change virtio device init to fix
this. Any thoughts ?

