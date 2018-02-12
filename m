Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933139AbeBLJAR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 04:00:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932768AbeBLJAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 04:00:15 -0500
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Balbir Singh <bsingharora@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/xmon: Dont register sysrq key when kernel param xmon=off
Date: Mon, 12 Feb 2018 14:29:56 +0530
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18021209-0040-0000-0000-0000042ECFBF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021209-0041-0000-0000-000020D28DFE
Message-Id: <20180212085956.12016-1-vaibhav@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802120116
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presently sysrq key for xmon('x') is registered during kernel init
irrespective of the value of kernel param 'xmon'. Thus xmon is enabled
even if 'xmon=off' is passed on the kernel command line.

This minor patch updates setup_xmon_sysrq() to register
'sysrq_xmon_op' only when variable 'xmon_on' is set.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 82e1a3ee6e0f..3b995474b102 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3642,8 +3642,7 @@ static struct sysrq_key_op sysrq_xmon_op = {
 
 static int __init setup_xmon_sysrq(void)
 {
-	register_sysrq_key('x', &sysrq_xmon_op);
-	return 0;
+	return xmon_on ? register_sysrq_key('x', &sysrq_xmon_op) : 0;
 }
 device_initcall(setup_xmon_sysrq);
 #endif /* CONFIG_MAGIC_SYSRQ */
-- 
2.14.3
