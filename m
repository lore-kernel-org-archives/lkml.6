Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDF0C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B4B2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B4B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932133AbeGCLEb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:04:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752837AbeGCLEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:04:30 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63B4MkA058188
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 07:04:29 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k0734a6wg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 07:04:25 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Tue, 3 Jul 2018 07:04:02 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 07:03:59 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w63B3w4D56229944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 11:03:58 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EC1CAE062;
        Tue,  3 Jul 2018 07:03:41 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EF84AE05F;
        Tue,  3 Jul 2018 07:03:41 -0400 (EDT)
Received: from sofia.ibm.com (unknown [9.124.35.39])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 07:03:41 -0400 (EDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 10CC62E2F42; Tue,  3 Jul 2018 16:33:57 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [v2 PATCH 0/2] powerpc: Detection and scheduler optimization for POWER9 bigcore
Date:   Tue,  3 Jul 2018 16:33:49 +0530
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18070311-0052-0000-0000-0000030813B0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009300; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01055907; UDB=6.00541612; IPR=6.00833829;
 MB=3.00021975; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-03 11:04:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070311-0053-0000-0000-00005D3A486B
Message-Id: <cover.1530609795.git.ego@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Hi,

This is the second iteration of the patchset to add support for big-core on POWER9.

The earlier version can be found here: https://lkml.org/lkml/2018/5/11/245.

The changes from the previous version:
    - Added comments explaining the "ibm,thread-groups" device tree property.
    - Uses cleaner device-tree parsing functions to parse the u32 arrays.
    - Adds a sysfs file listing the small-core siblings for every CPU.
    - Enables the scheduler optimization by setting the CPU_FTR_ASYM_SMT bit
      in the cur_cpu_spec->cpu_features on detecting the presence
      of interleaved big-core.
    - Handles the corner case where there is only a single thread-group
      or when there is a single thread in a thread-group.


Description:
~~~~~~~~~~~~~~~~~~~~
A pair of IBM POWER9 SMT4 cores can be fused together to form a
big-core with 8 SMT threads. This can be discovered via the
"ibm,thread-groups" CPU property in the device tree which will
indicate which group of threads that share the L1 cache, translation
cache and instruction data flow.  If there are multiple such group of
threads, then the core is a big-core. Furthermore, the thread-ids of
such a big-core is obtained by interleaving the thread-ids of the
component SMT4 cores.

Eg: Threads in the pair of component SMT4 cores of an interleaved
big-core are numbered {0,2,4,6} and {1,3,5,7} respectively.
    
On such a big-core, when multiple tasks are scheduled to run on the
big-core, we get the best performance when the tasks are spread across
the pair of SMT4 cores.

The Linux scheduler supports a flag called "SD_ASYM_PACKING" which
when set in the SMT sched-domain, biases the load-balancing of the
tasks on the smaller numbered threads in the core. On an big-core
whose threads are interleavings of the threads of the small cores,
enabling SD_ASYM_PACKING in the SMT sched-domain automatically results
in spreading the tasks uniformly across the associated pair of SMT4
cores, thereby yielding better performance.

This patchset contains two patches which on detecting the presence of
interleaved big-cores will enable the the CPU_FTR_ASYM_SMT bit in the
cur_cpu_spec->cpu_feature.

Patch 1: adds support to detect the presence of
big-cores and reports the small-core siblings of each CPU X
via the sysfs file "/sys/devices/system/cpu/cpuX/big_core_siblings".

Patch 2: checks if the thread-ids of the component small-cores are
interleaved, in which case we enable the the CPU_FTR_ASYM_SMT bit in
the cur_cpu_spec->cpu_features which results in the SD_ASYM_PACKING
flag being set at the SMT level sched-domain.

Results:
~~~~~~~~~~~~~~~~~
Experimental results for ebizzy with 2 threads, bound to a single big-core
show a marked improvement with this patchset over the 4.18-rc3 vanilla
kernel.

The result of 100 such runs for 4.18-rc3 kernel and the 4.18-rc3 +
big-core-patches are as follows

4.18-rc3:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        records/s    :  # samples  : Histogram
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
[0 -       1000000]  :      0      : #
[1000000 - 2000000]  :      3      : #
[2000000 - 3000000]  :      16     : ####
[3000000 - 4000000]  :      11     : ###
[4000000 - 5000000]  :      0      : #
[5000000 - 6000000]  :      70     : ###############

4.18-rc3 + big-core-patches
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        records/s    :  # samples  : Histogram
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
[0 -       1000000]  :      0      : #
[1000000 - 2000000]  :      0      : #
[2000000 - 3000000]  :      6      : ##
[3000000 - 4000000]  :      0      : #
[4000000 - 5000000]  :      2      : #
[5000000 - 6000000]  :      92     : ###################



Gautham R. Shenoy (2):
  powerpc: Detect the presence of big-cores via "ibm,thread-groups"
  powerpc: Enable CPU_FTR_ASYM_SMT for interleaved big-cores

 Documentation/ABI/testing/sysfs-devices-system-cpu |   8 +
 arch/powerpc/include/asm/cputhreads.h              |  22 +++
 arch/powerpc/kernel/setup-common.c                 | 177 ++++++++++++++++++++-
 arch/powerpc/kernel/sysfs.c                        |  35 ++++
 4 files changed, 241 insertions(+), 1 deletion(-)

-- 
1.9.4

