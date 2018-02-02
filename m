Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeBBNKK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 08:10:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751958AbeBBNHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 08:07:49 -0500
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: prudo@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 12/17] s390/kexec_file: Prepare setup.h for kexec_file_load
Date: Fri,  2 Feb 2018 14:07:13 +0100
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180202130718.35509-1-prudo@linux.vnet.ibm.com>
References: <20180202130718.35509-1-prudo@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18020213-0008-0000-0000-000004C8CBFD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020213-0009-0000-0000-00001E5C6E4C
Message-Id: <20180202130718.35509-13-prudo@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802020162
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kexec_file_load needs to prepare the new kernels before they are loaded.
For that it has to know the offsets in head.S, e.g. to register the new
command line. Unfortunately there are no macros right now defining those
offsets. Define them now.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
---
 arch/s390/include/asm/setup.h | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.h
index 2eb0c8a7b664..75b354e774eb 100644
--- a/arch/s390/include/asm/setup.h
+++ b/arch/s390/include/asm/setup.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  S390 version
- *    Copyright IBM Corp. 1999, 2010
+ *    Copyright IBM Corp. 1999, 2017
  */
 #ifndef _ASM_S390_SETUP_H
 #define _ASM_S390_SETUP_H
@@ -38,17 +38,31 @@
 #define LPP_MAGIC		_BITUL(31)
 #define LPP_PID_MASK		_AC(0xffffffff, UL)
 
+/* Offsets to entry points in kernel/head.S  */
+
+#define STARTUP_NORMAL_OFFSET	0x10000
+#define STARTUP_KDUMP_OFFSET	0x10010
+
+/* Offsets to parameters in kernel/head.S  */
+
+#define IPL_DEVICE_OFFSET	0x10400
+#define INITRD_START_OFFSET	0x10408
+#define INITRD_SIZE_OFFSET	0x10410
+#define OLDMEM_BASE_OFFSET	0x10418
+#define OLDMEM_SIZE_OFFSET	0x10420
+#define COMMAND_LINE_OFFSET	0x10480
+
 #ifndef __ASSEMBLY__
 
 #include <asm/lowcore.h>
 #include <asm/types.h>
 
-#define IPL_DEVICE        (*(unsigned long *)  (0x10400))
-#define INITRD_START      (*(unsigned long *)  (0x10408))
-#define INITRD_SIZE       (*(unsigned long *)  (0x10410))
-#define OLDMEM_BASE	  (*(unsigned long *)  (0x10418))
-#define OLDMEM_SIZE	  (*(unsigned long *)  (0x10420))
-#define COMMAND_LINE      ((char *)            (0x10480))
+#define IPL_DEVICE	(*(unsigned long *)  (IPL_DEVICE_OFFSET))
+#define INITRD_START	(*(unsigned long *)  (INITRD_START_OFFSET))
+#define INITRD_SIZE	(*(unsigned long *)  (INITRD_SIZE_OFFSET))
+#define OLDMEM_BASE	(*(unsigned long *)  (OLDMEM_BASE_OFFSET))
+#define OLDMEM_SIZE	(*(unsigned long *)  (OLDMEM_SIZE_OFFSET))
+#define COMMAND_LINE	((char *)	     (COMMAND_LINE_OFFSET))
 
 extern int memory_end_set;
 extern unsigned long memory_end;
@@ -123,12 +137,12 @@ extern void (*_machine_power_off)(void);
 
 #else /* __ASSEMBLY__ */
 
-#define IPL_DEVICE        0x10400
-#define INITRD_START      0x10408
-#define INITRD_SIZE       0x10410
-#define OLDMEM_BASE	  0x10418
-#define OLDMEM_SIZE	  0x10420
-#define COMMAND_LINE      0x10480
+#define IPL_DEVICE	(IPL_DEVICE_OFFSET)
+#define INITRD_START	(INITRD_START_OFFSET)
+#define INITRD_SIZE	(INITRD_SIZE_OFFSET)
+#define OLDMEM_BASE	(OLDMEM_BASE_OFFSET)
+#define OLDMEM_SIZE	(OLDMEM_SIZE_OFFSET)
+#define COMMAND_LINE	(COMMAND_LINE_OFFSET)
 
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_S390_SETUP_H */
-- 
2.13.5
