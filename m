Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED64C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB5D2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UcZ5whuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB5D2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbeHNA1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:27:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34403 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730027AbeHNA1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:27:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id y5-v6so8136567pgv.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 14:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=AIYhaGiFEdSWf/yXNRouyccJjJb9GLAq+/xWR/TAmIk=;
        b=UcZ5whuymUBkaSI0jvQDwiznq3LGmsEEDzFzEufSdXZPHbzj/tLLUXHpXc6xvTbbXZ
         qYn0K/SAj75LJz3v/Lp7t5IeFwWy4m1v8TdWvYL/ocHSV0pXRucWdA3LIrVOg7dwHhqI
         hZiYR7kMRr9UcEkl8ato+grxH06540kmKiHRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=AIYhaGiFEdSWf/yXNRouyccJjJb9GLAq+/xWR/TAmIk=;
        b=DWTaKdPiQSLmFTgBKQAa40ioo4j2IcsY9qfbX+Ak0X7xhgkpKdBkZ0VZa6qZ0gjX9O
         GFenKYZqeoUDLLirq+DnU15C6ujcXT2ckOGrzBGlmktz4Pr3c5PmCqvz4HZK87iqlzgk
         xUHG8I4IcQh9+bgteuT0DwIPLupUh0x24oZIJoNAa+dqPbX2SjNjq7IKeDbhBW2iOQUv
         lTEmJOR21VK3JE2N1RKdo3LlpbhyE7npgaU4OPvRdOmkLFY2CWhvbQ8ZCRuiyIfroyPv
         JKz2Y4QIlLcy/yKxGydYERJjJ9ZDnmLFUGMFohpfFlsR8GHTr19sQLav1CJljjDC4FNS
         aAUg==
X-Gm-Message-State: AOUpUlFsJhB5ZOJwGHylQ+ukguWEQ1SvgVCTIP4HuNYl0eXxZB8usUeO
        9qvv3ZdBK8WUIXBGLVABe/AoIw==
X-Google-Smtp-Source: AA+uWPwRIkas58X0fpFiI2dakDhSzWLBdzACB14uwcOqREocrEM4dwAAYk81Yd69gSD1VqqjAtSQfA==
X-Received: by 2002:a62:569c:: with SMTP id h28-v6mr20730560pfj.201.1534196610532;
        Mon, 13 Aug 2018 14:43:30 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id c1-v6sm21475993pfi.142.2018.08.13.14.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 14:43:29 -0700 (PDT)
Date:   Mon, 13 Aug 2018 14:43:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [GIT PULL] gcc-plugin updates for v4.19-rc1
Message-ID: <20180813214328.GA15137@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these gcc-plugin changes for v4.19-rc1. This has some Kconfig
and Makefile cleanups from Masahiro and myself, but the bulk of this
is the STACKLEAK plugin ported by Alexander Popov. As discussed in its
commit logs, it provides efficient stack content poisoning at syscall
exit. This creates a defense against several classes of flaws:

- uninitialized stack usage (while we continue to work on improving the
  compiler to do this in other ways: e.g. unconditional zero init was
  proposed to gcc and clang, and more plugin work has started too)

- stack content exposure (by greatly reducing the lifetime of valid stack
  contents, exposures via either direct read bugs or unknown cache
  side-channels become much more difficult to exploit. This complements
  the existing buddy and heap poisoning options, but provides the coverage
  for stacks)

- stack exhaustion/guard-page skipping (while we continue to work to
  remove all VLAs in the kernel: of the ~115 cases found in v4.16, after
  the v4.19 merge window we should be down to about 13 remaining, most of
  them in crypto code, all of which have patches under review)

The x86 hooks are included in this series (which have been reviewed by
Ingo, Dave Hansen, and Thomas Gleixner), and have hopefully addressed
your concerns with regard to the size of assembly changes which are now
minimal. The arm64 hooks are expected to be coming through the arm64
tree during the v4.19 merge window as well (written by Laura Abbott and
reviewed by Mark Rutland and Will Deacon).

Thanks!

-Kees

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v4.19-rc1

for you to fetch changes up to b1310d137bc578f0032b6b990628a366d5f0910e:

  stackleak: Allow runtime disabling of kernel stack erasing (2018-07-26 09:04:15 -0700)

----------------------------------------------------------------
- Kconfig and Makefile clean ups (Masahiro Yamada, Kees Cook)
- Add STACKLEAK plugin, metrics, docs, knob and x86 hooks (Alexander Popov)

----------------------------------------------------------------
Alexander Popov (7):
      gcc-plugins: Clean up the cgraph_create_edge* macros
      x86/entry: Add STACKLEAK erasing the kernel stack at the end of syscalls
      gcc-plugins: Add STACKLEAK plugin for tracking the kernel stack
      lkdtm: Add a test for STACKLEAK
      fs/proc: Show STACKLEAK metrics in the /proc file system
      doc: self-protection: Add information about STACKLEAK feature
      stackleak: Allow runtime disabling of kernel stack erasing

Kees Cook (1):
      gcc-plugins: Regularize Makefile.gcc-plugins

Masahiro Yamada (2):
      gcc-plugins: remove unused GCC_PLUGIN_SUBDIR
      gcc-plugins: split out Kconfig entries to scripts/gcc-plugins/Kconfig

 Documentation/security/self-protection.rst |  23 +-
 Documentation/sysctl/kernel.txt            |  18 ++
 Documentation/x86/x86_64/mm.txt            |   2 +
 arch/Kconfig                               | 147 +--------
 arch/x86/Kconfig                           |   1 +
 arch/x86/entry/calling.h                   |  14 +
 arch/x86/entry/entry_32.S                  |   7 +
 arch/x86/entry/entry_64.S                  |   3 +
 arch/x86/entry/entry_64_compat.S           |   5 +
 arch/x86/kernel/dumpstack.c                |  31 ++
 drivers/misc/lkdtm/Makefile                |   3 +
 drivers/misc/lkdtm/core.c                  |   3 +
 drivers/misc/lkdtm/lkdtm.h                 |   5 +
 drivers/misc/lkdtm/stackleak.c             | 146 +++++++++
 fs/proc/base.c                             |  18 ++
 include/linux/sched.h                      |   5 +
 include/linux/stackleak.h                  |  35 +++
 kernel/Makefile                            |   4 +
 kernel/fork.c                              |   3 +
 kernel/stackleak.c                         | 132 ++++++++
 kernel/sysctl.c                            |  15 +-
 scripts/Makefile.gcc-plugins               |  47 ++-
 scripts/gcc-plugins/Kconfig                | 196 ++++++++++++
 scripts/gcc-plugins/Makefile               |   5 -
 scripts/gcc-plugins/gcc-common.h           |  26 +-
 scripts/gcc-plugins/stackleak_plugin.c     | 480 +++++++++++++++++++++++++++++
 26 files changed, 1195 insertions(+), 179 deletions(-)
 create mode 100644 drivers/misc/lkdtm/stackleak.c
 create mode 100644 include/linux/stackleak.h
 create mode 100644 kernel/stackleak.c
 create mode 100644 scripts/gcc-plugins/Kconfig
 create mode 100644 scripts/gcc-plugins/stackleak_plugin.c

-- 
Kees Cook
Pixel Security
