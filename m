Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbeEBXIn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 19:08:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751441AbeEBXIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 19:08:40 -0400
From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
To: David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Keyrings <keyrings@vger.kernel.org>
Cc: Linux Integrity <linux-integrity@vger.kernel.org>,
        Linux Security <linux-security-module@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        George Wilson <gcwilson@us.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Subject: [PATCH v6 0/4] Certificate insertion support for x86 bzImages
Date: Wed,  2 May 2018 19:08:07 -0400
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
X-TM-AS-GCONF: 00
x-cbid: 18050223-0020-0000-0000-00000DDA063B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008959; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01026618; UDB=6.00524344; IPR=6.00805804;
 MB=3.00020894; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-02 23:08:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050223-0021-0000-0000-0000612E6574
Message-Id: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805020192
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add support for modifying the reserved space for extra
certificates in a compressed bzImage in x86. This allows separating the
system keyring certificate from the kernel build process. After the kernel
image is distributed, the insert-sys-cert script can be used to insert the
certificate for x86.

Changes:

v6:
* Removed libelf dependency (2/4)

v5:
* Added CRC fixing (3/4)

v4:
* Applied checkpatch.pl suggestions (2/4, 3/4)
* Cleaned up the commit messages (1/4, 2/4)
* Added the build file to .gitignore (1/4)

v3:
* Rewrote 1/4 to insert incompressible bytes are at build time. Previous
solution required changes to <arch>/boot/Makefile's for modifying the
vmlinux file after linking, and did not work well with cross compilation.
* Added 2/4 for ELF class-independent processing of vmlinux file, in case
the script was compiled for 64-bit and the kernel was compiled for 32-bit.
* Reordered 3/4, added x86 bzImage boot version (>=2.08) verification.

v2:
* Rebased arch/boot/x86/Makefile patch (removed in v3)

Mehmet Kayaalp (4):
  KEYS: Insert incompressible bytes to reserve space in bzImage
  KEYS: Add ELF class-independent certificate insertion support
  KEYS: Support for inserting a certificate into x86 bzImage
  KEYS: Print insert-sys-cert information to stdout instead of stderr

 certs/.gitignore            |   1 +
 certs/Makefile              |  21 +-
 certs/system_certificates.S |   2 +-
 scripts/insert-sys-cert.c   | 584 +++++++++++++++++++++++++++++-------
 4 files changed, 488 insertions(+), 120 deletions(-)

-- 
2.17.0
