Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeBZQLV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:11:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751463AbeBZQLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:11:19 -0500
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Dave Young <dyoung@redhat.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 00/11] kexec_file: Clean up purgatory load
Date: Mon, 26 Feb 2018 16:16:09 +0100
X-Mailer: git-send-email 2.13.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18022615-0040-0000-0000-00000416F7D7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022615-0041-0000-0000-0000261A19E1
Message-Id: <20180226151620.20970-1-prudo@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802260202
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi everybody

following the discussion with Dave and AKASHI, here are the common code
patches extracted from my recent patch set (Add kexec_file_load support to
s390) [1]. The patches were extracted to allow upstream integration together
with AKASHI's common code patches before the arch code gets adjusted to the
new base.

The reason for this series is to prepare common code for adding
kexec_file_load to s390 as well as cleaning up the mis-use of the sh_offset
field during purgatory load. In detail this series contains:

Patch #1&2: Minor cleanups/fixes.

Patch #3-9: Clean up the purgatory load/relocation code. Especially remove
the mis-use of the purgatory_info->sechdrs->sh_offset field, currently
holding a pointer into either kexec_purgatory (ro) or purgatory_buf (rw)
depending on the section. With these patches the section address will be
calculated verbosely and sh_offset will contain the offset of the section
in the stripped purgatory binary (purgatory_buf).

Patch #10: Allows architectures to set the purgatory load address. This
patch is important for s390 as the kernel and purgatory have to be loaded
to fixed addresses. In current code this is impossible as the purgatory
load is opaque to the architecture.

Patch #11: Moves x86 purgatories sha implementation to common lib/
directory to allow reuse in other architectures.

The patches apply to v4.16-rc3. There are no changes compared to [1] (all
requested changes only affected s390 code). Please note that I had to touch
arch code for x86 and power a little. In theory this should not change the
behavior but I don't have a way to test it. Cross-compiling with
defconfig [2] works fine for both.

Thanks
Philipp

[1] http://lists.infradead.org/pipermail/kexec/2018-February/019926.html
[2] On x86 with the orc unwinder and stack validation turned off. objtool
    SEGFAULTs on s390...

Philipp Rudo (11):
  kexec_file: Silence compile warnings
  kexec_file: Remove checks in kexec_purgatory_load
  kexec_file: Make purgatory_info->ehdr const
  kexec_file: Search symbols in read-only kexec_purgatory
  kexec_file: Use read-only sections in arch_kexec_apply_relocations*
  kexec_file: Split up __kexec_load_puragory
  kexec_file: Simplify kexec_purgatory_setup_sechdrs 1
  kexec_file: Simplify kexec_purgatory_setup_sechdrs 2
  kexec_file: Remove mis-use of sh_offset field
  kexec_file: Allow archs to set purgatory load address
  kexec_file: Move purgatories sha256 to common code

 arch/powerpc/kernel/kexec_elf_64.c             |   9 +-
 arch/x86/kernel/kexec-bzimage64.c              |   8 +-
 arch/x86/kernel/machine_kexec_64.c             |  66 ++---
 arch/x86/purgatory/Makefile                    |   3 +
 arch/x86/purgatory/purgatory.c                 |   2 +-
 include/linux/kexec.h                          |  38 +--
 {arch/x86/purgatory => include/linux}/sha256.h |  10 +-
 kernel/kexec_file.c                            | 375 ++++++++++++-------------
 {arch/x86/purgatory => lib}/sha256.c           |   4 +-
 9 files changed, 244 insertions(+), 271 deletions(-)
 rename {arch/x86/purgatory => include/linux}/sha256.h (63%)
 rename {arch/x86/purgatory => lib}/sha256.c (99%)

-- 
2.13.5
