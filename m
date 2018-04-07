Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeDGXrX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 19:47:23 -0400
Received: from namei.org ([65.99.196.166]:55858 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752156AbeDGXrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 19:47:21 -0400
Date: Sun, 8 Apr 2018 09:47:21 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL][SECURITY] Integrity updates for v4.17
Message-ID: <alpine.LRH.2.21.1804080937550.1486@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1665246916-617956046-1523144331=:1486"
Content-ID: <alpine.LRH.2.21.1804080939180.1486@namei.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-617956046-1523144331=:1486
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LRH.2.21.1804080939181.1486@namei.org>

Please pull these updates for the Integrity subsystem, via Mimi:

    a mixture of bug fixes, code cleanup, and continues to close 
    IMA-measurement, IMA-appraisal, and IMA-audit gaps.

Also note the addition of a new cred_getsecid LSM hook by Matthew Garrett:

    For IMA purposes, we want to be able to obtain the prepared secid in 
    the bprm structure before the credentials are committed. Add a 
    cred_getsecid hook that makes this possible.

which is used by a new CREDS_CHECK target in IMA:

    In ima_bprm_check(), check with both the existing process credentials 
    and the credentials that will be committed when the new process is 
    started. This will not change behaviour unless the system policy is 
    extended to include CREDS_CHECK targets - BPRM_CHECK will continue to 
    check the same credentials that it did previously.



The following changes since commit 5893ed18a26d1f56b97c0290b0cbbc2d49d6de28:

  Merge tag 'v4.16-rc6' into next-general (2018-03-23 08:26:16 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-integrity

for you to fetch changes up to ab60368ab6a452466885ef4edf0cefd089465132:

  ima: Fallback to the builtin hash algorithm (2018-03-25 07:26:32 -0400)

----------------------------------------------------------------
Hernán Gonzalez (2):
      evm: Move evm_hmac and evm_hash from evm_main.c to evm_crypto.c
      evm: Constify *integrity_status_msg[]

Jiandi An (1):
      ima: Fix Kconfig to select TPM 2.0 CRB interface

Martin Townsend (1):
      ima: Add smackfs to the default appraise/measure list

Matthew Garrett (2):
      security: Add a cred_getsecid hook
      IMA: Support using new creds in appraisal policy

Mimi Zohar (5):
      ima: fail file signature verification on non-init mounted filesystems
      ima: re-evaluate files on privileged mounted filesystems
      ima: clear IMA_HASH
      ima: fail signature verification based on policy
      fuse: define the filesystem as untrusted

Petr Vorel (1):
      ima: Fallback to the builtin hash algorithm

Sascha Hauer (1):
      evm: check for remount ro in progress before writing

Thiago Jung Bauermann (3):
      integrity: Remove unused macro IMA_ACTION_RULE_FLAGS
      ima: Simplify ima_eventsig_init()
      ima: Improvements in ima_appraise_measurement()

Tycho Andersen (1):
      ima: drop vla in ima_audit_measurement()

 Documentation/ABI/testing/ima_policy            |  2 +-
 Documentation/admin-guide/kernel-parameters.txt |  8 ++-
 fs/fuse/inode.c                                 |  3 ++
 include/linux/fs.h                              |  2 +
 include/linux/lsm_hooks.h                       |  6 +++
 include/linux/security.h                        |  1 +
 security/integrity/evm/evm.h                    |  2 -
 security/integrity/evm/evm_crypto.c             |  3 ++
 security/integrity/evm/evm_main.c               | 12 +++--
 security/integrity/iint.c                       |  2 +
 security/integrity/ima/Kconfig                  |  1 +
 security/integrity/ima/ima.h                    |  9 ++--
 security/integrity/ima/ima_api.c                | 25 +++++----
 security/integrity/ima/ima_appraise.c           | 65 +++++++++++++++++------
 security/integrity/ima/ima_crypto.c             |  2 +
 security/integrity/ima/ima_main.c               | 69 ++++++++++++++++++++-----
 security/integrity/ima/ima_policy.c             | 32 ++++++++----
 security/integrity/ima/ima_template_lib.c       | 11 ++--
 security/integrity/integrity.h                  | 11 ++--
 security/security.c                             |  7 +++
 security/selinux/hooks.c                        |  6 +++
 security/smack/smack_lsm.c                      | 18 +++++++
 22 files changed, 227 insertions(+), 70 deletions(-)
--1665246916-617956046-1523144331=:1486--
