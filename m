Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751658AbeCZMOZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 08:14:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:54462 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750984AbeCZMOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 08:14:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,364,1517904000";
   d="scan'208";a="31341162"
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 0/4] Migrate all TPM 2.0 commands to use struct tpm_buf
Date: Mon, 26 Mar 2018 15:14:02 +0300
Message-Id: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make struct tpm_buf the first class object for constructing TPM
commands, this patch set migrates all TPM 2.0 commands to use it. Eventually,
tpm_transmit_cmd() can take simply struct tpm_buf as its argument and this
interface can be exported to be used by the kernel keyring and potentially
other subsystems.

The ultimate goal of this work is to make constructing TPM commands inside
the kernel simple and robust.

v4:
* Fixed invalid return value from tpm2_probe(). TPM return codes are
  ignored on purpose as we only care about the tag.
* Removed James' fix for the self test as it was separately applied.

v3:
* Fixed error handling in tpm2_get_random()

v2:
* Fixed author information in the commit that fixes the self-test issue,
  removed '\n' from the log message and added the missing tested-by.
  (James: sincere apologies about this)
* Removed the redundant "out of memory" log message from tpm2_shutdown().
* tpm_buf_destroy() was called before using the response data in
  tpm2_probe().
* Added missing tpm_buf_destroy() to tpm2_get_random().

Jarkko Sakkinen (4):
  tpm: migrate tpm2_shutdown() to use struct tpm_buf
  tpm: migrate tpm2_probe() to use struct tpm_buf
  tpm: migrate tpm2_get_tpm_pt() to use struct tpm_buf
  tpm: migrate tpm2_get_random() to use struct tpm_buf

 drivers/char/tpm/tpm.h      |  19 ++--
 drivers/char/tpm/tpm2-cmd.c | 242 +++++++++++++++++---------------------------
 2 files changed, 105 insertions(+), 156 deletions(-)

-- 
2.15.1
