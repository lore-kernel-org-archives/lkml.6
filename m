Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033068AbeCAQ3C (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:29:02 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43959 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1032934AbeCAQYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:24:13 -0500
From: Loic Pallardy <loic.pallardy@st.com>
To: <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v3 00/13] remoteproc: add fixed memory region support
Date: Thu, 1 Mar 2018 17:23:47 +0100
Message-ID: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aim of the series is to implement carveout memory management as
discussed during OpenAMP weekly call and defined in proposed document [1]

This first series focus only on adding support of the different types of
carveout memories (dynamic, fixed, platform driver depend...).
64bit resource table will be addressed in a next series.

[1]: http://openamp.github.io/docs/mca/coprocessor-memory-definition-v6.pdf

---
Changes sine V2:
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


Loic Pallardy (13):
  remoteproc: configure IOMMU only if device address requested
  remoteproc: add rproc_va_to_pa function
  remoteproc: add release ops in rproc_mem_entry struct
  remoteproc: add name in rproc_mem_entry struct
  remoteproc: add helper function to allocate and init rproc_mem_entry
    struct
  remoteproc: introduce rproc_add_carveout function
  remoteproc: introduce rproc_find_carveout_by_name function
  remoteproc: add prepare and unprepare ops
  remoteproc: modify rproc_handle_carveout to support pre-registered
    region
  remoteproc: modify vring allocation to support pre-registered region
  remoteproc: create vdev subdevice with specific dma memory pool
  rpmsg: virtio: allocate buffer from parent
  remoteproc: st: add reserved memory support

 drivers/remoteproc/remoteproc_core.c    | 332 ++++++++++++++++++++++++++++----
 drivers/remoteproc/remoteproc_debugfs.c |   1 +
 drivers/remoteproc/remoteproc_virtio.c  |   2 +-
 drivers/remoteproc/st_remoteproc.c      |  68 ++++++-
 drivers/rpmsg/virtio_rpmsg_bus.c        |   2 +-
 include/linux/remoteproc.h              |  22 ++-
 6 files changed, 379 insertions(+), 48 deletions(-)

-- 
1.9.1
