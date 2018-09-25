Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6DCC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B566206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kmP8tlJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B566206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbeIYGX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:23:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38020 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbeIYGX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:23:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so9916961pfh.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lbJmJEKFJU90Os6l9fc3VI1ZSjEbBl90bdrIJ+lgVE8=;
        b=kmP8tlJqLwvjPkKqptPdC8VP3HxudgJ3pArhwbMnFKZu9oqfDGUBOFm1TbW26uw0Mp
         2D+k67wKSnSLvTAJiDPFfwpfMOP2KUJDNxYHm2uqOwxv9xZjLTvc6GONRrpSjUXTGOPg
         SfvREXysjXVi5GLrh164KRLIGInUdbHIZe5bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lbJmJEKFJU90Os6l9fc3VI1ZSjEbBl90bdrIJ+lgVE8=;
        b=gslBuhrYymQC+viyhGL/9/jl7oNo81TirrJvmLVZR+lb4VkGZhPaLk8gjdyG2t3+lA
         yB7Gzczl/bssGqY2CzROXXb7oc7+Yx0/kKl6rw79xhgnvlUrtVeMb9obg9TsqYQpGM8Z
         4fGeOIoRI5F0hITHH78Xm/uN/BN5hqM5BCDE9/fasMVJZ2HLJEKi/lLJktboP8eDbJUs
         43vZMi6YuDGDgfPe40STyzNi4whaa8XrNIIuI/BDVNfyFsQz9UcLY5TJBFzbrIsYY8Rp
         Eev38ROKfYn6k0PaPvdze3yh+BiWRRg0ietiDrFWGbdjuEY4F6cTv9Vr1UcZKCMGStpc
         /2Lg==
X-Gm-Message-State: ABuFfoiYZVFGI/mYhh5CBVPu03dA6BIangLdIFODAFjNVxfjiXfG8/Y7
        pwkSTKy1eB0fJOBK+TAlsKZEeA==
X-Google-Smtp-Source: ACcGV61dfLyt93rKYxrH2+Hg1g98JNOSfAgdUguUBVGpH/ytCHZI3dbGhoIUol85k6SpWH7hjTUJKQ==
X-Received: by 2002:a63:5c5d:: with SMTP id n29-v6mr917110pgm.253.1537834721126;
        Mon, 24 Sep 2018 17:18:41 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id x4-v6sm518099pfm.119.2018.09.24.17.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 17:18:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH security-next v3 00/29] LSM: Explict LSM ordering
Date:   Mon, 24 Sep 2018 17:18:03 -0700
Message-Id: <20180925001832.18322-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

With all LSMs being proessed centrally, it was possible to implement
a new boot parameter "lsm.order=" to provide explicit ordering, which
is helpful for the future "blob sharing" LSMs. Matching this is the
new CONFIG_LSM_ORDER, which replaces CONFIG_DEFAULT_SECURITY, as it
provides a higher granularity of control.

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
  LoadPin: Rename "enable" to "enforce"
  LSM: Plumb visibility into optional "enabled" state
  LSM: Lift LSM selection out of individual LSMs
  LSM: Prepare for arbitrary LSM enabling
  LSM: Introduce CONFIG_LSM_ENABLE
  LSM: Introduce lsm.enable= and lsm.disable=
  LSM: Prepare for reorganizing "security=" logic
  LSM: Refactor "security=" in terms of enable/disable

Provide centralized LSM ordering infrastructure:
  LSM: Build ordered list of ordered LSMs for init
  LSM: Introduce CONFIG_LSM_ORDER
  LSM: Introduce "lsm.order=" for boottime ordering

Move minor LSMs into ordered LSM initialization:
  LoadPin: Initialize as ordered LSM
  Yama: Initialize as ordered LSM
  LSM: Introduce enum lsm_order
  capability: Initialize as LSM_ORDER_FIRST

Move major LSMs into ordered LSM initialization:
  LSM: Separate idea of "major" LSM from "exclusive" LSM
  LSM: Add all exclusive LSMs to ordered initialization

-Kees

 .../admin-guide/kernel-parameters.txt         |  20 +
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
 include/linux/lsm_hooks.h                     |  43 ++-
 include/linux/module.h                        |   1 -
 security/Kconfig                              |  61 ++-
 security/apparmor/lsm.c                       |  16 +-
 security/commoncap.c                          |   8 +-
 security/integrity/iint.c                     |   5 +-
 security/loadpin/Kconfig                      |   4 +-
 security/loadpin/loadpin.c                    |  28 +-
 security/security.c                           | 351 +++++++++++++++---
 security/selinux/hooks.c                      |  16 +-
 security/smack/smack_lsm.c                    |   8 +-
 security/tomoyo/tomoyo.c                      |   7 +-
 security/yama/yama_lsm.c                      |   7 +-
 24 files changed, 438 insertions(+), 175 deletions(-)

-- 
2.17.1
