Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751728AbeCUCId (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 22:08:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751459AbeCUCIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 22:08:31 -0400
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com,
        pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com
Subject: [PATCH 0/4] vfio: ccw: error handling fixes and improvements
Date: Wed, 21 Mar 2018 03:08:18 +0100
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18032102-0012-0000-0000-000015EDBA46
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008713; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01006058; UDB=6.00512229; IPR=6.00785341;
 MB=3.00020153; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-21 02:08:27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032102-0013-0000-0000-000051F466D1
Message-Id: <20180321020822.86255-1-bjsdjshi@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803210024
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conny,

Halil reported a host crash when using vfio-ccw. The root cause of the problem
is that vfio_pin_pages fails with EINVAL for reasons unknown. He has
experienced such failures after online-ing a dasd in the guest (the dasd has 3
partitions, hat may or may not have any significance). The problem isn't
experienced on every attempt to online the dasd, and breaking at css_do_ssch
seems to make things work.

One thing is sure: the host kernel should not crash under the described
circumstances.

To fix the problem, the first patch of this series fixes the cleanup when
cp_prefetch fails in the higher level. The 2nd and the 3rd patches provide
correctness and denfensive actions for the interfaces in the lower level.

The 4th patch is trying to add tracepoints for vfio-ccw, so that we can debug
such issue easier in future.

For details see the commit message portions of the inividual patches.

Thanks.

Dong Jia Shi (2):
  vfio: ccw: refactor and improve pfn_array_alloc_pin()
  vfio: ccw: set ccw->cda to NULL defensively

Halil Pasic (2):
  vfio: ccw: fix cleanup if cp_prefetch fails
  vfio: ccw: add traceponits for interesting error paths

 drivers/s390/cio/Makefile         |   1 +
 drivers/s390/cio/vfio_ccw_cp.c    | 121 ++++++++++++++++++++------------------
 drivers/s390/cio/vfio_ccw_fsm.c   |  13 ++++
 drivers/s390/cio/vfio_ccw_trace.h |  86 +++++++++++++++++++++++++++
 4 files changed, 163 insertions(+), 58 deletions(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_trace.h

-- 
2.13.5
