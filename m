Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B29C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B4F2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B4F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeICGvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 02:51:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:63415 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725949AbeICGvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 02:51:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2018 19:33:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,323,1531810800"; 
   d="scan'208";a="67899220"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by fmsmga008.fm.intel.com with ESMTP; 02 Sep 2018 19:33:15 -0700
Cc:     baolu.lu@linux.intel.com, linuxarm@huawei.com
Subject: Re: [RFCv2 PATCH 0/7] A General Accelerator Framework, WarpDrive
To:     Kenneth Lee <nek.in.cn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Hao Fang <fanghao11@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kvm@vger.kernel.org, linux-accelerators@lists.ozlabs.org,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
References: <20180903005204.26041-1-nek.in.cn@gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <81edb8ff-d046-34e5-aee7-d8564e2517c2@linux.intel.com>
Date:   Mon, 3 Sep 2018 10:32:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903005204.26041-1-nek.in.cn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/03/2018 08:51 AM, Kenneth Lee wrote:
> From: Kenneth Lee <liguozhu@hisilicon.com>
> 
> WarpDrive is an accelerator framework to expose the hardware capabilities
> directly to the user space. It makes use of the exist vfio and vfio-mdev
> facilities. So the user application can send request and DMA to the
> hardware without interaction with the kernel. This removes the latency
> of syscall.
> 
> WarpDrive is the name for the whole framework. The component in kernel
> is called SDMDEV, Share Domain Mediated Device. Driver driver exposes its
> hardware resource by registering to SDMDEV as a VFIO-Mdev. So the user
> library of WarpDrive can access it via VFIO interface.
> 
> The patchset contains document for the detail. Please refer to it for more
> information.
> 
> This patchset is intended to be used with Jean Philippe Brucker's SVA
> patch [1], which enables not only IO side page fault, but also PASID
> support to IOMMU and VFIO.
> 
> With these features, WarpDrive can support non-pinned memory and
> multi-process in the same accelerator device.  We tested it in our SoC
> integrated Accelerator (board ID: D06, Chip ID: HIP08). A reference work
> tree can be found here: [2].
> 
> But it is not mandatory. This patchset is tested in the latest mainline
> kernel without the SVA patches.  So it supports only one process for each
> accelerator.
> 
> We have noticed the IOMMU aware mdev RFC announced recently [3].
> 
> The IOMMU aware mdev has similar idea but different intention comparing to
> WarpDrive. It intends to dedicate part of the hardware resource to a VM.
> And the design is supposed to be used with Scalable I/O Virtualization.
> While sdmdev is intended to share the hardware resource with a big amount
> of processes.  It just requires the hardware supporting address
> translation per process (PCIE's PASID or ARM SMMU's substream ID).
> 
> But we don't see serious confliction on both design. We believe they can be
> normalized as one.
> 
> The patch 1 is document of the framework. The patch 2 and 3 add sdmdev
> support. The patch 4, 5 and 6 is drivers for Hislicon's ZIP Accelerator
> which is registered to both crypto and warpdrive(sdmdev) and can be
> used from kernel or user space at the same time. The patch 7 is a user
> space sample demonstrating how WarpDrive works.
> 
> 
> Change History:
> V2 changed from V1:
> 	1. Change kernel framework name from SPIMDEV (Share Parent IOMMU
> 	   Mdev) to SDMDEV (Share Domain Mdev).
> 	2. Allocate Hardware Resource when a new mdev is created (While
> 	   it is allocated when the mdev is openned)
> 	3. Unmap pages from the shared domain when the sdmdev iommu group is
> 	   detached. (This procedure is necessary, but missed in V1)
> 	4. Update document accordingly.
> 	5. Rebase to the latest kernel (4.19.0-rc1)
> 	
> 	According the review comment on RFCv1, We did try to use dma-buf
> 	as back end of WarpDrive. It can work properly with the current
> 	solution [4], but it cannot make use of process's
> 	own memory address space directly. This is important to many
> 	acceleration scenario. So dma-buf will be taken as a backup
> 	alternative for noiommu scenario, it will be added in the future
> 	version.
> 
> 
> Refernces:
> [1] https://www.spinics.net/lists/kernel/msg2651481.html
> [2] https://github.com/Kenneth-Lee/linux-kernel-warpdrive/tree/warpdrive-sva-v0.5
> [3] https://lkml.org/lkml/2018/7/22/34

Please refer to the latest version posted here for discussion.

https://lkml.org/lkml/2018/8/30/107

Best regards,
Lu Baolu
