Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C1CC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82B52175D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82B52175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731520AbeHNBgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:36:11 -0400
Received: from namei.org ([65.99.196.166]:43056 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730203AbeHNBgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:36:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w7DMpqXU003050;
        Mon, 13 Aug 2018 22:51:52 GMT
Date:   Tue, 14 Aug 2018 08:51:52 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] security subsystem: general update for v4.19
Message-ID: <alpine.LRH.2.21.1808140835030.2526@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull these general updates for v4.19.

Summary:

- kstrdup() return value fix from Eric Biggers

- Add new security_load_data hook to differentiate security checking of 
kernel-loaded binaries in the case of there being no associated file 
descriptor, from Mimi Zohar.

- Add ability to IMA to specify a policy at build-time, rather than just 
via command line params or by loading a custom policy, from Mimi.

- Allow IMA and LSMs to prevent sysfs firmware load fallback (e.g. if 
using signed firmware), from Mimi.

- Allow IMA to deny loading of kexec kernel images, as they cannot be 
measured by IMA, from Mimi.


I'll followup with updates for Smack and TPM once this is merged.


---

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

for you to fetch changes up to 87ea58433208d17295e200d56be5e2a4fe4ce7d6:

  security: check for kstrdup() failure in lsm_append() (2018-07-17 21:27:06 -0700)

----------------------------------------------------------------
Arnd Bergmann (1):
      security: export security_kernel_load_data function

Eric Biggers (1):
      security: check for kstrdup() failure in lsm_append()

James Morris (1):
      Merge tag 'v4.18-rc2' into next-general

Mimi Zohar (8):
      security: define new LSM hook named security_kernel_load_data
      kexec: add call to LSM hook in original kexec_load syscall
      ima: based on policy require signed kexec kernel images
      firmware: add call to LSM hook before firmware sysfs fallback
      ima: based on policy require signed firmware (sysfs fallback)
      ima: add build time policy
      module: replace the existing LSM hook in init_module
      ima: based on policy warn about loading firmware (pre-allocated buffer)

Paul Moore (1):
      MAINTAINERS: remove the outdated "LINUX SECURITY MODULE (LSM) FRAMEWORK" entry

 MAINTAINERS                             |  5 ---
 drivers/base/firmware_loader/fallback.c |  7 ++++
 include/linux/ima.h                     |  7 ++++
 include/linux/lsm_hooks.h               |  6 +++
 include/linux/security.h                | 27 +++++++++++++
 kernel/kexec.c                          |  8 ++++
 kernel/module.c                         |  2 +-
 security/integrity/ima/Kconfig          | 58 ++++++++++++++++++++++++++++
 security/integrity/ima/ima.h            |  1 +
 security/integrity/ima/ima_main.c       | 68 ++++++++++++++++++++++++++-------
 security/integrity/ima/ima_policy.c     | 48 +++++++++++++++++++++--
 security/loadpin/loadpin.c              |  6 +++
 security/security.c                     | 13 +++++++
 security/selinux/hooks.c                | 15 ++++++++
 14 files changed, 248 insertions(+), 23 deletions(-)
