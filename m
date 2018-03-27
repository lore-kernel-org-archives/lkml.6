Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbeC0N5b (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:57:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752801AbeC0N51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:57:27 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, tycho@docker.com,
        serge@hallyn.com, sunyuqiong1988@gmail.com, david.safford@ge.com,
        mkayaalp@cs.binghamton.edu, James.Bottomley@HansenPartnership.com,
        zohar@linux.vnet.ibm.com, ebiederm@xmission.com,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 0/3] ima: namespacing IMA
Date: Tue, 27 Mar 2018 09:57:15 -0400
X-Mailer: git-send-email 2.5.5
X-TM-AS-GCONF: 00
x-cbid: 18032713-0040-0000-0000-0000040D87CE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008753; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01009167; UDB=6.00514062; IPR=6.00788450;
 MB=3.00020268; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-27 13:57:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032713-0041-0000-0000-0000080E9478
Message-Id: <1522159038-14175-1-git-send-email-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803270141
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set implements an IMA namespace data structure that gets
created alongside a user namespace with CLONE_NEWUSER, and lays down the
foundation for namespacing the different aspects of IMA (eg. IMA-audit,
IMA-measurement, IMA-appraisal).

The original PoC patches [1] created a new CLONE_NEWIMA flag to explicitly
control when a new IMA namespace should be created. The previously posted
version 2 of this series had it hooked on the mount namespace, which was
regarded as inappropriate. Based on comments, we elected to hang the IMA
namepace off of the existing user namespace now. In this patch series we
are adding a pointer to the user_namespace pointing to the ima_namespace.
Both are now tied together and joining the user_namespace with setns() also
joins the ima_namespace that was created along with it.

The first patch creates the ima_namespace data, while the second patch
puts the iint->flags in the namespace. The third patch uses these flags
for namespacing the IMA-audit messages, enabling the same file to be
audited each time it is accessed in a new namespace.


   Stefan

Mehmet Kayaalp (2):
  ima: Add ns_status for storing namespaced iint data
  ima: mamespace audit status flags

Yuqiong Sun (1):
  ima: extend clone() with IMA namespace support

 include/linux/ima.h                      |  67 +++++++++
 include/linux/user_namespace.h           |   4 +
 init/Kconfig                             |  10 ++
 kernel/user.c                            |   7 +
 kernel/user_namespace.c                  |  18 +++
 security/integrity/ima/Makefile          |   3 +-
 security/integrity/ima/ima.h             |  47 ++++++-
 security/integrity/ima/ima_api.c         |   8 +-
 security/integrity/ima/ima_init.c        |   4 +
 security/integrity/ima/ima_init_ima_ns.c |  43 ++++++
 security/integrity/ima/ima_main.c        |  15 ++-
 security/integrity/ima/ima_ns.c          | 225 +++++++++++++++++++++++++++++++
 12 files changed, 443 insertions(+), 8 deletions(-)
 create mode 100644 security/integrity/ima/ima_init_ima_ns.c
 create mode 100644 security/integrity/ima/ima_ns.c

-- 
2.14.3
