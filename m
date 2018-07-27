Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FC0C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AE9208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1AE9208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbeG0OhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:37:12 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:22460 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730395AbeG0OhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:37:12 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6RDE7MR020140;
        Fri, 27 Jul 2018 15:15:14 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2kg25fgjt7-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 15:15:14 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 44F7631;
        Fri, 27 Jul 2018 13:15:13 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 21658577A;
        Fri, 27 Jul 2018 13:15:13 +0000 (GMT)
Received: from localhost (10.75.127.48) by SFHDAG7NODE2.st.com (10.75.127.20)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 27 Jul 2018 15:15:12
 +0200
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v4 00/17] remoteproc: add fixed memory region support
Date:   Fri, 27 Jul 2018 15:14:35 +0200
Message-ID: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aim of the series is to implement carveout memory management as
discussed during OpenAMP weekly call and defined in proposed document [1]

This first series focus only on adding support of the different types of
carveout memories (dynamic, fixed, platform driver depend...).
64bit resource table will be addressed in a next series.
Cent
[1]: http://openamp.github.io/docs/mca/coprocessor-memory-definition-v6.pdf

---
Changes since V3:
- Rebase on top of Bjorn remoteproc next git (3d065621c921)
- Apply on top of "remoteproc: replace "%p" with "%pK"" [2]
- Lot of changes to centralize carveout allocation before rproc_start()
- Remove prepare/unprepare ops and rely on parse_fw instead of
- Add possibility to assign reserved memory region to vdev device
- Adapt TI da8xx and keystone remoteproc driver

As V3 series, V4 series takes some assumptions for carveout names
associated to vdev:
- For vring: "vdev%xvring%x" with vdev index from resource table and vring index
  in vdev.
- For vdev buffer: "vdev%xbuffer" with vdev index from resource table

[2] https://patchwork.kernel.org/patch/10511599

Changes since V2:
Reshuffle the series to: 
- Take into account Bjorn's comments.
- Add patch to check consistency between carveout resource request and IOMMU
  support.
- Introduce platform specific prepare and unprepare ops to enable HW like
  clock, bus, regulator, memory region... before loading co-processor firmware.
- Rely on memory carveout management for all remoteproc memory allocations.
- Lookup pre-registered carveout by name first.
- Create a subdevice for each vdev declared in firmware resource table that
  will be used by virtio based driver to retrieve specific memory pool.

This series takes some assumptions for carveout names associated to vdev:
- For vring: "vdev%xvring%x" with vdev index from resource table and vring index
  in vdev.
- For vdev buffer: "vdev%xbuffer" with vdev index from resource table

This will be changed in the future, adding names field in vdev resource in
next resource table version.


Changes since V1:
- Minor corrections on first 7 patches (error management)
- Add "memory device" support on the top of first 7 patches.
  Goal is to answer use case reported during OpenAMP weekly discussion:
  - "Be able to specify memory region for vring and buffer allocation, even
    if no specific request defined in firmware resource table."
  Patches offer the capability to create a "memory device" associated to a
  carveout with a dedicated DMA memory pool. Different resource handlers are
  modified to look-up for specific carveout by name. If match found and associated
  "memory device" present, device is used instead of rproc platform device for
  allocation.


Loic Pallardy (17):
  remoteproc: configure IOMMU only if device address requested
  remoteproc: add rproc_va_to_pa function
  remoteproc: add release ops in rproc_mem_entry struct
  remoteproc: add name in rproc_mem_entry struct
  remoteproc: add helper function to allocate and init rproc_mem_entry
    struct
  remoteproc: introduce rproc_add_carveout function
  remoteproc: introduce rproc_find_carveout_by_name function
  remoteproc: add alloc ops in rproc_mem_entry struct
  remoteproc: add helper function to allocate rproc_mem_entry from
    reserved memory
  remoteproc: add helper function to check carveout device address
  remoteproc: modify rproc_handle_carveout to support pre-registered
    region
  remoteproc: modify vring allocation to rely on centralized carveout
    allocator
  remoteproc: create vdev subdevice with specific dma memory pool
  remoteproc: keystone: declare reserved memory region for vdev device
  remoteproc: da8xx: declare reserved memory region for vdev device
  remoteproc: st: add reserved memory support
  rpmsg: virtio: allocate buffer from parent

 drivers/remoteproc/da8xx_remoteproc.c    |  38 ++
 drivers/remoteproc/keystone_remoteproc.c |  53 ++-
 drivers/remoteproc/remoteproc_core.c     | 572 +++++++++++++++++++++++++------
 drivers/remoteproc/remoteproc_debugfs.c  |   1 +
 drivers/remoteproc/remoteproc_internal.h |   3 +
 drivers/remoteproc/remoteproc_virtio.c   |  56 ++-
 drivers/remoteproc/st_remoteproc.c       |  96 +++++-
 drivers/rpmsg/virtio_rpmsg_bus.c         |   6 +-
 include/linux/remoteproc.h               |  35 +-
 9 files changed, 728 insertions(+), 132 deletions(-)

-- 
1.9.1

