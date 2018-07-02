Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FD4C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39BD24FAE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fPMqiCOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39BD24FAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753353AbeGBSL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:11:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54371 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753323AbeGBSLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:11:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id i139-v6so9940735wmf.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 11:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Wczpy3MovXWNF7ShMlLVscAxwBkNReIA4OC63ioDHCk=;
        b=fPMqiCOoUDfXS1E43H+E5gbSFg7NvicpuSmnrOvnPITvWlXmtmop/OW578exsChdHB
         glKYpvEX2x7vrbVDKid+ioTxGWgbb3FkBM81jbJhUuUpY0ylST8oZWX1VYifdUfAE6/r
         6qVbJ4+Yfsd79TlLyG3Zdy6PkvRXeiwyMIFfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Wczpy3MovXWNF7ShMlLVscAxwBkNReIA4OC63ioDHCk=;
        b=XKpMMebvB5qfLizTSx8M0VoDFWar7Zcoe+CT4fBY7mKJiqSLdgh2rA2dkrhi8UxmY0
         ajM8he62hl1zYyIZ8Q9j5L5gRwwLQX7cMNubtbbYKc/7RD/SI7dOLFdo6tgCEUUpkvkK
         D/K4i15dsttnKhPccvPw/X/C2c4uJNLchyWglq6Ri4FjXXxF4Tmt8noRZEyP5fT0XuvT
         4aD1AlHQQY3/sZD9pgRlc93U4RzCUCQ905V5Qn4dWw6Iv6Xt8r6Hf11pCoE3EI3DzSE8
         bWJgxmFrnWJQe4DwZwKo/L3qq0XuiEQ/6gEfuRuD0eSv83YLRHZyxgrhcahU1mciZXiq
         un2w==
X-Gm-Message-State: APt69E2dE08D7xLvLl3R1i3lIwP9N+mBcUNSGenamIZertfX936Sca2b
        1cmDxZ+lYgtV3r9xSt3daEFdnQ==
X-Google-Smtp-Source: AAOMgpe5y9govJFgCfkxtQAChKywRDdWE/hLG+2NQfjkUgD+yBv9gNDJgLml0HoNNWuW7/wlpyXf+Q==
X-Received: by 2002:a1c:568a:: with SMTP id k132-v6mr8641245wmb.89.1530555111446;
        Mon, 02 Jul 2018 11:11:51 -0700 (PDT)
Received: from localhost.localdomain (151.21.90.92.rev.sfr.net. [92.90.21.151])
        by smtp.gmail.com with ESMTPSA id 189-v6sm10582822wmd.17.2018.07.02.11.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 11:11:50 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Subject: [PATCH v2 0/8] add support for relative references in jump tables
Date:   Mon,  2 Jul 2018 20:11:37 +0200
Message-Id: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
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

 arch/Kconfig                        |   3 +
 arch/arm/kernel/vmlinux-xip.lds.S   |   1 +
 arch/arm64/Kconfig                  |   1 +
 arch/arm64/include/asm/jump_label.h |  36 ++++---
 arch/arm64/kernel/jump_label.c      |   6 +-
 arch/s390/kernel/vmlinux.lds.S      |   1 +
 arch/x86/Kconfig                    |   1 +
 arch/x86/include/asm/elf.h          |   1 +
 arch/x86/include/asm/jump_label.h   |  24 ++---
 arch/x86/kernel/jump_label.c        |  62 +++++-------
 arch/x86/kernel/machine_kexec_64.c  |   4 +
 arch/x86/kernel/module.c            |   6 ++
 arch/x86/tools/relocs.c             |  10 ++
 include/asm-generic/vmlinux.lds.h   |  11 ++-
 include/linux/jump_label.h          |  65 ++++++++++++-
 init/main.c                         |   1 -
 kernel/jump_label.c                 | 100 +++++++++-----------
 kernel/module.c                     |   9 ++
 tools/objtool/special.c             |   4 +-
 19 files changed, 205 insertions(+), 141 deletions(-)

-- 
2.17.1

