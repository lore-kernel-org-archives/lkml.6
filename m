Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7DAC46463
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A84120841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 00:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nBg3Sls5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A84120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbeJKHpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 03:45:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41075 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeJKHnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 03:43:32 -0400
Received: by mail-pl1-f194.google.com with SMTP id q17-v6so3292732plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 17:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9GY5AAtvgERP9oXXXvNWwxszGskNOVj+UIOqYG1mWT4=;
        b=nBg3Sls5Z3QZe9XWkZqca0LuWRKb1PHQuGI1mpzyAwYcE+iO+N8qUB1nxF33+Yj863
         Bv5jHjnwmW89bQgrGquTsGsMhMOnUeIPU/0X4dpW1KwSedYJvV5zauhIPblXo2ssusO3
         ZqK97S6z8l/D90mCqL9i7cxsZiDygEkmDBexY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9GY5AAtvgERP9oXXXvNWwxszGskNOVj+UIOqYG1mWT4=;
        b=cAEE5L7OmzIlpsB3g49pUtRvZe3nYh2LuBe50otKY2yKazkP8TY4nvNbBDeUCIoGY5
         OILCCAwckoFGt333lUpAuaYpfAgJmAkyi8qIH5GvEB1DUo7ET/Rjzs1EM4rGSBvsA4Lw
         rKoJZONiBy9GAP6m3W6I/WnN2gHGjivHJ3n8dUxPLWyqfPUdhS01y3/QSSnjvSjQjuvN
         b8cerSyzpSeKuGWlnKmkrg0p/wpI17z2UC/2T4phP9mfAKhw1ssS3ZUAtVTX6ZvnZwdI
         kmm5RI8JcXlWmnYBVzweJcB3ipiUtEHntNTYAgTQ2kSQoiwEXoqzSz5mDgD/eaLXtsDS
         ZR9w==
X-Gm-Message-State: ABuFfoi28Yixa85X823UO/SaGE/ISjan9UIxu11p1uvYhplsIPqCZXxn
        To0qVa8jHzXXo4LC4kGWEwqTFg==
X-Google-Smtp-Source: ACcGV60WG1I2OSE+YModul0Tof7aZyUtVjDcmjUucL/tLqC0qB0Gj1TnKO7Wnc4PnpX2GX3nbaIaLw==
X-Received: by 2002:a17:902:5e3:: with SMTP id f90-v6mr34463242plf.222.1539217137900;
        Wed, 10 Oct 2018 17:18:57 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id t11-v6sm32243397pgn.38.2018.10.10.17.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 17:18:52 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH security-next v5 00/30] LSM: Explict ordering
Date:   Wed, 10 Oct 2018 17:18:16 -0700
Message-Id: <20181011001846.30964-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5:
- redesigned to use CONFIG_LSM= and lsm= for both ordering and enabling
- dropped various Reviewed-bys due to rather large refactoring

v4:
- add Reviewed-bys.
- cosmetic tweaks.
- New patches to fully centralize LSM "enable" decisions:
    LSM: Finalize centralized LSM enabling logic
    apparmor: Remove boot parameter
    selinux: Remove boot parameter

v3:
- add CONFIG_LSM_ENABLE and refactor resulting logic

v2:
- add "lsm.order=" and CONFIG_LSM_ORDER instead of overloading "security="
- reorganize introduction of ordering logic code

Overview:

This refactors the LSM registration and initialization infrastructure to
more centrally support different LSM types for more cleanly supporting the
future expansion of LSM stacking via the "blob-sharing" patch series. What
was considered a "major" LSM is kept for legacy use of the "security="
boot parameter, and now overlaps with the new class of "exclusive" LSMs
for the future blob sharing. The "minor" LSMs become more well defined
as a result of the refactoring.

Approach:

To better show LSMs activation some debug reporting was added (enabled
with the "lsm.debug" boot commandline option).

I added a WARN() around LSM initialization failures, which appear to
have always been silently ignored. (Realistically any LSM init failures
would have only been due to catastrophic kernel issues that would render
a system unworkable anyway, but it'd be better to expose the problem as
early as possible.)

Instead of continuing to (somewhat improperly) overload the kernel's
initcall system, this changes the LSM infrastructure to store a
registration structure (struct lsm_info) table instead, where metadata
about each LSM can be recorded (name, flags, order, enable flag, init
function). This can be extended in the future to include things like
required blob size for the coming "blob sharing" LSMs.

The "major" LSMs had to individually negotiate which of them should be
enabled. This didn't provide a way to negotiate combinations of other
LSMs (as will be needed for "blob sharing" LSMs). This is solved by
providing the LSM infrastructure with all the details needed to make
the choice (exposing the per-LSM "enabled" flag, if used, the LSM
characteristics, and ordering expectations).

As a result of the refactoring, the "minor" LSMs are able to remove
the open-coded security_add_hooks() calls for "capability", "yama",
and "loadpin", and to redefine "integrity" properly as a general LSM.
(Note that "integrity" actually defined _no_ hooks, but needs the early
initialization).

With all LSMs being proessed centrally, it was possible to implement a
new boot parameter "lsm=" to provide explicit ordering, which is helpful
for the future "blob sharing" LSMs. Matching this is the new CONFIG_LSM,
which effectively replaces CONFIG_DEFAULT_SECURITY, as it provides a
higher granularity of control.


Breakdown of patches:

Infrastructure improvements (no logical changes):
  LSM: Correctly announce start of LSM initialization
  vmlinux.lds.h: Avoid copy/paste of security_init section
  LSM: Rename .security_initcall section to .lsm_info
  LSM: Remove initcall tracing
  LSM: Convert from initcall to struct lsm_info
  vmlinux.lds.h: Move LSM_TABLE into INIT_DATA
  LSM: Convert security_initcall() into DEFINE_LSM()
  LSM: Record LSM name in struct lsm_info
  LSM: Provide init debugging infrastructure
  LSM: Don't ignore initialization failures

Split "integrity" out into "ordered initialization" (no logical changes):
  LSM: Introduce LSM_FLAG_LEGACY_MAJOR
  LSM: Provide separate ordered initialization

Provide centralized LSM enable/disable infrastructure:
  LoadPin: Rename boot param "enabled" to "enforce"
  LSM: Plumb visibility into optional "enabled" state
  LSM: Lift LSM selection out of individual LSMs

Provide centralized LSM ordering infrastructure:
  LSM: Build ordered list of LSMs to initialize
  LSM: Introduce CONFIG_LSM
  LSM: Introduce "lsm=" for boottime LSM selection
  LSM: Tie enabling logic to presence in ordered list

Refactor legacy "security=" handling to map to new infrastructure:
  LSM: Prepare for reorganizing "security=" logic
  LSM: Refactor "security=" in terms of enable/disable

Move major LSMs into ordered initialization:
  LSM: Separate idea of "major" LSM from "exclusive" LSM
  apparmor: Remove SECURITY_APPARMOR_BOOTPARAM_VALUE
  selinux: Remove SECURITY_SELINUX_BOOTPARAM_VALUE
  LSM: Add all exclusive LSMs to ordered initialization
  LSM: Split LSM preparation from initialization

Move minor LSMs into ordered initialization:
  LoadPin: Initialize as ordered LSM
  Yama: Initialize as ordered LSM
  LSM: Introduce enum lsm_order
  capability: Initialize as LSM_ORDER_FIRST


-Kees

 .../admin-guide/kernel-parameters.txt         |   6 +
 arch/arc/kernel/vmlinux.lds.S                 |   1 -
 arch/arm/kernel/vmlinux-xip.lds.S             |   1 -
 arch/arm64/kernel/vmlinux.lds.S               |   1 -
 arch/h8300/kernel/vmlinux.lds.S               |   1 -
 arch/microblaze/kernel/vmlinux.lds.S          |   2 -
 arch/powerpc/kernel/vmlinux.lds.S             |   2 -
 arch/um/include/asm/common.lds.S              |   2 -
 arch/xtensa/kernel/vmlinux.lds.S              |   1 -
 include/asm-generic/vmlinux.lds.h             |  25 +-
 include/linux/init.h                          |   2 -
 include/linux/lsm_hooks.h                     |  36 ++-
 include/linux/module.h                        |   1 -
 security/Kconfig                              |  41 +--
 security/apparmor/Kconfig                     |  16 -
 security/apparmor/lsm.c                       |  17 +-
 security/commoncap.c                          |   9 +-
 security/integrity/iint.c                     |   6 +-
 security/loadpin/Kconfig                      |   4 +-
 security/loadpin/loadpin.c                    |  29 +-
 security/security.c                           | 288 ++++++++++++++----
 security/selinux/Kconfig                      |  15 -
 security/selinux/hooks.c                      |  22 +-
 security/smack/smack_lsm.c                    |   9 +-
 security/tomoyo/tomoyo.c                      |   8 +-
 security/yama/yama_lsm.c                      |   8 +-
 26 files changed, 343 insertions(+), 210 deletions(-)

-- 
2.17.1

