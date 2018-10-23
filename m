Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95A4C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C1520665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C1520665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbeJWRpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:45:10 -0400
Received: from namei.org ([65.99.196.166]:47806 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727714AbeJWRpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:45:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w9N9MaIE019327;
        Tue, 23 Oct 2018 09:22:36 GMT
Date:   Tue, 23 Oct 2018 20:22:36 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] security: general updates for 4.20
Message-ID: <alpine.LRH.2.21.1810232013020.19032@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these general updates for the security subsystem.

In this patchset, there are a couple of minor updates, as well as some 
reworking of the LSM initialization code from Kees Cook (these prepare the 
way for ordered stackable LSMs, but are a valuable cleanup on their own).

---

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

for you to fetch changes up to 3f6caaf5ff33073ca1a3a0b82edacab3c57c38f9:

  LSM: Don't ignore initialization failures (2018-10-10 20:40:22 -0700)

----------------------------------------------------------------
Christian Brauner (1):
      security/capabilities: remove check for -EINVAL

David Howells (1):
      keys: Fix the use of the C++ keyword "private" in uapi/linux/keyctl.h

Ding Xiang (1):
      security: tomoyo: Fix obsolete function

Igor Stoppa (1):
      seccomp: remove unnecessary unlikely()

James Morris (1):
      Merge tag 'v4.19-rc2' into next-general

Kees Cook (10):
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

Randy Dunlap (1):
      security: fix LSM description location

 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 Documentation/security/LSM.rst                  |  2 +-
 arch/arc/kernel/vmlinux.lds.S                   |  1 -
 arch/arm/kernel/vmlinux-xip.lds.S               |  1 -
 arch/arm64/kernel/vmlinux.lds.S                 |  1 -
 arch/h8300/kernel/vmlinux.lds.S                 |  1 -
 arch/microblaze/kernel/vmlinux.lds.S            |  2 --
 arch/powerpc/kernel/vmlinux.lds.S               |  2 --
 arch/um/include/asm/common.lds.S                |  2 --
 arch/xtensa/kernel/vmlinux.lds.S                |  1 -
 include/asm-generic/vmlinux.lds.h               | 25 +++++++-------
 include/linux/init.h                            |  2 --
 include/linux/lsm_hooks.h                       | 12 +++++++
 include/linux/module.h                          |  1 -
 include/uapi/linux/keyctl.h                     |  7 +++-
 kernel/seccomp.c                                |  4 +--
 security/apparmor/lsm.c                         |  5 ++-
 security/commoncap.c                            |  3 --
 security/integrity/iint.c                       |  6 +++-
 security/security.c                             | 43 ++++++++++++++++---------
 security/selinux/hooks.c                        |  5 ++-
 security/smack/smack_lsm.c                      |  5 ++-
 security/tomoyo/common.c                        |  3 +-
 security/tomoyo/tomoyo.c                        |  5 ++-
 24 files changed, 84 insertions(+), 57 deletions(-)
