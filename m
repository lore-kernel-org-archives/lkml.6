Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6C6C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC0724AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 02:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d/ugzsoR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC0724AB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934639AbeFWCUa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 22:20:30 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42721 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934528AbeFWCU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 22:20:28 -0400
Received: by mail-pf0-f193.google.com with SMTP id w7-v6so3994855pfn.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 19:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DtfsdCm1RwRu4PfazbqVoJ3PkGHAVbBjWBGhYMZTQQE=;
        b=d/ugzsoRg+Z48qgB/NFMxX9jGXsAty+fqAUnHpobAW53MT4O9/zOf81FnEWPmWPAqZ
         hTl1QCdx7oJ6/VHP403xZ+S4cmJAodzBIJ5ZfgpPvMtVDY3avXvbJJp8H+sbiv7KfNq5
         mzFK9d7/2Re3HG3mv365SBhusQffb6L/bMwHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DtfsdCm1RwRu4PfazbqVoJ3PkGHAVbBjWBGhYMZTQQE=;
        b=pwgKYREJmgjerhEY0tOz/yCkUyOdpg8bam4z1gihAD19pxjZVKK26hOf8rdqT1Zlx4
         /sKt7cgziKl5wNqiuIZGJ8DuY9HjGimBz8vmCOpHhWKB9VFFgCvBBmYGJgOuQ0L7yzhd
         ldSSKQ/3lq36t6I8AbYbD+tLrMANhIj7YzewUS9LkS3OhAdkgGdnlsyG3xnLS85a6rSi
         wD/rD08Gsrh7xxYhVTilIkKqAcs8B+5MDoQV5pws7bSBMc/OkLv7KvmCIn00vtUWbJbn
         dlDGiNDoRX/rV9DOwNjxxPwW3+Yh0nuggrcocb4Vkz23/5QKXP7Pa/ds5h4SBPichvy8
         wlZg==
X-Gm-Message-State: APt69E2Wypeseyy923tc0A0UxIkALD4nruzhqHI0q7G84Go+vHOgwhD+
        VIFyyjLoSFBwyyNfE7FZ8QYK9A==
X-Google-Smtp-Source: ADUXVKLdTi1QaEug7GGNVew/Sbb6JenQHOuaA0sbnNhwguEepbViZrDa/nVOjY07yoIppiC/E6EnNg==
X-Received: by 2002:a63:b812:: with SMTP id p18-v6mr3473646pge.11.1529720428301;
        Fri, 22 Jun 2018 19:20:28 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id d6-v6sm11630099pgc.38.2018.06.22.19.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 19:20:27 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v10 00/14] arm64: kexec: add kexec_file_load() support
Date:   Sat, 23 Jun 2018 11:20:44 +0900
Message-Id: <20180623022058.10935-1-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the tenth round of implementing kexec_file_load() support
on arm64.[1] (See "Changes" below)
Most of the code is based on kexec-tools.


This patch series enables us to
  * load the kernel by specifying its file descriptor, instead of user-
    filled buffer, at kexec_file_load() system call, and
  * optionally verify its signature at load time for trusted boot.
Kernel virtual address randomization is also supported since v9.

Contrary to kexec_load() system call, as we discussed a long time ago,
users may not be allowed to provide a device tree to the 2nd kernel
explicitly, hence enforcing a dt blob of the first kernel to be re-used
internally.

To use kexec_file_load() system call, instead of kexec_load(), at kexec
command, '-s' option must be specified. See [2] for a necessary patch for
kexec-tools.

To analyze a generated crash dump file, use the latest master branch of
crash utility[3]. I always try to submit patches to fix any inconsistencies
introduced in the latest kernel.

Regarding a kernel image verification, a signature must be presented
along with the binary itself. A signature is basically a hash value
calculated against the whole binary data and encrypted by a key which
will be authenticated by one of the system's trusted certificates.
Any attempt to read and load a to-be-kexec-ed kernel image through
a system call will be checked and blocked if the binary's hash value
doesn't match its associated signature.

There are two methods available now:
1. implementing arch-specific verification hook of kexec_file_load()
2. utilizing IMA(Integrity Measurement Architecture)[4] appraisal framework

Before my v7, I believed that my patch only supports (1) but am now
confident that (2) comes free if IMA is enabled and properly configured.


(1) Arch-specific verification hook
If CONFIG_KEXEC_VERIFY_SIG is enabled, kexec_file_load() invokes an arch-
defined (and hence file-format-specific) hook function to check for the
validity of kernel binary.

On x86, a signature is embedded into a PE file (Microsoft's format) header
of binary. Since arm64's "Image" can also be seen as a PE file as far as
CONFIG_EFI is enabled, we adopt this format for kernel signing.  

As in the case of UEFI applications, we can create a signed kernel image:
    $ sbsign --key ${KEY} --cert ${CERT} Image

You may want to use certs/signing_key.pem, which is intended to be used
for module signing (CONFIG_MODULE_SIG), as ${KEY} and ${CERT} for test
purpose.


(2) IMA appraisal-based
IMA was first introduced in linux in order to meet TCG (Trusted Computing
Group) requirement that all the sensitive files be *measured* before
reading/executing them to detect any untrusted changes/modification.
Then appraisal feature, which allows us to ensure the integrity of
files and even prevent them from reading/executing, was added later.

Meanwhile, kexec_file_load() has been merged since v3.17 and evolved to
enable IMA-appraisal type verification by the commit b804defe4297 ("kexec:
replace call to copy_file_from_fd() with kernel version").

In this scheme, a signature will be stored in a extended file attribute,
"security.ima" while a decryption key is hold in a dedicated keyring,
".ima" or "_ima".  All the necessary process of verification is confined
in a secure API, kernel_read_file_from_fd(), called by kexec_file_load().

    Please note that powerpc is one of the two architectures now
    supporting KEXEC_FILE, and that it wishes to exntend IMA,
    where a signature may be appended to "vmlinux" file[5], like module
    signing, instead of using an extended file attribute.

While IMA meant to be used with TPM (Trusted Platform Module) on secure
platform, IMA is still usable without TPM. Here is an example procedure
about how we can give it a try to run the feature using a self-signed
root ca for demo/test purposes:

 1) Generate needed keys and certificates, following "Generate trusted
    keys" section in README of ima-evm-utils[6].

 2) Build the kernel with the following kernel configurations, specifying
    "ima-local-ca.pem" for CONFIG_SYSTEM_TRUSTED_KEYS:
	CONFIG_EXT4_FS_SECURITY
	CONFIG_INTEGRITY_SIGNATURE
	CONFIG_INTEGRITY_ASYMMETRIC_KEYS
	CONFIG_INTEGRITY_TRUSTED_KEYRING
	CONFIG_IMA
	CONFIG_IMA_WRITE_POLICY
	CONFIG_IMA_READ_POLICY
	CONFIG_IMA_APPRAISE
	CONFIG_IMA_APPRAISE_BOOTPARAM
	CONFIG_SYSTEM_TRUSTED_KEYS
    Please note that CONFIG_KEXEC_VERIFY_SIG is not, actually should
    not be, enabled.

 3) Sign(label) a kernel image binary to be kexec-ed on target filesystem:
    $ evmctl ima_sign --key /path/to/private_key.pem /your/Image

 4) Add a command line parameter and boot the kernel:
    ima_appraise=enforce

 On live system,
 5) Set a security policy:
    $ mount -t securityfs none /sys/kernel/security
    $ echo "appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig" \
      > /sys/kernel/security/ima/policy

 6) Add a key for ima:
    $ keyctl padd asymmetric my_ima_key %:.ima < /path/to/x509_ima.der
    (or evmctl import /path/to/x509_ima.der <ima_keyring_id>)

 7) Then try kexec as normal.


Concerns(or future works):
* Support for physical address randomization
* Signature verification of big endian kernel with CONFIG_KEXEC_VERIFY_SIG
  While big-endian kernel can support kernel signing, I'm not sure that
  Image can be recognized as in PE format because x86 standard only
  defines little-endian-based format.
* Support for vminux loading

  [1] http://git.linaro.org/people/takahiro.akashi/linux-aarch64.git
	branch:arm64/kexec_file
  [2] http://git.linaro.org/people/takahiro.akashi/kexec-tools.git
	branch:arm64/kexec_file
  [3] http://github.com/crash-utility/crash.git
  [4] https://sourceforge.net/p/linux-ima/wiki/Home/
  [5] http://lkml.iu.edu//hypermail/linux/kernel/1707.0/03669.html
  [6] https://sourceforge.net/p/linux-ima/ima-evm-utils/ci/master/tree/


Changes in v10 (June 23, 2018)
* rebased to v4.18-rc
* change syscall numer of kexec_file_load from 292 to 293
* factor out memblock-based arch_kexec_walk_mem() from powerpc and
  merge it into generic one
* move generic fdt helper functions from arm64 dir to drivers/of
  (dt_root_[addr|size]_cells are no longer __initdata.)
* modify fill_property() to use 'while' loop
* modify fdt_setprop_reg() to allocate a buffer on stack
* modify setup_dtb() to use fdt_setprop_u64()
* pass kernel_load_addr/size directly as arguments, instead of via
  kimage_arch.kern_segment, at load_other_segments()
* refuse loading an image which cannot be supported in image loader,
  adding cpu-feature(MMFR0) helper functions
* modify prepare_elf_headers() to use kmalloc() instead of vmalloc()
* always pass arch.dtb_mem as the fourth argument to cpu_soft_restart()
  in machine_kexec() while dtb_mem will be zero in kexec case

Changes in v9 (April 25, 2018)
* rebased to v4.17-rc
* remove preparatory patches on generic/x86/ppc code
  They have now been merged in v4.17-rc1.
* allocate memory based on memblock list instead of system resources
  This will prevent reserved regions, particularly UEFI/ACPI data,
  from being corrupted.
* correct dt property names, linux,initrd-*, in newly-created dtb
  "linux," was missing.
* remove alignment requirement for initrd loading
* add kaslr (kernel virtual address randomization) support
* misc code clean-up
* revise commit messages

Changes in v8 (Feb 22, 2018)
* introduce ARCH_HAS_KEXEC_PURGATORY so that arm64 will be able to skip
  purgatory
* remove "ifdef CONFIG_X86_64" stuffs from a re-factored function,
  prepare_elf64_headers(), making its interface more generic
  (The original patch was split into two for easier reviews.)
* modify cpu_soft_restart() so as to let the 2nd kernel jump into its entry
  code directly without requiring purgatory in case of kexec_file_load
* remove CONFIG_KEXEC_FILE_IMAGE_FMT and introduce
  CONFIG_KEXEC_IMAGE_VERIFY_SIG, much similar to x86 but quite redundant
  for now.
* In addition, update/modify dependencies of KEXEC_IMAGE_VERIFY_SIG

Changes in v7 (Dec 4, 2017)
* rebased to v4.15-rc2
* re-organize the patch set to separate KEXEC_FILE_VERIFY_SIG-related
  code from the others
* revamp factored-out code in kernel/kexec_file.c due to the changes
  in original x86 code
* redefine walk_sys_ram_res_rev() prototype due to change of callback
  type in the counterpart, walk_sys_ram_res()
* make KEXEC_FILE_IMAGE_FMT default on if KEXEC_FILE selected

Changes in v6 (Oct 24, 2017)
* fix a for-loop bug in _kexec_kernel_image_probe() per Julien

Changes in v5 (Oct 10, 2017)
* fix kbuild errors around patch #3
per Julien's comments,
* fix a bug in walk_system_ram_res_rev() with some cleanup
* modify fdt_setprop_range() to use vmalloc()
* modify fill_property() to use memset()

Changes in v4 (Oct 2, 2017)
* reinstate x86's arch_kexec_kernel_image_load()
* rename weak arch_kexec_kernel_xxx() to _kexec_kernel_xxx() for
  better re-use
* constify kexec_file_loaders[]

Changes in v3 (Sep 15, 2017)
* fix kbuild test error
* factor out arch_kexec_kernel_*() & arch_kimage_file_post_load_cleanup()
* remove CONFIG_CRASH_CORE guard from kexec_file.c
* add vmapped kernel region to vmcore for gdb backtracing
  (see prepare_elf64_headers())
* merge asm/kexec_file.h into asm/kexec.h
* and some cleanups

Changes in v2 (Sep 8, 2017)
* move core-header-related functions from crash_core.c to kexec_file.c
* drop hash-check code from purgatory
* modify purgatory asm to remove arch_kexec_apply_relocations_add()
* drop older kernel support
* drop vmlinux support (at least, for this series)


Patch #1 to #10 are essential part for KEXEC_FILE support
(additionally allowing for IMA-based verification):
  Patch #1 to #6 are all preparatory patches on generic side.
  Patch #7 to #11 are to enable kexec_file_load on arm64.

Patch #12 to #13 are for KEXEC_VERIFY_SIG (arch-specific verification)
support

AKASHI Takahiro (14):
  asm-generic: add kexec_file_load system call to unistd.h
  kexec_file: make kexec_image_post_load_cleanup_default() global
  powerpc, kexec_file: factor out memblock-based arch_kexec_walk_mem()
  of/fdt: add helper functions for handling properties
  arm64: add image head flag definitions
  arm64: cpufeature: add MMFR0 helper functions
  arm64: enable KEXEC_FILE config
  arm64: kexec_file: load initrd and device-tree
  arm64: kexec_file: allow for loading Image-format kernel
  arm64: kexec_file: add crash dump support
  arm64: kexec_file: invoke the kernel without purgatory
  include: pe.h: remove message[] from mz header definition
  arm64: kexec_file: add kernel signature verification support
  arm64: kexec_file: add kaslr support

 arch/arm64/Kconfig                          |  34 +++
 arch/arm64/include/asm/boot.h               |  15 +
 arch/arm64/include/asm/cpufeature.h         |  48 ++++
 arch/arm64/include/asm/kexec.h              |  48 ++++
 arch/arm64/kernel/Makefile                  |   3 +-
 arch/arm64/kernel/cpu-reset.S               |   8 +-
 arch/arm64/kernel/head.S                    |   2 +-
 arch/arm64/kernel/kexec_image.c             | 128 +++++++++
 arch/arm64/kernel/machine_kexec.c           |  12 +-
 arch/arm64/kernel/machine_kexec_file.c      | 291 ++++++++++++++++++++
 arch/arm64/kernel/relocate_kernel.S         |   3 +-
 arch/powerpc/kernel/machine_kexec_file_64.c |  53 ----
 drivers/of/fdt.c                            |  62 ++++-
 include/linux/kexec.h                       |   1 +
 include/linux/of_fdt.h                      |  10 +-
 include/linux/pe.h                          |   2 +-
 include/uapi/asm-generic/unistd.h           |   4 +-
 kernel/kexec_file.c                         |  54 +++-
 18 files changed, 709 insertions(+), 69 deletions(-)
 create mode 100644 arch/arm64/kernel/kexec_image.c
 create mode 100644 arch/arm64/kernel/machine_kexec_file.c

-- 
2.17.0

