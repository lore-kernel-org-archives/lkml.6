Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932343AbeCJI2A (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 03:28:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:63004 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750829AbeCJI16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 03:27:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,450,1515484800";
   d="scan'208";a="24039398"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH v2 0/8] tpm: factor out tpm1 code into tpm1-cmd.c
Date: Sat, 10 Mar 2018 10:24:20 +0200
Message-Id: <20180310082428.31519-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move TPM1 implementation from tpm-interface.c to tpm1-cmd.c
similarly to tpm2-cmd.c, as well as move TPM2 open code flows
into new functions to tpm2-cmd.c
The functions in tpm-interface.c should now be in form:


int tpm_func(struct tpm_chip *chip)
{
 if (chip->flags & TPM_CHIP_FLAG_TPM2)
                return tpm2_func(chip);
        else
                return tpm1_func(chip);
}

This is work in progress of possible dropping compiling out one tpm 1.x or tpm 2.x in case
not needed on a target platform.

V2: 1. This resend includes more patches that cleans the tpm-interface.c
completely 
    2. Fix notorious typo tmp -> tpm, in some patches

Tomas Winkler (8):
  tpm: move tpm1_pcr_extend to tpm1-cmd.c
  tpm: move tpm_getcap to tpm1-cmd.c
  tpm: factor out tpm1_get_random into tpm1-cmd.c
  tpm: move tpm1 selftest code from tpm-interface tpm1-cmd.c
  tpm: factor out tpm1 pm suspend flow into tpm1-cmd.c
  tpm: factor out tpm_startup function
  tpm: Move pcr extend to tpm2-cmd.c
  tpm: move tpm2 code validation to tpm2-space.c

 drivers/char/tpm/st33zp24/st33zp24.c |   2 +-
 drivers/char/tpm/tpm-interface.c     | 425 ++---------------------------------
 drivers/char/tpm/tpm-sysfs.c         |  50 ++---
 drivers/char/tpm/tpm.h               |  18 +-
 drivers/char/tpm/tpm1-cmd.c          | 358 ++++++++++++++++++++++++++++-
 drivers/char/tpm/tpm2-cmd.c          |  60 ++++-
 drivers/char/tpm/tpm2-space.c        |  32 +++
 drivers/char/tpm/tpm_tis_core.c      |   4 +-
 8 files changed, 496 insertions(+), 453 deletions(-)

-- 
2.14.3
