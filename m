Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F275FC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FDC20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1FDC20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbeJXBGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:06:51 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51720 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeJXBGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 21:06:51 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9NGgcS1051709;
        Tue, 23 Oct 2018 11:42:38 -0500
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9NGgcMA106149
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Oct 2018 11:42:38 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 23
 Oct 2018 11:42:37 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 23 Oct 2018 11:42:37 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9NGgbsM023729;
        Tue, 23 Oct 2018 11:42:37 -0500
Subject: Re: [PATCH v4 00/17] remoteproc: add fixed memory region support
To:     Loic Pallardy <loic.pallardy@st.com>, <bjorn.andersson@linaro.org>,
        <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <129e3fbe-72c6-97d7-7d83-dc2858074f33@ti.com>
Date:   Tue, 23 Oct 2018 11:42:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 7/27/18 8:14 AM, Loic Pallardy wrote:
> The aim of the series is to implement carveout memory management as
> discussed during OpenAMP weekly call and defined in proposed document [1]
> 
> This first series focus only on adding support of the different types of
> carveout memories (dynamic, fixed, platform driver depend...).
> 64bit resource table will be addressed in a next series.
> Cent
> [1]: http://openamp.github.io/docs/mca/coprocessor-memory-definition-v6.pdf

Some of the patches in this series are breaking TI platforms, and I have
found couple of generic bugs as well. You may want to reconsider some of
these patches for 4.20. Apologies for the late review, but please look
through the comments I will be posting on various patches through the
rest of the day.

regards
Suman

> 
> ---
> Changes since V3:
> - Rebase on top of Bjorn remoteproc next git (3d065621c921)
> - Apply on top of "remoteproc: replace "%p" with "%pK"" [2]
> - Lot of changes to centralize carveout allocation before rproc_start()
> - Remove prepare/unprepare ops and rely on parse_fw instead of
> - Add possibility to assign reserved memory region to vdev device
> - Adapt TI da8xx and keystone remoteproc driver
> 
> As V3 series, V4 series takes some assumptions for carveout names
> associated to vdev:
> - For vring: "vdev%xvring%x" with vdev index from resource table and vring index
>   in vdev.
> - For vdev buffer: "vdev%xbuffer" with vdev index from resource table
> 
> [2] https://patchwork.kernel.org/patch/10511599
> 
> Changes since V2:
> Reshuffle the series to: 
> - Take into account Bjorn's comments.
> - Add patch to check consistency between carveout resource request and IOMMU
>   support.
> - Introduce platform specific prepare and unprepare ops to enable HW like
>   clock, bus, regulator, memory region... before loading co-processor firmware.
> - Rely on memory carveout management for all remoteproc memory allocations.
> - Lookup pre-registered carveout by name first.
> - Create a subdevice for each vdev declared in firmware resource table that
>   will be used by virtio based driver to retrieve specific memory pool.
> 
> This series takes some assumptions for carveout names associated to vdev:
> - For vring: "vdev%xvring%x" with vdev index from resource table and vring index
>   in vdev.
> - For vdev buffer: "vdev%xbuffer" with vdev index from resource table
> 
> This will be changed in the future, adding names field in vdev resource in
> next resource table version.
> 
> 
> Changes since V1:
> - Minor corrections on first 7 patches (error management)
> - Add "memory device" support on the top of first 7 patches.
>   Goal is to answer use case reported during OpenAMP weekly discussion:
>   - "Be able to specify memory region for vring and buffer allocation, even
>     if no specific request defined in firmware resource table."
>   Patches offer the capability to create a "memory device" associated to a
>   carveout with a dedicated DMA memory pool. Different resource handlers are
>   modified to look-up for specific carveout by name. If match found and associated
>   "memory device" present, device is used instead of rproc platform device for
>   allocation.
> 
> 
> Loic Pallardy (17):
>   remoteproc: configure IOMMU only if device address requested
>   remoteproc: add rproc_va_to_pa function
>   remoteproc: add release ops in rproc_mem_entry struct
>   remoteproc: add name in rproc_mem_entry struct
>   remoteproc: add helper function to allocate and init rproc_mem_entry
>     struct
>   remoteproc: introduce rproc_add_carveout function
>   remoteproc: introduce rproc_find_carveout_by_name function
>   remoteproc: add alloc ops in rproc_mem_entry struct
>   remoteproc: add helper function to allocate rproc_mem_entry from
>     reserved memory
>   remoteproc: add helper function to check carveout device address
>   remoteproc: modify rproc_handle_carveout to support pre-registered
>     region
>   remoteproc: modify vring allocation to rely on centralized carveout
>     allocator
>   remoteproc: create vdev subdevice with specific dma memory pool
>   remoteproc: keystone: declare reserved memory region for vdev device
>   remoteproc: da8xx: declare reserved memory region for vdev device
>   remoteproc: st: add reserved memory support
>   rpmsg: virtio: allocate buffer from parent
> 
>  drivers/remoteproc/da8xx_remoteproc.c    |  38 ++
>  drivers/remoteproc/keystone_remoteproc.c |  53 ++-
>  drivers/remoteproc/remoteproc_core.c     | 572 +++++++++++++++++++++++++------
>  drivers/remoteproc/remoteproc_debugfs.c  |   1 +
>  drivers/remoteproc/remoteproc_internal.h |   3 +
>  drivers/remoteproc/remoteproc_virtio.c   |  56 ++-
>  drivers/remoteproc/st_remoteproc.c       |  96 +++++-
>  drivers/rpmsg/virtio_rpmsg_bus.c         |   6 +-
>  include/linux/remoteproc.h               |  35 +-
>  9 files changed, 728 insertions(+), 132 deletions(-)
> 

