Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66621C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338F2222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390828AbfBMIt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:49:26 -0500
Received: from mga17.intel.com ([192.55.52.151]:6721 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbfBMItZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:49:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 00:49:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,365,1544515200"; 
   d="scan'208";a="143852240"
Received: from sorenthe-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.151])
  by fmsmga004.fm.intel.com with ESMTP; 13 Feb 2019 00:49:22 -0800
Date:   Wed, 13 Feb 2019 10:49:21 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     jmorris@namei.org
Cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] tpmdd updates for Linux v5.1
Message-ID: <20190213084921.GA8208@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James,

Quite a fat release this time. I'll try to enumerate the highlights.

Clean up the transmission flow
==============================

Cleaned up the whole transmission flow. Locking of the chip is now done in
the level of tpm_try_get_ops() and tpm_put_ops() instead taking the chip
lock inside tpm_transmit(). The nested calls inside tpm_transmit(), used
with the resource manager, have been refactored out.

Should make easier to perform more complex transactions with the TPM
without making the subsystem a bigger mess (e.g. encrypted channel patches
by James Bottomley).

PPI 1.3 support
===============

TPM PPI 1.3 introduces an additional optional command parameter that may be
needed for some commands. Display the parameter if the command requires
such a parameter. Only command 23 (SetPCRBanks) needs one.

The PPI request file will show output like this then:

   # echo "23 16" > request
   # cat request
   23 16

   # echo "5" > request
   # cat request
   5

Extend all PCR banks in IMA
===========================

Instead of static PCR banks array, the array of available PCR banks is now
allocated dynamically. The digests sizes are determined dynamically using a
probe PCR read without relying crypto's static list of hash algorithms.

This should finally make sealing of measurements in IMA safe and secure.

TPM 2.0 selftests
=================

Added a test suite to tools/testing/selftests/tpm2 previously outside of
the kernel tree: https://github.com/jsakkine-intel/tpm2-scripts.

The following changes since commit 2181e084b26bddca22bc3f23364c15809cfed28b:

  LSM: SafeSetID: remove unused include (2019-01-30 12:29:53 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20190213

for you to fetch changes up to 50a81b60bfe075a0023670ff86558abd02536799:

  tpm/ppi: Enable submission of optional command parameter for PPI 1.3 (2019-02-13 09:48:53 +0200)

----------------------------------------------------------------
tpmdd updates for Linux v5.1

----------------------------------------------------------------
Jarkko Sakkinen (21):
      tpm/tpm_crb: Avoid unaligned reads in crb_recv()
      tpm: Fix some name collisions with drivers/char/tpm.h
      selftests: add TPM 2.0 tests
      tpm: Unify the send callback behaviour
      tpm/tpm_i2c_atmel: Return -E2BIG when the transfer is incomplete
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

Jerry Snitselaar (2):
      tpm: don't print error message in tpm_transmit_cmd when tpm still testing
      tpm: don't return bool from update_timeouts

Jia Zhang (2):
      tpm: Simplify the measurements loop
      tpm: Fix off-by-one when reading binary_bios_measurements

Roberto Sassu (7):
      tpm: add _head suffix to tcg_efi_specid_event and tcg_pcr_event2
      tpm: dynamically allocate the allocated_banks array
      tpm: rename and export tpm2_digest and tpm2_algorithms
      tpm: retrieve digest size of unknown algorithms with PCR read
      tpm: move tpm_chip definition to include/linux/tpm.h
      KEYS: trusted: explicitly use tpm_chip structure from tpm_default_chip()
      tpm: pass an array of tpm_extend_digest structures to tpm_pcr_extend()

Stefan Berger (5):
      tpm/ppi: pass function revision ID to tpm_eval_dsm()
      tpm/ppi: rename TPM_PPI_REVISION_ID to TPM_PPI_REVISION_ID_1
      tpm/ppi: Display up to 101 operations as define for version 1.3
      tpm/ppi: Possibly show command parameter if TPM PPI 1.3 is used
      tpm/ppi: Enable submission of optional command parameter for PPI 1.3

 drivers/char/tpm/eventlog/tpm1.c           |  41 +-
 drivers/char/tpm/eventlog/tpm2.c           |  12 +-
 drivers/char/tpm/st33zp24/i2c.c            |   2 +-
 drivers/char/tpm/st33zp24/spi.c            |   2 +-
 drivers/char/tpm/st33zp24/st33zp24.c       |   2 +-
 drivers/char/tpm/st33zp24/st33zp24.h       |   4 +-
 drivers/char/tpm/tpm-chip.c                | 124 ++++-
 drivers/char/tpm/tpm-dev-common.c          |  44 +-
 drivers/char/tpm/tpm-interface.c           | 327 ++++----------
 drivers/char/tpm/tpm-sysfs.c               | 138 +++---
 drivers/char/tpm/tpm.h                     | 180 ++------
 drivers/char/tpm/tpm1-cmd.c                |  43 +-
 drivers/char/tpm/tpm2-cmd.c                | 208 +++++----
 drivers/char/tpm/tpm2-space.c              |  90 +++-
 drivers/char/tpm/tpm_atmel.c               |   2 +-
 drivers/char/tpm/tpm_crb.c                 |  22 +-
 drivers/char/tpm/tpm_i2c_atmel.c           |  15 +-
 drivers/char/tpm/tpm_i2c_infineon.c        |  17 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c         |  18 +-
 drivers/char/tpm/tpm_ibmvtpm.c             |   8 +-
 drivers/char/tpm/tpm_infineon.c            |   2 +-
 drivers/char/tpm/tpm_nsc.c                 |   2 +-
 drivers/char/tpm/tpm_ppi.c                 |  78 +++-
 drivers/char/tpm/tpm_tis_core.c            |  21 +-
 drivers/char/tpm/tpm_vtpm_proxy.c          |  15 +-
 drivers/char/tpm/xen-tpmfront.c            |   4 +-
 include/linux/tpm.h                        | 129 +++++-
 include/linux/tpm_eventlog.h               |  19 +-
 security/integrity/ima/ima.h               |   1 +
 security/integrity/ima/ima_crypto.c        |  10 +-
 security/integrity/ima/ima_init.c          |   4 +
 security/integrity/ima/ima_queue.c         |  27 +-
 security/keys/trusted.c                    |  73 ++-
 tools/testing/selftests/Makefile           |   1 +
 tools/testing/selftests/tpm2/Makefile      |   4 +
 tools/testing/selftests/tpm2/test_smoke.sh |   4 +
 tools/testing/selftests/tpm2/test_space.sh |   4 +
 tools/testing/selftests/tpm2/tpm2.py       | 696 +++++++++++++++++++++++++++++
 tools/testing/selftests/tpm2/tpm2_tests.py | 227 ++++++++++
 39 files changed, 1876 insertions(+), 744 deletions(-)
 create mode 100644 tools/testing/selftests/tpm2/Makefile
 create mode 100755 tools/testing/selftests/tpm2/test_smoke.sh
 create mode 100755 tools/testing/selftests/tpm2/test_space.sh
 create mode 100644 tools/testing/selftests/tpm2/tpm2.py
 create mode 100644 tools/testing/selftests/tpm2/tpm2_tests.py
