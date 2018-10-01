Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B751C0044B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0943F20684
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 13:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0943F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbeJATyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:54:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729267AbeJATyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:54:46 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w91DAcHg105524
        for <linux-kernel@vger.kernel.org>; Mon, 1 Oct 2018 09:16:59 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mukgejf5h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 09:16:59 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Mon, 1 Oct 2018 09:16:57 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Oct 2018 09:16:53 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w91DGqsR28246220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Oct 2018 13:16:52 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54CEEAE066;
        Mon,  1 Oct 2018 09:15:12 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04F62AE06A;
        Mon,  1 Oct 2018 09:15:12 -0400 (EDT)
Received: from sofia.ibm.com (unknown [9.124.35.106])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Oct 2018 09:15:11 -0400 (EDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 9D6F92E413E; Mon,  1 Oct 2018 18:46:49 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Anton Blanchard <anton@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v9 0/3] powerpc: Detection and scheduler optimization for POWER9 bigcore
Date:   Mon,  1 Oct 2018 18:46:39 +0530
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18100113-0072-0000-0000-000003AD4EFB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009802; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01096315; UDB=6.00566874; IPR=6.00876357;
 MB=3.00023575; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-01 13:16:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100113-0073-0000-0000-0000499B28B9
Message-Id: <1538399802-23582-1-git-send-email-ego@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810010131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Hi,

This is the ninth iteration of the patchset to add support for
big-core on POWER9. This patch also optimizes the task placement on
such big-core systems.

The previous versions can be found here:
v8: https://lkml.org/lkml/2018/9/20/899
v7: https://lkml.org/lkml/2018/8/20/52
v6: https://lkml.org/lkml/2018/8/9/119
v5: https://lkml.org/lkml/2018/8/6/587
v4: https://lkml.org/lkml/2018/7/24/79
v3: https://lkml.org/lkml/2018/7/6/255
v2: https://lkml.org/lkml/2018/7/3/401
v1: https://lkml.org/lkml/2018/5/11/245

Changes :
v8 --> v9:
   - Rebased it on v4.19-rc5
   - Updated the commit log for the second patch as per Dave Hansen's
   suggestion.
   - Fixed the build errors reported by Michael Neuling and the Kernel
   Build bot.

Description:
~~~~~~~~~~~~~~~~~~~~

IBM POWER9 SMT8 cores consists of two groups of small-cores where each
group has its own L1 cache, translation cache and instruction-data
flow. This can be discovered via the "ibm,thread-groups" CPU property
in the device tree. Furthermore, on POWER9 the thread-ids of such a
big-core is obtained by interleaving the thread-ids of the two
small-cores.

Eg: In an SMT8 core with thread ids {0,1,2,3,4,5,6,7}, the thread-ids
of the threads in the two small-cores respectively will be {0,2,4,6}
and {1,3,5,7} respectively.

 	   -------------------------
	   |  	    L1 Cache       |
       ----------------------------------
       |L2|     |     |     |      |
       |  |  0  |  2  |  4  |  6   |Small Core0
       |C |     |     |     |      |
Big    |a --------------------------
Core   |c |     |     |     |      |
       |h |  1  |  3  |  5  |  7   | Small Core1
       |e |     |     |     |      |
       -----------------------------
	  |  	    L1 Cache       |
	  --------------------------

On such a big-core system, when multiple tasks are scheduled to run on
the big-core, we get the best performance when the tasks are spread
across the pair of small-cores.

Eg: Suppose there 4 tasks {p1, p2, p3, p4} are run on a big core, then

An Example of Optimal Task placement:
	   --------------------------
           |     |     |     |      |
           |  0  |  2  |  4  |  6   |   Small Core0
           | (p1)| (p2)|     |      |
Big Core   --------------------------
           |     |     |     |      |
           |  1  |  3  |  5  |  7   |   Small Core1
           |     | (p3)|     | (p4) |
           --------------------------

An example of Suboptimal Task placement:
	   --------------------------
           |     |     |     |      |
           |  0  |  2  |  4  |  6   |   Small Core0
           | (p1)| (p2)|     |  (p4)|
Big Core   --------------------------
           |     |     |     |      |
           |  1  |  3  |  5  |  7   |   Small Core1
           |     | (p3)|     |      |
           --------------------------

Currently on the big-core systems, the sched domain hierarchy is:

SMT   : group of CPUs in the SMT8 core.
DIE   : groups of CPUs on the same die.
NUMA  : all the CPUs in the system.

Thus the scheduler doesn't distinguish between CPUs in the core that
share the L1-cache vs the ones that don't resulting in a run-to-run
variance when multithreaded applications are run on an SMT8 core.

In this patch-set, we address this by defining the sched-domain on the
big-core systems to be:

SMT   : group of CPUs sharing the L1 cache
CACHE : group of CPUs in the SMT8 core.
DIE   : groups of CPUs on the same die.
NUMA  : all the CPUs in the system.

With this, the Linux Kernel load-balancer will ensure that the tasks
are spread across all the component small cores in the system, thereby
yielding optimum performance.

Furthermore, this solution works correctly across all SMT modes
(8,4,2), as the interleaved thread-ids ensures that when we go to
lower SMT modes (4,2) the threads are offlined in a descending order,
thereby leaving equal number of threads from the component small cores
online as illustrated below.

This patchset contains three patches which on detecting the presence
of big-cores, defines the SMT level sched domain to correspond to the
threads of the small cores.

Patch 1: adds support to detect the presence of
big-cores and parses the output of "ibm,thread-groups" device-tree
which using which it updates a per-cpu mask named cpu_smallcore_mask

Patch 2: Defines the SMT level sched domain to correspond to the
threads of the small cores.

Patch 3: Creates a pair of sysfs attributes named
	  /sys/devices/system/cpu/cpuN/topology/smallcore_thread_siblings
	  and
	  /sys/devices/system/cpu/cpuN/topology/smallcore_thread_siblings_list
	  exposing the small-core siblings that share the L1 cache
	  to the userspace.

Results:
~~~~~~~~~~~~~~~~~
1) 2 thread ebizzy
~~~~~~~~~~~~~~~~~~~~~~
Experimental results for ebizzy with 2 threads, bound to a single big-core
show a marked improvement with this patchset over the 4.19.0-rc5 vanilla
kernel.

The result of 100 such runs for 4.19.0-rc5 kernel and the
4.19.0-rc5 + big-core-patches are as follows

4.19.0-rc5 vanilla
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        records/s    :  # samples  : Histogram
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[0 -       1000000]  :      0      : #
[1000000 - 2000000]  :      1      : #
[2000000 - 3000000]  :      8      : ##
[3000000 - 4000000]  :      31     : #######
[4000000 - 5000000]  :      5      : ##
[5000000 - 6000000]  :      2      : #
[6000000 - 7000000]  :      53     : ###########
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

4.19.0-rc5 + big-core-patches
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        records/s    :  # samples  : Histogram
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[0 -       1000000]  :      0      : #
[1000000 - 2000000]  :      0      : #
[2000000 - 3000000]  :      7      : ##
[3000000 - 4000000]  :      8      : ##
[4000000 - 5000000]  :      0      : #
[5000000 - 6000000]  :      1      : #
[6000000 - 7000000]  :      84     : #################
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

2) Hackbench (perf bench sched pipe)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

500 iterations of the hackbench run both on 4.19.0-rc5 vanilla kernel
and v4.19.0-rc5 + big-core-patches. There isn't a significant
difference between the two.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			4.19.0-rc5 vanilla
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    N           Min           Max        Median           Avg        Stddev
  500         5.195         7.108         6.818      6.634932    0.39956043
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			4.19.0-rc5 + big-core-patches
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    N           Min           Max        Median           Avg        Stddev
  500         5.215         6.978         6.895      6.759908    0.33699356
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Gautham R. Shenoy (3):
  powerpc: Detect the presence of big-cores via "ibm,thread-groups"
  powerpc: Use cpu_smallcore_sibling_mask at SMT level on bigcores
  powerpc/sysfs: Add topology/smallcore_thread_siblings[_list]

 Documentation/ABI/testing/sysfs-devices-system-cpu |  14 ++
 arch/powerpc/include/asm/cputhreads.h              |   2 +
 arch/powerpc/include/asm/smp.h                     |   6 +
 arch/powerpc/kernel/smp.c                          | 241 ++++++++++++++++++++-
 arch/powerpc/kernel/sysfs.c                        |  91 ++++++++
 5 files changed, 353 insertions(+), 1 deletion(-)

-- 
1.9.4

