Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932355AbeCIUOl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 15:14:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751227AbeCIUOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 15:14:39 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-ima-devel@lists.sourceforge.net
Cc: containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, tycho@docker.com,
        serge@hallyn.com, sunyuqiong1988@gmail.com, david.safford@ge.com,
        mkayaalp@cs.binghamton.edu, linux-integrity@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, zohar@linux.vnet.ibm.com,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 0/3] ima: namespacing IMA
Date: Fri,  9 Mar 2018 15:14:18 -0500
X-Mailer: git-send-email 2.13.6
X-TM-AS-GCONF: 00
x-cbid: 18030920-0036-0000-0000-000002CDE6DE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008642; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01000666; UDB=6.00509011; IPR=6.00779996;
 MB=3.00019944; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-09 20:14:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030920-0037-0000-0000-00004397A16E
Message-Id: <20180309201421.6150-1-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803090239
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set implements an IMA namespace data structure that gets
created alongside a mount namespace with CLONE_NEWNS, and lays down the
foundation for namespacing the different aspects of IMA (eg. IMA-audit,
IMA-measurement, IMA-appraisal).

The original PoC patches [1] created a new CLONE_NEWIMA flag to
explicitly control when a new IMA namespace should be created. Based on
comments, we elected to hang the IMA namepace off of existing namespaces,
and the mount namespace made the most sense. In this version of the patches
we are adding a pointer to the mnt_namespace pointing to the ima_namespace.
Both are now tied together and joining the mnt_namespace with setns()
also joins the ima_namespace that was created along with it.

The first patch creates the ima_namespace data, while the second patch
puts the iint->flags in the namespace. The third patch uses these flags
for namespacing the IMA-audit messages, enabling the same file to be
audited each time it is accessed in a new namespace.

Mehmet Kayaalp (2):
  ima: Add ns_status for storing namespaced iint data
  ima: mamespace audit status flags

Yuqiong Sun (1):
  ima: extend clone() with IMA namespace support

 fs/mount.h                               |  14 --
 fs/namespace.c                           |  29 +++-
 include/linux/ima.h                      |  70 ++++++++++
 include/linux/mount.h                    |  20 ++-
 init/Kconfig                             |  10 ++
 kernel/nsproxy.c                         |   1 +
 security/integrity/ima/Makefile          |   3 +-
 security/integrity/ima/ima.h             |  47 ++++++-
 security/integrity/ima/ima_api.c         |   8 +-
 security/integrity/ima/ima_init.c        |   4 +
 security/integrity/ima/ima_init_ima_ns.c |  44 ++++++
 security/integrity/ima/ima_main.c        |  15 +-
 security/integrity/ima/ima_ns.c          | 230 +++++++++++++++++++++++++++++++
 13 files changed, 469 insertions(+), 26 deletions(-)
 create mode 100644 security/integrity/ima/ima_init_ima_ns.c
 create mode 100644 security/integrity/ima/ima_ns.c

-- 
2.13.6
