Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id JMwDETxvGVvrWgAAmS7hNA
	; Thu, 07 Jun 2018 17:46:12 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EDDC26074D; Thu,  7 Jun 2018 17:46:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DBE256063F;
	Thu,  7 Jun 2018 17:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DBE256063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933785AbeFGRqJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:46:09 -0400
Received: from namei.org ([65.99.196.166]:58470 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933071AbeFGRqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:46:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w57Hk5AM030781;
        Thu, 7 Jun 2018 17:46:05 GMT
Date: Fri, 8 Jun 2018 03:46:05 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Security subsystem: Integrity updates for v4.18
Message-ID: <alpine.LRH.2.21.1806080340420.27121@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull these updates for the Integrity subsystem.


>From Mimi:

- adds run time support for specifying additional security xattrs
  included in the security.evm HMAC/signature

- some code clean up and bug fixes.


---

The following changes since commit 890e2abe1028c39e5399101a2c277219cd637aaa:

  dh key: get rid of stack allocated array for zeroes (2018-05-11 13:07:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-integrity

for you to fetch changes up to b5c90a7526fe39164c2204f0404ce8f8ff21e522:

  EVM: unlock on error path in evm_read_xattrs() (2018-06-01 06:03:08 -0400)

----------------------------------------------------------------
Colin Ian King (2):
      EVM: fix memory leak of temporary buffer 'temp'
      EVM: Fix null dereference on xattr when xattr fails to allocate

Dan Carpenter (2):
      EVM: prevent array underflow in evm_write_xattrs()
      EVM: unlock on error path in evm_read_xattrs()

Matthew Garrett (3):
      integrity: Add an integrity directory in securityfs
      EVM: turn evm_config_xattrnames into a list
      EVM: Allow runtime modification of the set of verified xattrs

Mimi Zohar (3):
      ima: define a new policy condition based on the filesystem name
      ima: based on policy verify firmware signatures (pre-allocated buffer)
      ima: fix updating the ima_appraise flag

Petko Manolov (1):
      IMA: use list_splice_tail_init_rcu() instead of its open coded variant

Petr Vorel (3):
      ima: Reflect correct permissions for policy
      ima: Unify logging
      ima: Remove unused variable ima_initialized

Yisheng Xie (1):
      ima: use match_string() helper

 Documentation/ABI/testing/evm             |  13 ++
 Documentation/ABI/testing/ima_policy      |   2 +-
 include/uapi/linux/audit.h                |   1 +
 security/integrity/evm/Kconfig            |  11 ++
 security/integrity/evm/evm.h              |   7 +-
 security/integrity/evm/evm_crypto.c       |  10 +-
 security/integrity/evm/evm_main.c         |  79 +++++++-----
 security/integrity/evm/evm_secfs.c        | 206 +++++++++++++++++++++++++++++-
 security/integrity/iint.c                 |  18 +++
 security/integrity/ima/ima.h              |   1 -
 security/integrity/ima/ima_fs.c           |  18 ++-
 security/integrity/ima/ima_kexec.c        |   2 +
 security/integrity/ima/ima_main.c         |  19 +--
 security/integrity/ima/ima_policy.c       |  70 ++++++----
 security/integrity/ima/ima_template_lib.c |   2 +
 security/integrity/integrity.h            |   2 +
 16 files changed, 377 insertions(+), 84 deletions(-)
