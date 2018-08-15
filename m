Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2F7C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89C32084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 22:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B89C32084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbeHPBcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 21:32:02 -0400
Received: from namei.org ([65.99.196.166]:43380 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbeHPBcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 21:32:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w7FMbo0V022747;
        Wed, 15 Aug 2018 22:37:50 GMT
Date:   Thu, 16 Aug 2018 08:37:50 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] security subsystem: TPM updates for v4.19
Message-ID: <alpine.LRH.2.21.1808160835290.19586@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Jarkko:

" * Migrated away from PM runtime as explicit cmdReady/goIdle trasactions
    for every command is a spec requirement. PM runtime adds only a layer 
    of complexity on our case.
  * tpm_tis drivers can now specify the hwrng quality.
  * TPM 2.0 code uses now tpm_buf for constructing messages. I think Tomas
    Winkler has done the same for TPM 1.2. I'll start digging those
    changes from the patchwork in the near future.
  * Bug fixes and clean ups."


The following changes since commit 87ea58433208d17295e200d56be5e2a4fe4ce7d6:

  security: check for kstrdup() failure in lsm_append() (2018-07-17 21:27:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tpm

for you to fetch changes up to 5da08f7d01693433ff6bea0c3462a5173d577540:

  Merge tag 'tpmdd-next-20180728' of git://git.infradead.org/users/jjs/linux-tpmdd into next-tpm (2018-07-30 09:30:19 -0700)

----------------------------------------------------------------
James Morris (1):
      Merge tag 'tpmdd-next-20180728' of git://git.infradead.org/users/jjs/linux-tpmdd into next-tpm

Jarkko Sakkinen (5):
      tpm: migrate tpm2_shutdown() to use struct tpm_buf
      tpm: migrate tpm2_probe() to use struct tpm_buf
      tpm: migrate tpm2_get_tpm_pt() to use struct tpm_buf
      tpm: migrate tpm2_get_random() to use struct tpm_buf
      tpm: replace TPM_TRANSMIT_RAW with TPM_TRANSMIT_NESTED

Linus Walleij (1):
      tpm_tis_spi: Pass the SPI IRQ down to the driver

Louis Collard (1):
      tpm: Allow tpm_tis drivers to set hwrng quality.

Peter Rosin (1):
      tpm/tpm_i2c_infineon: switch to i2c_lock_bus(..., I2C_LOCK_SEGMENT)

Ricardo Schwarzmeier (1):
      tpm: Return the actual size when receiving an unsupported command

Stefan Berger (5):
      tpm: rename tpm_chip_find_get() to tpm_find_get_ops()
      tpm: Implement tpm_default_chip() to find a TPM chip
      tpm: Convert tpm_find_get_ops() to use tpm_default_chip()
      ima: Use tpm_default_chip() and call TPM functions with a tpm_chip
      ima: Get rid of ima_used_chip and use ima_tpm_chip != NULL instead

Tomas Winkler (1):
      tpm: separate cmd_ready/go_idle from runtime_pm

 drivers/char/tpm/tpm-chip.c         |  68 +++++++---
 drivers/char/tpm/tpm-interface.c    |  72 +++++++---
 drivers/char/tpm/tpm.h              |  31 +++--
 drivers/char/tpm/tpm2-cmd.c         | 258 +++++++++++++++---------------------
 drivers/char/tpm/tpm2-space.c       |  12 +-
 drivers/char/tpm/tpm_crb.c          | 101 ++++----------
 drivers/char/tpm/tpm_i2c_infineon.c |   8 +-
 drivers/char/tpm/tpm_tis_core.c     |   2 +
 drivers/char/tpm/tpm_tis_core.h     |   1 +
 drivers/char/tpm/tpm_tis_spi.c      |   9 +-
 drivers/char/tpm/tpm_vtpm_proxy.c   |   2 +-
 include/linux/tpm.h                 |   7 +
 security/integrity/ima/ima.h        |   2 +-
 security/integrity/ima/ima_crypto.c |   4 +-
 security/integrity/ima/ima_init.c   |  16 +--
 security/integrity/ima/ima_queue.c  |   4 +-
 16 files changed, 289 insertions(+), 308 deletions(-)
