Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A0EC4161C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA9E21477
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 00:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ePl5RNm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA9E21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeIPFwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 01:52:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36395 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbeIPFwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 01:52:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id p5-v6so5790324plk.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Sep 2018 17:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=i0TC8sRNqqnjqDN9Ck/AhonvLtsBU122kr0QiQGjOQA=;
        b=ePl5RNm3/h4veWpl3e0x7EEIzRLnec7ruRJu68IJVAKYQcWKV2TCtML0RnXSpEImVL
         fiCgaw/Lx1V149j5VPrLe6t2ylYql6okA3sqYNWTn/Lvqa+ffTTNl72wvxxo9z2GwjWp
         SZB6XWmGUqsm/N+qm/G2RDYza/wgl6PsR3xaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=i0TC8sRNqqnjqDN9Ck/AhonvLtsBU122kr0QiQGjOQA=;
        b=pTRmyJqUKmat9cyyCyGFyd41DidbU5J9d76Ie+P3pUVQeVUhQb26XT65Mgr10XwN29
         I7Xd0wsA/BaPdSkdpfojBnrxoWsfzGnX5l2OuP2gJFIRaWLAv9KkvH5XCN6Md78TeYVo
         kOlQYECWgO2JToetfCpWrcry/Ls/ujKkJEQl4uvSFqwMyLnkKfoX/eX3zqCiMNgoLlG+
         JoldJykLwj09lZPJ0wtDFY1Bask+qOvtHHVZrCQoioNO99AhzxLgdi8q/69gAqCzjJjH
         ZUhPG4C6RTV3XF4CwiqbxJN+J96BG3mLTHJHZ1Z/2DT34lBFK+zkpQ6DDnYKyzYWSg4a
         rsrA==
X-Gm-Message-State: APzg51AsIitSmtWrhRjLIbSZygZZmfP9N5e3ZKFHaZ7C7BlkjOiDLxAZ
        Q0WwB+1sHkodc3aJZasLH1kbqQ==
X-Google-Smtp-Source: ANB0Vdb09T6FIfyPWR5q3uPJAAqp/6briGEdnaTwwyIfui1F2c/am6aBQeGMHrKANbO8krF5xHdysA==
X-Received: by 2002:a17:902:d808:: with SMTP id a8-v6mr18596187plz.68.1537057868287;
        Sat, 15 Sep 2018 17:31:08 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id h132-v6sm15349697pfc.100.2018.09.15.17.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 17:31:03 -0700 (PDT)
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
        LKLM <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/18] LSM: Prepare for explict LSM ordering
Date:   Sat, 15 Sep 2018 17:30:41 -0700
Message-Id: <20180916003059.1046-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This refactors the LSM registration and initialization infrastructure
to more centrally support different LSM types. What was considered a
"major" LSM is split into "exclusive" and future "blob sharing" (to be
added later). The "minor" LSMs become more well defined as a result.

Instead of continuing to (somewhat improperly) overload the kernel's
initcall system, this changes the LSM infrastructure to store a
registration structure (struct lsm_info) table instead, where metadata
about each LSM can be recorded (name, type, order, enable flag, init
function). This can be extended in the future to include things like
required blob size for the coming "blob sharing" LSMs.

The "major" LSMs had to individually negotiate which of them should be
enabled. This didn't provide a way to negotiate combinations of other
LSMs (as will be needed for "blob sharing" LSMs). This is solved by
providing the LSM infrastructure with all the details needed to make
the choice (exposing the per-LSM "enabled" flag, if used, the LSM type,
and ordering expectations).

In better defining the "minor" LSMs, it was possible to remove the
open-coded security_add_hooks() calls for "capability", "yama", and
"loadpin", and to redefine "integrity" properly as a "minor" LSM (it
actually defines _no_ hooks, but needs the early initialization).

With all LSMs being proessed centrally, it was possible to implement
sensible parsing of the "security=" boot commandline argument to provide
explicit ordering, which is helpful for the future "blob sharing" LSMs.

To better show LSMs activation some debug reporting was added (enabled
with the "lsm.debug" boot commandline option).

Finally, I added a WARN() around LSM initialization failures, which
appear to have always been silently ignored. (Realistically any LSM init
failures would have only been due to catastrophic kernel issues that
would render a system unworkable anyway, but it'd be better to expose
the problem as early as possible.)

-Kees

Kees Cook (18):
  vmlinux.lds.h: Avoid copy/paste of security_init section
  LSM: Rename .security_initcall section to .lsm_info
  LSM: Remove initcall tracing
  LSM: Convert from initcall to struct lsm_info
  vmlinux.lds.h: Move LSM_TABLE into INIT_DATA
  LSM: Convert security_initcall() into DEFINE_LSM()
  LSM: Add minor LSM initialization loop
  integrity: Initialize as LSM_TYPE_MINOR
  LSM: Record LSM name in struct lsm_info
  LSM: Plumb visibility into optional "enabled" state
  LSM: Lift LSM selection out of individual LSMs
  LSM: Introduce ordering details in struct lsm_info
  LoadPin: Initialize as LSM_TYPE_MINOR
  Yama: Initialize as LSM_TYPE_MINOR
  capability: Initialize as LSM_TYPE_MINOR
  LSM: Allow arbitrary LSM ordering
  LSM: Provide init debugging
  LSM: Don't ignore initialization failures

 .../admin-guide/kernel-parameters.txt         |  15 +-
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
 include/linux/lsm_hooks.h                     |  45 +++-
 include/linux/module.h                        |   1 -
 security/apparmor/lsm.c                       |  15 +-
 security/commoncap.c                          |   9 +-
 security/integrity/iint.c                     |   6 +-
 security/loadpin/loadpin.c                    |  11 +-
 security/security.c                           | 252 ++++++++++++++----
 security/selinux/hooks.c                      |  15 +-
 security/smack/smack_lsm.c                    |   7 +-
 security/tomoyo/tomoyo.c                      |   6 +-
 security/yama/yama_lsm.c                      |   8 +-
 22 files changed, 295 insertions(+), 133 deletions(-)

-- 
2.17.1

