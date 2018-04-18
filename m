Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbeDRK7I (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 06:59:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751940AbeDRK7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 06:59:07 -0400
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@redhat.com
Cc: linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        ravi.bangoria@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,
        maynard@us.ibm.com
Subject: [PATCH v2 0/3] perf: Fixes for callchain ip handling on powerpc
Date: Wed, 18 Apr 2018 16:28:57 +0530
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18041810-0012-0000-0000-000005CC2ECC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041810-0013-0000-0000-000019487F64
Message-Id: <20180418105900.5899-1-sandipan@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804180101
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch fixes the callchain ip filtering mechanism for powerpc
from skipping entries in case the LR value is still valid and yet to
be written to the stack frame. This was previously posted as an RFC
here: https://lkml.org/lkml/2018/4/4/633

The second patch fixes a crash caused by attempting to access an empty
callchain.

The third patch fixes a shell test which used to fail on powerpc as
the back trace from perf output did not match the expected pattern.
Also, because of the issue described in the first patch, some entries
from the callchain were incorrectly skipped. So, this has also been
readjusted to work with the fix in the first patch.

v2:
 - Consider case when return address is in R0 as pointed out by Ravi.
 - Add another patch to fix crash when callchain is empty.

Sandipan Das (3):
  perf tools powerpc: Fix callchain ip filtering
  perf tools powerpc: Fix crash if callchain is empty
  perf tests: Fix record+probe_libc_inet_pton.sh for powerpc64

 tools/perf/arch/powerpc/util/skip-callchain-idx.c  | 74 +++++++++++++---------
 .../tests/shell/record+probe_libc_inet_pton.sh     |  8 +++
 2 files changed, 53 insertions(+), 29 deletions(-)

-- 
2.14.3
