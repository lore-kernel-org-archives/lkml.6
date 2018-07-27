Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDDCC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15822089F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:00:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15822089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732351AbeG0MVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 08:21:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730515AbeG0MVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 08:21:43 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6RAwu4C027485
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 07:00:18 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kfytydu3s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 07:00:18 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <khandual@linux.vnet.ibm.com>;
        Fri, 27 Jul 2018 12:00:16 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Jul 2018 12:00:11 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6RB0AVB36896848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 27 Jul 2018 11:00:10 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBB9B11C069;
        Fri, 27 Jul 2018 14:00:23 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2998E11C04A;
        Fri, 27 Jul 2018 13:58:47 +0100 (BST)
Received: from [9.202.14.95] (unknown [9.202.14.95])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jul 2018 13:58:46 +0100 (BST)
Subject: Re: [RFC 0/4] Virtio uses DMA API for all devices
To:     Will Deacon <will.deacon@arm.com>
References: <20180720035941.6844-1-khandual@linux.vnet.ibm.com>
 <20180727095804.GA25592@arm.com>
Cc:     robh@kernel.org, srikar@linux.vnet.ibm.com, mst@redhat.com,
        aik@ozlabs.ru, jasowang@redhat.com, linuxram@us.ibm.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, hch@infradead.org,
        jean-philippe.brucker@arm.com, paulus@samba.org,
        marc.zyngier@arm.com, joe@perches.com, robin.murphy@arm.com,
        linuxppc-dev@lists.ozlabs.org, elfring@users.sourceforge.net,
        haren@linux.vnet.ibm.com, david@gibson.dropbear.id.au
From:   Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date:   Fri, 27 Jul 2018 16:28:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180727095804.GA25592@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18072711-0020-0000-0000-000002ACCE76
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072711-0021-0000-0000-000020F8DA51
Message-Id: <0f123b95-7ac2-d1a2-80c9-732c7113d9c0@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807270114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/27/2018 03:28 PM, Will Deacon wrote:
> Hi Anshuman,
> 
> On Fri, Jul 20, 2018 at 09:29:37AM +0530, Anshuman Khandual wrote:
>> This patch series is the follow up on the discussions we had before about
>> the RFC titled [RFC,V2] virtio: Add platform specific DMA API translation
>> for virito devices (https://patchwork.kernel.org/patch/10417371/). There
>> were suggestions about doing away with two different paths of transactions
>> with the host/QEMU, first being the direct GPA and the other being the DMA
>> API based translations.
>>
>> First patch attempts to create a direct GPA mapping based DMA operations
>> structure called 'virtio_direct_dma_ops' with exact same implementation
>> of the direct GPA path which virtio core currently has but just wrapped in
>> a DMA API format. Virtio core must use 'virtio_direct_dma_ops' instead of
>> the arch default in absence of VIRTIO_F_IOMMU_PLATFORM flag to preserve the
>> existing semantics. The second patch does exactly that inside the function
>> virtio_finalize_features(). The third patch removes the default direct GPA
>> path from virtio core forcing it to use DMA API callbacks for all devices.
>> Now with that change, every device must have a DMA operations structure
>> associated with it. The fourth patch adds an additional hook which gives
>> the platform an opportunity to do yet another override if required. This
>> platform hook can be used on POWER Ultravisor based protected guests to
>> load up SWIOTLB DMA callbacks to do the required (as discussed previously
>> in the above mentioned thread how host is allowed to access only parts of
>> the guest GPA range) bounce buffering into the shared memory for all I/O
>> scatter gather buffers to be consumed on the host side.
>>
>> Please go through these patches and review whether this approach broadly
>> makes sense. I will appreciate suggestions, inputs, comments regarding
>> the patches or the approach in general. Thank you.
> I just wanted to say that this patch series provides a means for us to
> force the coherent DMA ops for legacy virtio devices on arm64, which in turn
> means that we can enable the SMMU with legacy devices in our fastmodel
> emulation platform (which is slowly being upgraded to virtio 1.0) without
> hanging during boot. Patch below.
> 
> So:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> Tested-by: Will Deacon <will.deacon@arm.com>

Thanks Will.

