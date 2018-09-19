Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83724C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C7420880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ADm/6+Mj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C7420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbeISM2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:28:38 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52698 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbeISM2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:28:38 -0400
Received: by mail-it0-f66.google.com with SMTP id h3-v6so6839901ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 23:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8J6RqrCYqxFTJGEKNKL5VAPGu8G2QxV+5l6IwAhc2Vs=;
        b=ADm/6+MjVXgAegUp5TVm/hq5rbbVz3gDtj3CZAjLBEjT9zj8k/VwpzY+M0JLvpEv8W
         CGCIeKWNX0miypBSnGmmDHifkA0iFm8QxoxoDA3169xzWuQhd/37QqRcWYxOAY/by+12
         ws1A1r+RXaUCxt4XvuskAO+WLSy3DZ6idt2IQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8J6RqrCYqxFTJGEKNKL5VAPGu8G2QxV+5l6IwAhc2Vs=;
        b=b2M5xzwPCnZU8PSUaMoTyNGw0NwYfCLgn9XlgfJiUDpS21Wfjdm+Z7K1hxRZG2pwjr
         t4X875KMVG2CN8CZgLUOF2i/DROwesKq0lEf4ToMCa6wEo4t2ara7lxIor/A8Ga1a1eM
         z+JHipDKtYk1seUjmv2xQ30RoATXmWWQWTL878CyR2ZfwtQ39tefMDVlQWNulWFECddj
         lYF3ls7PjeoDxPWXMgPCORszrByOAr0nbYXqRPRZa3OmvZEpYOshzmt2TZDlKo+rfhIL
         dQWiT51ygiJSFXIhTrh2Zd83rBwhD8LqqOr5EM7QGL41y5DbM300/BI6o27Oivwnslpx
         us4w==
X-Gm-Message-State: APzg51Adh3tVTQSPDGn/GnSMrArkDbMXLdFQlyevYlAiaAyoUGrqzDTF
        MSw/Tw+8kj0OQAxKL8I1yyjWwYEaR93lIQ==
X-Google-Smtp-Source: ANB0VdZbnNgHlyjztwE/tFcpbSEae7QHtRHdrfd/pW2ZoFxs0/q7jEor28e3gmlAuyiunPXLtMRWeA==
X-Received: by 2002:a24:ad11:: with SMTP id c17-v6mr20577071itf.46.1537339928258;
        Tue, 18 Sep 2018 23:52:08 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id x68-v6sm7939477ita.2.2018.09.18.23.52.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 23:52:07 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 0/9] add support for relative references in jump tables
Date:   Tue, 18 Sep 2018 23:51:35 -0700
Message-Id: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series implements support for emitting the data structures associated
with jump tables as 32-bit relative references instead of absolute
references, which take up more space on builds that target 64-bit
architectures, or implement self relocation [or both].

This series enables it for arm64 and x86, although other architectures
might benefit as well.

Patch #1 does some preparatory refactoring before patch #2 introduces the
generic pieces required for using relative references.

Patch #3 wires everything up for arm64.

Patch #4 introduces support for handling 64-bit place relative relocations
on x86_64 (see 'Changes since v1' below)

For x86, patch #5 applies some preparatory changes for the arch specific
jump label C code, which is a lot more involved than on arm64, which is
why it is split off in this case. Patch #6 wires it up for x86 as well.

Patch #7 and #8 implement the changes so that the jump_entry arrays reside
in ro_after_init memory rather than remain fully writable all of the time.

Patch #9 enables the feature for s390 (contributed by Heiko)

Changes since v2:
- fix breakage in user mode x86 kernel due to missing definition of the
  R_X86_64_PC64 symbolic constant
- add acks from Jessica and Kees
- add s390 enablement patch

Changes since v1:
- change the relative reference to the static key to a 64-bit wide one on 64
  bit architectures; this is necessary on arm64, which allows modules to
  reside anywhere within a 4 GB window covering the core kernel text, which
  means a 32-bit signed quantity with its +/- 2 GB range is insufficient.
  Note that x86_64 changes are in preparation that widen the relocation
  range as well (using the PIE linker), so I assumed that the same change
  is appropriate for x86 as well.
- add patch #4 to handle the relocations emitted by the compiler as a result
  of the change above
- added patches to move the jump_entry arrays to ro_after_init memory, so
  that they are not as easily corrupted or manipulated.
- add Will's ack to patch #3

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Jessica Yu <jeyu@kernel.org> 
Cc: Peter Zijlstra <peterz@infradead.org>

Ard Biesheuvel (8):
  kernel/jump_label: abstract jump_entry member accessors
  kernel/jump_label: implement generic support for relative references
  arm64/kernel: jump_label: switch to relative references
  x86: add support for 64-bit place relative relocations
  x86: jump_label: switch to jump_entry accessors
  x86/kernel: jump_table: use relative references
  jump_label: annotate entries that operate on __init code earlier
  jump_table: move entries into ro_after_init region

Heiko Carstens (1):
  s390/jump_label: switch to relative references

 arch/Kconfig                        |   3 +
 arch/arm64/Kconfig                  |   1 +
 arch/arm64/include/asm/jump_label.h |  38 ++++----
 arch/arm64/kernel/jump_label.c      |   6 +-
 arch/s390/Kconfig                   |   1 +
 arch/s390/include/asm/jump_label.h  |  40 ++++----
 arch/s390/kernel/jump_label.c       |  11 ++-
 arch/s390/kernel/vmlinux.lds.S      |   1 +
 arch/x86/Kconfig                    |   1 +
 arch/x86/include/asm/elf.h          |   3 +-
 arch/x86/include/asm/jump_label.h   |  24 ++---
 arch/x86/kernel/jump_label.c        |  62 +++++-------
 arch/x86/kernel/module.c            |   6 ++
 arch/x86/tools/relocs.c             |  10 ++
 arch/x86/um/asm/elf.h               |   3 +-
 include/asm-generic/vmlinux.lds.h   |  11 ++-
 include/linux/jump_label.h          |  65 ++++++++++++-
 init/main.c                         |   1 -
 kernel/jump_label.c                 | 100 +++++++++-----------
 kernel/module.c                     |   9 ++
 tools/objtool/special.c             |   4 +-
 21 files changed, 226 insertions(+), 174 deletions(-)

-- 
2.17.1

