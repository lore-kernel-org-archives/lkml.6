Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbeB0Esb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 23:48:31 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43352 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeB0Es3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 23:48:29 -0500
X-Google-Smtp-Source: AH8x2273TX0pq+C95dYTfVw+1AUqjJ9qMjaWYXLDyDcWLmYiajpVV1OZHK8BXHnDQD3mx8G7dI2C1w==
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: dyoung@redhat.com, vgoyal@redhat.com, bhe@redhat.com,
        mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com,
        prudo@linux.vnet.ibm.com
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 0/7] kexec_file: refactoring for other architecutres 
Date: Tue, 27 Feb 2018 13:48:07 +0900
Message-Id: <20180227044814.24808-1-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

subject: 

This is a preparatory patch set for adding kexec_file support on arm64.

It was originally included in a arm64 patch set[1], but Philipp is also
working on their kexec_file support on s390[2] and some changes are now
conflicting.

So these common part was extracted and put into a separate patch set for
better integration. What's more, my original patch#4 was split into a few
small chunks for easier review after Dave's comment.

As such, the resulting code is basically identical with my original, and
the only difference is that kexec_file_loaders[] is now declared in kexec.h
after Phillipp's comment[3]. Other than that, this patch set doesn't
require any changes on the rest of my original patch set(#1, #6 to #13).

Patch#1 allows making a use of purgatory optional, particularly useful
for arm64.
Patch#2 commonalizes arch_kexec_kernel_{image_probe, image_load,
verify_sig}() and arch_kimage_file_post_load_cleanup() across architectures.
Patch#3-#7 is also intended to generalize parse_elf64_headers(), along with
exclude_mem_range(), to be made best re-use of.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-February/561182.html
[2] http://lkml.iu.edu//hypermail/linux/kernel/1802.1/02596.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-February/562041.html

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
 arch/x86/kernel/crash.c                     | 332 +++++-----------------------
 arch/x86/kernel/kexec-bzimage64.c           |   2 +-
 arch/x86/kernel/machine_kexec_64.c          |  45 +---
 include/linux/kexec.h                       |  36 ++-
 kernel/kexec_file.c                         | 236 +++++++++++++++++++-
 11 files changed, 336 insertions(+), 366 deletions(-)

-- 
2.16.2
