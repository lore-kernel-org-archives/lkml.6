Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D97ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3B62084C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 06:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3B62084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeGPG2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 02:28:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727163AbeGPG2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 02:28:50 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6G5wwMQ138521
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 02:03:06 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k8fwbjw7s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 02:03:06 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <mahesh@linux.vnet.ibm.com>;
        Mon, 16 Jul 2018 07:03:04 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 16 Jul 2018 07:03:00 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6G62xtd13959326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Jul 2018 06:02:59 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B4F6A4059;
        Mon, 16 Jul 2018 09:03:18 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22260A4065;
        Mon, 16 Jul 2018 09:03:16 +0100 (BST)
Received: from jupiter.in.ibm.com (unknown [9.109.202.229])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 16 Jul 2018 09:03:15 +0100 (BST)
Subject: [RFC PATCH v6 0/4] powerpc/fadump: Improvements and fixes for
 firmware-assisted dump.
From:   Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To:     linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@suse.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Ananth Narayan <ananth@in.ibm.com>, kernelfans@gmail.com
Date:   Mon, 16 Jul 2018 11:32:56 +0530
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18071606-0008-0000-0000-000002537A0F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071606-0009-0000-0000-000021B9C274
Message-Id: <153172096333.29252.4376707071382727345.stgit@jupiter.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-16_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=909 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807160072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the primary issues with Firmware Assisted Dump (fadump) on Power
is that it needs a large amount of memory to be reserved. This reserved
memory is used for saving the contents of old crashed kernel's memory before
fadump capture kernel uses old kernel's memory area to boot. However, This
reserved memory area stays unused until system crash and isn't available
for production kernel to use.

Instead of setting aside a significant chunk of memory that nobody can use,
take advantage ZONE_MOVABLE to mark a significant chunk of reserved memory
as ZONE_MOVABLE, so that the kernel is prevented from using, but
applications are free to use it.

Patch 1 introduces an interface to mark reserved memory as ZONE_MOVABLE.
Patch 2 uses the above interface to mark reserved memory movable so that
it can be used for applications usage, making fadump reservationless.
Patch 3 and 4 fixes minor issues.

Changes in V6:
- Introduce an interface to mark reserved memory as ZONE_MOVABLE. Hence
  sending this series as RFC again.
- Mark reserved area as ZONE_MOVABLE instead of CMA.
- Add fadump=nonmovable parameter for user who don't want to use ZONE_MOVABLE.

Changes in V5:
- Drop the patch that does metadata movement.
- Move the kexec fix patch to top (patch 1)
- Fold CMA documenation patch into patch 2
- Fix the compilation issues when CONFIG_CMA is not set reported by Hari.
- Use the approach of using boot memory size for CMA as suggested by Hari
  except the movement of sections. Thanks to Hari.

Changes in V4:
- patch 1: Make fadump compatible irrespective of kernel versions.
- patch 4: moved out of the series and been posted seperatly at
  http://patchwork.ozlabs.org/patch/896716/
- Documentation update about CMA reservation.

Changes in V3:
- patch 1 & 2: move metadata region and documentation update.
- patch 7: Un-register the faudmp on kexec path


---

Mahesh Salgaonkar (4):
      mm/page_alloc: Introduce an interface to mark reserved memory as ZONE_MOVABLE
      powerpc/fadump: Reservationless firmware assisted dump
      powerpc/fadump: throw proper error message on fadump registration failure.
      powerpc/fadump: Do not allow hot-remove memory from fadump reserved area.


 Documentation/powerpc/firmware-assisted-dump.txt |   18 +++
 arch/powerpc/include/asm/fadump.h                |    7 +
 arch/powerpc/kernel/fadump.c                     |  123 +++++++++++++++++--
 arch/powerpc/platforms/pseries/hotplug-memory.c  |    7 +
 include/linux/mmzone.h                           |    2 
 mm/page_alloc.c                                  |  146 ++++++++++++++++++++++
 6 files changed, 290 insertions(+), 13 deletions(-)

--
Signature

