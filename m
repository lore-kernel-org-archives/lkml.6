Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4B6C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AFE2175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbfBEWri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:47:38 -0500
Received: from mga02.intel.com ([134.134.136.20]:12463 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbfBEWrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:47:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2019 14:47:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,337,1544515200"; 
   d="scan'208";a="115538127"
Received: from ibanaga-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.171])
  by orsmga008.jf.intel.com with ESMTP; 05 Feb 2019 14:47:28 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Peter Huewe <PeterHuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH v11 00/16] Remove nested TPM operations
Date:   Wed,  6 Feb 2019 00:47:07 +0200
Message-Id: <20190205224723.19671-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the changes necessary to detach TPM space code and TPM activation
code out of the tpm_transmit() flow because of both of these can cause
nested tpm_transmit() calls. The nesteds calls make the whole flow hard
to maintain, and thus, it is better to just fix things now before this
turns into a bigger mess.

v11:
* Drop the patch that tries to flush TPM space on system. Not a proper
  fallback + out of scope for this patch set.

v10:
* Use void pointers to avoid unnecessary casts in functions paramaters
  where it makes sense.

v9:
* Fixed again tpm_try_get_ops().
* Added missing reviewed-by's.

v8:
* Re-add the check for ret < 0 after calling tpm_try_transmit() that
  was dropped by mistake while moving code.
* Fix error fallback for tpm_try_get_ops() when tpm_chip_start()
  fails.

v7:
*  Reorganize series so that more trivial and self-contained changes are
   in the head.

v6:
* When tpm_validate_commmand() was moved to tpm2-space.c, the struct for
  the TPM header was incorrectly declared as struct tpm_input_header.
* Fix return value in tpm_validate_command().

v5:
* Add the missing rev's from Stefan Berger.

v4:
* Return 0 from pcrs_show() when tpm1_pcr_read() fails.
* Fix error handling flow in tpm_try_transmit().
* Replace struct tpm_input_header and struct tpm_output_header with
  struct tpm_header.

v3:
* Encapsulate power gating code to tpm_chip_start() and tpm_chip_stop().
* Move TPM power gating code and locking to tpm_try_get_ops() and
  tpm_put_ops().
* Call power gating code directly in tpm_chip_register() and
  tpm2_del_space().

v2:
* Print tpm2_commit_space() error inside tpm2_commit_space()
* Error code was not printed when recv() callback failed. It is
  fixed in this version.
* Added a patch that removes @space from tpm_transmit().
* Fixed a regression in earlier series. Forgot to amend the change
  from the staging area that renames NESTED to UNLOCKED in tpm2-space.c.

Jarkko Sakkinen (16):
  tpm: use tpm_buf in tpm_transmit_cmd() as the IO parameter
  tpm: fix invalid return value in pubek_show()
  tpm: return 0 from pcrs_show() when tpm1_pcr_read() fails
  tpm: print tpm2_commit_space() error inside tpm2_commit_space()
  tpm: declare struct tpm_header
  tpm: access command header through struct in tpm_try_transmit()
  tpm: encapsulate tpm_dev_transmit()
  tpm: clean up tpm_try_transmit() error handling flow
  tpm: move tpm_validate_commmand() to tpm2-space.c
  tpm: move TPM space code out of tpm_transmit()
  tpm: remove @space from tpm_transmit()
  tpm: use tpm_try_get_ops() in tpm-sysfs.c.
  tpm: remove TPM_TRANSMIT_UNLOCKED flag
  tpm: introduce tpm_chip_start() and tpm_chip_stop()
  tpm: take TPM chip power gating out of tpm_transmit()
  tpm: remove @flags from tpm_transmit()

 drivers/char/tpm/tpm-chip.c       | 109 ++++++++++++
 drivers/char/tpm/tpm-dev-common.c |  44 ++++-
 drivers/char/tpm/tpm-interface.c  | 264 ++++++------------------------
 drivers/char/tpm/tpm-sysfs.c      | 138 ++++++++++------
 drivers/char/tpm/tpm.h            |  64 +++-----
 drivers/char/tpm/tpm1-cmd.c       |  28 +---
 drivers/char/tpm/tpm2-cmd.c       |  72 +++-----
 drivers/char/tpm/tpm2-space.c     |  91 +++++++---
 drivers/char/tpm/tpm_i2c_atmel.c  |   5 +-
 drivers/char/tpm/tpm_vtpm_proxy.c |  12 +-
 drivers/char/tpm/xen-tpmfront.c   |   2 +-
 11 files changed, 408 insertions(+), 421 deletions(-)

-- 
2.19.1

