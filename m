Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeFDIRY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 04:17:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56580 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbeFDIRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 04:17:22 -0400
MIME-Version: 1.0
Message-ID: <7d20be40-4c15-4e15-a4d0-cd2efda6d701@default>
Date: Mon, 4 Jun 2018 08:16:51 +0000 (UTC)
From: Zhenzhong Duan <zhenzhong.duan@oracle.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: <mingo@redhat.com>, <tglx@linutronix.de>,
        Srinivas REDDY Eeda <srinivas.eeda@oracle.com>, <bp@alien8.de>,
        <hpa@zytor.com>
Subject: [PATCH] x86/microcode/intel: Ensure new microcode processor flags
 match with cpu's pf
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8913 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=701
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806040103
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w548HREv028593

Intel spec says: 'The processor flags in the 48-byte header and the
processor flags field associated with the extended processor signature
structures may have multiple bits set.'

Make sure processor flags of the new microcode intersect with current
cpu's. Comparing with old microcode's pf can't guarantee this.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
---
 arch/x86/kernel/cpu/microcode/intel.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 461e315..54f4014 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -371,12 +371,10 @@ static int microcode_sanity_check(void *mc, int print_err)
 				goto next;
 
 		} else {
-			struct microcode_header_intel *phdr = &patch->hdr;
-
 			if (!has_newer_microcode(data,
-						 phdr->sig,
-						 phdr->pf,
-						 phdr->rev))
+						 uci->cpu_sig.sig,
+						 uci->cpu_sig.pf,
+						 patch->hdr.rev))
 				goto next;
 		}
 
-- 
1.7.3
