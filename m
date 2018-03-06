Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753300AbeCFKXG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 05:23:06 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:33762 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeCFKXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 05:23:04 -0500
X-Google-Smtp-Source: AG47ELseU7VXqy/O9Y81e1KuhfXbTcydKrYR3iF4dR6GrQMgg46oFoB2Bn7SOmHoFlHr4I44h7yaJw==
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: dyoung@redhat.com, vgoyal@redhat.com, bhe@redhat.com,
        mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com,
        prudo@linux.vnet.ibm.com
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 0/7] kexec_file, x86, powerpc: refactoring for other architecutres
Date: Tue,  6 Mar 2018 19:22:56 +0900
Message-Id: <20180306102303.9063-1-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory patch set for adding kexec_file support on arm64.

It was originally included in a arm64 patch set[1], but Philipp is also
working on their kexec_file support on s390[2] and some changes are now
conflicting.

So these common parts were extracted and put into a separate patch set for
better integration. What's more, my original patch#4 was split into a few
small chunks for easier review after Dave's comment.

As such, the resulting code is basically identical with my original, and
the only *visible* differences are:
  * renamings of _kexec_kernel_image_probe() and
    _kimage_file_post_load_cleanup()
  * change one of types of arguments at prepare_elf64_headers()
Those, unfortunately, require a couple of trivial changes on the rest
(#1, #6 to #13) of my arm64 kexec_file patch set[1].

Patch#1 allows making a use of purgatory optional, particularly useful
for arm64.
Patch#2 commonalizes arch_kexec_kernel_{image_probe, image_load,
verify_sig}() and arch_kimage_file_post_load_cleanup() across architectures.
Patch#3-#7 is also intended to generalize parse_elf64_headers(), along with
exclude_mem_range(), to be made best re-use of.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-February/561182.html
[2] http://lkml.iu.edu//hypermail/linux/kernel/1802.1/02596.html


Changes in v2 (Mar 6, 2018)
* use IS_ENABLED() instead of #ifdef's in kexec_calculate_store_digests() 
* rename _kexec_kernel_*() and make them static for now except for
  kexec_image_probe_default() which is actually used by arch(powerpc) code
  (Note: kexec_image_post_load_cleanup_default() will also be exported by
  arm64 patches.)
* change a type of kernel_map in prepare_elf64_headers() to "int"
* check for a total number of system ram regions in full_up_crash_elf_data()
  and use vzalloc() instead of vmalloc()

AKASHI Takahiro (7):
  kexec_file: make an use of purgatory optional
  kexec_file,x86,powerpc: factor out kexec_file_ops functions
  x86: kexec_file: purge system-ram walking from prepare_elf64_headers()
  x86: kexec_file: remove X86_64 dependency from prepare_elf64_headers()
  x86: kexec_file: lift CRASH_MAX_RANGES limit on crash_mem buffer
  x86: kexec_file: clean up prepare_elf64_headers()
  kexec_file, x86: move re-factored code to generic side

 arch/powerpc/Kconfig                        |   3 +
 arch/powerpc/include/asm/kexec.h            |   2 +-
 arch/powerpc/kernel/kexec_elf_64.c          |   2 +-
 arch/powerpc/kernel/machine_kexec_file_64.c |  39 +---
 arch/x86/Kconfig                            |   3 +
 arch/x86/include/asm/kexec-bzimage64.h      |   2 +-
 arch/x86/kernel/crash.c                     | 334 ++++++----------------------
 arch/x86/kernel/kexec-bzimage64.c           |   2 +-
 arch/x86/kernel/machine_kexec_64.c          |  45 +---
 include/linux/kexec.h                       |  32 ++-
 kernel/kexec_file.c                         | 240 +++++++++++++++++++-
 11 files changed, 338 insertions(+), 366 deletions(-)

-- 
2.16.2
