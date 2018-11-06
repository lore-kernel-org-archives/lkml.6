Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499F9C46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3E920881
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3E920881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389709AbeKGDDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:03:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:51946 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389275AbeKGDDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:03:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 09:37:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,472,1534834800"; 
   d="scan'208";a="247464728"
Received: from wenjiewa-mobl2.ccr.corp.intel.com (HELO localhost) ([10.249.254.60])
  by orsmga004.jf.intel.com with ESMTP; 06 Nov 2018 09:36:56 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip
        (AT91) SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 00/17] Remove nested TPM operations
Date:   Tue,  6 Nov 2018 19:36:32 +0200
Message-Id: <20181106173652.31020-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[was Detach TPM space code out of the tpm_transmit() flow but the scope
 expanded a bit.]

Make the changes necessary to detach TPM space code and TPM activation
code out of the tpm_transmit() flow because of both of these can cause
nested tpm_transmit() calls. The nesteds calls make the whole flow hard
to maintain, and thus, it is better to just fix things now before this
turns into a bigger mess.

The commits are available in a branch called 'nested' in

git://git.infradead.org/users/jjs/linux-tpmdd.git

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

Jarkko Sakkinen (17):
  tpm: use tpm_buf in tpm_transmit_cmd() as the IO parameter
  tpm: fix invalid return value in pubek_show()
  tpm: return 0 from pcrs_show() when tpm1_pcr_read() fails
  tpm: call tpm2_flush_space() on error in tpm_try_transmit()
  tpm: print tpm2_commit_space() error inside tpm2_commit_space()
  tpm: clean up tpm_try_transmit() error handling flow
  tpm: declare struct tpm_header
  tpm: access command header through struct in  tpm_try_transmit()
  tpm: move tpm_validate_commmand() to tpm2-space.c
  tpm: encapsulate tpm_dev_transmit()
  tpm: move TPM space code out of tpm_transmit()
  tpm: remove @space from tpm_transmit()
  tpm: use tpm_try_get_ops() in tpm-sysfs.c.
  tpm: remove TPM_TRANSMIT_UNLOCKED flag
  tpm: introduce tpm_chip_start() and tpm_chip_stop()
  tpm: take TPM chip power gating out of tpm_transmit()
  tpm: remove @flags from tpm_transmit()

 drivers/char/tpm/tpm-chip.c       | 105 +++++++++++-
 drivers/char/tpm/tpm-dev-common.c |  45 ++++-
 drivers/char/tpm/tpm-interface.c  | 267 ++++++------------------------
 drivers/char/tpm/tpm-sysfs.c      | 138 +++++++++------
 drivers/char/tpm/tpm.h            |  64 +++----
 drivers/char/tpm/tpm1-cmd.c       |  28 +---
 drivers/char/tpm/tpm2-cmd.c       |  72 +++-----
 drivers/char/tpm/tpm2-space.c     |  93 ++++++++---
 drivers/char/tpm/tpm_i2c_atmel.c  |   5 +-
 drivers/char/tpm/tpm_vtpm_proxy.c |  12 +-
 drivers/char/tpm/xen-tpmfront.c   |   2 +-
 11 files changed, 406 insertions(+), 425 deletions(-)

-- 
2.19.1

