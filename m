Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753307AbeEKLRp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 07:17:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753115AbeEKLRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 07:17:42 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 0/2] powerpc: Scheduler optimization for POWER9 bigcores
Date: Fri, 11 May 2018 16:47:22 +0530
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18051111-0048-0000-0000-0000026B93CF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009005; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000259; SDB=6.01030698; UDB=6.00526774; IPR=6.00809829;
 MB=3.00021044; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-11 11:17:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051111-0049-0000-0000-000045153E7B
Message-Id: <1526037444-22876-1-git-send-email-ego@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805110107
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Hi,

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

The Linux scheduler has a feature called "ASYM_SMT" which will bias
the load-balancing of the tasks on the smaller numbered threads in the
core. On an big-core whose threads are interleavings of the threads of
the small cores, enabling ASYM_SMT automatically results in spreading
the tasks uniformly across the associated pair of SMT4 cores.

In this patchset, we detect if the cores are big-cores with interleaved threads.
If so, we enable ASYM_SMT feature at the SMT-sched domain.

Experimental results for ebizzy with 2 threads, bound to a single big-core
show a marked improvement with this patchset over the 4.17-rc3 vanilla
kernel.

The results of 100 such runs, for 4.17-rc3 vanilla kernel and
4.17-rc3 + this_patchset are as follows.

4.17-rc3 vanilla:
================================================
  ebizzy records/s   :# samples: Histogram 
=================================================
[1000000 - 2000000]  :      14    : ###
[2000000 - 3000000]  :      13    : ###
[3000000 - 4000000]  :      15    : ####
[4000000 - 5000000]  :       2    : #
[5000000 - 6000000]  :      56    : ############
=================================================
 
4.17-rc3 vanilla + this_patchset
=================================================
  ebizzy records/s   :# samples: Histogram 
=================================================
[1000000 - 2000000]  :       0    : #
[2000000 - 3000000]  :      14    : ###
[3000000 - 4000000]  :       0    : #
[4000000 - 5000000]  :       1    : #
[5000000 - 6000000]  :      85    : ##################
=================================================

This patchset contains two patchset.

The first patch detects the presence of big-cores with interleaved
threads.

The second patch adds the ASYM_SMT bit to the flags the SMT-sched
domain when interleaved big-cores are detected.

Gautham R. Shenoy (2):
  powerpc: Detect the presence of big-core with interleaved threads
  powerpc: Enable ASYM_SMT on interleaved big-core systems

 arch/powerpc/include/asm/cputhreads.h |  8 +++--
 arch/powerpc/kernel/setup-common.c    | 63 +++++++++++++++++++++++++++++++++--
 arch/powerpc/kernel/smp.c             |  2 +-
 3 files changed, 67 insertions(+), 6 deletions(-)

-- 
1.9.4
