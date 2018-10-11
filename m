Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2059C46462
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865C82087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 05:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865C82087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbeJKM7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 08:59:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727252AbeJKM6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 08:58:54 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9B5TQSn073295
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:33:18 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n1ysm1dsx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:33:17 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Thu, 11 Oct 2018 01:33:16 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Oct 2018 01:33:12 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9B5XB2228967062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Oct 2018 05:33:11 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 155CCAC060;
        Thu, 11 Oct 2018 01:32:18 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A70DAC05E;
        Thu, 11 Oct 2018 01:32:17 -0400 (EDT)
Received: from sofia.ibm.com (unknown [9.124.35.51])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 11 Oct 2018 01:32:17 -0400 (EDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 240822E3CAB; Thu, 11 Oct 2018 11:03:09 +0530 (IST)
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
Subject: [PATCH v10 0/3] powerpc: Detection and scheduler optimization for POWER9 bigcore
Date:   Thu, 11 Oct 2018 11:03:00 +0530
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18101105-0040-0000-0000-0000047ECBEF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009858; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01100952; UDB=6.00569661; IPR=6.00880998;
 MB=3.00023704; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-11 05:33:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101105-0041-0000-0000-00000886DD1C
Message-Id: <1539235983-25259-1-git-send-email-ego@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-11_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Hi,

This is the tenth iteration of the patchset to add support for
big-core on POWER9. This patch also optimizes the task placement on
such big-core systems.

The previous versions can be found here:
v9: https://lkml.org/lkml/2018/10/1/608
v8: https://lkml.org/lkml/2018/9/20/899
v7: https://lkml.org/lkml/2018/8/20/52
v6: https://lkml.org/lkml/2018/8/9/119
v5: https://lkml.org/lkml/2018/8/6/587
v4: https://lkml.org/lkml/2018/7/24/79
v3: https://lkml.org/lkml/2018/7/6/255
v2: https://lkml.org/lkml/2018/7/3/401
v1: https://lkml.org/lkml/2018/5/11/245

Changes :
v9 --> v10:
   - Rebased it on v4.19-rc7
   - Added a patch to report the correct shared_cpu_map for L1-caches
   on big-core systems.

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

Patch 3: Added a patch to report the correct shared_cpu_map for L1-caches
on big-core systems.

   Without patch 3:
       /sys/devices/system/cpu/cpu0/cache/index0/shared_cpu_map : 000000ff
       /sys/devices/system/cpu/cpu0/cache/index1/shared_cpu_map : 000000ff
       /sys/devices/system/cpu/cpu1/cache/index0/shared_cpu_map : 000000ff
       /sys/devices/system/cpu/cpu1/cache/index1/shared_cpu_map : 000000ff

    With patch 3:
       /sys/devices/system/cpu/cpu0/cache/index0/shared_cpu_map : 00000055
       /sys/devices/system/cpu/cpu0/cache/index1/shared_cpu_map : 00000055
       /sys/devices/system/cpu/cpu1/cache/index0/shared_cpu_map : 000000aa
       /sys/devices/system/cpu/cpu1/cache/index1/shared_cpu_map : 000000aa

Results:
~~~~~~~~~~~~~~~~~
1) 2 thread ebizzy
~~~~~~~~~~~~~~~~~~~~~~
Experimental results for ebizzy with 2 threads, bound to a single big-core
show a marked improvement with this patchset over the 4.19.0-rc7 vanilla
kernel.

The result of 100 such runs for 4.19.0-rc7 kernel and the
4.19.0-rc7 + big-core-patches are as follows

4.19.0-rc7 vanilla
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        records/s    :  # samples  : Histogram
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[0       - 1000000]  :      0      : #
[1000000 - 2000000]  :      2      : #
[2000000 - 3000000]  :      8      : ##
[3000000 - 4000000]  :      19     : ####
[4000000 - 5000000]  :      7      : ##
[5000000 - 6000000]  :      2      : #
[6000000 - 7000000]  :      62     : #############
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

4.19.0-rc7 + big-core-patches
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        records/s    :  # samples  : Histogram
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
[0       - 1000000]  :      0      : #
[1000000 - 2000000]  :      0      : #
[2000000 - 3000000]  :      4      : #
[3000000 - 4000000]  :      8      : ##
[4000000 - 5000000]  :      0      : #
[5000000 - 6000000]  :      1      : #
[6000000 - 7000000]  :      87     : ##################
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

2) Hackbench (perf bench sched pipe)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

500 iterations of the hackbench run both on 4.19.0-rc7 vanilla kernel
and v4.19.0-rc7 + big-core-patches. There isn't a significant
difference between the two.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			4.19.0-rc7 vanilla
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    N           Min           Max        Median           Avg        Stddev
  500         4.658s         6.293s      6.076s      5.846528s    0.45096266
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			4.19.0-rc7 + big-core-patches
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    N           Min           Max        Median           Avg        Stddev
  500         4.543s          6.3s        5.75s      5.682208s   0.50767805
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Gautham R. Shenoy (3):
  powerpc: Detect the presence of big-cores via "ibm,thread-groups"
  powerpc: Use cpu_smallcore_sibling_mask at SMT level on bigcores
  powerpc/cacheinfo: Report the correct shared_cpu_map on big-cores

 arch/powerpc/include/asm/cputhreads.h |   2 +
 arch/powerpc/include/asm/smp.h        |  11 ++
 arch/powerpc/kernel/cacheinfo.c       |  37 +++++-
 arch/powerpc/kernel/smp.c             | 241 +++++++++++++++++++++++++++++++++-
 4 files changed, 288 insertions(+), 3 deletions(-)

-- 
1.9.4

