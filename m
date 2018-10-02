Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A88C00449
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAF221471
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 00:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WsnlpMzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BAF221471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeJBHfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:35:43 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38053 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeJBHfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:35:42 -0400
Received: by mail-io1-f67.google.com with SMTP id y3-v6so252846ioc.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 17:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ktt3JW7jGajBPkbbI86StPv6XdFH/coirzVsiU2QTCI=;
        b=WsnlpMzijI+cNWStBdptmpOPjCjntMQWOfaJ7G9i5XCOtEWeQGJ1kkOABZQWNyu6vY
         /cWurmB5WQzqL82Zc+62wsVK0lkBUTkLVPsu4jsVPd8y/OASeyExCtGSF2luoQY+FK9S
         mx7usAq9lT2DTCSDVJtuTOwamo3bkFP9lvCRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ktt3JW7jGajBPkbbI86StPv6XdFH/coirzVsiU2QTCI=;
        b=k8T5l1eq4O1mOEi73iYhmDNvDy0LoeGY03i8r92x7OEWpq0MqyQVoiJIzrTlEQbUP5
         fRLfzln5PJqmEGrslY+K6r5Dj21650sazVxqRlH7UhLHB5SjMpNio2enw1c5WB6c0wjf
         h6Xjf0jB3v8Scbd863wYo057RqWWT8okLB+6sAdFuTC0RLVtkBACbxUfSd9siDy0Ab3G
         p5NfWpX5A1q2g/NE7Y6qiaLBYktvObwcl6Gw9g1j7+7nTF9wJuSHLmNqA144UssfsZj2
         xQV4Ymm5ZjyIAAWEQfbYedHRu3dtodvie80kypwt0YEU6AQUMBb0BOXtVpB4yADzaXfj
         3UBQ==
X-Gm-Message-State: ABuFfogL09OdzJS+oKdl2Pi6ZX79ksdmACZ1sfJQfZaI7+atTU/38fcB
        XO4gbf5PlYupwSugrD2BANyGcQ==
X-Google-Smtp-Source: ACcGV61WlLOZVFk1/m2qEStw++h04w6VcNpbkgAorONOYszqy4VpKm9PQbU14j5TJ9h8dPApWps6dA==
X-Received: by 2002:a17:902:14d:: with SMTP id 71-v6mr13848665plb.146.1538441713455;
        Mon, 01 Oct 2018 17:55:13 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id s14-v6sm15958720pgv.29.2018.10.01.17.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 17:55:08 -0700 (PDT)
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
Subject: [PATCH security-next v4 00/32] LSM: Explict LSM ordering
Date:   Mon,  1 Oct 2018 17:54:33 -0700
Message-Id: <20181002005505.6112-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
  LSM: Finalize centralized LSM enabling logic
  apparmor: Remove boot parameter
  selinux: Remove boot parameter

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

 .../admin-guide/kernel-parameters.txt         |  34 +-
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
 include/linux/lsm_hooks.h                     |  37 +-
 include/linux/module.h                        |   1 -
 security/Kconfig                              |  61 ++--
 security/apparmor/Kconfig                     |  16 -
 security/apparmor/lsm.c                       |  22 +-
 security/commoncap.c                          |   9 +-
 security/integrity/iint.c                     |   6 +-
 security/loadpin/Kconfig                      |   4 +-
 security/loadpin/loadpin.c                    |  29 +-
 security/security.c                           | 343 +++++++++++++++---
 security/selinux/Kconfig                      |  29 --
 security/selinux/hooks.c                      |  32 +-
 security/smack/smack_lsm.c                    |   9 +-
 security/tomoyo/tomoyo.c                      |   8 +-
 security/yama/yama_lsm.c                      |   8 +-
 26 files changed, 432 insertions(+), 254 deletions(-)

-- 
2.17.1

