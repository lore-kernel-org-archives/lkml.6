Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0153CECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B24F52082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PbxHsQ3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24F52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeJYDne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:43:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34340 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeJYDnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:43:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id g12-v6so2791230pgs.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 12:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=eeN36ZCceTU17cQgP4onUHjrc2fnpb5nBKf0P5xP0CE=;
        b=PbxHsQ3MQAJB010EdEHXs7ksKAXRTUskPRFX3bhuBP3QFZG1eqHN5HKoZ6nkbVr+aV
         iUaMfaiEysEMOGcHQdsBX21cVxhh3wGBfP3TC1giZtVJ4W9RKOnp12MY26qO06Gufi0J
         jfn34EV4/LZJA9TrYmiOIfym5yMObuZ59i2PM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=eeN36ZCceTU17cQgP4onUHjrc2fnpb5nBKf0P5xP0CE=;
        b=GsEv9qRRZvCQ9Xd7KMhUgH3RZqOroBz0rBtme/XUbPI4Ca0v2IpcNn8w7lwYho2YVo
         pSnuYgNxkcwLoKeXyAJRVkb/UJZhuLoHYsVjCT5KoJvMJCQo938iq+E56dfwkszeNarg
         TMYIkrlUT1wmZkA4yhFpX1u+wzp9cMr/XJ5kNE+G1BnikWi/Xn41XSFhVp3UTi/Pis56
         obzUF8VR7PHcPUViq4QKf3h9bBIddBnHTJBdyX0uN2G7jmwdOFs93Oy+dRmbYZ9iMsLV
         KKFmRRQKHPGOs+1OrECH5oKfRSfYH56jUshkH5EIT8ivfG8mgPoEUJP/54phUITSBL92
         4O9Q==
X-Gm-Message-State: AGRZ1gISxTdv0sRJ4KUZ491ev5HQPLOhHeYvOGI9TqDUeRwZ83vZ3TTS
        HwdFJQDSa1XsGyJcYUii53DMog==
X-Google-Smtp-Source: AJdET5faRhL52KGEiMIp0HfN10P/N+gxwWKVajVOOJAJxMWVenxFOblZROJe3SPTTufel/LT2nLT8g==
X-Received: by 2002:a63:194a:: with SMTP id 10-v6mr3720012pgz.192.1540408456781;
        Wed, 24 Oct 2018 12:14:16 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id u124-v6sm15803770pgc.0.2018.10.24.12.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 12:14:15 -0700 (PDT)
Date:   Wed, 24 Oct 2018 12:14:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>
Subject: [GIT PULL] gcc-plugin stackleak for v4.20-rc1
Message-ID: <20181024191413.GA24294@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this new GCC plugin, stackleak, for v4.20-rc1. This plugin
was ported from grsecurity by Alexander Popov. It provides efficient
stack content poisoning at syscall exit. This creates a defense against
at least two classes of flaws:

- Uninitialized stack usage. (We continue to work on improving the
  compiler to do this in other ways: e.g. unconditional zero init was
  proposed to GCC and Clang, and more plugin work has started too).

- Stack content exposure. By greatly reducing the lifetime of valid stack
  contents, exposures via either direct read bugs or unknown cache
  side-channels become much more difficult to exploit. This complements
  the existing buddy and heap poisoning options, but provides the coverage
  for stacks.

The x86 hooks are included in this series (which have been reviewed by
Ingo, Dave Hansen, and Thomas Gleixner). The arm64 hooks have already
been merged through the arm64 tree (written by Laura Abbott and reviewed
by Mark Rutland and Will Deacon).

With VLAs being removed this release (the final "-Wvla" patch is waiting
for the crypto, powerpc, and block trees to land in the merge window),
there is no need for alloca() protection, so it has been removed from
the plugin.

There is no use of BUG() or panic() (in fact, since the alloca()
protection has been removed, the arm64 hook using them is removed
as well).

There are two merge conflicts:

  drivers/misc/lkdtm/core.c: Trivial addition of a new test.

  Documentation/x86/x86_64/mm.txt: Looks nasty, but is actually trivial.
  The memory layout tables were rewritten, so the two additions of
  "STACKLEAK_POISON value in this last hole: ffffffffffff4111" just
  belong at the end of the newly reformatted tables.

Thanks!

-Kees

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/stackleak-v4.20-rc1

for you to fetch changes up to 6fcde90466738b84a073e4f4d18c50015ee29fb2:

  arm64: Drop unneeded stackleak_check_alloca() (2018-09-04 10:35:48 -0700)

----------------------------------------------------------------
New gcc plugin: stackleak

- Introduces the stackleak gcc plugin ported from grsecurity by Alexander
  Popov, with x86 and arm64 support.

----------------------------------------------------------------
Alexander Popov (7):
      x86/entry: Add STACKLEAK erasing the kernel stack at the end of syscalls
      gcc-plugins: Add STACKLEAK plugin for tracking the kernel stack
      lkdtm: Add a test for STACKLEAK
      fs/proc: Show STACKLEAK metrics in the /proc file system
      doc: self-protection: Add information about STACKLEAK feature
      stackleak: Allow runtime disabling of kernel stack erasing
      arm64: Drop unneeded stackleak_check_alloca()

 Documentation/security/self-protection.rst |  10 +-
 Documentation/sysctl/kernel.txt            |  18 ++
 Documentation/x86/x86_64/mm.txt            |   2 +
 arch/Kconfig                               |   7 +
 arch/arm64/kernel/process.c                |  22 --
 arch/x86/Kconfig                           |   1 +
 arch/x86/entry/calling.h                   |  14 +
 arch/x86/entry/entry_32.S                  |   7 +
 arch/x86/entry/entry_64.S                  |   3 +
 arch/x86/entry/entry_64_compat.S           |   5 +
 drivers/misc/lkdtm/Makefile                |   2 +
 drivers/misc/lkdtm/core.c                  |   1 +
 drivers/misc/lkdtm/lkdtm.h                 |   3 +
 drivers/misc/lkdtm/stackleak.c             |  73 +++++
 fs/proc/base.c                             |  18 ++
 include/linux/sched.h                      |   5 +
 include/linux/stackleak.h                  |  35 +++
 kernel/Makefile                            |   4 +
 kernel/fork.c                              |   3 +
 kernel/stackleak.c                         | 132 +++++++++
 kernel/sysctl.c                            |  15 +-
 scripts/Makefile.gcc-plugins               |  10 +
 scripts/gcc-plugins/Kconfig                |  51 ++++
 scripts/gcc-plugins/stackleak_plugin.c     | 427 +++++++++++++++++++++++++++++
 24 files changed, 840 insertions(+), 28 deletions(-)
 create mode 100644 drivers/misc/lkdtm/stackleak.c
 create mode 100644 include/linux/stackleak.h
 create mode 100644 kernel/stackleak.c
 create mode 100644 scripts/gcc-plugins/stackleak_plugin.c

-- 
Kees Cook
