Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC83C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A2F2083E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ifo0brj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A2F2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933983AbeGDIkt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:40:49 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36928 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932971AbeGDIir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:38:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id v22-v6so3464486edq.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 01:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=aolepLXtc+NmbPOU2kJlAJaawWtTg0YypMQvc+xfJfE=;
        b=Ifo0brj/ko4DgTcDV3VPScShETjyCnClfXS8TBxmSWk7hpkwBC0hycomw49VpreXmg
         ohI1wzOXWaFFIqxrHGcSrgosuqjtKInALy794jIR1iu6v+Hx83OwtK3Cd9tThZDmUTd5
         me6rCxFRuY3LDgeQRlNegwBAhuijJMUMRJ0Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aolepLXtc+NmbPOU2kJlAJaawWtTg0YypMQvc+xfJfE=;
        b=W7iO5f3gJ1aqCzSkTfTjAhGdWcHfeZrTEePdmGPlrFuZq3tie7KFBuRNb8C7kLIFDz
         hk1F1TNu+7a3R/4A9hbsyYIODFGkDISGycvCtOlYhQ/njFrcM8yKLW7To0VYzg1bWp40
         vOI0Cb5xsJVjlPQIr0Ic5JApCr4wuZc0mOTaNe1hlzy/Nsc0Viy+7Yoi98kLMJ5+TvMp
         jHH0qcHSBv0b01j2DdXXbeFXqDSm4W8cWnU9Co1QhwayGdyMrX4duKcryI+vEGlKkaAp
         5umBL4AK+FFbk9L13Zt9mmSqfdy5/vV6DqchwFtUvh13OgcSz1TBNceMvrLnjyR6NT+T
         1w4Q==
X-Gm-Message-State: APt69E1o+VOIqN9BhcFDr6BirjoEwx8mrAv2+SM0kcRvWqWCrDRjaU0g
        nZ3yYsJjrinoqBtGBle0CVaGNoGAX2k=
X-Google-Smtp-Source: AAOMgpfer+5QYOfBLpRKPkWtEM6dAFfsdj1zSKUDho6385G0Z4Pu1dsy1nJZTYEFvD4XIIuH5ITgvg==
X-Received: by 2002:a50:cc01:: with SMTP id m1-v6mr1718472edi.171.1530693526245;
        Wed, 04 Jul 2018 01:38:46 -0700 (PDT)
Received: from ards-mac-mini.arnhem.chello.nl (dhcp-077-251-017-237.chello.nl. [77.251.17.237])
        by smtp.gmail.com with ESMTPSA id k13-v6sm1821740edj.55.2018.07.04.01.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 01:38:45 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell King <linux@armlinux.org.uk>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nico@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: [PATCH v10 0/6] add support for relative references in special sections
Date:   Wed,  4 Jul 2018 10:36:45 +0200
Message-Id: <20180704083651.24360-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for emitting special sections such as initcall arrays,
PCI fixups and tracepoints as relative references rather than absolute
references. This reduces the size by 50% on 64-bit architectures, but
more importantly, it removes the need for carrying relocation metadata
for these sections in relocatable kernels (e.g., for KASLR) that needs
to be fixed up at boot time. On arm64, this reduces the vmlinux footprint
of such a reference by 8x (8 byte absolute reference + 24 byte RELA entry
vs 4 byte relative reference)

Patch #3 was sent out before as a single patch. This series supersedes
the previous submission. This version makes relative ksymtab entries
dependent on the new Kconfig symbol HAVE_ARCH_PREL32_RELOCATIONS rather
than trying to infer from kbuild test robot replies for which architectures
it should be blacklisted.

Patch #1 introduces the new Kconfig symbol HAVE_ARCH_PREL32_RELOCATIONS,
and sets it for the main architectures that are expected to benefit the
most from this feature, i.e., 64-bit architectures or ones that use
runtime relocations.

Patch #2 add support for #define'ing __DISABLE_EXPORTS to get rid of
ksymtab/kcrctab sections in decompressor and EFI stub objects when
rebuilding existing C files to run in a different context.

Patches #4 - #6 implement relative references for initcalls, PCI fixups
and tracepoints, respectively, all of which produce sections with order
~1000 entries on an arm64 defconfig kernel with tracing enabled. This
means we save about 28 KB of vmlinux space for each of these patches.

[From the v7 series blurb, which included the jump_label patches as well]:
  For the arm64 kernel, all patches combined reduce the memory footprint of
  vmlinux by about 1.3 MB (using a config copied from Ubuntu that has KASLR
  enabled), of which ~1 MB is the size reduction of the RELA section in .init,
  and the remaining 300 KB is reduction of .text/.data.

Branch:
git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git relative-special-sections-v10

Andrew, this series now has all the prerequisite acks in place. Could you please
take this through the -mm tree? Thanks.

Changes since v9:
- use .discard.addressable section (not .discard) for emitting dummy symbol
  references, to work around a build issue on powerpc
- add acks from Michael, Ingo, Will, James, Petr and Sergey

Changes since v8:
- add Nico's ack (#2)
- drop 'const' qualifier from __ADDRESSABLE(sym) to prevent mismatching
  attributes for the .discard section (#3)
- drop all uses of VMLINUX_SYMBOL_STR(), which is on its way out (#3 - #6)

Changes since v7:
- dropped the jump_label patches, these will be revisited in a separate series
- reorder __DISABLE_EXPORTS with __KSYM_DEPS__ check in #2
- use offset_to_ptr() helper function to abstract the relative pointer
  conversion [int *off -> (ulong)off + *off] (#3 - #6)
- rebase onto v4.16-rc3

Changes since v6:
- drop S390 from patch #1 introducing HAVE_ARCH_PREL32_RELOCATIONS: kbuild
  robot threw me some s390 curveballs, and given that s390 does not define
  CONFIG_RELOCATABLE in the first place, it does not benefit as much from
  relative references as arm64, x86 and power do
- add patch to allow symbol exports to be disabled at compilation unit
  granularity (#2)
- get rid of arm64 vmlinux.lds.S hunk to ensure code generated by __ADDRESSABLE
  gets discarded from the EFI stub - it is no longer needed after adding #2 (#1)
- change _ADDRESSABLE() to emit a data reference, not a code reference - this
  is another simplification made possible by patch #2 (#3)
- add Steven's ack to #6
- split x86 jump_label patch into two (#9, #10)

Changes since v5:
- add missing jump_label prototypes to s390 jump_label.h (#6)
- fix inverted condition in call to jump_entry_is_module_init() (#6)

Changes since v4:
- add patches to convert x86 and arm64 to use relative references for jump
  tables (#6 - #8)
- rename PCI patch and add Bjorn's ack (#4)
- rebase onto v4.15-rc5

Changes since v3:
- fix module unload issue in patch #5 reported by Jessica, by reusing the
  updated routine for_each_tracepoint_range() for the quiescent check at
  module unload time; this requires this routine to be moved before
  tracepoint_module_going() in kernel/tracepoint.c
- add Jessica's ack to #2
- rebase onto v4.14-rc1

Changes since v2:
- Revert my slightly misguided attempt to appease checkpatch, which resulted
  in needless churn and worse code. This v3 is based on v1 with a few tweaks
  that were actually reasonable checkpatch warnings: unnecessary braces (as
  pointed out by Ingo) and other minor whitespace misdemeanors.

Changes since v1:
- Remove checkpatch errors to the extent feasible: in some cases, this
  involves moving extern declarations into C files, and switching to
  struct definitions rather than typedefs. Some errors are impossible
  to fix: please find the remaining ones after the diffstat.
- Used 'int' instead if 'signed int' for the various offset fields: there
  is no ambiguity between architectures regarding its signedness (unlike
  'char')
- Refactor the different patches to be more uniform in the way they define
  the section entry type and accessors in the .h file, and avoid the need to
  add #ifdefs to the C code.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thomas Garnier <thgarnie@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Morris <jmorris@namei.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jessica Yu <jeyu@kernel.org>

Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: x86@kernel.org

Ard Biesheuvel (6):
  arch: enable relative relocations for arm64, power and x86
  module: allow symbol exports to be disabled
  module: use relative references for __ksymtab entries
  init: allow initcall tables to be emitted using relative references
  PCI: Add support for relative addressing in quirk tables
  kernel: tracepoints: add support for relative references

 arch/Kconfig                          | 10 ++++
 arch/arm64/Kconfig                    |  1 +
 arch/powerpc/Kconfig                  |  1 +
 arch/x86/Kconfig                      |  1 +
 arch/x86/boot/compressed/kaslr.c      |  5 +-
 arch/x86/include/asm/Kbuild           |  1 +
 arch/x86/include/asm/export.h         |  5 --
 drivers/firmware/efi/libstub/Makefile |  3 +-
 drivers/pci/quirks.c                  | 12 +++--
 include/asm-generic/export.h          | 12 ++++-
 include/linux/compiler.h              | 19 +++++++
 include/linux/export.h                | 57 +++++++++++++++-----
 include/linux/init.h                  | 44 +++++++++++----
 include/linux/pci.h                   | 20 +++++++
 include/linux/tracepoint.h            | 19 +++++--
 init/main.c                           | 32 +++++------
 kernel/module.c                       | 32 ++++++++---
 kernel/printk/printk.c                | 16 +++---
 kernel/tracepoint.c                   | 49 +++++++++--------
 security/security.c                   | 17 +++---
 20 files changed, 255 insertions(+), 101 deletions(-)
 delete mode 100644 arch/x86/include/asm/export.h

-- 
2.17.1

