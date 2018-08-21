Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47A7C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C1E21837
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KvH0TmmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C1E21837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbeHUV1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 17:27:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40804 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbeHUV1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 17:27:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id e13-v6so8862464pff.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=UIbUC/2lQFMvkO9HiQRL6dZwTsJHiGvbUOSRz6R0zG4=;
        b=KvH0TmmCT0GEH8nulIcJiXGYVQXZV9ytNCsWrcKp2izdupjJjfWY6XD/kZtXhJljxB
         apeHc0XQQMkvjWXZdKgHUWgM+32x2esTqIgw0Dt7HVdU9U1Wnio74IV1YWZrSeIhku29
         4+0K7ENSD+wh8eYNt17YwvWI/d8PuMxOy3IDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=UIbUC/2lQFMvkO9HiQRL6dZwTsJHiGvbUOSRz6R0zG4=;
        b=jZ0Sa8S8CJ+LYCvfyhhrCnkpXEkDg0iyG1iJI5AJc+I2/g2DDoVPfX9aTdebS97xZF
         p4U0INoLGZg2FAfXq+XV5TiUkpyRxxmkdYd9n/hJENDxtVkL5BukzvP+ka92+RDNNKC7
         RztdylzztDBnWWm6aNfZxiYl+MAnChuWNJSXP8xSlmagN32bE9tBFR9vlVs9NHYx2pcz
         9bir4KKRoeA0GD/cV8v9orw1eOz7MTi6jAPusjxWlcncfDLcBg07BTESIC75OxI7zM6v
         lomiTkrqtV/NBRyz79SBZOQjOzP4QlKVioZ9BvpQyk4pPi/QeEy4LjLjKeHsQhdNviIm
         82ag==
X-Gm-Message-State: AOUpUlESDL/6Qgk4cP559qjBN3GgKlkNWqBTBniBT2McxtCFpawfUrSa
        1E2ddJerRz5rkwQv4xTDjyaBhg==
X-Google-Smtp-Source: AA+uWPwbjo+MOgh/dvyzpM1B3EkeMxeLFWsEeXasJI2XSPCiSth1M7fCur9ovzYa+a70opsltoZAxQ==
X-Received: by 2002:a63:e457:: with SMTP id i23-v6mr48673763pgk.127.1534874780674;
        Tue, 21 Aug 2018 11:06:20 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id o10-v6sm32207115pfk.76.2018.08.21.11.06.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 11:06:19 -0700 (PDT)
Date:   Tue, 21 Aug 2018 11:06:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>
Subject: [GIT PULL] stackleak plugin for v4.19-rc1 (take 2)
Message-ID: <20180821180617.GA42042@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this corrected stackleak plugin for v4.19-rc1. The appropriate
Monty Python quote for this could be: "pull the other one"[1]. :)

This version has all the alloca() detection/checking code removed (which
removes both the x86 and arm64 BUG() usage) since we have almost finished
eradicating VLAs from the kernel. Additionally, the stack_erase() BUG()
has been removed by shifting the test to an earlier and recoverable
location.

The earlier plugin has been in -next for about two development cycles,
and this reduced version has had a further 5 days.


Notes edited down from the first pull request: this is the STACKLEAK
plugin ported by Alexander Popov. It provides efficient stack content
poisoning at syscall exit. This creates a defense against at least two
classes of flaws:

- uninitialized stack usage (while we continue to work on improving the
  compiler to do this in other ways: e.g. unconditional zero init was
  proposed to gcc and clang, and more plugin work has started too)

- stack content exposure (by greatly reducing the lifetime of valid stack
  contents, exposures via either direct read bugs or unknown cache
  side-channels become much more difficult to exploit. This complements
  the existing buddy and heap poisoning options, but provides the coverage
  for stacks)

The x86 hooks are included in this series (which have been reviewed by
Ingo, Dave Hansen, and Thomas Gleixner), and have hopefully addressed
your concerns with regard to the size of assembly changes which are now
minimal. The arm64 hooks have already been merged through the arm64 tree
(written by Laura Abbott and reviewed by Mark Rutland and Will Deacon).

Thanks!

-Kees

[1] https://www.youtube.com/watch?v=JHFXG3r_0B8#t=27

The following changes since commit 5c60a7389d795e001c8748b458eb76e3a5b6008c:

  Merge tag 'for-linus-4.19-ofs1' of git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux (2018-08-16 10:53:45 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/stackleak-plugin-v4.19-rc1

for you to fetch changes up to de75c4d4bdfc84b07c597239edd3f26117a841e8:

  arm64: Drop unneeded stackleak_check_alloca() (2018-08-21 10:40:52 -0700)

----------------------------------------------------------------
Stackleak GCC plugin:

- Stackleak GCC plugin, x86 support, test, docs, knob (Alexander Popov)

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
Pixel Security
