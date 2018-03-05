Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752910AbeCEUXt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 15:23:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:19709 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751764AbeCEUXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 15:23:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="209015196"
From: Tomas Winkler <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 0/6] tpm: timeouts revamp
Date: Mon,  5 Mar 2018 22:20:11 +0200
Message-Id: <20180305202017.24008-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series cleans up tpm timeouts setting and handling.

First motivation was to fix failures coming from too short timeouts
for commands that creates keys.
Key generation may take significant time depending on the underlying
hardware. Rather than increasing default timeout a new constant is
added, to not stall too long on regular commands failures.

Second is to define timeouts for new tpm2 commands
defined in TCG 1.36 spec.

Last, is to factor out tpm1.2 commands out of tpm-interface.c

Tomas Winkler (6):
  tpm: sort objects in the Makefile
  tpm: factor out tpm 1.2 duration calculation to tpm1-cmd.c
  tpm2: add longer timeouts for creation commands.
  tpm2: add new tpm2 commands according to TCG 1.36
  tmp: factor out tpm_get_timeouts
  tpm: tpm-interface: drop unused tpm_input_header headers.

 drivers/char/tpm/Makefile            |  15 +-
 drivers/char/tpm/st33zp24/st33zp24.c |   2 +-
 drivers/char/tpm/tpm-interface.c     | 424 +----------------------------------
 drivers/char/tpm/tpm.h               |  74 +++---
 drivers/char/tpm/tpm1-cmd.c          | 416 ++++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm2-cmd.c          | 220 ++++++++----------
 drivers/char/tpm/tpm_i2c_nuvoton.c   |  10 +-
 drivers/char/tpm/tpm_tis_core.c      |   2 +-
 drivers/char/tpm/xen-tpmfront.c      |   2 +-
 9 files changed, 582 insertions(+), 583 deletions(-)
 create mode 100644 drivers/char/tpm/tpm1-cmd.c

-- 
2.14.3
