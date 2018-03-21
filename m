Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeCUL2D (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 07:28:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751545AbeCUL2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 07:28:00 -0400
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
        Dave Young <dyoung@redhat.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2 00/11] kexec_file: Clean up purgatory load
Date: Wed, 21 Mar 2018 12:27:40 +0100
X-Mailer: git-send-email 2.13.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18032111-0020-0000-0000-00000407BAD9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032111-0021-0000-0000-0000429BD8EE
Message-Id: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803210139
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody

here is the updated patch set including Dave's comments.

Changes v1 -> v2:
	* Fix missing memcpy and memset definition in x86 purgatory
	introduced by moving the sha256 implementation to common code.
	* Update subject of patches #7-9 to be more precise.
	* Add missing semicolon in patch #7 found by kbuild bot.
	* Fix compile warnings found by kbuild bot by moving all kexec_file
	specific function declarations into a 'ifdef CONFIG_KEXEC_FILE'
	block (patch #5 and #10).

Thanks
Philipp

---

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
  kexec_file: Remove unneeded for-loop in kexec_purgatory_setup_sechdrs
  kexec_file: Remove unneeded variables in kexec_purgatory_setup_sechdrs
  kexec_file: Remove mis-use of sh_offset field during purgatory load
  kexec_file: Allow archs to set purgatory load address
  kexec_file: Move purgatories sha256 to common code

 arch/powerpc/kernel/kexec_elf_64.c             |   9 +-
 arch/x86/kernel/kexec-bzimage64.c              |   8 +-
 arch/x86/kernel/machine_kexec_64.c             |  66 ++---
 arch/x86/purgatory/Makefile                    |   3 +
 arch/x86/purgatory/purgatory.c                 |   2 +-
 arch/x86/purgatory/string.c                    |  12 +
 include/linux/kexec.h                          |  49 ++--
 {arch/x86/purgatory => include/linux}/sha256.h |  11 +-
 kernel/kexec_file.c                            | 379 ++++++++++++-------------
 {arch/x86/purgatory => lib}/sha256.c           |   4 +-
 10 files changed, 267 insertions(+), 276 deletions(-)
 rename {arch/x86/purgatory => include/linux}/sha256.h (62%)
 rename {arch/x86/purgatory => lib}/sha256.c (99%)

-- 
2.13.5
