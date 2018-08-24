Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B962C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA852147A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA852147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbeHXUBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 16:01:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50930 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726488AbeHXUBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 16:01:17 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7OGNqMP029285
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 12:25:55 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m2mfy2p8x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 12:25:55 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Fri, 24 Aug 2018 10:25:54 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 Aug 2018 10:25:49 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7OGPmYO49479832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Aug 2018 09:25:48 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5005C7805E;
        Fri, 24 Aug 2018 10:25:48 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09BD57805C;
        Fri, 24 Aug 2018 10:25:44 -0600 (MDT)
Received: from morokweng.localdomain.com (unknown [9.80.232.133])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 24 Aug 2018 10:25:44 -0600 (MDT)
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Anshuman Khandual <anshuman.linux@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Anderson <andmike@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [RFC PATCH 00/11] Secure Virtual Machine Enablement
Date:   Fri, 24 Aug 2018 13:25:24 -0300
X-Mailer: git-send-email 2.14.4
X-TM-AS-GCONF: 00
x-cbid: 18082416-0012-0000-0000-000016A594D9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009603; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01078233; UDB=6.00555984; IPR=6.00858207;
 MB=3.00022909; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-24 16:25:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082416-0013-0000-0000-00005428523B
Message-Id: <20180824162535.22798-1-bauerman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808240172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Some people didn't receive all the patches in this series, even though
  the linuxppc-dev list did so trying to send again. This is exactly the
  same series I posted yesterday. Sorry for the clutter. ]

This series contains preliminary work to enable Secure Virtual Machines
(SVM) on powerpc. SVMs request to be migrated to secure memory very early in
the boot process (in prom_init()), so by default all of their memory is
inaccessible to the hypervisor. There is an ultravisor call that the VM can
use to request certain pages to be made accessible (aka shared).

The objective of these patches is to have the guest perform this request for
buffers that need to be shared with the hypervisor, such as the LPPACAs, the
SWIOTLB buffer and the Debug Trace Log. This work is incomplete: there are
surely other memory regions that need to be made accessible, but I'm posting
it early to get comments on whether the approach being taken is appropriate.

It should be applied on top of the generic virtio DMA API rework series
posted earlier, which adds a platform hook to override any arch based DMA
API operations for any virtio device:

https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-July/175994.html

I'm aware that changes need to be made to the patch series above, but IIUC
it depends on upcoming virtio cleanup from Christoph Hellwig so for now the
patch series above will be used as a stepping stone for this series.

This code has been tested with virtio block, net and scsi devices with and
without VIRTIO_F_IOMMU_PLATFORM flag. Please let me know what you think.

For now I am testing on a regular guest with a couple of patches on top
forcing is_svm_platform() to always return true and adding debug messages to
confirm that mem_convert_shared() is being called in the expected places.

These are the commands I'm using to start up the guest:

Without VIRTIO_F_IOMMU_PLATFORM:

qemu-system-ppc64 \
  -enable-kvm \
  -kernel /home/bauermann/src/linux/arch/powerpc/boot/zImage \
  -append "root=PARTUUID=e550ad6f-05 ro" \
  -machine pseries-2.6 \
  -m 8G \
  -smp 2 \
  -serial mon:stdio \
  -nographic \
  -nodefaults \
  -device virtio-scsi-pci,id=scsi0,bus=pci.0,addr=0x4 \
  -drive file=/home/bauermann/VMs/svm.qcow2,format=qcow2,if=none,id=drive-scsi0-0-0-0 \
  -device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0-0-0-0,id=scsi0-0-0-0 \
  -drive file=/home/bauermann/VMs/svm-blk.qcow2,format=qcow2,if=none,id=drive-virtio-disk0 \
  -device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x5,drive=drive-virtio-disk0,id=virtio-disk0 \
  -device virtio-net,netdev=hostnet0,id=net0,mac=52:54:00:96:70:1f \
  -netdev user,id=hostnet0 \
  -set netdev.hostnet0.hostfwd=tcp::42022-:22

With VIRTIO_F_IOMMU_PLATFORM. Same as above plus some -global options so
that the virtio devices use the modern interface rather than the
transitional one:

qemu-system-ppc64 \
  -enable-kvm \
  -kernel /home/bauermann/src/linux/arch/powerpc/boot/zImage \
  -append "root=PARTUUID=e550ad6f-05 ro" \
  -machine pseries-2.6 \
  -m 8G \
  -smp 2 \
  -serial mon:stdio \
  -nographic \
  -nodefaults \
  -device virtio-scsi-pci,id=scsi0,bus=pci.0,addr=0x4 \
  -drive file=/home/bauermann/VMs/svm.qcow2,format=qcow2,if=none,id=drive-scsi0-0-0-0 \
  -device scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0-0-0-0,id=scsi0-0-0-0 \
  -drive file=/home/bauermann/VMs/svm-blk.qcow2,format=qcow2,if=none,id=drive-virtio-disk0 \
  -device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x5,drive=drive-virtio-disk0,id=virtio-disk0 \
  -device virtio-net,netdev=hostnet0,id=net0,mac=52:54:00:96:70:1f \
  -netdev user,id=hostnet0 \
  -set netdev.hostnet0.hostfwd=tcp::42022-:22 \
  -global virtio-blk-pci.iommu_platform=true \
  -global virtio-blk-pci.disable-legacy=on \
  -global virtio-blk-pci.disable-modern=off \
  -global virtio-net-pci.iommu_platform=true \
  -global virtio-net-pci.disable-legacy=on \
  -global virtio-net-pci.disable-modern=off \
  -global virtio-scsi-pci.iommu_platform=true \
  -global virtio-scsi-pci.disable-legacy=on \
  -global virtio-scsi-pci.disable-modern=off

The code was tested with a couple of other permutations where one virtio
device has the flag VIRTIO_F_IOMMU_PLATFORM and others don't. Please suggest
some other scenarios which need to be tested as well.

Anshuman Khandual (10):
  powerpc/svm: Detect Secure Virtual Machine (SVM) platform
  powerpc/svm: Select CONFIG_DMA_DIRECT_OPS and CONFIG_SWIOTLB
  powerpc/svm: Add memory conversion (shared/secure) helper functions
  powerpc/svm: Convert SWIOTLB buffers to shared memory
  powerpc/svm: Don't release SWIOTLB buffers on secure guests
  powerpc/svm: Use SWIOTLB DMA API for all virtio devices
  powerpc/svm: Use shared memory for Debug Trace Log (DTL)
  powerpc/svm: Use shared memory for LPPACA structures
  powerpc/svm: Force the use of bounce buffers
  powerpc/svm: Increase SWIOTLB buffer size

Thiago Jung Bauermann (1):
  powerpc: Add and use LPPACA_SIZE constant

 arch/powerpc/Kconfig                   | 22 ++++++++
 arch/powerpc/include/asm/mem_encrypt.h | 19 +++++++
 arch/powerpc/include/asm/reg.h         |  3 ++
 arch/powerpc/include/asm/svm.h         | 26 +++++++++
 arch/powerpc/kernel/Makefile           |  1 +
 arch/powerpc/kernel/paca.c             | 41 ++++++++++++--
 arch/powerpc/kernel/svm.c              | 99 ++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/iommu.c |  6 ++-
 arch/powerpc/platforms/pseries/setup.c |  5 +-
 kernel/dma/swiotlb.c                   |  5 ++
 10 files changed, 221 insertions(+), 6 deletions(-)
 create mode 100644 arch/powerpc/include/asm/mem_encrypt.h
 create mode 100644 arch/powerpc/include/asm/svm.h
 create mode 100644 arch/powerpc/kernel/svm.c

